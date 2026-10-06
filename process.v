module process #(
    parameter [7:0] HEADER_VAL    = 8'h23, // '#'
    parameter [7:0] FOOTER_VAL    = 8'h24, // '$'
    parameter [7:0] CRC_VAL       = 8'h07, // CRC-8 polynomial

    parameter [7:0] TYPE_LOOPBACK = 8'h01,
    parameter [7:0] TYPE_SENSOR   = 8'h02,

    parameter       MAX_PAYLOAD   = 1024,
    parameter [7:0] SENSOR_LEN    = 8'd13
)(
    input  wire        clk_i,
    input  wire        rst_i,

    // ============================================================
    // FIFO RX MAIN - Nhan packet tu PC
    // ============================================================
    input  wire        fifo_rx_empty_i,
    output reg         fifo_rx_rd_o,
    input  wire [7:0]  fifo_rx_data_i,

    // ============================================================
    // FIFO TX MAIN - Gui packet ve PC
    // ============================================================
    input  wire        fifo_tx_full_i,
    output reg         fifo_tx_wr_o,
    output reg  [7:0]  fifo_tx_data_o,

    // ============================================================
    // FIFO TX SENSOR - Gui data xuong Sensor
    // ============================================================
    input  wire        sensor_tx_full_i,
    output reg         sensor_tx_wr_o,
    output reg  [7:0]  sensor_tx_data_o,

    // ============================================================
    // FIFO RX SENSOR - Nhan 12 byte tu Sensor
    // ============================================================
    input  wire        sensor_rx_empty_i,
    output reg         sensor_rx_rd_o,
    input  wire [7:0]  sensor_rx_data_i
);

    // ============================================================
    // CRC-8
    // Polynomial: x^8 + x^2 + x + 1 = 0x07
    //
    // CRC duoc tinh tuong tu:
    //
    // CRC = CRC8(
    //      HEADER +
    //      TYPE +
    //      DATA[0..11] +
    //      FOOTER
    // )
    // ============================================================
    function [7:0] calc_crc8;
        input [7:0] crc_in;
        input [7:0] data_in;

        reg [7:0] crc;
        reg       mix;
        integer   i;

        begin
            crc = crc_in;
            for (i = 0; i < 8; i = i + 1) begin
                mix = crc[7] ^ data_in[7];
                crc = {crc[6:0], 1'b0};
                data_in = {data_in[6:0], 1'b0};
                if (mix)
                    crc = crc ^ 8'h07;
            end
            calc_crc8 = crc;
        end
    endfunction

    // ============================================================
    // MAIN FSM
    // ============================================================
    localparam [3:0]
        ST_IDLE           = 4'd0,
        ST_REQ_BYTE       = 4'd1,
        ST_WAIT_BYTE      = 4'd2,
        ST_PROC_BYTE      = 4'd3,

        ST_SENS_EXEC      = 4'd4,

        ST_SENS_READ_REQ  = 4'd5,
        ST_SENS_READ_WAIT = 4'd6,
        ST_SENS_READ_STO  = 4'd7,

        ST_SEND_HDR       = 4'd8,
        ST_SEND_TYPE      = 4'd9,
        ST_SEND_DATA      = 4'd10,
        ST_SEND_FTR       = 4'd11,
        ST_SEND_CRC       = 4'd12;

    // ============================================================
    // RX PHASE - Nhan packet tu PC
    // ============================================================
    localparam [2:0]
        PHASE_HDR       = 3'd0,
        PHASE_TYPE      = 3'd1,
        PHASE_DATA      = 3'd2,
        PHASE_CRC       = 3'd3,
        PHASE_FLUSH     = 3'd4,
        PHASE_FLUSH_CRC = 3'd5;


    // ============================================================
    // REGISTERS
    // ============================================================
    reg [3:0] state;
    reg [2:0] rx_phase;

    reg [7:0] type_reg;
    reg [7:0] send_type_reg;

    reg [7:0] data_buffer [0:MAX_PAYLOAD-1];

    reg [11:0] byte_cnt;
    reg [11:0] tx_cnt;

    reg [7:0] crc_reg;


    // ============================================================
    // MAIN SEQUENTIAL BLOCK
    // ============================================================
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            // ----------------------------------------------------
            // RESET FSM
            // ----------------------------------------------------
            state            <= ST_IDLE;
            rx_phase         <= PHASE_HDR;

            // Main RX FIFO
            fifo_rx_rd_o     <= 1'b0;

            // Main TX FIFO
            fifo_tx_wr_o     <= 1'b0;
            fifo_tx_data_o   <= 8'h00;

            // Sensor TX FIFO
            sensor_tx_wr_o   <= 1'b0;
            sensor_tx_data_o <= 8'h00;

            // Sensor RX FIFO
            sensor_rx_rd_o   <= 1'b0;

            // Registers
            type_reg         <= 8'h00;
            send_type_reg    <= 8'h00;

            byte_cnt         <= 11'h00;
            tx_cnt           <= 11'h00;

            crc_reg          <= 8'h00;

        end
        else begin
            // ====================================================
            // DEFAULT: cac pulse WR/RD chi ton tai 1 clock
            // ====================================================
            fifo_rx_rd_o   <= 1'b0;
            fifo_tx_wr_o   <= 1'b0;
            sensor_tx_wr_o <= 1'b0;
            sensor_rx_rd_o <= 1'b0;

            // ====================================================
            // FSM
            // ====================================================
            case (state)
                // =================================================
                // 1. IDLE
                //
                // Uu tien xu ly lenh tu PC.
                // Neu khong co lenh PC thi kiem tra Sensor FIFO.
                // =================================================
                ST_IDLE: begin
                    byte_cnt <= 11'h00;
                    tx_cnt   <= 11'h00;
                    if (!fifo_rx_empty_i) begin
                        rx_phase <= PHASE_HDR;
                        state <= ST_REQ_BYTE;
                    end
                    else if (!sensor_rx_empty_i) begin
                        // Bat dau doc 12 byte tu Sensor
                        byte_cnt <= 11'h00;
                        state <= ST_SENS_READ_REQ;
                    end
                end

                // =================================================
                // 2. REQUEST BYTE FROM PC FIFO
                // =================================================
                ST_REQ_BYTE: begin
                    if (!fifo_rx_empty_i) begin
                        fifo_rx_rd_o <= 1'b1;
                        state <= ST_WAIT_BYTE;
                    end
                end

                // =================================================
                // 3. WAIT 1 CLOCK FOR SYNCHRONOUS FIFO READ
                // =================================================
                ST_WAIT_BYTE: begin
                    state <= ST_PROC_BYTE;
                end

                // =================================================
                // 4. PROCESS BYTE FROM PC
                // =================================================
                ST_PROC_BYTE: begin
                    case (rx_phase)
                        // =================================================
                        // HEADER
                        // =================================================
                        PHASE_HDR: begin
                            if (fifo_rx_data_i == HEADER_VAL) begin
                                // Bat dau CRC tu HEADER
                                crc_reg <= calc_crc8(8'h00, HEADER_VAL);
                                rx_phase <= PHASE_TYPE;
                                state <= ST_REQ_BYTE;
                            end
                            else begin
                                // Header sai
                                state <= ST_IDLE;
                            end
                        end
                        // =================================================
                        // TYPE
                        // =================================================
                        PHASE_TYPE: begin
                            type_reg <= fifo_rx_data_i;
                            // CRC = CRC(HEADER + TYPE)
                            crc_reg <= calc_crc8(crc_reg, fifo_rx_data_i);

                            if (fifo_rx_data_i == TYPE_LOOPBACK || fifo_rx_data_i == TYPE_SENSOR) 
                            begin
                                byte_cnt <= 11'h00;
                                rx_phase <= PHASE_DATA;
                            end
                            else begin
                                rx_phase <= PHASE_FLUSH;
                            end
                            state <= ST_REQ_BYTE;
                        end
                        // =================================================
                        // DATA
                        // =================================================
                        PHASE_DATA: begin
                            if (fifo_rx_data_i == FOOTER_VAL) begin
                                // Footer da den
                                // CRC = CRC(HEADER + TYPE + DATA + FOOTER)
                                crc_reg <= calc_crc8(
                                    crc_reg,
                                    FOOTER_VAL
                                );

                                rx_phase <= PHASE_CRC;
                            end
                            else begin
                                if (byte_cnt < MAX_PAYLOAD) begin
                                    data_buffer[byte_cnt] <= fifo_rx_data_i;
                                    byte_cnt <= byte_cnt + 1'b1;
                                end

                                // Them DATA vao CRC
                                crc_reg <= calc_crc8(crc_reg, fifo_rx_data_i
                                );
                            end
                            state <= ST_REQ_BYTE;
                        end


                        // =================================================
                        // CRC FROM PC
                        // =================================================
                        PHASE_CRC: begin
                            if (fifo_rx_data_i == crc_reg) begin
                                // CRC dung
                                if (type_reg == TYPE_LOOPBACK) begin
                                    send_type_reg <= TYPE_LOOPBACK;
                                    tx_cnt <= 11'h00;
                                    state <= ST_SEND_HDR;
                                end
                                else if (type_reg == TYPE_SENSOR) begin
                                    tx_cnt <= 11'h00;
                                    state <= ST_SENS_EXEC;
                                end
                                else begin
                                    state <= ST_IDLE;
                                end
                            end
                            else begin
                                // CRC sai
                                state <= ST_IDLE;
                            end
                        end

                        // =================================================
                        // FLUSH PACKET SAI TYPE
                        // =================================================
                        PHASE_FLUSH: begin
                            if (fifo_rx_data_i == FOOTER_VAL)
                                rx_phase <= PHASE_FLUSH_CRC;
                            state <= ST_REQ_BYTE;
                        end

                        // =================================================
                        // BO QUA CRC CUA PACKET SAI TYPE
                        // =================================================
                        PHASE_FLUSH_CRC: begin
                            state <= ST_IDLE;
                        end
                        default: begin
                            state <= ST_IDLE;
                        end
                    endcase
                end

                // =================================================
                // 5. GUI DATA LEN SENSOR
                //
                // data_buffer[0..byte_cnt-1]
                // =================================================
                ST_SENS_EXEC: begin
                    if (tx_cnt < byte_cnt) begin
                        if (!sensor_tx_full_i) begin
                            sensor_tx_data_o <= data_buffer[tx_cnt];
                            sensor_tx_wr_o <= 1'b1;
                            tx_cnt <= tx_cnt + 1'b1;
                        end
                    end
                    else begin
                        // Da gui xong lenh Sensor
                        byte_cnt <= 11'h00;
                        tx_cnt   <= 11'h00;
                        state <= ST_IDLE;
                    end
                end

                // =================================================
                // 6. REQUEST READ FROM SENSOR RX FIFO
                //
                // Doc DUNG 12 BYTE.
                // =================================================
                ST_SENS_READ_REQ: begin
                    if (byte_cnt < SENSOR_LEN) begin
                        if (!sensor_rx_empty_i) begin
                            sensor_rx_rd_o <= 1'b1;
                            state <= ST_SENS_READ_WAIT;
                        end
                    end
                    else begin
                        // -----------------------------------------
                        // DA DOC DU 12 BYTE
                        // -----------------------------------------
                        send_type_reg <= TYPE_SENSOR;
                        tx_cnt <= 11'h00;
                        state <= ST_SEND_HDR;
                    end
                end

                // =================================================
                // 7. WAIT FOR SYNCHRONOUS SENSOR FIFO
                // =================================================
                ST_SENS_READ_WAIT: begin
                    state <= ST_SENS_READ_STO;
                end

                // =================================================
                // 8. STORE ONE SENSOR BYTE
                //
                // data_buffer[0]  = Sensor byte 0
                // data_buffer[1]  = Sensor byte 1
                // ...
                // data_buffer[11] = Sensor byte 11
                // =================================================
                ST_SENS_READ_STO: begin
                    if (byte_cnt < SENSOR_LEN) begin
                        data_buffer[byte_cnt] <= sensor_rx_data_i;
                        byte_cnt <= byte_cnt + 1'b1;
                    end
                    state <= ST_SENS_READ_REQ;
                end

                // =================================================
                // 9. SEND HEADER TO PC
                // =================================================
                ST_SEND_HDR: begin
                    if (!fifo_tx_full_i) begin
                        fifo_tx_data_o <= HEADER_VAL;
                        fifo_tx_wr_o <= 1'b1;
                        // CRC = CRC(HEADER)
                        crc_reg <= calc_crc8(8'h00, HEADER_VAL);
                        state <= ST_SEND_TYPE;
                    end
                end

                // =================================================
                // 10. SEND TYPE TO PC
                // =================================================
                ST_SEND_TYPE: begin
                    if (!fifo_tx_full_i) begin
                        fifo_tx_data_o <= send_type_reg;
                        fifo_tx_wr_o <= 1'b1;
                        // CRC = CRC(HEADER + TYPE)
                        crc_reg <= calc_crc8(
                            crc_reg,
                            send_type_reg
                        );
                        state <= ST_SEND_DATA;
                    end
                end

                // =================================================
                // 11. SEND DATA TO PC
                //
                // Sensor:
                // DATA[0] -> DATA[11]
                // =================================================
                ST_SEND_DATA: begin
                    if (tx_cnt < byte_cnt) begin
                        if (!fifo_tx_full_i) begin
                            fifo_tx_data_o <= data_buffer[tx_cnt];
                            fifo_tx_wr_o <= 1'b1;

                            // CRC them DATA
                            crc_reg <= calc_crc8(crc_reg, data_buffer[tx_cnt]);
                            tx_cnt <= tx_cnt + 1'b1;
                        end
                    end
                    else begin
                        // Da gui het DATA
                        state <= ST_SEND_FTR;
                    end
                end
                // =================================================
                // 12. SEND FOOTER
                //
                // CRC luc nay:
                //
                // CRC(
                //     HEADER +
                //     TYPE +
                //     DATA[0..11]
                // )
                //
                // Sau state nay:
                //
                // CRC(
                //     HEADER +
                //     TYPE +
                //     DATA[0..11] +
                //     FOOTER
                // )
                // =================================================
                ST_SEND_FTR: begin
                    if (!fifo_tx_full_i) begin
                        fifo_tx_data_o <= FOOTER_VAL;
                        fifo_tx_wr_o <= 1'b1;
                        crc_reg <= calc_crc8(crc_reg, FOOTER_VAL);
                        state <= ST_SEND_CRC;
                    end
                end

                // =================================================
                // 13. SEND CRC
                // =================================================
                ST_SEND_CRC: begin
                    if (!fifo_tx_full_i) begin
                        fifo_tx_data_o <= crc_reg;
                        fifo_tx_wr_o <= 1'b1;
                        state <= ST_IDLE;
                    end
                end

                // =================================================
                // DEFAULT
                // =================================================
                default: begin
                    state <= ST_IDLE;
                end
            endcase
        end
    end
endmodule