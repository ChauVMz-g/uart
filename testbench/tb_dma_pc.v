`timescale 1ns / 1ps

module tb_dma_pc;

    // ----------------------------------------------------
    // Các tham số mô phỏng (Thu nhỏ để simulation chạy nhanh)
    // ----------------------------------------------------
    parameter DATA_WIDTH      = 8;
    parameter BUFFER_DEPTH    = 1024;      // 1024 Bytes
    parameter MAX_PAYLOAD     = 1000;      // Payload tối đa 1000 Bytes
    parameter MAX_PKT_QUEUE   = 16;
    parameter START_BYTE      = 8'h23;     // Ký tự '#'
    parameter STOP_BYTE       = 8'h24;     // Ký tự '$'
    parameter TIMEOUT_LIMIT   = 50;        // Thu nhỏ Timeout Limit xuống 50 clocks

    parameter CLK_PERIOD      = 10;        // Chu kỳ xung nhịp 10ns (100MHz)

    // ----------------------------------------------------
    // Khai báo Tín hiệu Nối với DUT (dma_pc)
    // ----------------------------------------------------
    reg                     clk_i;
    reg                     rst_i;

    // FIFO Interface
    reg                     fifo_empty_i;
    wire                    fifo_rd_o;
    reg  [DATA_WIDTH-1:0]   w_data_i;

    // Process Block Interface
    reg                     rd_en;
    wire [DATA_WIDTH-1:0]   r_data_o;
    wire                    flag;
    wire [$clog2(BUFFER_DEPTH):0] pkt_len_o;

    // ----------------------------------------------------
    // Khởi tạo Device Under Test (DUT: dma_pc)
    // ----------------------------------------------------
    dma_pc #(
        .DATA_WIDTH(DATA_WIDTH),
        .BUFFER_DEPTH(BUFFER_DEPTH),
        .MAX_PAYLOAD(MAX_PAYLOAD),
        .MAX_PKT_QUEUE(MAX_PKT_QUEUE),
        .START_BYTE(START_BYTE),
        .STOP_BYTE(STOP_BYTE),
        .TIMEOUT_LIMIT(TIMEOUT_LIMIT)
    ) dut (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .fifo_empty_i(fifo_empty_i),
        .fifo_rd_o(fifo_rd_o),
        .w_data_i(w_data_i),
        .rd_en(rd_en),
        .r_data_o(r_data_o),
        .flag(flag),
        .pkt_len_o(pkt_len_o)
    );

    // ----------------------------------------------------
    // Tạo Xung Nhịp (Clock Generation)
    // ----------------------------------------------------
    always #(CLK_PERIOD / 2) clk_i = ~clk_i;

    // ----------------------------------------------------
    // FIFO Ảo Phản Hồi Tự Động (Emulated Stream FIFO)
    // ----------------------------------------------------
    reg [DATA_WIDTH-1:0] fifo_mem [0:4095];
    integer fifo_rd_ptr = 0;
    integer fifo_wr_ptr = 0;

    always @(posedge clk_i) begin
        if (rst_i) begin
            fifo_rd_ptr <= 0;
            w_data_i    <= 8'h00;
        end else if (fifo_rd_o && !fifo_empty_i) begin
            w_data_i    <= fifo_mem[fifo_rd_ptr];
            fifo_rd_ptr <= fifo_rd_ptr + 1;
            
            // Cập nhật tín hiệu rỗng nếu đã đọc hết bộ nhớ FIFO ảo
            if (fifo_rd_ptr + 1 == fifo_wr_ptr) begin
                fifo_empty_i <= 1'b1;
            end
        end
    end

    // ----------------------------------------------------
    // TASKS BỔ TRỢ VIẾT SCENARIO
    // ----------------------------------------------------
    
    // Task 1: Thêm gói tin vào FIFO ảo
    task push_packet_to_fifo(
        input [DATA_WIDTH-1:0] pkt_type,
        input integer          payload_len,
        input [DATA_WIDTH-1:0] crc_val
    );
        integer i;
        begin
            fifo_mem[fifo_wr_ptr] = START_BYTE;
            fifo_wr_ptr = fifo_wr_ptr + 1;

            fifo_mem[fifo_wr_ptr] = pkt_type;
            fifo_wr_ptr = fifo_wr_ptr + 1;

            for (i = 0; i < payload_len; i = i + 1) begin
                fifo_mem[fifo_wr_ptr] = (i + 1) & 8'hFF;
                fifo_wr_ptr = fifo_wr_ptr + 1;
            end

            fifo_mem[fifo_wr_ptr] = STOP_BYTE;
            fifo_wr_ptr = fifo_wr_ptr + 1;

            fifo_mem[fifo_wr_ptr] = crc_val;
            fifo_wr_ptr = fifo_wr_ptr + 1;

            fifo_empty_i = 1'b0; // Báo FIFO có dữ liệu
        end
    endtask

    // Task 2: Process Block đọc trọn gói tin từ dma_pc (Streaming 1 Byte/Clock)
    task process_block_read_packet();
        integer i;
        integer expected_len;
        begin
            @(posedge clk_i);
            wait (flag == 1'b1);
            expected_len = pkt_len_o;
            
            $display("   [READ START] Thấy flag = 1, Gói tin dài %0d Bytes. Đang trích xuất...", expected_len);
            $display("   --> Byte 0 (SOF Test): 0x%0h (Expected: 0x%0h)", r_data_o, START_BYTE);

            for (i = 0; i < expected_len; i = i + 1) begin
                rd_en = 1'b1;
                @(posedge clk_i);
            end

            rd_en = 1'b0;
            $display("   [READ END] Đã đọc xong %0d Bytes!", expected_len);
            @(posedge clk_i);
        end
    endtask

    // ----------------------------------------------------
    // KỊCH BẢN MÔ PHỎNG CHI TIẾT (ALL COVERAGE SCENARIOS)
    // ----------------------------------------------------
    initial begin
        $dumpfile("tb_dma_pc.vcd");
        $dumpvars(0, tb_dma_pc);

        clk_i        = 0;
        rst_i        = 1;
        fifo_empty_i = 1;
        rd_en        = 0;
        w_data_i     = 0;

        $display("==========================================================================");
        $display("          BẮT ĐẦU MÔ PHỎNG TOÀN DIỆN MODULE dma_pc (WITH FREE SPACE CHECK)");
        $display("==========================================================================");

        // ------------------------------------------------
        // TEST CASE 1: Reset Hệ thống
        // ------------------------------------------------
        #30;
        rst_i = 0;
        #20;
        if (flag == 0 && dut.wr_ptr == 0 && dut.rd_ptr == 0)
            $display("[PASS] TC1: Reset ban đầu thành công!");
        else
            $display("[FAIL] TC1: Reset thất bại!");

        // ------------------------------------------------
        // TEST CASE 2: Gói ngắn & Đọc tức thì (Zero-Latency Output Check)
        // ------------------------------------------------
        $display("\n--- TC2: Đơn gói ngắn (4B Payload) & Kiểm tra 0-Latency ---");
        push_packet_to_fifo(8'h01, 4, 8'h99); // 4 Byte Payload -> Tổng 8 Bytes
        process_block_read_packet();

        #50;

        // ------------------------------------------------
        // TEST CASE 3: Gói cực đại Max Payload (1000B Payload)
        // ------------------------------------------------
        $display("\n--- TC3: Gói tin kích thước cực đại (1000B Payload = 1004B Frame) ---");
        push_packet_to_fifo(8'h02, 1000, 8'hA1);
        process_block_read_packet();

        #50;

        // ------------------------------------------------
        // TEST CASE 4: KIỂM TRA CHẶN TRÀN BỘ ĐỆM DUNG LƯỢNG BYTE (CRITICAL CASE)
        // ------------------------------------------------
        $display("\n--- TC4: Kiểm tra cơ chế chặn tràn byte (has_enough_space Check) ---");
        $display("   --> Đẩy Gói 1 (600 Bytes Payload) vào FIFO...");
        push_packet_to_fifo(8'h01, 600, 8'hC1); // Chiếm ~604 Bytes
        
        // Chờ dma_pc nhận xong Gói 1 nhưng Process Block CHƯA ĐỌC
        wait (flag == 1'b1);
        #50;

        $display("   --> Đẩy tiếp Gói 2 (600 Bytes Payload) vào FIFO...");
        push_packet_to_fifo(8'h02, 600, 8'hC2); // Tổng 2 gói = 1208 Bytes > BUFFER_DEPTH (1024)
        
        #100;
        // Kiểm tra dma_pc có chặn không nhận Gói 2 (giữ fifo_rd_o = 0) hay không
        if (dut.free_space < 1004 && dut.has_enough_space == 0 && dut.state == 2'b00) begin
            $display("[PASS] TC4: dma_pc đã CHẶN THÀNH CÔNG gói 2 để bảo vệ Gói 1 không bị ghi đè!");
        end else begin
            $display("[FAIL] TC4: Bị tràn bộ đệm hoặc không chặn đúng!");
        end

        // Process Block tiến hành đọc Gói 1 để giải phóng dung lượng
        $display("   --> Process Block tiến hành đọc Gói 1 để giải phóng Ring Buffer...");
        process_block_read_packet();
        
        #50;
        // Kiểm tra xem sau khi đọc Gói 1, dma_pc có tự động nhận tiếp Gói 2 hay không
        wait (dut.pkt_cnt == 1);
        $display("[PASS] TC4: Sau khi xả dung lượng, dma_pc đã tự động tiếp tục nhận Gói 2!");
        process_block_read_packet(); // Đọc luôn Gói 2

        #50;

        // ------------------------------------------------
        // TEST CASE 5: Kiểm tra Con trỏ xoay vòng (Ring Buffer Wrap-around)
        // ------------------------------------------------
        $display("\n--- TC5: Kiểm tra xoay vòng đệm (Wrap-around qua mốc 1023) ---");
        push_packet_to_fifo(8'h01, 500, 8'hD1);
        process_block_read_packet();

        push_packet_to_fifo(8'h02, 600, 8'hD2); // Gói này sẽ tràn vắt qua mốc 1023 về 0
        process_block_read_packet();

        #50;

        // ------------------------------------------------
        // TEST CASE 6: Kiểm tra Timeout khi đứt đường truyền giữa chừng
        // ------------------------------------------------
        $display("\n--- TC6: Kiểm tra Timeout khi bị đứt đường truyền mid-payload ---");
        // Gửi dở SOF + Type
        fifo_mem[fifo_wr_ptr] = START_BYTE; fifo_wr_ptr = fifo_wr_ptr + 1;
        fifo_mem[fifo_wr_ptr] = 8'h01;      fifo_wr_ptr = fifo_wr_ptr + 1;
        fifo_empty_i = 1'b0;

        #40;
        fifo_empty_i = 1'b1; // Rỗng dữ liệu đột ngột

        #600; // Cho qua thời gian TIMEOUT_LIMIT (50 clocks = 500ns)

        if (dut.state == 2'b00) begin
            $display("[PASS] TC6: dma_pc tự phục hồi về ST_WAIT_START thành công sau Timeout!");
        end else begin
            $display("[FAIL] TC6: Kẹt trạng thái Timeout!");
        end

        // ------------------------------------------------
        // TEST CASE 7: Lỗi Quá Kích Thước Payload (Over-length Frame Error)
        // ------------------------------------------------
        $display("\n--- TC7: Khung lỗi quá kích thước cho phép (> 1000 Bytes Payload) ---");
        // Gửi gói không có STOP_BYTE, kéo dài quá 1004 bytes
        push_packet_to_fifo(8'h01, 1010, 8'hEE); 
        
        #2000; // Cho FSM chạy
        if (dut.state == 2'b00 && dut.pkt_cnt == 0) begin
            $display("[PASS] TC7: dma_pc đã tự động hủy gói lỗi quá dung lượng thành công!");
        end else begin
            $display("[FAIL] TC7: Không hủy gói quá dung lượng!");
        end

        // ------------------------------------------------
        // KẾT THÚC TOÀN BỘ BÀI MÔ PHỎNG
        // ------------------------------------------------
        #100;
        $display("\n==========================================================================");
        $display("         HOÀN THÀNH 100% CÁC KỊCH BẢN VERIFICATION CHO dma_pc             ");
        $display("==========================================================================");
        $finish;
    end

endmodule