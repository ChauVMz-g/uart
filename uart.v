module uart #(
    // =========================================================================
    // CÁC THAM SỐ CẤU HÌNH HỆ THỐNG & BAUD RATE
    // =========================================================================
    parameter CLK_FREQ     = 50000000, // Tần số clock hệ thống (Hz) - Mặc định 50 MHz
    parameter BAUDRATE     = 9600,     // Tốc độ truyền Baud Rate (bps) - Mặc định 9600

    // Các tham số định nghĩa khung gói tin
    parameter [7:0] HEADER_VAL   = 8'h23,
    parameter [7:0] FOOTER_VAL   = 8'h54,
    parameter [7:0] TYPE_LOOPBACK= 8'h01,
    parameter [7:0] TYPE_SENSOR  = 8'h02
)(
    input  wire       clk_i,       // System Clock
    input  wire       rst_i,       // Reset hệ thống (Active High)

    // Giao tiếp UART vật lý với bên ngoài
    input  wire       rx_i,        // Chân nhận RX
    output wire       tx_o,        // Chân truyền TX

    // Đầu ra điều khiển ngoại vi (Sensor)
    output wire [7:0] cmd_o,       // Mã lệnh giải mã được    ///Sai
    output wire [7:0] data_o       // Dữ liệu/Tham số đi kèm  ///Sai
);

    // =========================================================================
    // DÂY DẪN NỘI BỘ (INTERNAL WIRES)
    // =========================================================================

    // 1. Tín hiệu Baud Rate Tick
    wire       s_tick;

    // 2. Kết nối UART_RX -> FIFO_RX
    wire       rx_done_to_fifo_wr;
    wire [7:0] rx_data_to_fifo_wdata;

    // 3. Kết nối FIFO_RX -> PROCESS
    wire       fifo_rx_empty;
    wire       process_rd_rq_rx;
    wire [7:0] fifo_rx_rdata;

    // 4. Kết nối PROCESS -> FIFO_TX
    wire       fifo_tx_full;
    wire       process_wr_en_tx;
    wire [7:0] process_tx_wdata;

    // 5. Kết nối FIFO_TX, TX_CONTROLLER và UART_TX
    wire       fifo_tx_empty;
    wire       tx_ctrl_rd_fifo;
    wire [7:0] fifo_tx_rdata;
    wire       tx_ctrl_start_uart;
    wire       uart_tx_done;


    // =========================================================================
    // INSTANTIATION 7 KHỐI CON
    // =========================================================================

    // 1. Khối Baud Rate Generator (Nhận CLK_FREQ và BAUDRATE từ Top Module)
    baud_gen #(
        .CLK_FREQ (CLK_FREQ),
        .BAUDRATE (BAUDRATE)
    ) u_baud_gen (
        .clk_i    (clk_i),
        .rst_i    (rst_i),
        .s_tick_o (s_tick)
    );

    // 2. Khối UART RX
    uart_rx u_uart_rx (
        .clk_i     (clk_i),
        .rst_i     (rst_i),
        .rx_i      (rx_i),
        .s_tick_i  (s_tick),
        .rx_done_o (rx_done_to_fifo_wr),
        .data_o    (rx_data_to_fifo_wdata)
    );

    // 3. Bộ đệm FIFO RX
    fifo u_fifo_rx (
        .clk_i     (clk_i),
        .rst_i     (rst_i),
        .wr_en     (rx_done_to_fifo_wr),
        .w_data_i  (rx_data_to_fifo_wdata),
        .rd_en     (process_rd_rq_rx),
        .r_data_o  (fifo_rx_rdata),
        .empty_o   (fifo_rx_empty),
        .full_o    ()
    );

    // 4. Khối PROCESS (Giải mã & Xử lý gói tin)
    process #(
        .HEADER_VAL   (HEADER_VAL),
        .FOOTER_VAL   (FOOTER_VAL),
        .TYPE_SENSOR  (TYPE_SENSOR),
        .TYPE_LOOPBACK(TYPE_LOOPBACK)
    ) u_process (
        .clk_i           (clk_i),
        .rst_i           (rst_i),
        
        .fifo_rx_empty_i (fifo_rx_empty),
        .rd_rq_o         (process_rd_rq_rx),
        .data_i          (fifo_rx_rdata),
        
        .fifo_tx_full_i  (fifo_tx_full),
        .wr_en_tx_o      (process_wr_en_tx),
        .tx_data_o       (process_tx_wdata),
        
        .cmd_o           (cmd_o),
        .data_o          (data_o)
    );

    // 5. Bộ đệm FIFO TX
    fifo u_fifo_tx (
        .clk_i     (clk_i),
        .rst_i     (rst_i),
        .wr_en     (process_wr_en_tx),
        .w_data_i  (process_tx_wdata),
        .rd_en     (tx_ctrl_rd_fifo),
        .r_data_o  (fifo_tx_rdata),
        .empty_o   (fifo_tx_empty),
        .full_o    (fifo_tx_full)
    );

    // 6. Khối TX_CONTROLLER (Điều phối Handshake)
    tx_controller u_tx_controller (
        .clk_i        (clk_i),
        .rst_i        (rst_i),
        .fifo_empty_i (fifo_tx_empty),
        .fifo_rd_o    (tx_ctrl_rd_fifo),
        .tx_done_i    (uart_tx_done),
        .uart_start_o (tx_ctrl_start_uart)
    );

    // 7. Khối UART TX
    uart_tx u_uart_tx (
        .clk_i     (clk_i),
        .rst_i     (rst_i),
        .s_tick_i  (s_tick),
        .tx_start_i(tx_ctrl_start_uart),
        .data_i    (fifo_tx_rdata),
        .tx_done_o (uart_tx_done),
        .tx_o      (tx_o)
    );

endmodule