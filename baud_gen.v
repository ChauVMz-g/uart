module baud_gen #(
    parameter CLK_FREQ = 50000000, // Tần số clock hệ thống (Ví dụ: 50MHz)
    parameter BAUDRATE = 9600      // Tốc độ Baud mong muốn
)(
    input  wire clk_i,
    input  wire rst_i,
    output reg  s_tick_o
);

    // M = CLK_FREQ / (16 * BAUDRATE)
    localparam N = CLK_FREQ / (16 * BAUDRATE);
    reg [$clog2(N)-1:0] count;

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            count    <= 0;
            s_tick_o <= 1'b0;
        end else begin
            if (count == N - 1) begin
                count    <= 0;
                s_tick_o <= 1'b1;
            end else begin
                count    <= count + 1'b1;
                s_tick_o <= 1'b0;
            end
        end
    end

endmodule