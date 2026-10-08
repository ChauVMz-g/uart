module dma_pc #(
    parameter DATA_WIDTH      = 8,
    parameter BUFFER_DEPTH    = 1024,                  // Dung lượng Ring Buffer (ví dụ: 1024 Bytes)
    parameter MAX_PAYLOAD     = 1000,                  // Payload tối đa 1000 Bytes
    parameter MAX_PKT_QUEUE   = 16,                    // Số gói tin tối đa trong hàng đợi
    parameter START_BYTE      = 8'h23,                 // Ký tự bắt đầu (#)
    parameter STOP_BYTE       = 8'h24,                 // Ký tự kết thúc ($)
    parameter TIMEOUT_LIMIT   = 50_000_000             // Giới hạn Timeout (chu kỳ clock)
)(
    // ----------------------------------------------------
    // System Signals (Reset tích cực mức cao)
    // ----------------------------------------------------
    input  wire                  clk_i,
    input  wire                  rst_i,        // Reset tích cực mức cao

    // ----------------------------------------------------
    // Interface đọc từ FIFO
    // ----------------------------------------------------
    input  wire                  fifo_empty_i, // Báo FIFO trống
    output reg                   fifo_rd_o,    // DMA kích tín hiệu xin byte từ FIFO
    input  wire [DATA_WIDTH-1:0] w_data_i,     // Byte dữ liệu từ FIFO

    // ----------------------------------------------------
    // Interface nối trực tiếp với Process Block
    // ----------------------------------------------------
    input  wire                  rd_en,        // Process Block kích để lấy 1 byte
    output wire [DATA_WIDTH-1:0] r_data_o,     // Byte dữ liệu xuất tức thì (Combinational)
    output wire                  flag,         // Cờ báo có gói tin sẵn sàng
    output wire [$clog2(BUFFER_DEPTH):0] pkt_len_o // Tự động tính bit-width cho ngõ ra độ dài gói
);

    // ----------------------------------------------------
    // TỰ ĐỘNG TÍNH SỐ BIT BẰNG $clog2
    // ----------------------------------------------------
    localparam ADDR_WIDTH    = $clog2(BUFFER_DEPTH);  // $clog2(1024) = 10 bits
    localparam TIMEOUT_WIDTH = $clog2(TIMEOUT_LIMIT);  
    localparam QUEUE_WIDTH   = $clog2(MAX_PKT_QUEUE);  
    localparam MAX_PKT_SIZE  = MAX_PAYLOAD + 4;       // Tổng kích thước khung lớn nhất (1004 Bytes)

    // ----------------------------------------------------
    // Định nghĩa Trạng thái FSM
    // ----------------------------------------------------
    localparam ST_WAIT_START = 2'b00; // Săn Start Byte (0x23)
    localparam ST_REQ_BYTE   = 2'b01; // Xin 1 byte từ FIFO
    localparam ST_COLLECT    = 2'b10; // Lưu byte vào Ring Buffer
    localparam ST_GET_CRC    = 2'b11; // Lấy byte CRC (đứng ngay sau Stop Byte)

    reg [1:0] state;

    // Bộ nhớ đệm vòng
    reg [DATA_WIDTH-1:0] dma_buffer [0:BUFFER_DEPTH-1];
    
    // Con trỏ Ghi & Đọc đệm vòng
    reg [ADDR_WIDTH-1:0] wr_ptr;
    reg [ADDR_WIDTH-1:0] rd_ptr;
    reg [ADDR_WIDTH-1:0] current_pkt_start_ptr;
    reg [ADDR_WIDTH:0]   cur_pkt_write_len;

    // Quản lý Hàng đợi Gói tin (Packet Queue)
    reg [QUEUE_WIDTH:0]    pkt_cnt;
    reg [ADDR_WIDTH:0]     len_fifo [0:MAX_PKT_QUEUE-1];
    reg [QUEUE_WIDTH-1:0]  len_wr_ptr;
    reg [QUEUE_WIDTH-1:0]  len_rd_ptr;

    reg  pkt_inc;
    wire pkt_dec;
    wire last_byte_reading;

    // ----------------------------------------------------
    // KHỐI KHẮC PHỤC LỖI: TÍNH TOÁN DUNG LƯỢNG TRỐNG THỰC TẾ
    // ----------------------------------------------------
    wire [ADDR_WIDTH:0] occupied_bytes;
    wire [ADDR_WIDTH:0] free_space;
    wire                has_enough_space;

    // Tính số byte đang bị chiếm dụng bởi dữ liệu chưa đọc
    assign occupied_bytes = (wr_ptr >= rd_ptr) ? 
                            (wr_ptr - rd_ptr) : 
                            (BUFFER_DEPTH + wr_ptr - rd_ptr);

    // Tính số byte còn trống thực tế trong Ring Buffer
    assign free_space = BUFFER_DEPTH - occupied_bytes;

    // Chỉ cho phép nhận gói mới khi Dung lượng trống > Kích thước gói tối đa (MAX_PKT_SIZE)
    assign has_enough_space = (free_space > MAX_PKT_SIZE);

    // ----------------------------------------------------
    // 1. COMBINATIONAL OUTPUTS (0 Latency)
    // ----------------------------------------------------
    assign r_data_o = dma_buffer[rd_ptr];

    // Ngõ ra xuất độ dài thực tế của gói tin hiện tại
    assign pkt_len_o = (pkt_cnt > 0) ? len_fifo[len_rd_ptr] : {(ADDR_WIDTH+1){1'b0}};

    // Phát hiện Process Block đang đọc Byte cuối cùng (CRC)
    assign last_byte_reading = (rd_en && (pkt_cnt > 0) && 
                                (rd_ptr == (current_pkt_start_ptr + len_fifo[len_rd_ptr] - 1'b1)));

    assign pkt_dec = last_byte_reading;

    // Cờ Flag bật 1 tức thì nếu còn gói tin chưa đọc xong
    assign flag = (pkt_cnt > 1) || ((pkt_cnt == 1) && !last_byte_reading);

    // ----------------------------------------------------
    // 2. PACKET COUNTER LOGIC
    // ----------------------------------------------------
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            pkt_cnt <= 0;
        end else begin
            case ({pkt_inc, pkt_dec})
                2'b10:   pkt_cnt <= pkt_cnt + 1'b1;
                2'b01:   pkt_cnt <= pkt_cnt - 1'b1;
                default: pkt_cnt <= pkt_cnt;
            endcase
        end
    end

    // ----------------------------------------------------
    // 3. TIMEOUT COUNTER
    // ----------------------------------------------------
    reg [TIMEOUT_WIDTH:0] timeout_cnt;
    wire                  timeout_err;

    assign timeout_err = (timeout_cnt >= TIMEOUT_LIMIT);

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            timeout_cnt <= 0;
        end else begin
            if (state == ST_REQ_BYTE || state == ST_COLLECT || state == ST_GET_CRC) begin
                if (!fifo_empty_i) begin
                    timeout_cnt <= 0;
                end else if (!timeout_err) begin
                    timeout_cnt <= timeout_cnt + 1'b1;
                end
            end else begin
                timeout_cnt <= 0;
            end
        end
    end

    // ----------------------------------------------------
    // 4. FSM GHI: Đã bổ sung điều kiện 'has_enough_space'
    // ----------------------------------------------------
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            state             <= ST_WAIT_START;
            fifo_rd_o         <= 1'b0;
            wr_ptr            <= {ADDR_WIDTH{1'b0}};
            cur_pkt_write_len <= 0;
            len_wr_ptr        <= 0;
            pkt_inc           <= 1'b0;
        end else begin
            pkt_inc <= 1'b0;

            case (state)
                ST_WAIT_START: begin
                    cur_pkt_write_len <= 0;

                    // CHẶN AN TOÀN KÉP: Chỉ kích đọc FIFO khi thỏa mãn CẢ HẠN MỨC GÓI VÀ DUNG LƯỢNG BYTE TRỐNG
                    if (!fifo_empty_i && (pkt_cnt < MAX_PKT_QUEUE) && has_enough_space) begin
                        fifo_rd_o <= 1'b1;
                        state     <= ST_COLLECT;
                    end else begin
                        fifo_rd_o <= 1'b0;
                        state     <= ST_WAIT_START;
                    end
                end

                ST_REQ_BYTE: begin
                    if (timeout_err) begin
                        fifo_rd_o <= 1'b0;
                        wr_ptr    <= wr_ptr - cur_pkt_write_len[ADDR_WIDTH-1:0]; // Hoàn tác gói lỗi
                        state     <= ST_WAIT_START;
                    end else if (!fifo_empty_i) begin
                        fifo_rd_o <= 1'b1;
                        state     <= ST_COLLECT;
                    end else begin
                        fifo_rd_o <= 1'b0;
                        state     <= ST_REQ_BYTE;
                    end
                end

                ST_COLLECT: begin
                    fifo_rd_o <= 1'b0;

                    if (cur_pkt_write_len == 0) begin
                        if (w_data_i == START_BYTE) begin
                            dma_buffer[wr_ptr] <= w_data_i;
                            wr_ptr             <= wr_ptr + 1'b1;
                            cur_pkt_write_len  <= 1;
                            state              <= ST_REQ_BYTE;
                        end else begin
                            state <= ST_WAIT_START;
                        end
                    end else begin
                        dma_buffer[wr_ptr] <= w_data_i;
                        wr_ptr            <= wr_ptr + 1'b1;
                        cur_pkt_write_len <= cur_pkt_write_len + 1'b1;

                        if (w_data_i == STOP_BYTE) begin
                            state <= ST_GET_CRC;
                        end else if (cur_pkt_write_len >= (MAX_PAYLOAD + 3)) begin
                            // Bảo vệ bổ sung: Vượt quá giới hạn Payload -> Hủy gói
                            wr_ptr <= wr_ptr - cur_pkt_write_len[ADDR_WIDTH-1:0];
                            state  <= ST_WAIT_START;
                        end else begin
                            state  <= ST_REQ_BYTE;
                        end
                    end
                end

                ST_GET_CRC: begin
                    if (timeout_err) begin
                        fifo_rd_o <= 1'b0;
                        wr_ptr    <= wr_ptr - cur_pkt_write_len[ADDR_WIDTH-1:0];
                        state     <= ST_WAIT_START;
                    end else if (!fifo_empty_i && !fifo_rd_o) begin
                        fifo_rd_o <= 1'b1;
                        state     <= ST_GET_CRC;
                    end else if (fifo_rd_o) begin
                        fifo_rd_o          <= 1'b0;
                        dma_buffer[wr_ptr] <= w_data_i;
                        wr_ptr             <= wr_ptr + 1'b1;

                        len_fifo[len_wr_ptr] <= cur_pkt_write_len + 1'b1;
                        len_wr_ptr           <= len_wr_ptr + 1'b1;

                        pkt_inc <= 1'b1;
                        state   <= ST_WAIT_START;
                    end else begin
                        state <= ST_WAIT_START;
                    end
                end

                default: state <= ST_WAIT_START;
            endcase
        end
    end

    // ----------------------------------------------------
    // 5. TIẾN TRÌNH ĐỌC
    // ----------------------------------------------------
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            rd_ptr                <= {ADDR_WIDTH{1'b0}};
            len_rd_ptr            <= 0;
            current_pkt_start_ptr <= {ADDR_WIDTH{1'b0}};
        end else begin
            if (rd_en && flag) begin
                if (last_byte_reading) begin
                    current_pkt_start_ptr <= rd_ptr + 1'b1;
                    len_rd_ptr            <= len_rd_ptr + 1'b1;
                    rd_ptr                <= rd_ptr + 1'b1;
                end else begin
                    rd_ptr <= rd_ptr + 1'b1;
                end
            end
        end
    end

endmodule