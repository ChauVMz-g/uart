module rx (
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

    // Synchronizer 2-stage chống hiện tượng Bất ổn định (Metastability)
    reg rx_sync_1, rx_sync_2;

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            rx_sync_1 <= 1'b1;
            rx_sync_2 <= 1'b1;
        end else begin
            rx_sync_1 <= rx_i;
            rx_sync_2 <= rx_sync_1;
        end
    end

    // FSM Giải mã UART RX
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            state     <= IDLE;
            rx_done_o <= 1'b0;
            tick_cnt  <= 4'd0;
            bit_cnt   <= 3'd0;
            b_reg     <= 8'h00;
            data_o    <= 8'h00;
        end else begin
            rx_done_o <= 1'b0; // Mặc định pulse rx_done_o kéo dài đúng 1 clk

            case (state)
                // -------------------------------------------------------------
                // IDLE: Chờ cạnh xuống (Start Bit)
                // -------------------------------------------------------------
                IDLE: begin
                    if (!rx_sync_2) begin
                        state    <= START;
                        tick_cnt <= 4'd0;
                    end
                end

                // -------------------------------------------------------------
                // START: Kiểm tra giữa Start Bit (Tick thứ 7)
                // -------------------------------------------------------------
                START: begin
                    if (s_tick_i) begin
                        if (tick_cnt == 4'd7) begin
                            if (!rx_sync_2) begin // Xác nhận Start bit hợp lệ
                                state    <= DATA;
                                tick_cnt <= 4'd0;
                                bit_cnt  <= 3'd0;
                            end else begin
                                state    <= IDLE; // Nhiễu tín hiệu -> Quay về IDLE
                            end
                        end else begin
                            tick_cnt <= tick_cnt + 1'b1;
                        end
                    end
                end

                // -------------------------------------------------------------
                // DATA: Lấy mẫu 8 bit dữ liệu (LSB First)
                // -------------------------------------------------------------
                DATA: begin
                    if (s_tick_i) begin
                        if (tick_cnt == 4'd15) begin
                            tick_cnt <= 4'd0;
                            b_reg    <= {rx_sync_2, b_reg[7:1]}; // Dịch phải
                            
                            if (bit_cnt == 3'd7)
                                state <= STOP;
                            else
                                bit_cnt <= bit_cnt + 1'b1;
                        end else begin
                            tick_cnt <= tick_cnt + 1'b1;
                        end
                    end
                end

                // -------------------------------------------------------------
                // STOP: Lấy mẫu giữa Stop Bit & Phát tín hiệu rx_done_o
                // -------------------------------------------------------------
                STOP: begin
                    if (s_tick_i) begin
                        if (tick_cnt == 4'd15) begin
                            // Chỉ chốt dữ liệu nếu Stop bit ở mức cao (1'b1)
                            if (rx_sync_2) begin
                                rx_done_o <= 1'b1;
                                data_o    <= b_reg;
                            end
                            state <= IDLE;
                        end else begin
                            tick_cnt <= tick_cnt + 1'b1;
                        end
                    end
                end

                default: state <= IDLE;
            endcase
        end
    end

endmodule