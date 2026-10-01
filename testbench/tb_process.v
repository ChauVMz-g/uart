`timescale 1ns / 1ps
//=============================================================================
// TESTBENCH: tb_process
// Kiem thu module "process" (FSM xu ly khung PC<->Sensor)
// Cover: Loopback (PC-PC), lenh Sensor (PC-Sensor), du lieu Sensor (Sensor-PC),
//        sai CRC, sai Header (resync), Type khong ho tro (flush/resync),
//        va backpressure khi fifo_tx_full_i.
//=============================================================================
module tb_process;

    // --- Tham so khung tin, PHAI KHOP voi module process ---
    localparam [7:0] HEADER_VAL    = 8'h23;
    localparam [7:0] FOOTER_VAL    = 8'h24;
    localparam [7:0] TYPE_LOOPBACK = 8'h01;
    localparam [7:0] TYPE_SENSOR   = 8'h02;
    localparam       MAX_PAYLOAD   = 32;

    localparam CLK_PERIOD = 20; // 50 MHz

    // --- Tin hieu ket noi DUT ---
    reg        clk_i;
    reg        rst_i;

    wire       fifo_rx_empty_i;
    wire       fifo_rx_rd_o;
    reg  [7:0] fifo_rx_data_i;

    reg        fifo_tx_full_i;
    wire       fifo_tx_wr_o;
    wire [7:0] fifo_tx_data_o;

    reg        sensor_tx_full_i;
    wire       sensor_tx_wr_o;
    wire [7:0] sensor_tx_data_o;

    wire       sensor_rx_empty_i;
    wire       sensor_rx_rd_o;
    reg  [7:0] sensor_rx_data_i;

    integer error_count = 0;

    // =========================================================================
    // DUT
    // =========================================================================
    process dut (
        .clk_i            (clk_i),
        .rst_i            (rst_i),
        .fifo_rx_empty_i  (fifo_rx_empty_i),
        .fifo_rx_rd_o     (fifo_rx_rd_o),
        .fifo_rx_data_i   (fifo_rx_data_i),
        .fifo_tx_full_i   (fifo_tx_full_i),
        .fifo_tx_wr_o     (fifo_tx_wr_o),
        .fifo_tx_data_o   (fifo_tx_data_o),
        .sensor_tx_full_i (sensor_tx_full_i),
        .sensor_tx_wr_o   (sensor_tx_wr_o),
        .sensor_tx_data_o (sensor_tx_data_o),
        .sensor_rx_empty_i(sensor_rx_empty_i),
        .sensor_rx_rd_o   (sensor_rx_rd_o),
        .sensor_rx_data_i (sensor_rx_data_i)
    );

    // =========================================================================
    // CLOCK
    // =========================================================================
    initial clk_i = 1'b0;
    always #(CLK_PERIOD/2) clk_i = ~clk_i;

    // =========================================================================
    // HAM CRC-8 (COPY Y HET module process, dung de tinh gia tri mong doi)
    // =========================================================================
    function [7:0] calc_crc8;
        input [7:0] crc_in;
        input [7:0] data_in;
        reg   [7:0] d;
        reg   [7:0] c;
        reg   [7:0] crc_out;
    begin
        d = data_in;
        c = crc_in;
        crc_out[0] = c[0]^c[6]^c[7]^d[0]^d[6]^d[7];
        crc_out[1] = c[0]^c[1]^c[6]^d[0]^d[1]^d[6];
        crc_out[2] = c[0]^c[1]^c[2]^c[6]^d[0]^d[1]^d[2]^d[6];
        crc_out[3] = c[1]^c[2]^c[3]^c[7]^d[1]^d[2]^d[3]^d[7];
        crc_out[4] = c[2]^c[3]^c[4]^d[2]^d[3]^d[4];
        crc_out[5] = c[3]^c[4]^c[5]^d[3]^d[4]^d[5];
        crc_out[6] = c[4]^c[5]^c[6]^d[4]^d[5]^d[6];
        crc_out[7] = c[5]^c[6]^c[7]^d[5]^d[6]^d[7];
        calc_crc8 = crc_out;
    end
    endfunction

    // =========================================================================
    // MO HINH FIFO_RX (giao dien voi PC->process) - do tre doc 1 chu ky giong FIFO that
    // =========================================================================
    reg  [7:0] rx_mem [0:255];
    integer    rx_head, rx_tail, rx_cnt;
    assign fifo_rx_empty_i = (rx_cnt == 0);

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            fifo_rx_data_i <= 8'h00;
        end else if (fifo_rx_rd_o && (rx_cnt > 0)) begin
            fifo_rx_data_i <= rx_mem[rx_head];
            rx_head        <= (rx_head + 1) % 256;
            rx_cnt         <= rx_cnt - 1;
        end
    end

    task rx_push;
        input [7:0] b;
        begin
            rx_mem[rx_tail] = b;
            rx_tail = (rx_tail + 1) % 256;
            rx_cnt  = rx_cnt + 1;
        end
    endtask

    // =========================================================================
    // MO HINH FIFO_TX (phan hoi tu process -> PC) - bo giam sat, chi bat khi ghi
    // =========================================================================
    reg  [7:0] tx_capture [0:255];
    integer    tx_cnt;

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            tx_cnt <= 0;
        end else if (fifo_tx_wr_o && !fifo_tx_full_i) begin
            tx_capture[tx_cnt] <= fifo_tx_data_o;
            tx_cnt             <= tx_cnt + 1;
        end
    end

    // =========================================================================
    // MO HINH SENSOR_TX (lenh tu process -> Sensor) - bo giam sat
    // =========================================================================
    reg  [7:0] sens_tx_capture [0:255];
    integer    sens_tx_cnt;

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            sens_tx_cnt <= 0;
        end else if (sensor_tx_wr_o && !sensor_tx_full_i) begin
            sens_tx_capture[sens_tx_cnt] <= sensor_tx_data_o;
            sens_tx_cnt                  <= sens_tx_cnt + 1;
        end
    end

    // =========================================================================
    // MO HINH SENSOR_RX (du lieu Sensor -> process) - cung do tre doc 1 chu ky
    // =========================================================================
    reg  [7:0] sensor_mem [0:255];
    integer    sensor_head, sensor_tail, sensor_cnt;
    assign sensor_rx_empty_i = (sensor_cnt == 0);

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            sensor_rx_data_i <= 8'h00;
        end else if (sensor_rx_rd_o && (sensor_cnt > 0)) begin
            sensor_rx_data_i <= sensor_mem[sensor_head];
            sensor_head      <= (sensor_head + 1) % 256;
            sensor_cnt       <= sensor_cnt - 1;
        end
    end

    task sensor_push;
        input [7:0] b;
        begin
            sensor_mem[sensor_tail] = b;
            sensor_tail = (sensor_tail + 1) % 256;
            sensor_cnt  = sensor_cnt + 1;
        end
    endtask

    // =========================================================================
    // BUFFER SCRATCH DUNG CHUNG DE DUNG GOI TIN TEST
    // =========================================================================
    reg [7:0] payload [0:15];

    // Day 1 khung PC hop le (hoac co chu y sai) vao rx_mem
    // Neu bad_crc=1 -> byte CRC cuoi bi dao bit de test truong hop sai CRC
    task push_pc_frame;
        input [7:0] type_val;
        input integer len;
        input        bad_crc;
        integer i;
        reg [7:0] crc_acc;
        begin
            rx_push(HEADER_VAL);
            crc_acc = calc_crc8(8'h00, HEADER_VAL);

            rx_push(type_val);
            crc_acc = calc_crc8(crc_acc, type_val);

            for (i = 0; i < len; i = i + 1) begin
                rx_push(payload[i]);
                crc_acc = calc_crc8(crc_acc, payload[i]);
            end

            rx_push(FOOTER_VAL);
            crc_acc = calc_crc8(crc_acc, FOOTER_VAL);

            if (bad_crc)
                rx_push(crc_acc ^ 8'hFF); // co tinh sai CRC
            else
                rx_push(crc_acc);
        end
    endtask

    // Day 1 byte rac (khong phai Header) truoc 1 khung, de test resync
    task push_garbage_byte;
        input [7:0] b;
        begin
            rx_push(b);
        end
    endtask

    // =========================================================================
    // TASK CHO: cho fifo_tx nhan du N byte, co timeout tranh treo mo phong
    // =========================================================================
    task wait_tx_bytes;
        input  integer target_cnt;
        input  integer timeout_cycles;
        output reg      timeout_flag;
        integer cyc;
        begin
            cyc = 0;
            timeout_flag = 1'b0;
            while ((tx_cnt < target_cnt) && (cyc < timeout_cycles)) begin
                @(posedge clk_i);
                cyc = cyc + 1;
            end
            if (tx_cnt < target_cnt) timeout_flag = 1'b1;
        end
    endtask

    task wait_sens_tx_bytes;
        input  integer target_cnt;
        input  integer timeout_cycles;
        output reg      timeout_flag;
        integer cyc;
        begin
            cyc = 0;
            timeout_flag = 1'b0;
            while ((sens_tx_cnt < target_cnt) && (cyc < timeout_cycles)) begin
                @(posedge clk_i);
                cyc = cyc + 1;
            end
            if (sens_tx_cnt < target_cnt) timeout_flag = 1'b1;
        end
    endtask

    task wait_cycles;
        input integer n;
        integer i;
        begin
            for (i = 0; i < n; i = i + 1) @(posedge clk_i);
        end
    endtask

    // =========================================================================
    // KICH BAN KIEM THU CHINH
    // =========================================================================
    integer base_cnt, base_sens_cnt;
    reg     timeout_flag;
    reg [7:0] exp_crc;
    integer   i;

    initial begin
        // --- Khoi tao ---
        rst_i          = 1'b1;
        fifo_tx_full_i   = 1'b0;
        sensor_tx_full_i = 1'b0;
        rx_head = 0; rx_tail = 0; rx_cnt = 0;
        sensor_head = 0; sensor_tail = 0; sensor_cnt = 0;

        wait_cycles(5);
        rst_i = 1'b0;
        wait_cycles(5);

        $display("\n==================================================");
        $display("   BAT DAU KIEM THU MODULE PROCESS");
        $display("==================================================\n");

        // -----------------------------------------------------------
        // TEST 1: Loopback thanh cong (CRC dung)
        // -----------------------------------------------------------
        $display("[TEST 1] Loopback hop le (0xAA,0xBB,0xCC)...");
        payload[0] = 8'hAA; payload[1] = 8'hBB; payload[2] = 8'hCC;
        base_cnt = tx_cnt;
        push_pc_frame(TYPE_LOOPBACK, 3, 1'b0);

        wait_tx_bytes(base_cnt + 7, 500, timeout_flag);
        if (timeout_flag) begin
            $display("  [FAIL] Timeout - khong nhan du 7 byte phan hoi tren fifo_tx");
            error_count = error_count + 1;
        end else begin
            // Tinh CRC mong doi dung trinh tu HDR-TYPE-DATA(3)-FTR
            exp_crc = calc_crc8(8'h00, HEADER_VAL);
            exp_crc = calc_crc8(exp_crc, TYPE_LOOPBACK);
            exp_crc = calc_crc8(exp_crc, 8'hAA);
            exp_crc = calc_crc8(exp_crc, 8'hBB);
            exp_crc = calc_crc8(exp_crc, 8'hCC);
            exp_crc = calc_crc8(exp_crc, FOOTER_VAL);

            if (tx_capture[base_cnt+0] !== HEADER_VAL)
                begin $display("  [FAIL] Header sai"); error_count=error_count+1; end
            if (tx_capture[base_cnt+1] !== TYPE_LOOPBACK)
                begin $display("  [FAIL] Type sai"); error_count=error_count+1; end
            if (tx_capture[base_cnt+2] !== 8'hAA || tx_capture[base_cnt+3] !== 8'hBB || tx_capture[base_cnt+4] !== 8'hCC)
                begin $display("  [FAIL] Data khong khop"); error_count=error_count+1; end
            if (tx_capture[base_cnt+5] !== FOOTER_VAL)
                begin $display("  [FAIL] Footer sai"); error_count=error_count+1; end
            if (tx_capture[base_cnt+6] !== exp_crc)
                begin $display("  [FAIL] CRC sai: nhan 0x%0X, mong doi 0x%0X", tx_capture[base_cnt+6], exp_crc); error_count=error_count+1; end
            else
                $display("  [PASS] Khung Loopback dung: HDR-TYPE-DATA-FTR-CRC = 0x%0X", exp_crc);
        end
        wait_cycles(10);

        // -----------------------------------------------------------
        // TEST 2: Loopback sai CRC -> KHONG duoc phat gi ca
        // -----------------------------------------------------------
        $display("\n[TEST 2] Loopback voi CRC SAI (ky vong: khong co phan hoi)...");
        payload[0] = 8'h11; payload[1] = 8'h22;
        base_cnt = tx_cnt;
        push_pc_frame(TYPE_LOOPBACK, 2, 1'b1); // bad_crc = 1

        wait_cycles(200); // cho du thoi gian neu (sai) co phan hoi thi da xay ra
        if (tx_cnt != base_cnt) begin
            $display("  [FAIL] DUT van phat %0d byte ra fifo_tx du CRC sai!", tx_cnt-base_cnt);
            error_count = error_count + 1;
        end else begin
            $display("  [PASS] Khong co byte nao bi day ra khi CRC sai (an toan)");
        end

        // -----------------------------------------------------------
        // TEST 3: Header sai -> tu resync, khung tot ngay sau van xu ly duoc
        // -----------------------------------------------------------
        $display("\n[TEST 3] Byte rac (Header sai) truoc 1 khung Loopback hop le...");
        push_garbage_byte(8'h99); // khong phai HEADER_VAL
        payload[0] = 8'h55;
        base_cnt = tx_cnt;
        push_pc_frame(TYPE_LOOPBACK, 1, 1'b0);

        wait_tx_bytes(base_cnt + 5, 500, timeout_flag); // HDR+TYPE+1DATA+FTR+CRC = 5 byte
        if (timeout_flag) begin
            $display("  [FAIL] Timeout - DUT khong resync duoc sau byte rac");
            error_count = error_count + 1;
        end else if (tx_capture[base_cnt] !== HEADER_VAL || tx_capture[base_cnt+2] !== 8'h55) begin
            $display("  [FAIL] Khung sau byte rac bi sai noi dung");
            error_count = error_count + 1;
        end else begin
            $display("  [PASS] DUT tu resync dung sau byte Header rac");
        end
        wait_cycles(10);

        // -----------------------------------------------------------
        // TEST 4: Type khong ho tro -> phai flush het khung loi, khung sau van dung
        // -----------------------------------------------------------
        $display("\n[TEST 4] Khung voi Type la (0xFF), sau do 1 khung Loopback hop le...");
        // Khung loi: HDR - TYPE(0xFF) - 2 byte data rac - FOOTER - 1 byte CRC bat ky
        rx_push(HEADER_VAL);
        rx_push(8'hFF);      // Type khong ho tro
        rx_push(8'hDE);
        rx_push(8'hAD);
        rx_push(FOOTER_VAL);
        rx_push(8'h00);      // byte CRC bi/dropped, gia tri khong quan trong

        payload[0] = 8'h77; payload[1] = 8'h88;
        base_cnt = tx_cnt;
        push_pc_frame(TYPE_LOOPBACK, 2, 1'b0); // khung tot ngay sau

        wait_tx_bytes(base_cnt + 6, 800, timeout_flag); // HDR+TYPE+2DATA+FTR+CRC = 6 byte
        if (timeout_flag) begin
            $display("  [FAIL] Timeout - DUT khong flush/resync duoc sau khung Type la");
            error_count = error_count + 1;
        end else if (tx_capture[base_cnt] !== HEADER_VAL || tx_capture[base_cnt+2] !== 8'h77 || tx_capture[base_cnt+3] !== 8'h88) begin
            $display("  [FAIL] Khung Loopback sau khung Type la bi sai noi dung");
            error_count = error_count + 1;
        end else begin
            $display("  [PASS] DUT flush dung khung Type la, khung sau van xu ly binh thuong");
        end
        wait_cycles(10);

        // -----------------------------------------------------------
        // TEST 5: Lenh Sensor (PC->Sensor), CRC dung -> forward RAW, khong dong khung
        // -----------------------------------------------------------
        $display("\n[TEST 5] Lenh Sensor hop le (0x11,0x22,0x33)...");
        payload[0] = 8'h11; payload[1] = 8'h22; payload[2] = 8'h33;
        base_sens_cnt = sens_tx_cnt;
        push_pc_frame(TYPE_SENSOR, 3, 1'b0);

        wait_sens_tx_bytes(base_sens_cnt + 3, 500, timeout_flag);
        if (timeout_flag) begin
            $display("  [FAIL] Timeout - sensor_tx khong nhan du 3 byte lenh");
            error_count = error_count + 1;
        end else if (sens_tx_capture[base_sens_cnt+0] !== 8'h11 ||
                     sens_tx_capture[base_sens_cnt+1] !== 8'h22 ||
                     sens_tx_capture[base_sens_cnt+2] !== 8'h33) begin
            $display("  [FAIL] Du lieu gui xuong Sensor khong khop");
            error_count = error_count + 1;
        end else begin
            $display("  [PASS] Lenh Sensor duoc forward RAW dung (khong dong khung)");
        end
        wait_cycles(10);

        // -----------------------------------------------------------
        // TEST 6: Lenh Sensor sai CRC -> khong duoc forward gi xuong sensor_tx
        // -----------------------------------------------------------
        $display("\n[TEST 6] Lenh Sensor voi CRC SAI...");
        payload[0] = 8'h44; payload[1] = 8'h55;
        base_sens_cnt = sens_tx_cnt;
        push_pc_frame(TYPE_SENSOR, 2, 1'b1); // bad_crc = 1

        wait_cycles(200);
        if (sens_tx_cnt != base_sens_cnt) begin
            $display("  [FAIL] DUT van forward %0d byte xuong Sensor du CRC sai!", sens_tx_cnt-base_sens_cnt);
            error_count = error_count + 1;
        end else begin
            $display("  [PASS] Khong co byte nao bi forward xuong Sensor khi CRC sai");
        end

        // -----------------------------------------------------------
        // TEST 7: Du lieu tu Sensor -> PC (dong khung day du)
        // -----------------------------------------------------------
        $display("\n[TEST 7] Sensor co du lieu can gui len PC (0x01,0x02,0x03,0x04)...");
        sensor_push(8'h01); sensor_push(8'h02); sensor_push(8'h03); sensor_push(8'h04);
        base_cnt = tx_cnt;

        wait_tx_bytes(base_cnt + 7, 500, timeout_flag); // HDR+TYPE+4DATA+FTR+CRC = 7 byte
        if (timeout_flag) begin
            $display("  [FAIL] Timeout - khong nhan du khung du lieu Sensor tren fifo_tx");
            error_count = error_count + 1;
        end else begin
            exp_crc = calc_crc8(8'h00, HEADER_VAL);
            exp_crc = calc_crc8(exp_crc, TYPE_SENSOR);
            exp_crc = calc_crc8(exp_crc, 8'h01);
            exp_crc = calc_crc8(exp_crc, 8'h02);
            exp_crc = calc_crc8(exp_crc, 8'h03);
            exp_crc = calc_crc8(exp_crc, 8'h04);
            exp_crc = calc_crc8(exp_crc, FOOTER_VAL);

            if (tx_capture[base_cnt+0] !== HEADER_VAL || tx_capture[base_cnt+1] !== TYPE_SENSOR)
                begin $display("  [FAIL] Header/Type sai"); error_count=error_count+1; end
            else if (tx_capture[base_cnt+2] !== 8'h01 || tx_capture[base_cnt+3] !== 8'h02 ||
                     tx_capture[base_cnt+4] !== 8'h03 || tx_capture[base_cnt+5] !== 8'h04)
                begin $display("  [FAIL] Data Sensor khong khop"); error_count=error_count+1; end
            else if (tx_capture[base_cnt+6] !== FOOTER_VAL)
                begin $display("  [FAIL] Footer sai"); error_count=error_count+1; end
            else if (tx_capture[base_cnt+7] !== exp_crc)
                begin $display("  [FAIL] CRC sai: nhan 0x%0X, mong doi 0x%0X", tx_capture[base_cnt+7], exp_crc); error_count=error_count+1; end
            else
                $display("  [PASS] Khung du lieu Sensor->PC dung, CRC = 0x%0X", exp_crc);
        end
        wait_cycles(10);

        // -----------------------------------------------------------
        // TEST 8: Backpressure - fifo_tx_full_i bat giua chung, DUT phai CHO
        //          chu khong duoc huy/mat byte
        // -----------------------------------------------------------
        $display("\n[TEST 8] Loopback voi fifo_tx_full_i bi bat giua luc gui...");
        payload[0] = 8'hDE; payload[1] = 8'hAD; payload[2] = 8'hBE; payload[3] = 8'hEF;
        base_cnt = tx_cnt;
        push_pc_frame(TYPE_LOOPBACK, 4, 1'b0);

        // Cho byte dau tien xuat hien roi lap tuc chan fifo_tx
        wait_tx_bytes(base_cnt + 1, 500, timeout_flag);
        if (!timeout_flag) begin
            fifo_tx_full_i = 1'b1;
            wait_cycles(20); // giu day trong 20 chu ky
            fifo_tx_full_i = 1'b0;
        end

        wait_tx_bytes(base_cnt + 8, 800, timeout_flag); // HDR+TYPE+4DATA+FTR+CRC = 8 byte
        if (timeout_flag) begin
            $display("  [FAIL] Timeout - DUT khong hoan tat khung sau khi het backpressure");
            error_count = error_count + 1;
        end else begin
            exp_crc = calc_crc8(8'h00, HEADER_VAL);
            exp_crc = calc_crc8(exp_crc, TYPE_LOOPBACK);
            exp_crc = calc_crc8(exp_crc, 8'hDE);
            exp_crc = calc_crc8(exp_crc, 8'hAD);
            exp_crc = calc_crc8(exp_crc, 8'hBE);
            exp_crc = calc_crc8(exp_crc, 8'hEF);
            exp_crc = calc_crc8(exp_crc, FOOTER_VAL);

            if (tx_capture[base_cnt+2] !== 8'hDE || tx_capture[base_cnt+3] !== 8'hAD ||
                tx_capture[base_cnt+4] !== 8'hBE || tx_capture[base_cnt+5] !== 8'hEF ||
                tx_capture[base_cnt+7] !== exp_crc) begin
                $display("  [FAIL] Du lieu/CRC sai lech sau backpressure - co the da mat byte");
                error_count = error_count + 1;
            end else begin
                $display("  [PASS] DUT cho dung khi fifo_tx_full_i, khong mat byte nao");
            end
        end

        // -----------------------------------------------------------
        // TONG KET
        // -----------------------------------------------------------
        wait_cycles(10);
        $display("\n==================================================");
        if (error_count == 0)
            $display("   KET QUA: PASS ALL TESTS!");
        else
            $display("   KET QUA: FAIL (%0d loi)", error_count);
        $display("==================================================\n");

        $finish;
    end

endmodule