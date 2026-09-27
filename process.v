module process #(
    parameter [7:0] HEADER_VAL    = 8'h23, // Byte Header '#'
    parameter [7:0] FOOTER_VAL    = 8'h24, // Byte Footer '$'
    parameter [7:0] CRC_VAL       = 8'h07, // Poly CRC-8

    parameter [7:0] TYPE_LOOPBACK = 8'h01, // Type Loopback
    parameter [7:0] TYPE_SENSOR   = 8'h02, // Type Sensor
    parameter       MAX_PAYLOAD   = 32     // Kich thuoc Payload toi da
)(
    input  wire        clk_i,
    input  wire        rst_i,

    // Giao tiep voi FIFO_RX Main (Nhan goi tin tu PC)
    input  wire        fifo_rx_empty_i,
    output reg         fifo_rx_rd_o,
    input  wire [7:0]  fifo_rx_data_i,

    // Giao tiep voi FIFO_TX Main (Gui phan hoi ve PC)
    input  wire        fifo_tx_full_i,
    output reg         fifo_tx_wr_o,
    output reg  [7:0]  fifo_tx_data_o,

    // Giao tiep voi FIFO_TX Sensor (Gui lenh xuong Sensor)
    input  wire        sensor_tx_full_i,
    output reg         sensor_tx_wr_o,
    output reg  [7:0]  sensor_tx_data_o,

    // Giao tiep voi FIFO_RX Sensor (Nhan du lieu tu Sensor)
    input  wire        sensor_rx_empty_i,
    output reg         sensor_rx_rd_o,
    input  wire [7:0]  sensor_rx_data_i
);

    // =========================================================================
    // HAM TINH CRC-8 DONG (Dallas/Maxim Poly 0x07: X^8 + X^2 + X + 1)
    // =========================================================================
    function [7:0] calc_crc8;
        input [7:0] crc_in;
        input [7:0] data_in;
        reg   [7:0] d;
        reg   [7:0] c;
        reg   [7:0] crc_out;
    begin
        d = data_in;
        c = crc_in;

        crc_out[0] = c[0] ^ c[6] ^ c[7] ^ d[0] ^ d[6] ^ d[7];
        crc_out[1] = c[0] ^ c[1] ^ c[6] ^ d[0] ^ d[1] ^ d[6];
        crc_out[2] = c[0] ^ c[1] ^ c[2] ^ c[6] ^ d[0] ^ d[1] ^ d[2] ^ d[6];
        crc_out[3] = c[1] ^ c[2] ^ c[3] ^ c[7] ^ d[1] ^ d[2] ^ d[3] ^ d[7];
        crc_out[4] = c[2] ^ c[3] ^ c[4] ^ d[2] ^ d[3] ^ d[4];
        crc_out[5] = c[3] ^ c[4] ^ c[5] ^ d[3] ^ d[4] ^ d[5];
        crc_out[6] = c[4] ^ c[5] ^ c[6] ^ d[4] ^ d[5] ^ d[6];
        crc_out[7] = c[5] ^ c[6] ^ c[7] ^ d[5] ^ d[6] ^ d[7];

        calc_crc8 = crc_out;
    end
    endfunction

    // =========================================================================
    // FSM CHINH (13 trang thai, giam tu 30) - Chuan khung: HDR-TYPE-DATA-FTR-CRC
    // =========================================================================
    localparam ST_IDLE           = 4'd0,
               ST_REQ_BYTE       = 4'd1,  // Dong co doc DUNG CHUNG: yeu cau 1 byte tu fifo_rx
               ST_WAIT_BYTE      = 4'd2,  // Cho du lieu FIFO on dinh (1 chu ky)
               ST_PROC_BYTE      = 4'd3,  // Phan loai byte vua doc & re nhanh theo rx_phase
               ST_SENS_EXEC      = 4'd4,  // Day lenh da buffer & xac thuc CRC xuong Sensor
               ST_SENS_READ_REQ  = 4'd5,  // Dong co doc DUNG CHUNG: yeu cau 1 byte tu sensor_rx
               ST_SENS_READ_WAIT = 4'd6,
               ST_SENS_READ_STO  = 4'd7,  // Luu byte Sensor vao buffer
               ST_SEND_HDR       = 4'd8,  // Dong co gui DUNG CHUNG len PC: Header
               ST_SEND_TYPE      = 4'd9,  //                                  Type
               ST_SEND_DATA      = 4'd10, //                                  Data (loop buffer)
               ST_SEND_FTR       = 4'd11, //                                  Footer
               ST_SEND_CRC       = 4'd12; //                                  CRC

    // Vai tro cua byte dang doc tu PC, dung de re nhanh trong ST_PROC_BYTE
    localparam PHASE_HDR       = 3'd0,
               PHASE_TYPE      = 3'd1,
               PHASE_DATA      = 3'd2,
               PHASE_CRC       = 3'd3,
               PHASE_FLUSH     = 3'd4, // Type la -> xa not phan con lai cua khung loi
               PHASE_FLUSH_CRC = 3'd5;

    reg [3:0] state;
    reg [2:0] rx_phase;
    reg [7:0] type_reg;      // Type nhan tu PC, dung de re nhanh sau khi CRC khop
    reg [7:0] send_type_reg; // Type se gan vao khung phan hoi gui len PC
    reg [7:0] data_buffer [0:MAX_PAYLOAD-1]; // Buffer dung chung cho ca 3 luong (khong bao gio dung dong thoi)
    reg [7:0] byte_cnt;      // So byte data da nhan/luu vao buffer
    reg [7:0] tx_cnt;        // Con tro dang gui/day ra
    reg [7:0] crc_reg;

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            state            <= ST_IDLE;
            rx_phase         <= PHASE_HDR;
            fifo_rx_rd_o     <= 1'b0;
            fifo_tx_wr_o     <= 1'b0;
            fifo_tx_data_o   <= 8'h00;
            sensor_tx_wr_o   <= 1'b0;
            sensor_tx_data_o <= 8'h00;
            sensor_rx_rd_o   <= 1'b0;
            type_reg         <= 8'h00;
            send_type_reg    <= 8'h00;
            byte_cnt         <= 8'h00;
            tx_cnt           <= 8'h00;
            crc_reg          <= 8'h00;
        end else begin
            // Mac dinh ha cac tin hieu strobe trong 1 chu ky clock
            fifo_rx_rd_o   <= 1'b0;
            fifo_tx_wr_o   <= 1'b0;
            sensor_tx_wr_o <= 1'b0;
            sensor_rx_rd_o <= 1'b0;

            case (state)
                // -------------------------------------------------------------
                // 1. ST_IDLE: Uu tien goi tin tu PC truoc, sau do toi Sensor
                // -------------------------------------------------------------
                ST_IDLE: begin
                    byte_cnt <= 8'h00;
                    tx_cnt   <= 8'h00;

                    if (!fifo_rx_empty_i) begin
                        rx_phase <= PHASE_HDR;
                        state    <= ST_REQ_BYTE;
                    end else if (!sensor_rx_empty_i && !fifo_tx_full_i) begin
                        state <= ST_SENS_READ_REQ;
                    end
                end

                // -------------------------------------------------------------
                // 2. DONG CO DOC DUNG CHUNG: REQ -> WAIT -> PROC (phan loai byte)
                //    Dung cho MOI field cua khung PC->process: HDR/TYPE/DATA/FTR/CRC
                // -------------------------------------------------------------
                ST_REQ_BYTE: begin
                    if (!fifo_rx_empty_i) begin
                        fifo_rx_rd_o <= 1'b1;
                        state        <= ST_WAIT_BYTE;
                    end
                end

                ST_WAIT_BYTE: begin
                    state <= ST_PROC_BYTE;
                end

                ST_PROC_BYTE: begin
                    case (rx_phase)
                        // ---- Header ----
                        PHASE_HDR: begin
                            if (fifo_rx_data_i == HEADER_VAL) begin
                                crc_reg  <= calc_crc8(8'h00, HEADER_VAL);
                                rx_phase <= PHASE_TYPE;
                                state    <= ST_REQ_BYTE;
                            end else begin
                                state <= ST_IDLE; // Sai Header -> huy, tu resync o byte ke tiep
                            end
                        end

                        // ---- Type ----
                        PHASE_TYPE: begin
                            type_reg <= fifo_rx_data_i;
                            crc_reg  <= calc_crc8(crc_reg, fifo_rx_data_i);

                            if (fifo_rx_data_i == TYPE_LOOPBACK || fifo_rx_data_i == TYPE_SENSOR) begin
                                rx_phase <= PHASE_DATA;
                            end else begin
                                rx_phase <= PHASE_FLUSH; // Type khong ho tro -> xa het khung loi de giu dong bo
                            end
                            state <= ST_REQ_BYTE;
                        end

                        // ---- Data (dung khi gap Footer) ----
                        PHASE_DATA: begin
                            if (fifo_rx_data_i == FOOTER_VAL) begin
                                crc_reg  <= calc_crc8(crc_reg, FOOTER_VAL);
                                rx_phase <= PHASE_CRC;
                            end else begin
                                if (byte_cnt < MAX_PAYLOAD) begin
                                    data_buffer[byte_cnt] <= fifo_rx_data_i;
                                    byte_cnt               <= byte_cnt + 1'b1;
                                end
                                crc_reg <= calc_crc8(crc_reg, fifo_rx_data_i);
                                // rx_phase giu nguyen PHASE_DATA, tiep tuc doc byte ke
                            end
                            state <= ST_REQ_BYTE;
                        end

                        // ---- CRC: xac thuc TRUOC, chi re nhanh phat/forward khi khop ----
                        PHASE_CRC: begin
                            if (fifo_rx_data_i == crc_reg) begin
                                if (type_reg == TYPE_LOOPBACK) begin
                                    send_type_reg <= TYPE_LOOPBACK;
                                    tx_cnt        <= 8'h00;
                                    state         <= ST_SEND_HDR; // Da buffer an toan & khop CRC -> moi phat
                                end else begin // TYPE_SENSOR
                                    tx_cnt <= 8'h00;
                                    state  <= ST_SENS_EXEC;
                                end
                            end else begin
                                state <= ST_IDLE; // Sai CRC -> huy toan bo, CHUA co gi bi day ra ngoai
                            end
                        end

                        // ---- Xa khung loi (Type khong ho tro) de giu dong bo ----
                        PHASE_FLUSH: begin
                            if (fifo_rx_data_i == FOOTER_VAL)
                                rx_phase <= PHASE_FLUSH_CRC; // gap Footer -> doc not 1 byte CRC roi bo
                            // else: van PHASE_FLUSH, tiep tuc xa
                            state <= ST_REQ_BYTE;
                        end

                        PHASE_FLUSH_CRC: begin
                            state <= ST_IDLE; // Da xa xong CRC (gia tri bo qua) -> ve IDLE sach, khong lech khung sau
                        end

                        default: state <= ST_IDLE;
                    endcase
                end

                // -------------------------------------------------------------
                // 3. Day lenh Sensor da buffer & xac thuc CRC xuong sensor_tx
                // -------------------------------------------------------------
                ST_SENS_EXEC: begin
                    if (tx_cnt < byte_cnt) begin
                        if (!sensor_tx_full_i) begin
                            sensor_tx_data_o <= data_buffer[tx_cnt];
                            sensor_tx_wr_o   <= 1'b1;
                            tx_cnt           <= tx_cnt + 1'b1;
                        end
                    end else begin
                        state <= ST_IDLE;
                    end
                end

                // -------------------------------------------------------------
                // 4. Doc du lieu Sensor vao buffer TRUOC khi dong goi gui PC
                //    (buffer truoc, tinh CRC luc gui - nhat quan voi 2 luong kia)
                // -------------------------------------------------------------
                ST_SENS_READ_REQ: begin
                    if (!sensor_rx_empty_i && !fifo_tx_full_i) begin
                        sensor_rx_rd_o <= 1'b1;
                        state          <= ST_SENS_READ_WAIT;
                    end else if (sensor_rx_empty_i) begin
                        send_type_reg <= TYPE_SENSOR;
                        tx_cnt        <= 8'h00;
                        state         <= ST_SEND_HDR; // Het du lieu Sensor -> phat khung phan hoi
                    end
                end

                ST_SENS_READ_WAIT: begin
                    state <= ST_SENS_READ_STO;
                end

                ST_SENS_READ_STO: begin
                    if (byte_cnt < MAX_PAYLOAD) begin
                        data_buffer[byte_cnt] <= sensor_rx_data_i;
                        byte_cnt               <= byte_cnt + 1'b1;
                    end
                    state <= ST_SENS_READ_REQ;
                end

                // -------------------------------------------------------------
                // 5. DONG CO GUI DUNG CHUNG len PC: HDR -> TYPE -> DATA... -> FTR -> CRC
                //    Dung cho ca phan hoi Loopback lan goi du lieu Sensor->PC
                // -------------------------------------------------------------
                ST_SEND_HDR: begin
                    if (!fifo_tx_full_i) begin
                        fifo_tx_data_o <= HEADER_VAL;
                        fifo_tx_wr_o   <= 1'b1;
                        crc_reg        <= calc_crc8(8'h00, HEADER_VAL);
                        state          <= ST_SEND_TYPE;
                    end
                end

                ST_SEND_TYPE: begin
                    if (!fifo_tx_full_i) begin
                        fifo_tx_data_o <= send_type_reg;
                        fifo_tx_wr_o   <= 1'b1;
                        crc_reg        <= calc_crc8(crc_reg, send_type_reg);
                        state          <= ST_SEND_DATA;
                    end
                end

                ST_SEND_DATA: begin
                    if (tx_cnt < byte_cnt) begin
                        if (!fifo_tx_full_i) begin
                            fifo_tx_data_o <= data_buffer[tx_cnt];
                            fifo_tx_wr_o   <= 1'b1;
                            crc_reg        <= calc_crc8(crc_reg, data_buffer[tx_cnt]);
                            tx_cnt         <= tx_cnt + 1'b1;
                        end
                    end else begin
                        state <= ST_SEND_FTR;
                    end
                end

                ST_SEND_FTR: begin
                    if (!fifo_tx_full_i) begin
                        fifo_tx_data_o <= FOOTER_VAL;
                        fifo_tx_wr_o   <= 1'b1;
                        crc_reg        <= calc_crc8(crc_reg, FOOTER_VAL);
                        state          <= ST_SEND_CRC;
                    end
                end

                ST_SEND_CRC: begin
                    if (!fifo_tx_full_i) begin
                        fifo_tx_data_o <= crc_reg;
                        fifo_tx_wr_o   <= 1'b1;
                        state          <= ST_IDLE;
                    end
                end

                default: state <= ST_IDLE;
            endcase
        end
    end

endmodule