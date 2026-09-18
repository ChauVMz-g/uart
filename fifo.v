module fifo #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 4  // Dung lượng FIFO = 2^4 = 16 byte
)(
    input  wire                  clk_i,
    input  wire                  rst_i,
    input  wire                  wr_en,
    input  wire                  rd_en,
    input  wire [DATA_WIDTH-1:0] w_data_i,
    output wire [DATA_WIDTH-1:0] r_data_o,
    output wire                  empty_o,
    output wire                  full_o
);

    reg [DATA_WIDTH-1:0] memory [0:(1<<ADDR_WIDTH)-1];
    reg [ADDR_WIDTH-1:0] w_ptr, r_ptr;
    reg [ADDR_WIDTH:0]   fifo_cnt;

    // Ghi dữ liệu vào FIFO
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i)
            w_ptr <= 0;
        else if (wr_en && !full_o) begin
            memory[w_ptr] <= w_data_i;
            w_ptr <= w_ptr + 1'b1;
        end
    end

    // Đọc dữ liệu từ FIFO
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i)
            r_ptr <= 0;
        else if (rd_en && !empty_o) begin
            r_ptr <= r_ptr + 1'b1;
        end
    end

    // Quản lý số lượng phần tử
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i)
            fifo_cnt <= 0;
        else case ({wr_en && !full_o, rd_en && !empty_o})
            2'b10: fifo_cnt <= fifo_cnt + 1'b1;
            2'b01: fifo_cnt <= fifo_cnt - 1'b1;
            default: fifo_cnt <= fifo_cnt;
        endcase
    end

    assign r_data_o = memory[r_ptr];
    assign empty_o  = (fifo_cnt == 0);
    assign full_o   = (fifo_cnt == (1 << ADDR_WIDTH));

endmodule