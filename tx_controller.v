module tx_controller (
    input  wire clk_i,
    input  wire rst_i,

    // FIFO Interface
    input  wire fifo_empty_i,
    output reg  fifo_rd_o,

    // UART Interface
    input  wire tx_done_i,
    output reg  uart_start_o
);

    localparam STATE_IDLE      = 2'b00,
               STATE_READ_FIFO = 2'b01,
               STATE_START_TX  = 2'b10,
               STATE_WAIT_DONE = 2'b11;

    reg [1:0] state;

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            state        <= STATE_IDLE;
            fifo_rd_o    <= 1'b0;
            uart_start_o <= 1'b0;
        end else begin
            fifo_rd_o    <= 1'b0;
            uart_start_o <= 1'b0;

            case (state)
                STATE_IDLE: begin
                    if (!fifo_empty_i) begin
                        state <= STATE_READ_FIFO;
                    end
                end

                STATE_READ_FIFO: begin
                    fifo_rd_o <= 1'b1;         // Kích đọc FIFO (đợi 1 clock ra BRAM data)
                    state     <= STATE_START_TX;
                end

                STATE_START_TX: begin
                    uart_start_o <= 1'b1;       // Kích UART phát
                    state        <= STATE_WAIT_DONE;
                end

                STATE_WAIT_DONE: begin
                    // Đứng chờ xung tx_done_i (1 clock pulse) báo gửi xong byte
                    if (tx_done_i) begin
                        state <= STATE_IDLE;
                    end
                end

                default: state <= STATE_IDLE;
            endcase
        end
    end

endmodule