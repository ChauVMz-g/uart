module fifo #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8  // Dung lượng FIFO = 2^8 = 256 byte
)(
    input  wire                  clk_i,
    input  wire                  rst_i,
    input  wire                  wr_en,
    input  wire                  rd_en,
    input  wire [DATA_WIDTH-1:0] w_data_i,
    output reg  [DATA_WIDTH-1:0] r_data_o,
    output wire                  empty_o,
    output wire                  full_o
);

    localparam DEPTH = 1 << ADDR_WIDTH;

    // Bộ nhớ BRAM
    reg [DATA_WIDTH-1:0] memory [0:DEPTH-1];
    reg [ADDR_WIDTH-1:0] w_ptr, r_ptr;
    reg [ADDR_WIDTH:0]   fifo_cnt;

    wire write_valid = wr_en && !full_o;
    wire read_valid  = rd_en && !empty_o;

    // 1. Thao tác GHI (Ghi vào BRAM)
    always @(posedge clk_i) begin
        if (write_valid) begin
            memory[w_ptr] <= w_data_i;
        end
    end

    // 2. Thao tác ĐỌC (Đọc từ BRAM & Reset ngõ ra)
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            r_data_o <= {DATA_WIDTH{1'b0}};
        end else if (read_valid) begin
            r_data_o <= memory[r_ptr];
        end
    end

    // 3. Cập nhật con trỏ và đếm số lượng
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            w_ptr    <= 0;
            r_ptr    <= 0;
            fifo_cnt <= 0;
        end else begin
            // Cập nhật con trỏ ghi
            if (write_valid)
                w_ptr <= w_ptr + 1'b1;

            // Cập nhật con trỏ đọc
            if (read_valid)
                r_ptr <= r_ptr + 1'b1;

            // Cập nhật bộ đếm fifo_cnt
            case ({write_valid, read_valid})
                2'b10:   fifo_cnt <= fifo_cnt + 1'b1;
                2'b01:   fifo_cnt <= fifo_cnt - 1'b1;
                default: fifo_cnt <= fifo_cnt; // Đọc & Ghi đồng thời hoặc không làm gì
            endcase
        end
    end

    assign empty_o = (fifo_cnt == 0);
    assign full_o  = (fifo_cnt == DEPTH);

endmodule