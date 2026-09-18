module uart_rx (
    input  wire       clk_i,
    input  wire       rst_i,
    input  wire       rx_i,
    input  wire       s_tick_i,
    output reg        rx_done_o,
    output reg  [7:0] data_o
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
            rx_done_o <= 1'b0;
            tick_cnt  <= 0;
            bit_cnt   <= 0;
            b_reg     <= 0;
            data_o    <= 0;
        end else begin
            rx_done_o <= 1'b0;
            case (state)
                IDLE: begin
                    if (!rx_i) begin // Phát hiện Start bit (mức 0)
                        state    <= START;
                        tick_cnt <= 0;
                    end
                end

                START: begin
                    if (s_tick_i) begin
                        if (tick_cnt == 7) begin // Lấy mẫu ở giữa Start bit
                            state    <= DATA;
                            tick_cnt <= 0;
                            bit_cnt  <= 0;
                        end else begin
                            tick_cnt <= tick_cnt + 1'b1;
                        end
                    end
                end

                DATA: begin
                    if (s_tick_i) begin
                        if (tick_cnt == 15) begin // Đủ 16 ticks cho 1 bit
                            tick_cnt <= 0;
                            b_reg    <= {rx_i, b_reg[7:1]}; // Dịch bit LSB trước
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
                    if (s_tick_i) begin
                        if (tick_cnt == 15) begin // Đã nhận xong Stop bit
                            state     <= IDLE;
                            rx_done_o <= 1'b1;
                            data_o    <= b_reg;
                        end else begin
                            tick_cnt <= tick_cnt + 1'b1;
                        end
                    end
                end
            endcase
        end
    end

endmodule