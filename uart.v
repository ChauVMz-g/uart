module uart #(
    // =========================================================================
    // THAM Sá» Cáº¤U HÃŒNH Há»† THá»NG & BAUD RATE
    // =========================================================================
    parameter CLK_FREQ       = 50000000, // Táº§n sá»‘ clock há»‡ thá»‘ng (Hz) - 50 MHz
    parameter BAUDRATE       = 9600,     // Tá»‘c Ä‘á»™ truyá»n Baud Rate (bps) - 9600

    // Tham sá»‘ cáº¥u hÃ¬nh khung gÃ³i tin & Buffer
    parameter [7:0] HEADER_VAL    = 8'h23, // Byte '#'
    parameter [7:0] FOOTER_VAL    = 8'h24, // Byte '$'
    parameter [7:0] CRC_VAL       = 8'h07, // Byte CRC
    parameter [7:0] TYPE_LOOPBACK = 8'h01,
    parameter [7:0] TYPE_SENSOR   = 8'h02,
    parameter       MAX_PAYLOAD   = 1024,
	 parameter       SENSOR_LEN    = 8'd13;
	 parameter       DATA_WIDTH = 8,
    parameter       ADDR_WIDTH = 10
)(
    input  wire        clk_i,             // Clock há»‡ thá»‘ng
    input  wire        rst_i,             // Reset há»‡ thá»‘ng (Active High)

    // Giao tiáº¿p UART vá»›i MÃ¡y tÃ­nh (PC / Host)
    input  wire        rx_i,              // ChÃ¢n RX nháº­n dá»¯ liá»‡u tá»« PC
    output wire        tx_o,              // ChÃ¢n TX gá»­i dá»¯ liá»‡u vá» PC

    // Giao tiáº¿p UART vá»›i Cáº£m biáº¿n (Sensor)
    input  wire        sensor_rx_i,       // ChÃ¢n RX nháº­n dá»¯ liá»‡u tá»« Sensor
    output wire        sensor_tx_o,        // ChÃ¢n TX gá»­i lá»‡nh xuá»‘ng Sensor	

    //Hiá»ƒn thá»‹ máº¡ch Ä‘ang hoáº¡t dá»™ng hay chÆ°a
    output wire        led_rst_status_o  // Náº¿u rst tÃ­ch cá»±c cao, thÃ¬ led táº¯t
);

    // =========================================================================
    // DÃ‚Y DáºªN Ná»˜I Bá»˜ (INTERNAL WIRES)
    // =========================================================================

    // 1. TÃ­n hiá»‡u Baud Rate Generator (Sampling Tick 16x)
    wire       s_tick;

    // 2. KÃªnh PC RX (PC -> UART RX -> FIFO PC RX -> Process)
    wire       pc_rx_done;
    wire [7:0] pc_rx_data;
    wire       fifo_pc_rx_empty;
    wire       process_rd_pc_rx;
    wire [7:0] fifo_pc_rx_rdata;

    // 3. KÃªnh PC TX (Process -> FIFO PC TX -> TX Controller -> UART TX -> PC)
    wire       fifo_pc_tx_full;
    wire       fifo_pc_tx_empty;
    wire       process_wr_pc_tx;
    wire [7:0] process_pc_tx_wdata;
    wire       tx_ctrl_rd_pc_fifo;
    wire [7:0] fifo_pc_tx_rdata;
    wire       tx_ctrl_start_pc_uart;
    wire       pc_uart_tx_done;

    // 4. KÃªnh Sensor TX (Process -> FIFO Sensor TX -> TX Controller -> UART Sensor TX -> Sensor)
    wire       fifo_sensor_tx_full;
    wire       fifo_sensor_tx_empty;
    wire       process_wr_sensor_tx;
    wire [7:0] process_sensor_tx_wdata;
    wire       tx_ctrl_rd_sensor_fifo;
    wire [7:0] fifo_sensor_tx_rdata;
    wire       tx_ctrl_start_sensor_uart;
    wire       sensor_uart_tx_done;

    // 5. KÃªnh Sensor RX (Sensor -> UART Sensor RX -> FIFO Sensor RX -> Process)
    wire       sensor_rx_done;
    wire [7:0] sensor_rx_data;
    wire       fifo_sensor_rx_empty;
    wire       process_rd_sensor_rx;
    wire [7:0] fifo_sensor_rx_rdata;

    //6. Led hiá»ƒn thá»‹ trÃ¬nh tráº¡ng hoáº¡t Ä‘á»ng cá»§a máº¡ch
    //Náº¿u rst tÃ­ch cá»±c tháº¥p, led sÃ¡ng
    assign     led_rst_status_o = rst_i;

    // =========================================================================
    // INSTANTIATION CÃC KHá»I CON
    // =========================================================================

    // -------------------------------------------------------------------------
    // 1. BAUD RATE GENERATOR (DÃ¹ng chung cho cáº£ 2 kÃªnh UART PC & Sensor)
    // -------------------------------------------------------------------------
    baud_gen #(
        .CLK_FREQ (CLK_FREQ),
        .BAUDRATE (BAUDRATE)
    ) u_baud_gen (
        .clk_i    (clk_i),
        .rst_i    (rst_i),
        .s_tick_o (s_tick)
    );

    // -------------------------------------------------------------------------
    // 2. KÃŠNH UART PC (NHáº¬N & Gá»¬I Dá»® LIá»†U Vá»šI PC)
    // -------------------------------------------------------------------------
    // UART RX tá»« PC
    rx u_rx_pc (
        .clk_i     (clk_i),
        .rst_i     (rst_i),
        .rx_i      (rx_i),
        .s_tick_i  (s_tick),
        .rx_done_o (pc_rx_done),
        .data_o    (pc_rx_data)
    );

    // FIFO Ä‘á»‡m dá»¯ liá»‡u RX tá»« PC
    fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) u_fifo_pc_rx (
        .clk_i     (clk_i),
        .rst_i     (rst_i),
        .wr_en     (pc_rx_done),
        .w_data_i  (pc_rx_data),
        .rd_en     (process_rd_pc_rx),
        .r_data_o  (fifo_pc_rx_rdata),
        .empty_o   (fifo_pc_rx_empty),
        .full_o    ()
    );

    // FIFO Ä‘á»‡m dá»¯ liá»‡u TX gá»­i vá» PC
    fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) u_fifo_pc_tx (
        .clk_i     (clk_i),
        .rst_i     (rst_i),
        .wr_en     (process_wr_pc_tx),
        .w_data_i  (process_pc_tx_wdata),
        .rd_en     (tx_ctrl_rd_pc_fifo),
        .r_data_o  (fifo_pc_tx_rdata),
        .empty_o   (fifo_pc_tx_empty),
        .full_o    (fifo_pc_tx_full)
    );

    // Äiá»u khiá»ƒn Handshake Ä‘á»c FIFO TX PC & phÃ¡t UART TX
    tx_controller u_tx_controller_pc (
        .clk_i        (clk_i),
        .rst_i        (rst_i),
        .fifo_empty_i (fifo_pc_tx_empty),
        .fifo_rd_o    (tx_ctrl_rd_pc_fifo),
        .tx_done_i    (pc_uart_tx_done),
        .uart_start_o (tx_ctrl_start_pc_uart)
    );

    // UART TX gá»­i vá» PC
    tx u_tx_pc (
        .clk_i      (clk_i),
        .rst_i      (rst_i),
        .tx_start_i (tx_ctrl_start_pc_uart),
        .s_tick_i   (s_tick),
        .data_i     (fifo_pc_tx_rdata),
        .tx_o       (tx_o),
        .tx_done_o  (pc_uart_tx_done),
        .tx_busy_o  ()
    );

    // -------------------------------------------------------------------------
    // 3. KHá»I Xá»¬ LÃ & GIáº¢I MÃƒ GÃ“I TIN (PROCESS)
    // -------------------------------------------------------------------------
    process #(
        .HEADER_VAL    (HEADER_VAL),
        .FOOTER_VAL    (FOOTER_VAL),
        .CRC_VAL       (CRC_VAL),
        .TYPE_LOOPBACK (TYPE_LOOPBACK),
        .TYPE_SENSOR   (TYPE_SENSOR),
        .MAX_PAYLOAD   (MAX_PAYLOAD),
		  .SENSOR_LEN    (SENSOR_LEN)
    ) u_process (
        .clk_i             (clk_i),
        .rst_i             (rst_i),

        // Äá»c tá»« FIFO RX PC
        .fifo_rx_empty_i   (fifo_pc_rx_empty),
        .fifo_rx_rd_o      (process_rd_pc_rx),
        .fifo_rx_data_i    (fifo_pc_rx_rdata),

        // Ghi vÃ o FIFO TX PC
        .fifo_tx_full_i    (fifo_pc_tx_full),
        .fifo_tx_wr_o      (process_wr_pc_tx),
        .fifo_tx_data_o    (process_pc_tx_wdata),

        // Ghi vÃ o FIFO TX Sensor
        .sensor_tx_full_i  (fifo_sensor_tx_full),
        .sensor_tx_wr_o    (process_wr_sensor_tx),
        .sensor_tx_data_o  (process_sensor_tx_wdata),

        // Äá»c tá»« FIFO RX Sensor
        .sensor_rx_empty_i (fifo_sensor_rx_empty),
        .sensor_rx_rd_o    (process_rd_sensor_rx),
        .sensor_rx_data_i  (fifo_sensor_rx_rdata)
    );

    // -------------------------------------------------------------------------
    // 4. KÃŠNH UART SENSOR (NHáº¬N & Gá»¬I Dá»® LIá»†U Vá»šI Cáº¢M BIáº¾N)
    // -------------------------------------------------------------------------
    // FIFO Ä‘á»‡m lá»‡nh TX gá»­i xuá»‘ng Sensor
    fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) u_fifo_sensor_tx (
        .clk_i     (clk_i),
        .rst_i     (rst_i),
        .wr_en     (process_wr_sensor_tx),
        .w_data_i  (process_sensor_tx_wdata),
        .rd_en     (tx_ctrl_rd_sensor_fifo),
        .r_data_o  (fifo_sensor_tx_rdata),
        .empty_o   (fifo_sensor_tx_empty),
        .full_o    (fifo_sensor_tx_full)
    );

    // Äiá»u khiá»ƒn Handshake Ä‘á»c FIFO TX Sensor & phÃ¡t UART TX
    tx_controller u_tx_controller_sensor (
        .clk_i        (clk_i),
        .rst_i        (rst_i),
        .fifo_empty_i (fifo_sensor_tx_empty),
        .fifo_rd_o    (tx_ctrl_rd_sensor_fifo),
        .tx_done_i    (sensor_uart_tx_done),
        .uart_start_o (tx_ctrl_start_sensor_uart)
    );

    // UART TX gá»­i xuá»‘ng Sensor
    tx u_tx_sensor (
        .clk_i      (clk_i),
        .rst_i      (rst_i),
        .tx_start_i (tx_ctrl_start_sensor_uart),
        .s_tick_i   (s_tick),
        .data_i     (fifo_sensor_tx_rdata),
        .tx_o       (sensor_tx_o),
        .tx_done_o  (sensor_uart_tx_done),
        .tx_busy_o  ()
    );

    // UART RX nháº­n tá»« Sensor
    rx u_rx_sensor (
        .clk_i     (clk_i),
        .rst_i     (rst_i),
        .rx_i      (sensor_rx_i),
        .s_tick_i  (s_tick),
        .rx_done_o (sensor_rx_done),
        .data_o    (sensor_rx_data)
    );

    // FIFO Ä‘á»‡m dá»¯ liá»‡u RX tá»« Sensor
    fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) u_fifo_sensor_rx (
        .clk_i     (clk_i),
        .rst_i     (rst_i),
        .wr_en     (sensor_rx_done),
        .w_data_i  (sensor_rx_data),
        .rd_en     (process_rd_sensor_rx),
        .r_data_o  (fifo_sensor_rx_rdata),
        .empty_o   (fifo_sensor_rx_empty),
        .full_o    ()
    );

endmodule