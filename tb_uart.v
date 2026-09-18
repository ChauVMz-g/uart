`timescale 1ns/1ps

module tb_uart;

    reg        clk;
    reg        rst;
    reg        rx;
    wire       tx;

    // Chu kỳ clock 50MHz -> T = 20ns
    parameter CLK_PERIOD = 20; 
    // Tốc độ 9600 baud -> Thời gian 1 bit = 1/9600 s ≈ 104,166 ns
    parameter BIT_PERIOD = 104166; 

    // Instantiate khối Top-Level
    uart #(
        .CLK_FREQ(50000000),
        .BAUDRATE(9600)
    ) uut (
        .clk_i(clk),
        .rst_i(rst),
        .rx_i (rx),
        .tx_o (tx)
    );

    // 1. Tạo xung Clock 50MHz
    always #(CLK_PERIOD/2) clk = ~clk;

    // 2. Task đóng vai PC truyền 1 byte UART sang FPGA
    task send_uart_byte(input [7:0] data_to_send);
        integer i;
        begin
            // Start bit = 0
            rx = 1'b0;
            #(BIT_PERIOD);

            // 8 Data bits (LSB first)
            for (i = 0; i < 8; i = i + 1) begin
                rx = data_to_send[i];
                #(BIT_PERIOD);
            end

            // Stop bit = 1
            rx = 1'b1;
            #(BIT_PERIOD);
        end
    endtask

    // 3. Chu trình kiểm thử chính
    initial begin
        // Khởi tạo
        clk = 0;
        rst = 1;
        rx  = 1; // Nhàn rỗi (Idle)

        // Phục hồi Reset sau 100ns
        #100;
        rst = 0;
        #200;

        $display("[%0t ns] -- BAT DAU GUI DULIEU KTIEM THU --", $time);

        // Gửi thử byte thứ nhất: 0x55 (Mẫu 01010101)
        send_uart_byte(8'h55);
        
        // Gửi tiếp byte thứ hai: 0xA5
        send_uart_byte(8'hA5);

        // Chờ đủ thời gian để hệ thống Loopback phát trả lại qua tx_o
        #(BIT_PERIOD * 30);

        $display("[%0t ns] -- HOAN THANH KIEM THU --", $time);
        $finish;
    end

endmodule