# 🚀 FPGA Soft-UART Core: Color Sensor (TCS34725) Interface & Loopback Data Processing

[![Language](https://img.shields.io/badge/Language-Verilog--HDL-blue.svg)](https://en.wikipedia.org/wiki/Verilog)
[![Hardware](https://img.shields.io/badge/Hardware-FPGA-orange.svg)]()
[![Baudrate](https://img.shields.io/badge/Baudrate-9600_8N1-green.svg)]()

---

## 📌 Giới thiệu dự án (Project Overview)

Dự án thiết kế một bộ lõi **Soft-UART Controller** tùy chỉnh trên phần cứng FPGA bằng ngôn ngữ Verilog HDL. 
Hệ thống hỗ trợ giao tiếp truyền thông nối tiếp 2 chiều giữa FPGA và ứng dụng trên máy tính (PC App - C#) với tốc độ **9600 bps (cấu hình 8N1)**.

Hệ thống tích hợp bộ đệm FIFO kép (Dual Synchronous FIFO) cùng khối xử lý gói tin trung tâm (`process`), cho phép thực hiện 2 chức năng chính:
1. **Chế độ Loopback Data:** Phản hồi lại chính xác dữ liệu nhận được từ máy tính để kiểm tra độ tin cậy của đường truyền.
2. **Chế độ Sensor Interface:** Giải mã các khung lệnh từ PC để điều khiển và thu thập dữ liệu từ cảm biến nhận biết màu sắc **TCS34725**.

---

## 🏗️ Kiến trúc hệ thống & Các Module (System Architecture)

Hệ thống gồm 7 module con kết nối đồng bộ theo nhịp Clock hệ thống (`clk_i`):

## 🛠️ Công cụ & Phần cứng sử dụng (Tools & Hardware)
* **Hardware:** Board FPGA (Altera/Intel Cyclone IV), Cảm biến màu sắc TCS34725, Cáp chuyển đổi USB-to-UART (CP2102 / FT232 / CH340).
* **Software:** C# WinForms SerialPort Interface.
* **Firmware:** Verilog HDL.
