`timescale 1ns / 1ps

module tb_fifo;

    // --- 1. Parameters & Tín hiệu ---
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 3; // DEPTH = 8 byte

    reg                   clk_i;
    reg                   rst_i;
    reg                   wr_en;
    reg                   rd_en;
    reg  [DATA_WIDTH-1:0] w_data_i;
    wire [DATA_WIDTH-1:0] r_data_o;
    wire                  empty_o;
    wire                  full_o;

    localparam CLK_PERIOD = 20; // Clock 50 MHz (20ns)

    // --- 2. Call Module FIFO (DUT) ---
    fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) dut (
        .clk_i   (clk_i),
        .rst_i   (rst_i),
        .wr_en   (wr_en),
        .rd_en   (rd_en),
        .w_data_i(w_data_i),
        .r_data_o(r_data_o),
        .empty_o (empty_o),
        .full_o  (full_o)
    );

    // --- 3. Tạo Clock ---
    always #(CLK_PERIOD / 2) clk_i = ~clk_i;

    // =========================================================================
    // 4. HÀM TỰ ĐỘNG GHI, ĐỌC VÀ SO SÁNH DATA_IN VÀ DATA_OUT (PHƯƠNG PHÁP 2)
    // =========================================================================
    task check_fifo(input [DATA_WIDTH-1:0] test_data);
        begin
            // BƯỚC 1: Ghi dữ liệu vào FIFO
            w_data_i = test_data;
            wr_en    = 1'b1;
            #(CLK_PERIOD);
            wr_en    = 1'b0; // Tắt ghi

            // BƯỚC 2: Đọc dữ liệu ra từ FIFO
            rd_en    = 1'b1;
            #(CLK_PERIOD);
            rd_en    = 1'b0; // Tắt đọc

            // BƯỚC 3: Tự động so sánh dữ liệu Đầu vào và Đầu ra
            if (r_data_o === test_data) begin
                $display("[PASS] Data Input (0x%X) == Data Output (0x%X)", test_data, r_data_o);
            end else begin
                $display("[FAIL] MISMATCH! Input (0x%X) != Output (0x%X) at time %t", 
                         test_data, r_data_o, $time);
            end
            
            #(CLK_PERIOD); // Delay nghỉ giữa các lần test
        end
    endtask

    // =========================================================================
    // 5. KỊCH BẢN KIỂM THỬ TỰ ĐỘNG
    // =========================================================================
    initial begin
        // Khởi tạo
        clk_i    = 1'b0;
        rst_i    = 1'b1;
        wr_en    = 1'b0;
        rd_en    = 1'b0;
        w_data_i = 8'h00;

        // Reset hệ thống
        #(CLK_PERIOD * 5);
        rst_i = 1'b0;
        #(CLK_PERIOD * 2);

        $display("\n==================================================");
        $display("   BAT DAU KIEM THU FIFO BANG HÀM SO SÁNH DIRECT");
        $display("==================================================\n");

        // Gọi hàm kiểm tra liên tục với các giá trị ngẫu nhiên khác nhau
        check_fifo(8'hA5);
        check_fifo(8'h5A);
        check_fifo(8'h12);
        check_fifo(8'hFF);
        check_fifo(8'h00);

        $display("\n==================================================");
        $display("   HOAN THANH MÔ PHỎNG KIỂM THỬ FIFO!");
        $display("==================================================\n");
        $finish;
    end

endmodule`timescale 1ns / 1ps

module tb_fifo;

    // --- 1. Parameters & Tín hiệu ---
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 3; // DEPTH = 8 byte

    reg                   clk_i;
    reg                   rst_i;
    reg                   wr_en;
    reg                   rd_en;
    reg  [DATA_WIDTH-1:0] w_data_i;
    wire [DATA_WIDTH-1:0] r_data_o;
    wire                  empty_o;
    wire                  full_o;

    localparam CLK_PERIOD = 20; // Clock 50 MHz (20ns)

    // --- 2. Call Module FIFO (DUT) ---
    fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) dut (
        .clk_i   (clk_i),
        .rst_i   (rst_i),
        .wr_en   (wr_en),
        .rd_en   (rd_en),
        .w_data_i(w_data_i),
        .r_data_o(r_data_o),
        .empty_o (empty_o),
        .full_o  (full_o)
    );

    // --- 3. Tạo Clock ---
    always #(CLK_PERIOD / 2) clk_i = ~clk_i;

    // =========================================================================
    // 4. HÀM TỰ ĐỘNG GHI, ĐỌC VÀ SO SÁNH DATA_IN VÀ DATA_OUT (PHƯƠNG PHÁP 2)
    // =========================================================================
    task check_fifo(input [DATA_WIDTH-1:0] test_data);
        begin
            // BƯỚC 1: Ghi dữ liệu vào FIFO
            w_data_i = test_data;
            wr_en    = 1'b1;
            #(CLK_PERIOD);
            wr_en    = 1'b0; // Tắt ghi

            // BƯỚC 2: Đọc dữ liệu ra từ FIFO
            rd_en    = 1'b1;
            #(CLK_PERIOD);
            rd_en    = 1'b0; // Tắt đọc

            // BƯỚC 3: Tự động so sánh dữ liệu Đầu vào và Đầu ra
            if (r_data_o === test_data) begin
                $display("[PASS] Data Input (0x%X) == Data Output (0x%X)", test_data, r_data_o);
            end else begin
                $display("[FAIL] MISMATCH! Input (0x%X) != Output (0x%X) at time %t", 
                         test_data, r_data_o, $time);
            end
            
            #(CLK_PERIOD); // Delay nghỉ giữa các lần test
        end
    endtask

    // =========================================================================
    // 5. KỊCH BẢN KIỂM THỬ TỰ ĐỘNG
    // =========================================================================
    initial begin
        // Khởi tạo
        clk_i    = 1'b0;
        rst_i    = 1'b1;
        wr_en    = 1'b0;
        rd_en    = 1'b0;
        w_data_i = 8'h00;

        // Reset hệ thống
        #(CLK_PERIOD * 5);
        rst_i = 1'b0;
        #(CLK_PERIOD * 2);

        $display("\n==================================================");
        $display("   BAT DAU KIEM THU FIFO BANG HÀM SO SÁNH DIRECT");
        $display("==================================================\n");

        // Gọi hàm kiểm tra liên tục với các giá trị ngẫu nhiên khác nhau
        check_fifo(8'hA5);
        check_fifo(8'h5A);
        check_fifo(8'h12);
        check_fifo(8'hFF);
        check_fifo(8'h00);

        $display("\n==================================================");
        $display("   HOAN THANH MÔ PHỎNG KIỂM THỬ FIFO!");
        $display("==================================================\n");
        $finish;
    end

endmodule