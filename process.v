module process #(
    // =========================================================================
    // ĐỊNH NGHĨA CÁC THAM SỐ CẤU HÌNH GÓI TIN (PARAMETER)
    // =========================================================================
    parameter [7:0] HEADER_VAL   = 8'hAA, // Giá trị Byte Header
    parameter [7:0] FOOTER_VAL   = 8'h55, // Giá trị Byte Footer
    
    // Các loại Data Type
    parameter [7:0] TYPE_SENSOR  = 8'h01, // Lệnh điều khiển Sensor
    parameter [7:0] TYPE_LOOPBACK= 8'h02  // Lệnh Loopback phản hồi về TX
)(
    input  wire       clk_i,
    input  wire       rst_i,

    // Giao tiếp với FIFO_RX
    input  wire       fifo_rx_empty_i,
    output reg        rd_rq_o,        // Xung đọc dữ liệu từ FIFO_RX
    input  wire [7:0] data_i,         // Byte dữ liệu nhận từ FIFO_RX

    // Giao tiếp với FIFO_TX
    input  wire       fifo_tx_full_i,
    output reg        wr_en_tx_o,     // Xung ghi dữ liệu sang FIFO_TX
    output reg  [7:0] tx_data_o,      // Byte dữ liệu gửi sang FIFO_TX

    // Giao tiếp điều khiển Sensor
    output reg  [7:0] cmd_o,          // Mã lệnh cho Sensor
    output reg  [7:0] data_o          // Dữ liệu/Tham số cho Sensor
);

    // Định nghĩa các trạng thái FSM
    localparam ST_IDLE        = 4'd0,
               ST_REQ_HDR     = 4'd1,
               ST_PARSE_HDR   = 4'd2,
               ST_REQ_TYPE    = 4'd3,
               ST_PARSE_TYPE  = 4'd4,
               ST_REQ_CMD     = 4'd5,
               ST_PARSE_CMD   = 4'd6,
               ST_REQ_CRC     = 4'd7,
               ST_PARSE_CRC   = 4'd8,
               ST_REQ_FTR     = 4'd9,
               ST_PARSE_FTR   = 4'd10,
               ST_EXECUTE     = 4'd11;

    reg [3:0] state;

    // Bộ đệm lưu trữ tạm thời các byte của gói tin
    reg [7:0] header_reg;
    reg [7:0] type_reg;
    reg [7:0] cmd_reg;
    reg [7:0] crc_reg;
    reg [7:0] footer_reg;

    // Thuật toán kiểm tra CRC (Tổng XOR đơn giản của Datatype ^ Command)
    wire [7:0] calculated_crc = type_reg ^ cmd_reg;

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            state       <= ST_IDLE;
            rd_rq_o     <= 1'b0;
            wr_en_tx_o  <= 1'b0;
            tx_data_o   <= 8'h00;
            cmd_o       <= 8'h00;
            data_o      <= 8'h00;
            header_reg  <= 8'h00;
            type_reg    <= 8'h00;
            cmd_reg     <= 8'h00;
            crc_reg     <= 8'h00;
            footer_reg  <= 8'h00;
        end else begin
            // Mặc định hạ các xung điều khiển về 0 sau mỗi clock
            rd_rq_o    <= 1'b0;
            wr_en_tx_o <= 1'b0;

            case (state)
                // -------------------------------------------------------------
                // 1. CHỜ GÓI TIN MỚI
                // -------------------------------------------------------------
                ST_IDLE: begin
                    if (!fifo_rx_empty_i) begin
                        rd_rq_o <= 1'b1; // Phát xung yêu cầu đọc Byte 1 (Header)
                        state   <= ST_PARSE_HDR;
                    end
                end

                // -------------------------------------------------------------
                // 2. NHẬN & KIỂM TRA HEADER
                // -------------------------------------------------------------
                ST_PARSE_HDR: begin
                    header_reg <= data_i; // Chốt Byte 1 vào thanh ghi
                    if (data_i == HEADER_VAL) begin // Sử dụng Parameter HEADER_VAL
                        state <= ST_REQ_TYPE;
                    end else begin
                        state <= ST_IDLE; // Sai Header -> Hủy gói
                    end
                end

                // -------------------------------------------------------------
                // 3. ĐỌC DATATYPE
                // -------------------------------------------------------------
                ST_REQ_TYPE: begin
                    if (!fifo_rx_empty_i) begin
                        rd_rq_o <= 1'b1; // Phát xung yêu cầu đọc Byte 2
                        state   <= ST_PARSE_TYPE;
                    end
                end

                ST_PARSE_TYPE: begin
                    type_reg <= data_i; // Chốt Byte 2
                    state    <= ST_REQ_CMD;
                end

                // -------------------------------------------------------------
                // 4. ĐỌC COMMAND / DATA
                // -------------------------------------------------------------
                ST_REQ_CMD: begin
                    if (!fifo_rx_empty_i) begin
                        rd_rq_o <= 1'b1; // Phát xung yêu cầu đọc Byte 3
                        state   <= ST_PARSE_CMD;
                    end
                end

                ST_PARSE_CMD: begin
                    cmd_reg <= data_i; // Chốt Byte 3
                    state   <= ST_REQ_CRC;
                end

                // -------------------------------------------------------------
                // 5. ĐỌC CRC
                // -------------------------------------------------------------
                ST_REQ_CRC: begin
                    if (!fifo_rx_empty_i) begin
                        rd_rq_o <= 1'b1; // Phát xung yêu cầu đọc Byte 4
                        state   <= ST_PARSE_CRC;
                    end
                end

                ST_PARSE_CRC: begin
                    crc_reg <= data_i; // Chốt Byte 4
                    state   <= ST_REQ_FTR;
                end

                // -------------------------------------------------------------
                // 6. ĐỌC & KIỂM TRA FOOTER
                // -------------------------------------------------------------
                ST_REQ_FTR: begin
                    if (!fifo_rx_empty_i) begin
                        rd_rq_o <= 1'b1; // Phát xung yêu cầu đọc Byte 5
                        state   <= ST_PARSE_FTR;
                    end
                end

                ST_PARSE_FTR: begin
                    footer_reg <= data_i; // Chốt Byte 5
                    
                    // Kiểm tra cả Footer VÀ CRC
                    if (data_i == FOOTER_VAL && crc_reg == calculated_crc) begin // Sử dụng Parameter FOOTER_VAL
                        state <= ST_EXECUTE;
                    end else begin
                        state <= ST_IDLE; // Lỗi CRC/Footer -> Hủy gói
                    end
                end

                // -------------------------------------------------------------
                // 7. THỰC THI LỆNH
                // -------------------------------------------------------------
                ST_EXECUTE: begin
                    if (type_reg == TYPE_SENSOR) begin // Sử dụng Parameter TYPE_SENSOR
                        // Điều khiển Sensor
                        cmd_o  <= cmd_reg;
                        data_o <= cmd_reg;
                        state  <= ST_IDLE;
                    end 
                    else if (type_reg == TYPE_LOOPBACK) begin // Sử dụng Parameter TYPE_LOOPBACK
                        // Gửi Loopback sang FIFO_TX
                        if (!fifo_tx_full_i) begin
                            tx_data_o  <= cmd_reg;
                            wr_en_tx_o <= 1'b1; // Phát xung ghi vào FIFO_TX
                            state      <= ST_IDLE;
                        end
                    end 
                    else begin
                        state <= ST_IDLE;
                    end
                end

                default: state <= ST_IDLE;
            endcase
        end
    end

endmodule