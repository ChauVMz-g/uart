`timescale 1ns/1ps

module tb_uart_dual_com;

    // =========================================================================
    // 1. IMPORT CÁC HÀM C QUA SYSTEMVERILOG DPI-C
    // =========================================================================
    import "DPI-C" function int  init_com_port(int dev_id, string port_name, int baudrate);
    import "DPI-C" function int  read_com_byte(int dev_id, output byte data);
    import "DPI-C" function void write_com_byte(int dev_id, byte data);
    import "DPI-C" function void close_all_com_ports();

    // =========================================================================
    // 2. TÍN HIỆU PHẦN CỨNG & HẰNG SỐ
    // =========================================================================
    reg  clk = 0;
    reg  rst = 1;

    // Kênh PC (Kết nối với C# App qua COM1)
    reg  rx_pc = 1;
    wire tx_pc;

    // Kênh Sensor (Kết nối với Java/Hercules qua COM2)
    reg  rx_sensor = 1;
    wire tx_sensor;

    // Trạng thái Reset LED
    wire led_rst_status;

    // Thời gian 1 bit UART @ 9600 Baud (1/9600s ≈ 104.166us)
    localparam BIT_PERIOD = 104166; 

    // Tạo Clock 50MHz (Chu kỳ 20ns)
    always #10 clk = ~clk;

    // =========================================================================
    // 3. INSTANTIATE MODULE TOP UART VERILOG
    // =========================================================================
    uart #(
        .CLK_FREQ(50000000),
        .BAUDRATE(9600)
    ) uut (
        .clk_i            (clk),
        .rst_i            (rst),

        // PC Channel
        .rx_i             (rx_pc),
        .tx_o             (tx_pc),

        // Sensor Channel
        .sensor_rx_i      (rx_sensor),
        .sensor_tx_o      (tx_sensor),

        .led_rst_status_o (led_rst_status)
    );

    // =========================================================================
    // 4. LUỒNG KÊNH PC: C# APP (COM1) <---> FPGA PC UART
    // =========================================================================

    // Luồng A: Nhận byte từ C# App (COM1) ---> Bơm từng Bit vào rx_pc
    initial begin
        byte data_from_csharp;
        #200;

        // Khởi tạo cổng COM1 cho C# App (Device ID = 0)
        if (!init_com_port(0, "COM1", 9600)) begin
            $display("[SV-TB LỖI] Không thể kết nối với COM1 cho C# App!");
            $finish;
        end

        forever begin
            #100;
            if (read_com_byte(0, data_from_csharp) == 1) begin
                $display("[C# -> FPGA] Nhận từ C# App: 0x%02X, phát vào rx_pc...", data_from_csharp);
                
                // Start Bit
                rx_pc = 1'b0; #(BIT_PERIOD);
                
                // 8 Data Bits (LSB First)
                for (int i = 0; i < 8; i++) begin
                    rx_pc = data_from_csharp[i]; 
                    #(BIT_PERIOD);
                end
                
                // Stop Bit
                rx_pc = 1'b1; #(BIT_PERIOD);
            end
        end
    end

    // Luồng B: Bắt tín hiệu tx_pc từ FPGA ---> Bắn phản hồi Loopback về C# App (COM1)
    initial begin
        byte tx_pc_data;
        forever begin
            @(negedge tx_pc); // Bắt Start bit
            #(BIT_PERIOD + BIT_PERIOD/2); // Nhảy vào giữa bit dữ liệu đầu tiên

            for (int i = 0; i < 8; i++) begin
                tx_pc_data[i] = tx_pc;
                #(BIT_PERIOD);
            end

            $display("[FPGA -> C#] Loopback trả dữ liệu về C# App: 0x%02X", tx_pc_data);
            write_com_byte(0, tx_pc_data); // Gửi ra Device 0 (COM1)
            #(BIT_PERIOD/2);
        end
    end

    // =========================================================================
    // 5. LUỒNG KÊNH SENSOR: FPGA SENSOR UART <---> JAVA/HERCULES (COM2)
    // =========================================================================

    // Luồng C: Bắt lệnh từ FPGA (sensor_tx) ---> Gửi sang Java/Hercules (COM2)
    initial begin
        byte tx_sens_data;
        
        // Khởi tạo cổng COM2 cho Java/Hercules (Device ID = 1)
        if (!init_com_port(1, "COM2", 9600)) begin
            $display("[SV-TB CẢNH BÁO] Chưa kết nối COM2 cho Java/Hercules!");
        end

        forever begin
            @(negedge tx_sensor); // Bắt Start bit
            #(BIT_PERIOD + BIT_PERIOD/2);

            for (int i = 0; i < 8; i++) begin
                tx_sens_data[i] = tx_sensor;
                #(BIT_PERIOD);
            end

            $display("[FPGA -> SENSOR] Process phân tuyến gửi lệnh sang Java/Hercules: 0x%02X", tx_sens_data);
            write_com_byte(1, tx_sens_data); // Gửi ra Device 1 (COM2)
            #(BIT_PERIOD/2);
        end
    end

    // Luồng D: Nhận dữ liệu Cảm biến phản hồi từ Java/Hercules (COM2) ---> Bơm vào sensor_rx
    initial begin
        byte data_from_sensor;
        forever begin
            #100;
            if (read_com_byte(1, data_from_sensor) == 1) begin
                $display("[SENSOR -> FPGA] Java/Hercules phản hồi dữ liệu cảm biến: 0x%02X", data_from_sensor);
                
                // Start Bit
                rx_sensor = 1'b0; #(BIT_PERIOD);
                
                // 8 Data Bits
                for (int i = 0; i < 8; i++) begin
                    rx_sensor = data_from_sensor[i]; 
                    #(BIT_PERIOD);
                end
                
                // Stop Bit
                rx_sensor = 1'b1; #(BIT_PERIOD);
            end
        end
    end

    // =========================================================================
    // 6. DỌN DẸP & KHỞI TẠO MẠCH
    // =========================================================================
    initial begin
        $display("==================================================");
        $display("   KHOI DONG SYSTEMVERILOG DUAL-COM TESTBENCH    ");
        $display("==================================================");
        rst = 1'b1;
        #200;
        rst = 1'b0; // Thoát Reset
    end

    final begin
        close_all_com_ports();
    end

endmodule