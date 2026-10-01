`timescale 1ns / 1ps

module tb_uart;

    // =========================================================================
    // 1. TÍN HIỆU GIAO TIẾP TESTBENCH & DUT
    // =========================================================================

    reg        clk_i;
    reg        rst_i;

    // PC -> DUT
    reg        pc_rx_i;

    // DUT -> PC
    wire       pc_tx_o;

    // Sensor không sử dụng trong test Loopback
    reg        sensor_rx_i;
    wire       sensor_tx_o;


    // =========================================================================
    // 2. CÁC HẰNG SỐ ĐỊNH THỜI
    // =========================================================================

    // Clock hệ thống 50 MHz
    localparam CLK_PERIOD = 20;

    // baud_gen.v:
    //
    // N = 50,000,000 / (16 × 9600)
    //   = 325
    //
    // 1 s_tick = 325 × 20 ns = 6500 ns
    //
    // 1 bit UART = 16 × 6500 ns = 104000 ns

    localparam TICK_PERIOD = 6500;
    localparam BIT_TIME    = TICK_PERIOD * 16;


    // =========================================================================
    // 3. THAM SỐ PACKET LOOPBACK
    // =========================================================================

    localparam [7:0] HEADER_VAL    = 8'h23;
    localparam [7:0] TYPE_LOOPBACK = 8'h01;
    localparam [7:0] DATA_VAL      = 8'h41;
    localparam [7:0] FOOTER_VAL    = 8'h24;
    localparam [7:0] CRC_VAL       = 8'h2D;

    localparam PACKET_SIZE = 5;


    // =========================================================================
    // 4. BIẾN KIỂM TRA
    // =========================================================================

    integer error_count;
    integer rx_count;

    reg [7:0] received_data;

    // Mảng chứa packet mà PC mong đợi nhận lại
    reg [7:0] expected_packet [0:PACKET_SIZE-1];


    // =========================================================================
    // 5. KHỞI TẠO DUT
    // =========================================================================

    uart #(
        .CLK_FREQ       (50000000),
        .BAUDRATE       (9600),
        .HEADER_VAL     (HEADER_VAL),
        .FOOTER_VAL     (FOOTER_VAL),
        .CRC_VAL        (8'h07),
        .TYPE_LOOPBACK  (TYPE_LOOPBACK),
        .TYPE_SENSOR    (8'h02),
        .MAX_PAYLOAD    (32)
    )
    dut (
        .clk_i       (clk_i),
        .rst_i       (rst_i),

        // PC
        .rx_i        (pc_rx_i),
        .tx_o        (pc_tx_o),

        // Sensor
        .sensor_rx_i (sensor_rx_i),
        .sensor_tx_o (sensor_tx_o)
    );


    // =========================================================================
    // 6. TẠO CLOCK 50 MHz
    // =========================================================================

    always #(CLK_PERIOD / 2) clk_i = ~clk_i;


    // =========================================================================
    // 7. TASK PC TRANSMITTER
    //
    // Gửi 1 byte UART:
    //
    // IDLE  = 1
    // START = 0
    // DATA  = LSB first
    // STOP  = 1
    // =========================================================================

    task pc_send_uart_byte(input [7:0] data_in);

        integer i;

        begin

            $display(
                "[PC TX] Sent byte = %02X    time = %0t ns",
                data_in,
                $time
            );

            // START BIT
            pc_rx_i = 1'b0;
            #(BIT_TIME);

            // DATA BITS
            for (i = 0; i < 8; i = i + 1) begin

                pc_rx_i = data_in[i];

                #(BIT_TIME);

            end

            // STOP BIT
            pc_rx_i = 1'b1;
            #(BIT_TIME);

        end

    endtask


    // =========================================================================
    // 8. TASK PC RECEIVER
    //
    // Chờ START -> lấy mẫu 8 DATA BIT -> kiểm tra STOP
    // =========================================================================

    task pc_receive_uart_byte;

        integer i;

        reg [7:0] data_reg;
        reg       start_bit;
        reg       stop_bit;

        begin

            data_reg = 8'h00;

            // -------------------------------------------------------------
            // IDLE -> phát hiện START
            // -------------------------------------------------------------

            @(negedge pc_tx_o);


            // -------------------------------------------------------------
            // Kiểm tra giữa START BIT
            // -------------------------------------------------------------

            #(BIT_TIME / 2);

            start_bit = pc_tx_o;

            if (start_bit !== 1'b0) begin

                $display(
                    "[PC RX] ERROR: Invalid START bit at %0t ns",
                    $time
                );

                error_count = error_count + 1;

            end


            // -------------------------------------------------------------
            // DATA
            // -------------------------------------------------------------

            for (i = 0; i < 8; i = i + 1) begin

                #(BIT_TIME);

                data_reg[i] = pc_tx_o;

            end


            // -------------------------------------------------------------
            // STOP
            // -------------------------------------------------------------

            #(BIT_TIME);

            stop_bit = pc_tx_o;

            if (stop_bit !== 1'b1) begin

                $display(
                    "[PC RX] ERROR: Invalid STOP bit at %0t ns",
                    $time
                );

                error_count = error_count + 1;

            end


            // -------------------------------------------------------------
            // Trả dữ liệu
            // -------------------------------------------------------------

            received_data = data_reg;

        end

    endtask


    // =========================================================================
    // 9. PC RECEIVER CHẠY SONG SONG
    //
    // Receiver luôn sẵn sàng trước khi DUT bắt đầu trả dữ liệu.
    // =========================================================================

    initial begin

        wait (!rst_i);

        forever begin

            pc_receive_uart_byte();

            // -------------------------------------------------------------
            // So sánh với byte mong đợi tương ứng
            // -------------------------------------------------------------

            if (rx_count < PACKET_SIZE) begin

                if (received_data === expected_packet[rx_count]) begin

                    $display(
                        "[PC RX] PASS: Received byte = %02X, Expected = %02X    time = %0t ns",
                        received_data,
                        expected_packet[rx_count],
                        $time
                    );

                end
                else begin

                    $display(
                        "[PC RX] FAIL: Received byte = %02X, Expected = %02X    time = %0t ns",
                        received_data,
                        expected_packet[rx_count],
                        $time
                    );

                    error_count = error_count + 1;

                end

                rx_count = rx_count + 1;

            end

        end

    end


    // =========================================================================
    // 10. MAIN TEST
    // =========================================================================

    initial begin

        // ---------------------------------------------------------------------
        // Khởi tạo
        // ---------------------------------------------------------------------

        clk_i       = 1'b0;
        rst_i       = 1'b1;

        pc_rx_i     = 1'b1;
        sensor_rx_i = 1'b1;

        error_count = 0;
        rx_count    = 0;

        received_data = 8'h00;


        // ---------------------------------------------------------------------
        // Khởi tạo packet mong đợi
        // ---------------------------------------------------------------------

        expected_packet[0] = HEADER_VAL;
        expected_packet[1] = TYPE_LOOPBACK;
        expected_packet[2] = DATA_VAL;
        expected_packet[3] = FOOTER_VAL;
        expected_packet[4] = CRC_VAL;


        // ---------------------------------------------------------------------
        // RESET
        // ---------------------------------------------------------------------

        #(CLK_PERIOD * 10);

        rst_i = 1'b0;

        #(CLK_PERIOD * 10);


        // ---------------------------------------------------------------------
        // Hiển thị thông tin test
        // ---------------------------------------------------------------------

        $display("");
        $display("=================================================");
        $display("          FULL UART LOOPBACK TEST");
        $display("=================================================");
        $display("");

        $display(
            "[TB] Expected packet: %02X %02X %02X %02X %02X",
            expected_packet[0],
            expected_packet[1],
            expected_packet[2],
            expected_packet[3],
            expected_packet[4]
        );

        $display("");


        // ---------------------------------------------------------------------
        // Gửi packet từ PC vào DUT
        // ---------------------------------------------------------------------

        pc_send_uart_byte(HEADER_VAL);

        pc_send_uart_byte(TYPE_LOOPBACK);

        pc_send_uart_byte(DATA_VAL);

        pc_send_uart_byte(FOOTER_VAL);

        pc_send_uart_byte(CRC_VAL);


        // ---------------------------------------------------------------------
        // Packet đã gửi
        // ---------------------------------------------------------------------

        $display("");
        $display("[TB] Packet sent.");
        $display("[TB] Waiting for DUT response...");
        $display("");


        // ---------------------------------------------------------------------
        // Chờ DUT trả đủ 5 byte
        // ---------------------------------------------------------------------

        wait (rx_count >= PACKET_SIZE);


        // ---------------------------------------------------------------------
        // Tổng kết
        // ---------------------------------------------------------------------

        #(BIT_TIME * 2);

        $display("");
        $display("=================================================");
        $display("             FULL UART LOOPBACK TEST");
        $display("=================================================");

        if (error_count == 0) begin

            $display("             RESULT: PASS ALL TESTS!");

        end
        else begin

            $display(
                "             RESULT: FAIL (%0d errors)",
                error_count
            );

        end

        $display("=================================================");
        $display("");

        $finish;

    end


    // =========================================================================
    // 11. DEBUG PROCESS -> PC TX FIFO
    // =========================================================================

    always @(posedge clk_i) begin

        if (!rst_i && dut.process_wr_pc_tx) begin

            $display(
                "[DEBUG PROCESS->FIFO] time=%0t    data=%02X",
                $time,
                dut.process_pc_tx_wdata
            );

        end

    end


    // =========================================================================
    // 12. DEBUG FIFO READ
    // =========================================================================

    always @(posedge clk_i) begin

        if (!rst_i && dut.tx_ctrl_rd_pc_fifo) begin

            $display(
                "[DEBUG FIFO READ] time=%0t    data=%02X",
                $time,
                dut.fifo_pc_tx_rdata
            );

        end

    end


    // =========================================================================
    // 13. DEBUG UART START
    // =========================================================================

    always @(posedge clk_i) begin

        if (!rst_i && dut.tx_ctrl_start_pc_uart) begin

            $display(
                "[DEBUG UART START] time=%0t    data=%02X",
                $time,
                dut.fifo_pc_tx_rdata
            );

        end

    end

endmodule