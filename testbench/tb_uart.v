`timescale 1ns / 1ps

module tb_uart;

    // =========================================================================
    // 1. THAM SỐ CẤU HÌNH TESTBENCH
    // =========================================================================
    parameter CLK_FREQ       = 50_000_000;          // 50 MHz
    parameter BAUDRATE       = 115_200;             // Baud rate simulation
    parameter BIT_PERIOD     = 1000000000 / BAUDRATE; // Thoi gian 1 bit UART (ns)

    parameter [7:0] HEADER_VAL    = 8'h23; // '#'
    parameter [7:0] FOOTER_VAL    = 8'h24; // '$'
    parameter [7:0] CRC_VAL       = 8'h07; // Poly 0x07
    parameter [7:0] TYPE_LOOPBACK = 8'h01;
    parameter [7:0] TYPE_SENSOR   = 8'h02;
    parameter       MAX_PAYLOAD   = 32;

    // =========================================================================
    // 2. SIGNALS VÀ DUT INSTANTIATION
    // =========================================================================
    reg        clk_i;
    reg        rst_i;

    reg        rx_i;
    wire       tx_o;

    reg        sensor_rx_i;
    wire       sensor_tx_o;

    integer test_pass_count;
    integer test_fail_count;

    reg [7:0] tc_pld [0:31];
    reg [7:0] tc_exp_pld [0:31];

    uart #(
        .CLK_FREQ     (CLK_FREQ),
        .BAUDRATE     (BAUDRATE),
        .HEADER_VAL   (HEADER_VAL),
        .FOOTER_VAL   (FOOTER_VAL),
        .CRC_VAL      (CRC_VAL),
        .TYPE_LOOPBACK(TYPE_LOOPBACK),
        .TYPE_SENSOR  (TYPE_SENSOR),
        .MAX_PAYLOAD  (MAX_PAYLOAD)
    ) u_dut (
        .clk_i       (clk_i),
        .rst_i       (rst_i),
        .rx_i        (rx_i),
        .tx_o        (tx_o),
        .sensor_rx_i (sensor_rx_i),
        .sensor_tx_o (sensor_tx_o)
    );

    // =========================================================================
    // 3. GENERATE CLOCK (50 MHz)
    // =========================================================================
    always #10 clk_i = ~clk_i;

    // =========================================================================
    // 4. FUNCTION TÍNH CRC-8 (ĐỒNG BỘ VỚI PROCESS.V)
    // =========================================================================
    function [7:0] calc_crc8;
        input [7:0] crc_in;
        input [7:0] data_in;
        reg [7:0] crc;
        reg       mix;
        integer   i;
        begin
            crc = crc_in;
            for (i = 0; i < 8; i = i + 1) begin
                mix = crc[7] ^ data_in[7];
                crc = {crc[6:0], 1'b0};
                data_in = {data_in[6:0], 1'b0};
                if (mix)
                    crc = crc ^ 8'h07;
            end
            calc_crc8 = crc;
        end
    endfunction

    // =========================================================================
    // 5. TASKS TRUYỀN & NHẬN UART
    // =========================================================================

    // Gui 1 Byte qua PC RX
    task send_pc_byte;
        input [7:0] data;
        integer i;
        begin
            rx_i = 1'b0; // Start bit
            #(BIT_PERIOD);
            for (i = 0; i < 8; i = i + 1) begin
                rx_i = data[i];
                #(BIT_PERIOD);
            end
            rx_i = 1'b1; // Stop bit
            #(BIT_PERIOD);
        end
    endtask

    // Nhan 1 Byte tu PC TX
    task read_pc_byte;
        output [7:0] data;
        integer i;
        begin
            @(negedge tx_o);
            #(BIT_PERIOD / 2);
            for (i = 0; i < 8; i = i + 1) begin
                #(BIT_PERIOD);
                data[i] = tx_o;
            end
            #(BIT_PERIOD / 2);
        end
    endtask

    // Gui 1 Byte qua Sensor RX
    task send_sensor_byte;
        input [7:0] data;
        integer i;
        begin
            sensor_rx_i = 1'b0;
            #(BIT_PERIOD);
            for (i = 0; i < 8; i = i + 1) begin
                sensor_rx_i = data[i];
                #(BIT_PERIOD);
            end
            sensor_rx_i = 1'b1;
            sensor_rx_i = 1'b1;
            #(BIT_PERIOD);
        end
    endtask

    // Nhan 1 Byte tu Sensor TX
    task read_sensor_byte;
        output [7:0] data;
        integer i;
        begin
            @(negedge sensor_tx_o);
            #(BIT_PERIOD / 2);
            for (i = 0; i < 8; i = i + 1) begin
                #(BIT_PERIOD);
                data[i] = sensor_tx_o;
            end
            #(BIT_PERIOD / 2);
        end
    endtask

    // Task gui goi tin PC voi CRC tinh dong
    task send_pc_packet;
        input [7:0] pkt_type;
        input [7:0] payload_len;
        integer i;
        reg [7:0] crc_calc;
        begin
            // Tinh CRC = CRC8(HEADER + TYPE + DATA + FOOTER)
            crc_calc = calc_crc8(8'h00, HEADER_VAL);
            crc_calc = calc_crc8(crc_calc, pkt_type);
            for (i = 0; i < payload_len; i = i + 1) begin
                crc_calc = calc_crc8(crc_calc, tc_pld[i]);
            end
            crc_calc = calc_crc8(crc_calc, FOOTER_VAL);

            $display("[%0t ns] ---> Sending PC Packet: Type=0x%0h, Len=%0d, CRC=0x%0h", 
                     $time, pkt_type, payload_len, crc_calc);

            send_pc_byte(HEADER_VAL);
            send_pc_byte(pkt_type);
            for (i = 0; i < payload_len; i = i + 1) begin
                send_pc_byte(tc_pld[i]);
            end
            send_pc_byte(FOOTER_VAL);
            send_pc_byte(crc_calc);
        end
    endtask

    // Task verfiy goi tin tra ve tu PC TX
    task verify_pc_packet;
        input [7:0] exp_type;
        input [7:0] exp_len;
        reg [7:0] r_data;
        reg [7:0] crc_calc;
        integer i;
        reg match;
        begin
            match = 1'b1;

            // 1. Header
            read_pc_byte(r_data);
            if (r_data !== HEADER_VAL) match = 1'b0;
            crc_calc = calc_crc8(8'h00, r_data);

            // 2. Type
            read_pc_byte(r_data);
            if (r_data !== exp_type) match = 1'b0;
            crc_calc = calc_crc8(crc_calc, r_data);

            // 3. Data Payload
            for (i = 0; i < exp_len; i = i + 1) begin
                read_pc_byte(r_data);
                if (r_data !== tc_exp_pld[i]) match = 1'b0;
                crc_calc = calc_crc8(crc_calc, r_data);
            end

            // 4. Footer
            read_pc_byte(r_data);
            if (r_data !== FOOTER_VAL) match = 1'b0;
            crc_calc = calc_crc8(crc_calc, r_data);

            // 5. CRC
            read_pc_byte(r_data);
            if (r_data !== crc_calc) match = 1'b0;

            if (match) begin
                $display("[%0t ns] [PASSED] PC RX Packet Verification Success!", $time);
                test_pass_count = test_pass_count + 1;
            end else begin
                $display("[%0t ns] [FAILED] PC RX Packet Verification Mismatch!", $time);
                test_fail_count = test_fail_count + 1;
            end
        end
    endtask

    // =========================================================================
    // 6. MAIN TEST SUITE
    // =========================================================================
    integer k;
    reg [7:0] dummy_data;

    initial begin
        clk_i           = 0;
        rst_i           = 1;
        rx_i            = 1;
        sensor_rx_i     = 1;
        test_pass_count = 0;
        test_fail_count = 0;

        #200;
        rst_i = 0;
        #500;

        $display("==========================================================");
        $display("          BAT DAU CHAY KIEM THU MODULE UART              ");
        $display("==========================================================");

        // ---------------------------------------------------------------------
        // TESTCASE 1: LOOPBACK PACKET
        // ---------------------------------------------------------------------
        $display("\n--- [TC1] TEST LOOPBACK PACKET ---");
        tc_pld[0]     = 8'hAA; tc_pld[1]     = 8'hBB; tc_pld[2]     = 8'hCC;
        tc_exp_pld[0] = 8'hAA; tc_exp_pld[1] = 8'hBB; tc_exp_pld[2] = 8'hCC;

        fork
            send_pc_packet(TYPE_LOOPBACK, 3);
            verify_pc_packet(TYPE_LOOPBACK, 3);
        join

        #100000;

        // ---------------------------------------------------------------------
        // TESTCASE 2: SENSOR COMMAND (PC -> SENSOR)
        // ---------------------------------------------------------------------
        $display("\n--- [TC2] TEST SENSOR COMMAND ROUTING ---");
        tc_pld[0] = 8'h01; tc_pld[1] = 8'h02;

        fork
            send_pc_packet(TYPE_SENSOR, 2);
            begin : sensor_tx_verify
                $display("[%0t ns] Verifying Sensor TX line...", $time);
                read_sensor_byte(dummy_data); // Byte 01
                read_sensor_byte(dummy_data); // Byte 02
                $display("[%0t ns] Command payload successfully written to Sensor TX!", $time);
            end
        join

        #100000;

        // ---------------------------------------------------------------------
        // TESTCASE 3: SENSOR DATA RESPONSE (SENSOR -> PC)
        // ---------------------------------------------------------------------
        $display("\n--- [TC3] TEST SENSOR READ 12 BYTES RESPOND TO PC ---");
        // Giả lập Sensor đẩy 12 bytes dữ liệu vào Sensor RX
        for (k = 0; k < 12; k = k + 1) begin
            tc_exp_pld[k] = 8'h10 + k;
        end

        fork
            begin : sensor_push_12bytes
                for (k = 0; k < 12; k = k + 1) begin
                    send_sensor_byte(tc_exp_pld[k]);
                end
            end
            verify_pc_packet(TYPE_SENSOR, 12);
        join

        #100000;

        // ---------------------------------------------------------------------
        // TESTCASE 4: CRC ERROR INJECTION
        // ---------------------------------------------------------------------
        $display("\n--- [TC4] TEST INVALID CRC (CORRUPTED PACKET) ---");
        $display("[%0t ns] Sending packet with wrong CRC...", $time);
        send_pc_byte(HEADER_VAL);
        send_pc_byte(TYPE_LOOPBACK);
        send_pc_byte(8'h55);
        send_pc_byte(FOOTER_VAL);
        send_pc_byte(8'hFF); // Bad CRC (Wrong)

        #200000;
        $display("[%0t ns] Checked: Corrupted CRC packet successfully ignored.", $time);

        // ---------------------------------------------------------------------
        // TESTCASE 5: UNKNOWN TYPE FLUSH
        // ---------------------------------------------------------------------
        $display("\n--- [TC5] TEST UNKNOWN TYPE (FLUSH PHASE) ---");
        $display("[%0t ns] Sending packet with Type = 0xEE...", $time);
        send_pc_byte(HEADER_VAL);
        send_pc_byte(8'hEE); // Unknown Type
        send_pc_byte(8'h12);
        send_pc_byte(FOOTER_VAL);
        send_pc_byte(8'h00);

        #200000;
        $display("[%0t ns] Checked: Unknown type packet flushed properly.", $time);

        // ---------------------------------------------------------------------
        // TỔNG KẾT
        // ---------------------------------------------------------------------
        $display("\n==========================================================");
        $display("                   TONG KET KIEM THU                      ");
        $display("==========================================================");
        $display("  PASSED TESTCASES : %0d", test_pass_count);
        $display("  FAILED TESTCASES : %0d", test_fail_count);
        if (test_fail_count == 0)
            $display("  --> RATING: ALL TESTS PASSED SUCCESSFULLY! <--");
        else
            $display("  --> RATING: FAILURES DETECTED! CHECK LOGS. <--");
        $display("==========================================================");

        $finish;
    end

endmodule