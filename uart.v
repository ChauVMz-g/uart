module uart #(
    // =========================================================================
    // THAM SỐ CẤU HÌNH HỆ THỐNG & BAUD RATE
    // =========================================================================
    parameter CLK_FREQ       = 50000000, // Tần số clock hệ thống (Hz) - 50 MHz
    parameter BAUDRATE       = 9600,     // Tốc độ truyền Baud Rate (bps) - 9600

    // Tham số cấu hình khung gói tin & Buffer
    parameter [7:0] HEADER_VAL    = 8'h23, // Byte '#'
    parameter [7:0] FOOTER_VAL    = 8'h24, // Byte '$'
    parameter [7:0] CRC_VAL       = 8'h07, // Byte CRC
    parameter [7:0] TYPE_LOOPBACK = 8'h01,
    parameter [7:0] TYPE_SENSOR   = 8'h02,
    parameter       MAX_PAYLOAD   = 32,
    parameter       FIFO_DEPTH    = 16
)(
    input  wire        clk_i,             // Clock hệ thống
    input  wire        rst_i,             // Reset hệ thống (Active High)

    // Giao tiếp UART với Máy tính (PC / Host)
    input  wire        rx_i,              // Chân RX nhận dữ liệu từ PC
    output wire        tx_o,              // Chân TX gửi dữ liệu về PC

    // Giao tiếp UART với Cảm biến (Sensor)
    input  wire        sensor_rx_i,       // Chân RX nhận dữ liệu từ Sensor
    output wire        sensor_tx_o        // Chân TX gửi lệnh xuống Sensor
);

    // =========================================================================
    // DÂY DẪN NỘI BỘ (INTERNAL WIRES)
    // =========================================================================

    // 1. Tín hiệu Baud Rate Generator (Sampling Tick 16x)
    wire       s_tick;

    // 2. Kênh PC RX (PC -> UART RX -> FIFO PC RX -> Process)
    wire       pc_rx_done;
    wire [7:0] pc_rx_data;
    wire       fifo_pc_rx_empty;
    wire       process_rd_pc_rx;
    wire [7:0] fifo_pc_rx_rdata;

    // 3. Kênh PC TX (Process -> FIFO PC TX -> TX Controller -> UART TX -> PC)
    wire       fifo_pc_tx_full;
    wire       fifo_pc_tx_empty;
    wire       process_wr_pc_tx;
    wire [7:0] process_pc_tx_wdata;
    wire       tx_ctrl_rd_pc_fifo;
    wire [7:0] fifo_pc_tx_rdata;
    wire       tx_ctrl_start_pc_uart;
    wire       pc_uart_tx_done;

    // 4. Kênh Sensor TX (Process -> FIFO Sensor TX -> TX Controller -> UART Sensor TX -> Sensor)
    wire       fifo_sensor_tx_full;
    wire       fifo_sensor_tx_empty;
    wire       process_wr_sensor_tx;
    wire [7:0] process_sensor_tx_wdata;
    wire       tx_ctrl_rd_sensor_fifo;
    wire [7:0] fifo_sensor_tx_rdata;
    wire       tx_ctrl_start_sensor_uart;
    wire       sensor_uart_tx_done;

    // 5. Kênh Sensor RX (Sensor -> UART Sensor RX -> FIFO Sensor RX -> Process)
    wire       sensor_rx_done;
    wire [7:0] sensor_rx_data;
    wire       fifo_sensor_rx_empty;
    wire       process_rd_sensor_rx;
    wire [7:0] fifo_sensor_rx_rdata;


    // =========================================================================
    // INSTANTIATION CÁC KHỐI CON
    // =========================================================================

    // -------------------------------------------------------------------------
    // 1. BAUD RATE GENERATOR (Dùng chung cho cả 2 kênh UART PC & Sensor)
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
    // 2. KÊNH UART PC (NHẬN & GỬI DỮ LIỆU VỚI PC)
    // -------------------------------------------------------------------------
    // UART RX từ PC
    rx u_rx_pc (
        .clk_i     (clk_i),
        .rst_i     (rst_i),
        .rx_i      (rx_i),
        .s_tick_i  (s_tick),
        .rx_done_o (pc_rx_done),
        .data_o    (pc_rx_data)
    );

    // FIFO đệm dữ liệu RX từ PC
    fifo #(
        .DATA_WIDTH(8),
        .ADDR_WIDTH(4) // DEPTH = 16
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

    // FIFO đệm dữ liệu TX gửi về PC
    fifo #(
        .DATA_WIDTH(8),
        .ADDR_WIDTH(4)
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

    // Điều khiển Handshake đọc FIFO TX PC & phát UART TX
    tx_controller u_tx_controller_pc (
        .clk_i        (clk_i),
        .rst_i        (rst_i),
        .fifo_empty_i (fifo_pc_tx_empty),
        .fifo_rd_o    (tx_ctrl_rd_pc_fifo),
        .tx_done_i    (pc_uart_tx_done),
        .uart_start_o (tx_ctrl_start_pc_uart)
    );

    // UART TX gửi về PC
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
    // 3. KHỐI XỬ LÝ & GIẢI MÃ GÓI TIN (PROCESS)
    // -------------------------------------------------------------------------
    process #(
        .HEADER_VAL    (HEADER_VAL),
        .FOOTER_VAL    (FOOTER_VAL),
        .CRC_VAL       (CRC_VAL),
        .TYPE_LOOPBACK (TYPE_LOOPBACK),
        .TYPE_SENSOR   (TYPE_SENSOR),
        .MAX_PAYLOAD   (MAX_PAYLOAD)
    ) u_process (
        .clk_i             (clk_i),
        .rst_i             (rst_i),

        // Đọc từ FIFO RX PC
        .fifo_rx_empty_i   (fifo_pc_rx_empty),
        .fifo_rx_rd_o      (process_rd_pc_rx),
        .fifo_rx_data_i    (fifo_pc_rx_rdata),

        // Ghi vào FIFO TX PC
        .fifo_tx_full_i    (fifo_pc_tx_full),
        .fifo_tx_wr_o      (process_wr_pc_tx),
        .fifo_tx_data_o    (process_pc_tx_wdata),

        // Ghi vào FIFO TX Sensor
        .sensor_tx_full_i  (fifo_sensor_tx_full),
        .sensor_tx_wr_o    (process_wr_sensor_tx),
        .sensor_tx_data_o  (process_sensor_tx_wdata),

        // Đọc từ FIFO RX Sensor
        .sensor_rx_empty_i (fifo_sensor_rx_empty),
        .sensor_rx_rd_o    (process_rd_sensor_rx),
        .sensor_rx_data_i  (fifo_sensor_rx_rdata)
    );

    // -------------------------------------------------------------------------
    // 4. KÊNH UART SENSOR (NHẬN & GỬI DỮ LIỆU VỚI CẢM BIẾN)
    // -------------------------------------------------------------------------
    // FIFO đệm lệnh TX gửi xuống Sensor
    fifo #(
        .DATA_WIDTH(8),
        .ADDR_WIDTH(4)
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

    // Điều khiển Handshake đọc FIFO TX Sensor & phát UART TX
    tx_controller u_tx_controller_sensor (
        .clk_i        (clk_i),
        .rst_i        (rst_i),
        .fifo_empty_i (fifo_sensor_tx_empty),
        .fifo_rd_o    (tx_ctrl_rd_sensor_fifo),
        .tx_done_i    (sensor_uart_tx_done),
        .uart_start_o (tx_ctrl_start_sensor_uart)
    );

    // UART TX gửi xuống Sensor
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

    // UART RX nhận từ Sensor
    rx u_rx_sensor (
        .clk_i     (clk_i),
        .rst_i     (rst_i),
        .rx_i      (sensor_rx_i),
        .s_tick_i  (s_tick),
        .rx_done_o (sensor_rx_done),
        .data_o    (sensor_rx_data)
    );

    // FIFO đệm dữ liệu RX từ Sensor
    fifo #(
        .DATA_WIDTH(8),
        .ADDR_WIDTH(4)
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