`timescale 1ns / 1ps

module tb_tx;

    // -------------------------------------------------------------------------
    // 1. Tín hiệu kết nối với Module TX
    // -------------------------------------------------------------------------
    reg        clk_i;
    reg        rst_i;
    reg        tx_start_i;
    reg        s_tick_i;
    reg  [7:0] data_i;

    wire       tx_o;
    wire       tx_done_o;
    wire       tx_busy_o;

    // -------------------------------------------------------------------------
    // 2. Hằng số định thời
    // -------------------------------------------------------------------------
    localparam CLK_PERIOD  = 20;     // 50 MHz
    localparam TICK_PERIOD = 6510;   // Tick dùng cho TB

    // UART bit time:
    // 6510 ns × 16 = 104160 ns
    localparam BIT_TIME = TICK_PERIOD * 16;

    integer error_count = 0;

    // Dữ liệu mà TB đang chờ nhận từ TX
    reg [7:0] expected_data;

    // -------------------------------------------------------------------------
    // 3. Khởi tạo DUT
    // -------------------------------------------------------------------------
    tx dut (
        .clk_i      (clk_i),
        .rst_i      (rst_i),
        .tx_start_i (tx_start_i),
        .s_tick_i   (s_tick_i),
        .data_i     (data_i),
        .tx_o       (tx_o),
        .tx_done_o  (tx_done_o),
        .tx_busy_o  (tx_busy_o)
    );

    // -------------------------------------------------------------------------
    // 4. Clock 50 MHz
    // -------------------------------------------------------------------------
    always #(CLK_PERIOD / 2) clk_i = ~clk_i;

    // -------------------------------------------------------------------------
    // 5. Tạo s_tick_i
    // -------------------------------------------------------------------------
    initial begin
        s_tick_i = 1'b0;

        forever begin
            #(TICK_PERIOD - CLK_PERIOD);
            s_tick_i = 1'b1;

            #(CLK_PERIOD);
            s_tick_i = 1'b0;
        end
    end

    // -------------------------------------------------------------------------
    // 6. Task nhận 1 byte UART từ tx_o
    //
    // UART:
    //   Idle  = 1
    //   Start = 0
    //   Data  = 8 bit, LSB first
    //   Stop  = 1
    // -------------------------------------------------------------------------
    task receive_uart_byte;
        integer i;
        reg [7:0] received_data;
        reg       start_bit;
        reg       stop_bit;

        begin
            received_data = 8'h00;

            // -------------------------------------------------------------
            // Chờ cạnh xuống của START BIT
            // -------------------------------------------------------------
            @(negedge tx_o);

            // -------------------------------------------------------------
            // Đi vào giữa START BIT
            // -------------------------------------------------------------
            #(BIT_TIME / 2);

            start_bit = tx_o;

            if (start_bit !== 1'b0) begin
                $display(
                    "[FAIL] Invalid START bit at time = %0t",
                    $time
                );

                error_count = error_count + 1;
            end

            // -------------------------------------------------------------
            // Đến giữa từng DATA BIT
            // -------------------------------------------------------------
            for (i = 0; i < 8; i = i + 1) begin
                #(BIT_TIME);

                received_data[i] = tx_o;
            end

            // -------------------------------------------------------------
            // Đến giữa STOP BIT
            // -------------------------------------------------------------
            #(BIT_TIME);

            stop_bit = tx_o;

            if (stop_bit !== 1'b1) begin
                $display(
                    "[FAIL] Invalid STOP bit at time = %0t",
                    $time
                );

                error_count = error_count + 1;
            end

            // -------------------------------------------------------------
            // So sánh dữ liệu nhận được với expected_data
            // -------------------------------------------------------------
            if (received_data === expected_data) begin

                $display(
                    "[PASS] Received: 0x%X (Khop voi Expected: 0x%X) time = %0t",
                    received_data,
                    expected_data,
                    $time
                );

            end else begin

                $display(
                    "[FAIL] Received: 0x%X (Khong khop Expected: 0x%X) time = %0t",
                    received_data,
                    expected_data,
                    $time
                );

                error_count = error_count + 1;
            end
        end
    endtask

    // -------------------------------------------------------------------------
    // 7. Luồng receiver chạy song song
    //
    // Receiver phải được chạy trước khi TX bắt đầu truyền để không bỏ
    // START BIT.
    // -------------------------------------------------------------------------
    initial begin
        wait (!rst_i);

        forever begin
            receive_uart_byte();
        end
    end

    // -------------------------------------------------------------------------
    // 8. Kiểm tra tx_done_o
    // -------------------------------------------------------------------------
    always @(posedge tx_done_o) begin
        $display(
            "[TX DONE] Byte transmission completed at time = %0t",
            $time
        );
    end

    // -------------------------------------------------------------------------
    // 9. Kịch bản kiểm thử chính
    // -------------------------------------------------------------------------
    initial begin

        // -------------------------------------------------------------
        // Khởi tạo
        // -------------------------------------------------------------
        clk_i      = 1'b0;
        rst_i      = 1'b1;
        tx_start_i = 1'b0;
        data_i     = 8'h00;
        expected_data = 8'h00;

        // -------------------------------------------------------------
        // Reset
        // -------------------------------------------------------------
        #(CLK_PERIOD * 10);

        rst_i = 1'b0;

        #(CLK_PERIOD * 10);

        $display("");
        $display("==================================================");
        $display("          BAT DAU KIEM THU UART TX");
        $display("==================================================");
        $display("");

        // =============================================================
        // TEST 1: 0x35
        // =============================================================
        expected_data = 8'h35;
        data_i        = 8'h35;

        $display("[TEST 1] Dang gui byte 0x35...");

        tx_start_i = 1'b1;
        #(CLK_PERIOD);
        tx_start_i = 1'b0;

        // Chờ TX hoàn thành
        @(posedge tx_done_o);

        $display("[TEST 1] Da truyen xong byte 0x35.");

        // Nghỉ 10 bit
        #(BIT_TIME * 10);

        // =============================================================
        // TEST 2: 0xA9
        // =============================================================
        expected_data = 8'hA9;
        data_i        = 8'hA9;

        $display("[TEST 2] Dang gui byte 0xA9...");

        tx_start_i = 1'b1;
        #(CLK_PERIOD);
        tx_start_i = 1'b0;

        // Chờ TX hoàn thành
        @(posedge tx_done_o);

        $display("[TEST 2] Da truyen xong byte 0xA9.");

        // Nghỉ
        #(BIT_TIME * 10);

        // =============================================================
        // Tổng kết
        // =============================================================
        $display("");
        $display("==================================================");

        if (error_count == 0) begin
            $display("          KET QUA: PASS ALL TESTS!");
        end
        else begin
            $display(
                "          KET QUA: FAIL (%0d loi phat hien)",
                error_count
            );
        end

        $display("==================================================");
        $display("");

        $finish;
    end

endmodule