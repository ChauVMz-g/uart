`timescale 1ns / 1ps

module tb_tx;

    // 1. Khai báo tín hiệu kết nối với Module TX
    reg        clk_i;
    reg        rst_i;
    reg        tx_start_i;
    reg        s_tick_i;
    reg  [7:0] data_i;
    wire       tx_o;
    wire       tx_done_o;
    wire       tx_busy_o;

    // Khởi tạo các hằng số thời gian
    localparam CLK_PERIOD  = 20;   // Clock 50MHz (20ns)
    localparam TICK_PERIOD = 6510; // Tần số lấy mẫu Baudrate 9600

    // 2. Gọi Module TX cần kiểm thử (DUT)
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

    // 3. Tạo Xung Clock hệ thống (50MHz)
    always #(CLK_PERIOD / 2) clk_i = ~clk_i;

    // 4. Tạo Xung Tick cho Baudrate
    initial begin
        s_tick_i = 1'b0;
        forever begin
            #(TICK_PERIOD - CLK_PERIOD);
            s_tick_i = 1'b1;
            #(CLK_PERIOD);
            s_tick_i = 1'b0;
        end
    end

    // 5. Kịch bản mô phỏng từng bước
    initial begin
        // --- Bước 1: Khởi tạo giá trị ban đầu ---
        clk_i      = 1'b0;
        rst_i      = 1'b1; // Tích cực Reset
        tx_start_i = 1'b0;
        data_i     = 8'h00;

        // Giữ Reset trong 10 chu kỳ clock rồi nhả
        #(CLK_PERIOD * 10);
        rst_i = 1'b0;
        #(CLK_PERIOD * 10);

        $display("=== BAT DAU KIEM THU UART TX ===");

        // --- Bước 2: Gửi Byte thứ nhất (0x35) ---
        $display("[LANTU 1] Dang gui byte 0x35...");
        data_i     = 8'h35;       // Nạp dữ liệu 0x35
        tx_start_i = 1'b1;       // Bật cờ cho phép truyền
        #(CLK_PERIOD);
        tx_start_i = 1'b0;       // Tắt cờ start ngay lập tức

        // Chờ đến khi tín hiệu tx_done_o báo đã truyền xong
        @(posedge tx_done_o);
        $display("[LANTU 1] Da truyen xong byte 0x35!");
        #(TICK_PERIOD * 10);     // Nghỉ một chút trước khi gửi tiếp

        // --- Bước 3: Gửi Byte thứ hai (0xA9) ---
        $display("[LANTU 2] Dang gui byte 0xA9...");
        data_i     = 8'hA9;       // Nạp dữ liệu 0xA9
        tx_start_i = 1'b1;       // Bật cờ start
        #(CLK_PERIOD);
        tx_start_i = 1'b0;

        // Chờ truyền xong
        @(posedge tx_done_o);
        $display("[LANTU 2] Da truyen xong byte 0xA9!");
        #(TICK_PERIOD * 10);

        $display("=== HOAN THANH MO PHONG ===");
        $finish; // Kết thúc mô phỏng
    end

endmodule