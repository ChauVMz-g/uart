module tx (
    input  wire       clk_i,
    input  wire       rst_i,
    input  wire       tx_start_i,
    input  wire       s_tick_i,
    input  wire [7:0] data_i,
    output reg        tx_o,
    output reg        tx_done_o,
    output wire       tx_busy_o
);

    localparam IDLE  = 2'b00,
               START = 2'b01,
               DATA  = 2'b10,
               STOP  = 2'b11;

    reg [1:0] state;
    reg [3:0] tick_cnt;
    reg [2:0] bit_cnt;
    reg [7:0] b_reg;

    // Cờ báo bận: Bận khi khác trạng thái IDLE
    assign tx_busy_o = (state != IDLE);

    // FSM Điều khiển truyền UART TX
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            state     <= IDLE;
            tx_o      <= 1'b1;
            tx_done_o <= 1'b0;
            tick_cnt  <= 4'd0;
            bit_cnt   <= 3'd0;
            b_reg     <= 8'h00;
        end else begin
            tx_done_o <= 1'b0; // Mặc định pulse tx_done_o kéo dài đúng 1 clk

            case (state)
                // -------------------------------------------------------------
                // IDLE: Chờ tín hiệu tx_start_i
                // -------------------------------------------------------------
                IDLE: begin
                    tx_o <= 1'b1; // Mức cao khi nghỉ (Idle state)
                    if (tx_start_i) begin
                        state    <= START;
                        b_reg    <= data_i; // Chốt byte dữ liệu cần gửi
                        tick_cnt <= 4'd0;
                    end
                end

                // -------------------------------------------------------------
                // START: Kéo đường truyền xuống 0 trong 16 ticks (Start Bit)
                // -------------------------------------------------------------
                START: begin
                    tx_o <= 1'b0;
                    if (s_tick_i) begin
                        if (tick_cnt == 4'd15) begin
                            state    <= DATA;
                            tick_cnt <= 4'd0;
                            bit_cnt  <= 3'd0;
                        end else begin
                            tick_cnt <= tick_cnt + 1'b1;
                        end
                    end
                end

                // -------------------------------------------------------------
                // DATA: Truyền 8 bit dữ liệu (LSB First)
                // -------------------------------------------------------------
                DATA: begin
                    tx_o <= b_reg[0]; // Xuất bit LSB hiện tại
                    if (s_tick_i) begin
                        if (tick_cnt == 4'd15) begin
                            tick_cnt <= 4'd0;
                            b_reg    <= {1'b0, b_reg[7:1]}; // Dịch phải
                            
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
                // STOP: Kéo đường truyền lên 1 trong 16 ticks (Stop Bit)
                // -------------------------------------------------------------
                STOP: begin
                    tx_o <= 1'b1;
                    if (s_tick_i) begin
                        if (tick_cnt == 4'd15) begin
                            state     <= IDLE;
                            tx_done_o <= 1'b1; // Phát xung báo truyền xong
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