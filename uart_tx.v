module uart_tx (
    input  wire       clk_i,
    input  wire       rst_i,
    input  wire       tx_start_i,
    input  wire       s_tick_i,
    input  wire [7:0] data_i,
    output reg        tx_o,
    output reg        tx_done_o
);

    localparam IDLE  = 2'b00,
               START = 2'b01,
               DATA  = 2'b10,
               STOP  = 2'b11;

    reg [1:0] state;
    reg [3:0] tick_cnt;
    reg [2:0] bit_cnt;
    reg [7:0] b_reg;

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            state     <= IDLE;
            tx_o      <= 1'b1; // Chân TX mặc định mức 1 (Idle)
            tx_done_o <= 1'b0;
            tick_cnt  <= 0;
            bit_cnt   <= 0;
            b_reg     <= 0;
        end else begin
            tx_done_o <= 1'b0;
            case (state)
                IDLE: begin
                    tx_o <= 1'b1;
                    if (tx_start_i) begin
                        state    <= START;
                        b_reg    <= data_i;
                        tick_cnt <= 0;
                    end
                end

                START: begin
                    tx_o <= 1'b0; // Start bit = 0
                    if (s_tick_i) begin
                        if (tick_cnt == 15) begin
                            state    <= DATA;
                            tick_cnt <= 0;
                            bit_cnt  <= 0;
                        end else begin
                            tick_cnt <= tick_cnt + 1'b1;
                        end
                    end
                end

                DATA: begin
                    tx_o <= b_reg[0]; // Truyền bit LSB trước
                    if (s_tick_i) begin
                        if (tick_cnt == 15) begin
                            tick_cnt <= 0;
                            b_reg    <= b_reg >> 1;
                            if (bit_cnt == 7)
                                state <= STOP;
                            else
                                bit_cnt <= bit_cnt + 1'b1;
                        end else begin
                            tick_cnt <= tick_cnt + 1'b1;
                        end
                    end
                end

                STOP: begin
                    tx_o <= 1'b1; // Stop bit = 1
                    if (s_tick_i) begin
                        if (tick_cnt == 15) begin
                            state     <= IDLE;
                            tx_done_o <= 1'b1; // Báo phát hoàn tất
                        end else begin
                            tick_cnt <= tick_cnt + 1'b1;
                        end
                    end
                end
            endcase
        end
    end

endmodule