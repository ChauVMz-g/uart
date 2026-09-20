module process #(
    parameter [7:0] HEADER_VAL    = 8'h23, // Byte Header '#'
    parameter [7:0] FOOTER_VAL    = 8'h24, // Byte Footer '$'
    parameter [7:0] CRC_VAL       = 8'h07, // CRC mặc định / fallback
    
    parameter [7:0] TYPE_LOOPBACK = 8'h01, // Type Loopback
    parameter [7:0] TYPE_SENSOR   = 8'h02, // Type Sensor
    parameter       MAX_PAYLOAD   = 32     // Kích thước Payload tối đa cho gói tin Sensor
)(
    input  wire        clk_i,
    input  wire        rst_i,

    // Giao tiếp với FIFO_RX Main (Nhận gói tin từ PC)
    input  wire        fifo_rx_empty_i,
    output reg         fifo_rx_rd_o,
    input  wire [7:0]  fifo_rx_data_i,

    // Giao tiếp với FIFO_TX Main (Gửi phản hồi về PC)
    input  wire        fifo_tx_full_i,
    output reg         fifo_tx_wr_o,
    output reg  [7:0]  fifo_tx_data_o,

    // Giao tiếp với FIFO_TX Sensor (Gửi lệnh xuống Sensor)
    input  wire        sensor_tx_full_i,
    output reg         sensor_tx_wr_o,
    output reg  [7:0]  sensor_tx_data_o,

    // Giao tiếp với FIFO_RX Sensor (Nhận dữ liệu từ Sensor)
    input  wire        sensor_rx_empty_i,
    output reg         sensor_rx_rd_o,
    input  wire [7:0]  sensor_rx_data_i
);

    // =========================================================================
    // HÀM TÍNH CRC-8 ĐỘNG (Dallas/Maxim Poly 0x07: X^8 + X^2 + X + 1)
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
    // ĐỊNH NGHĨA MÁY TRẠNG THÁI (FSM)
    // =========================================================================
    localparam ST_IDLE          = 5'd0,
               ST_WAIT_HDR      = 5'd1,
               ST_PARSE_HDR     = 5'd2,
               ST_READ_TYPE     = 5'd3,
               ST_WAIT_TYPE     = 5'd4,
               ST_PARSE_TYPE    = 5'd5,
               
               // Nhánh Loopback Stream
               ST_LB_SEND_HDR   = 5'd6,
               ST_LB_SEND_TYPE  = 5'd7,
               ST_LB_REQ_BYTE   = 5'd8,
               ST_LB_WAIT_BYTE  = 5'd9,
               ST_LB_FORWARD    = 5'd10,
               ST_LB_SEND_CRC   = 5'd11,
               ST_LB_SEND_FTR   = 5'd12,

               // Nhánh Sensor / Lệnh ngắn
               ST_READ_BYTE     = 5'd13,
               ST_WAIT_BYTE     = 5'd14,
               ST_PARSE_BYTE    = 5'd15,
               ST_EXEC_SENSOR   = 5'd16,

               // Nhánh Forward Sensor
               ST_WAIT_SENS     = 5'd17,
               ST_FORWARD_SENS  = 5'd18;

    reg [4:0] state;
    reg [7:0] type_reg;
    reg [7:0] data_buffer [0:MAX_PAYLOAD-1];
    reg [7:0] byte_cnt;
    reg [7:0] tx_cnt;
    
    // Thanh ghi lưu CRC động
    reg [7:0] crc_reg;

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            state            <= ST_IDLE;
            fifo_rx_rd_o     <= 1'b0;
            fifo_tx_wr_o     <= 1'b0;
            fifo_tx_data_o   <= 8'h00;
            sensor_tx_wr_o   <= 1'b0;
            sensor_tx_data_o <= 8'h00;
            sensor_rx_rd_o   <= 1'b0;
            type_reg         <= 8'h00;
            byte_cnt         <= 8'h00;
            tx_cnt           <= 8'h00;
            crc_reg          <= 8'h00;
        end else begin
            // Mặc định hạ các tín hiệu strobe trong 1 chu kỳ clock
            fifo_rx_rd_o   <= 1'b0;
            fifo_tx_wr_o   <= 1'b0;
            sensor_tx_wr_o <= 1'b0;
            sensor_rx_rd_o <= 1'b0;

            case (state)
                // -------------------------------------------------------------
                // 1. ST_IDLE
                // -------------------------------------------------------------
                ST_IDLE: begin
                    byte_cnt <= 8'h00;
                    tx_cnt   <= 8'h00;

                    if (!fifo_rx_empty_i) begin
                        fifo_rx_rd_o <= 1'b1;
                        state        <= ST_WAIT_HDR;
                    end 
                    else if (!sensor_rx_empty_i && !fifo_tx_full_i) begin
                        sensor_rx_rd_o <= 1'b1;
                        state          <= ST_WAIT_SENS;
                    end
                end

                // -------------------------------------------------------------
                // 2. PARSE HEADER
                // -------------------------------------------------------------
                ST_WAIT_HDR: begin
                    state <= ST_PARSE_HDR;
                end

                ST_PARSE_HDR: begin
                    if (fifo_rx_data_i == HEADER_VAL) begin
                        crc_reg <= 8'h00; // Reset giá trị CRC tích lũy khi bắt đầu gói tin mới
                        state   <= ST_READ_TYPE;
                    end else begin
                        state   <= ST_IDLE;
                    end
                end

                // -------------------------------------------------------------
                // 3. PARSE TYPE
                // -------------------------------------------------------------
                ST_READ_TYPE: begin
                    if (!fifo_rx_empty_i) begin
                        fifo_rx_rd_o <= 1'b1;
                        state        <= ST_WAIT_TYPE;
                    end
                end

                ST_WAIT_TYPE: begin
                    state <= ST_PARSE_TYPE;
                end

                ST_PARSE_TYPE: begin
                    type_reg <= fifo_rx_data_i;
                    if (fifo_rx_data_i == TYPE_LOOPBACK) begin
                        state <= ST_LB_SEND_HDR;
                    end else begin
                        state <= ST_READ_BYTE;
                    end
                end

                // =============================================================
                // 4. NHÁNH LOOPBACK STREAMING (TÍNH CRC ĐỘNG)
                // =============================================================
                ST_LB_SEND_HDR: begin
                    if (!fifo_tx_full_i) begin
                        fifo_tx_data_o <= HEADER_VAL;
                        fifo_tx_wr_o   <= 1'b1;
                        state          <= ST_LB_SEND_TYPE;
                    end
                end

                ST_LB_SEND_TYPE: begin
                    if (!fifo_tx_full_i) begin
                        fifo_tx_data_o <= TYPE_LOOPBACK;
                        fifo_tx_wr_o   <= 1'b1;
                        state          <= ST_LB_REQ_BYTE;
                    end
                end

                ST_LB_REQ_BYTE: begin
                    if (!fifo_rx_empty_i && !fifo_tx_full_i) begin
                        fifo_rx_rd_o <= 1'b1;
                        state        <= ST_LB_WAIT_BYTE;
                    end
                end

                ST_LB_WAIT_BYTE: begin
                    state <= ST_LB_FORWARD;
                end

                ST_LB_FORWARD: begin
                    if (fifo_rx_data_i == FOOTER_VAL) begin
                        // Đã đọc tới Footer -> Chuyển sang gửi byte CRC động
                        state <= ST_LB_SEND_CRC;
                    end 
                    else if (fifo_rx_data_i == CRC_VAL) begin
                        // Bỏ qua byte CRC trong khung nhận từ PC
                        state <= ST_LB_REQ_BYTE;
                    end 
                    else begin
                        // 1. Chuyển tiếp dữ liệu sang FIFO_TX
                        fifo_tx_data_o <= fifo_rx_data_i;
                        fifo_tx_wr_o   <= 1'b1;
                        
                        // 2. Tính toán và cộng dồn CRC cho byte vừa nhận
                        crc_reg        <= calc_crc8(crc_reg, fifo_rx_data_i);
                        
                        state          <= ST_LB_REQ_BYTE;
                    end
                end

                ST_LB_SEND_CRC: begin
                    if (!fifo_tx_full_i) begin
                        fifo_tx_data_o <= crc_reg; // Đẩy giá trị CRC-8 động đã tính
                        fifo_tx_wr_o   <= 1'b1;
                        state          <= ST_LB_SEND_FTR;
                    end
                end

                ST_LB_SEND_FTR: begin
                    if (!fifo_tx_full_i) begin
                        fifo_tx_data_o <= FOOTER_VAL;
                        fifo_tx_wr_o   <= 1'b1;
                        state          <= ST_IDLE;
                    end
                end

                // =============================================================
                // 5. NHÁNH LỆNH SENSOR
                // =============================================================
                ST_READ_BYTE: begin
                    if (!fifo_rx_empty_i) begin
                        fifo_rx_rd_o <= 1'b1;
                        state        <= ST_WAIT_BYTE;
                    end
                end

                ST_WAIT_BYTE: begin
                    state <= ST_PARSE_BYTE;
                end

                ST_PARSE_BYTE: begin
                    if (fifo_rx_data_i == FOOTER_VAL) begin
                        if (type_reg == TYPE_SENSOR)
                            state <= ST_EXEC_SENSOR;
                        else
                            state <= ST_IDLE;
                    end 
                    else if (fifo_rx_data_i == CRC_VAL) begin
                        state <= ST_READ_BYTE;
                    end 
                    else begin
                        if (byte_cnt < MAX_PAYLOAD) begin
                            data_buffer[byte_cnt] <= fifo_rx_data_i;
                            byte_cnt              <= byte_cnt + 1'b1;
                        end
                        state <= ST_READ_BYTE;
                    end
                end

                ST_EXEC_SENSOR: begin
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
                // 6. CHUYỂN TIẾP DỮ LIỆU SENSOR
                // -------------------------------------------------------------
                ST_WAIT_SENS: begin
                    state <= ST_FORWARD_SENS;
                end

                ST_FORWARD_SENS: begin
                    fifo_tx_data_o <= sensor_rx_data_i;
                    fifo_tx_wr_o   <= 1'b1;
                    state          <= ST_IDLE;
                end

                default: state <= ST_IDLE;
            endcase
        end
    end

endmodule