module process #(
    parameter [7:0] HEADER_VAL    = 8'h23, // Byte Header '#'
    parameter [7:0] FOOTER_VAL    = 8'h24, // Byte Footer '$'
    parameter [7:0] CRC_VAL       = 8'h07, // CRC cố định
    
    parameter [7:0] TYPE_LOOPBACK = 8'h01, // Type Loopback
    parameter [7:0] TYPE_SENSOR   = 8'h02, // Type Sensor
    parameter       MAX_PAYLOAD   = 32     // Số byte Data tối đa cho phép
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

    // Giao tiếp với FIFO_TX Sensor (Gửi lệnh điều khiển xuống Sensor)
    input  wire        sensor_tx_full_i,
    output reg         sensor_tx_wr_o,
    output reg  [7:0]  sensor_tx_data_o,

    // Giao tiếp với FIFO_RX Sensor (Nhận dữ liệu từ Sensor)
    input  wire        sensor_rx_empty_i,
    output reg         sensor_rx_rd_o,
    input  wire [7:0]  sensor_rx_data_i
);

    // =========================================================================
    // ĐỊNH NGHĨA MÁY TRẠNG THÁI (FSM)
    // =========================================================================
    localparam ST_IDLE          = 4'd0,
               ST_WAIT_HDR      = 4'd1,
               ST_PARSE_HDR     = 4'd2,
               ST_READ_TYPE     = 4'd3,
               ST_WAIT_TYPE     = 4'd4,
               ST_PARSE_TYPE    = 4'd5,
               ST_READ_BYTE     = 4'd6,
               ST_WAIT_BYTE     = 4'd7,
               ST_PARSE_BYTE    = 4'd8,
               ST_EXEC_LOOPBACK = 4'd9,
               ST_EXEC_SENSOR   = 4'd10,
               ST_WAIT_SENS     = 4'd11,
               ST_FORWARD_SENS  = 4'd12;

    reg [3:0] state;

    reg [7:0] type_reg;
    reg [7:0] data_buffer [0:MAX_PAYLOAD-1];
    reg [7:0] byte_cnt;
    reg [7:0] tx_cnt;

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
        end else begin
            // Mặc định hạ các xung điều khiển trong 1 chu kỳ clock
            fifo_rx_rd_o   <= 1'b0;
            fifo_tx_wr_o   <= 1'b0;
            sensor_tx_wr_o <= 1'b0;
            sensor_rx_rd_o <= 1'b0;

            case (state)
                // -------------------------------------------------------------
                // 1. ST_IDLE: Kiểm tra ưu tiên
                // -------------------------------------------------------------
                ST_IDLE: begin
                    byte_cnt <= 8'h00;
                    tx_cnt   <= 8'h00;

                    // Ưu tiên 1: Đọc lệnh PC
                    if (!fifo_rx_empty_i) begin
                        fifo_rx_rd_o <= 1'b1;   // Kích đọc Header từ FIFO PC
                        state        <= ST_WAIT_HDR;
                    end 
                    // Ưu tiên 2: Chuyển tiếp dữ liệu Cảm biến
                    else if (!sensor_rx_empty_i && !fifo_tx_full_i) begin
                        sensor_rx_rd_o <= 1'b1; // Kích đọc từ FIFO Sensor
                        state          <= ST_WAIT_SENS;
                    end
                end

                // -------------------------------------------------------------
                // 2. PARSE HEADER
                // -------------------------------------------------------------
                ST_WAIT_HDR: begin
                    state <= ST_PARSE_HDR; // Chờ BRAM xuất dữ liệu ra bus
                end

                ST_PARSE_HDR: begin
                    if (fifo_rx_data_i == HEADER_VAL) begin
                        state <= ST_READ_TYPE;
                    end else begin
                        state <= ST_IDLE; // Sai Header -> Hủy
                    end
                end

                // -------------------------------------------------------------
                // 3. PARSE DATATYPE
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
                    state    <= ST_READ_BYTE;
                end

                // -------------------------------------------------------------
                // 4. READ PAYLOAD / CRC / FOOTER
                // -------------------------------------------------------------
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
                        // Đã đọc tới Footer -> Bắt đầu thực thi
                        if (type_reg == TYPE_LOOPBACK)
                            state <= ST_EXEC_LOOPBACK;
                        else if (type_reg == TYPE_SENSOR)
                            state <= ST_EXEC_SENSOR;
                        else
                            state <= ST_IDLE;
                    end 
                    else if (fifo_rx_data_i == CRC_VAL) begin
                        // Bỏ qua byte CRC, tiếp tục đọc byte tiếp theo (kỳ vọng Footer)
                        state <= ST_READ_BYTE;
                    end 
                    else begin
                        // Lưu byte dữ liệu vào Buffer
                        if (byte_cnt < MAX_PAYLOAD) begin
                            data_buffer[byte_cnt] <= fifo_rx_data_i;
                            byte_cnt              <= byte_cnt + 1'b1;
                        end
                        state <= ST_READ_BYTE;
                    end
                end

                // -------------------------------------------------------------
                // 5. THỰC THI LOOPBACK (Gửi ngược về PC)
                // -------------------------------------------------------------
                ST_EXEC_LOOPBACK: begin
                    if (tx_cnt < byte_cnt) begin
                        if (!fifo_tx_full_i) begin
                            fifo_tx_data_o <= data_buffer[tx_cnt];
                            fifo_tx_wr_o   <= 1'b1;
                            tx_cnt         <= tx_cnt + 1'b1;
                        end
                    end else begin
                        state <= ST_IDLE;
                    end
                end

                // -------------------------------------------------------------
                // 6. THỰC THI LỆNH SENSOR (Gửi xuống Sensor)
                // -------------------------------------------------------------
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
                // 7. CHUYỂN TIẾP DỮ LIỆU CẢM BIẾN VỀ PC
                // -------------------------------------------------------------
                ST_WAIT_SENS: begin
                    state <= ST_FORWARD_SENS; // Chờ BRAM Sensor xuất dữ liệu
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