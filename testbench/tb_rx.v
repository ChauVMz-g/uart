`timescale 1ns / 1ps

module tb_rx;

    // -------------------------------------------------------------------------
    // 1. Tín hiệu giao tiếp Testbench & DUT
    // -------------------------------------------------------------------------
    reg        clk_i;
    reg        rst_i;
    reg        rx_i;
    reg        s_tick_i;
    wire       rx_done_o;
    wire [7:0] data_o;

    // Hằng số định thời
    // Clock hệ thống: 50 MHz (Chu kỳ 20ns)
    localparam CLK_PERIOD = 20; 
    
    // Baudrate 9600 bps -> 1 bit duration = ~104166 ns
    // Mội bit được lấy mẫu 16 lần -> 1 s_tick_i period = 104166 / 16 = 6510 ns
    localparam TICK_PERIOD = 6510; 

    // Biến lưu trữ kiểm thử
    integer error_count = 0;

    // -------------------------------------------------------------------------
    // 2. Khởi tạo Device Under Test (DUT)
    // -------------------------------------------------------------------------
    rx dut (
        .clk_i    (clk_i),
        .rst_i    (rst_i),
        .rx_i     (rx_i),
        .s_tick_i (s_tick_i),
        .rx_done_o(rx_done_o),
        .data_o   (data_o)
    );

    // -------------------------------------------------------------------------
    // 3. Generator Clock hệ thống (50 MHz)
    // -------------------------------------------------------------------------
    always #(CLK_PERIOD / 2) clk_i = ~clk_i;

    // -------------------------------------------------------------------------
    // 4. Generator Xung Sampling s_tick_i (Oversampling x16)
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
    // 5. Tasks giả lập truyền dữ liệu chuẩn UART từ bên ngoài
    // -------------------------------------------------------------------------
    
    // Task 1: Gửi 1 Byte đúng chuẩn UART
    task send_uart_byte(input [7:0] data_in);
        integer i;
        begin
            $display("[TX SIM] Bat dau gui Byte UART: 0x%X hien tai...", data_in);
            
            // --- START BIT (1 bit = 16 ticks) ---
            rx_i = 1'b0;
            #(TICK_PERIOD * 16);

            // --- DATA BITS (8 bits - LSB First) ---
            for (i = 0; i < 8; i = i + 1) begin
                rx_i = data_in[i];
                #(TICK_PERIOD * 16);
            end

            // --- STOP BIT (1'b1) ---
            rx_i = 1'b1;
            #(TICK_PERIOD * 16);
        end
    endtask

    // Task 2: Gửi Glitch/Nhiễu ở Start bit để test khả năng loại bỏ nhiễu
    task send_uart_glitch();
        begin
            $display("[TX SIM] Tao nhieu (Glitch) tren duong RX...");
            rx_i = 1'b0;
            #(TICK_PERIOD * 3); // Giữ mức low trong 3 ticks (< 7 ticks) rồi kéo cao lại
            rx_i = 1'b1;
            #(TICK_PERIOD * 16);
        end
    endtask

    // Task 3: Gửi Byte lỗi Stop Bit (Framing Error)
    task send_uart_bad_stop(input [7:0] data_in);
        integer i;
        begin
            $display("[TX SIM] Gui Byte 0x%X voi Stop Bit bi loi (Stop Bit = 0)...", data_in);
            
            // START BIT
            rx_i = 1'b0;
            #(TICK_PERIOD * 16);

            // DATA BITS
            for (i = 0; i < 8; i = i + 1) begin
                rx_i = data_in[i];
                #(TICK_PERIOD * 16);
            end

            // STOP BIT BỊ LỖI (Kéo xuống 0 thay vì 1)
            rx_i = 1'b1; // Cố tình làm sai stop bit
            rx_i = 1'b0; 
            #(TICK_PERIOD * 16);
            
            // Trả lại đường truyền Idle
            rx_i = 1'b1;
            #(TICK_PERIOD * 16);
        end
    endtask

    // -------------------------------------------------------------------------
    // 6. Luồng Kiểm Tra Tự Động (Self-Checking Logic)
    // -------------------------------------------------------------------------
    reg [7:0] expected_data;

    // Giám sát cạnh lên của rx_done_o để so sánh dữ liệu
    always @(posedge clk_i) begin
        if (rx_done_o) begin
            if (data_o === expected_data) begin
                $display("[PASS] Received: 0x%X (Khop voi Expected: 0x%X)", data_o, expected_data);
            end else begin
                $display("[FAIL] Received: 0x%X (Khong khop Expected: 0x%X)", data_o, expected_data);
                error_count = error_count + 1;
            end
        end
    end

    // -------------------------------------------------------------------------
    // 7. Kịch bản Test chính (Main Stimulus)
    // -------------------------------------------------------------------------
    initial begin
        // Khởi tạo trạng thái ban đầu
        clk_i         = 1'b0;
        rst_i         = 1'b1;
        rx_i          = 1'b1; // Đường truyền UART mặc định IDLE = 1
        expected_data = 8'h00;

        // Reset hệ thống
        #(CLK_PERIOD * 10);
        rst_i = 1'b0;
        #(CLK_PERIOD * 10);

        $display("\n==================================================");
        $display("   BAT DAU KIEM THU MODULE UART RX");
        $display("==================================================\n");

        // --- TEST CASE 1: Truyền Byte thuân 0x55 (01010101) ---
        expected_data = 8'h55;
        send_uart_byte(8'h55);
        #(TICK_PERIOD * 10);

        // --- TEST CASE 2: Truyền Byte 0xA5 (10100101) ---
        expected_data = 8'hA5;
        send_uart_byte(8'hA5);
        #(TICK_PERIOD * 10);

        // --- TEST CASE 3: Test khả năng chống nhiễu (Glitch Filtering) ---
        // Kỳ vọng: rx_done_o KHÔNG ĐƯỢC bật lên
        send_uart_glitch();
        #(TICK_PERIOD * 10);

        // --- TEST CASE 4: Truyền liền tỳ 2 Byte liên tiếp ---
        expected_data = 8'h12;
        send_uart_byte(8'h12);
        
        expected_data = 8'h34;
        send_uart_byte(8'h34);
        #(TICK_PERIOD * 10);

        // --- TEST CASE 5: Test truyền sai Stop Bit (Framing Error) ---
        // Kỳ vọng: Module RX hủy gói tin, rx_done_o không bật
        send_uart_bad_stop(8'hFF);
        #(TICK_PERIOD * 10);

        // --- TỔNG KẾT KẾT QUẢ ---
        $display("\n==================================================");
        if (error_count == 0) begin
            $display("   KET QUA: PASS ALL TESTS!");
        end else begin
            $display("   KET QUA: FAIL (%0d loi phát hien)", error_count);
        end
        $display("==================================================\n");

        $finish;
    end

endmodule