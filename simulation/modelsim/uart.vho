-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 64-Bit"
-- VERSION "Version 13.1.0 Build 162 10/23/2013 SJ Web Edition"

-- DATE "09/14/2026 07:04:12"

-- 
-- Device: Altera EP4CE115F29C7 Package FBGA780
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIVE;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIVE.CYCLONEIVE_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	uart IS
    PORT (
	clk_i : IN std_logic;
	rst_i : IN std_logic;
	rx_i : IN std_logic;
	tx_o : OUT std_logic
	);
END uart;

-- Design Ports Information
-- tx_o	=>  Location: PIN_L27,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk_i	=>  Location: PIN_J1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rst_i	=>  Location: PIN_Y2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- rx_i	=>  Location: PIN_A17,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF uart IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk_i : std_logic;
SIGNAL ww_rst_i : std_logic;
SIGNAL ww_rx_i : std_logic;
SIGNAL ww_tx_o : std_logic;
SIGNAL \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a0_PORTADATAIN_bus\ : std_logic_vector(35 DOWNTO 0);
SIGNAL \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a0_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a0_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a0_PORTBDATAOUT_bus\ : std_logic_vector(35 DOWNTO 0);
SIGNAL \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a0_PORTADATAIN_bus\ : std_logic_vector(35 DOWNTO 0);
SIGNAL \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a0_PORTAADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a0_PORTBADDR_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a0_PORTBDATAOUT_bus\ : std_logic_vector(35 DOWNTO 0);
SIGNAL \rst_i~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \clk_i~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \tx_o~output_o\ : std_logic;
SIGNAL \clk_i~input_o\ : std_logic;
SIGNAL \clk_i~inputclkctrl_outclk\ : std_logic;
SIGNAL \u_baud_gen|Add0~0_combout\ : std_logic;
SIGNAL \u_baud_gen|Add0~1\ : std_logic;
SIGNAL \u_baud_gen|Add0~2_combout\ : std_logic;
SIGNAL \rst_i~input_o\ : std_logic;
SIGNAL \rst_i~inputclkctrl_outclk\ : std_logic;
SIGNAL \u_baud_gen|Add0~3\ : std_logic;
SIGNAL \u_baud_gen|Add0~4_combout\ : std_logic;
SIGNAL \u_baud_gen|Add0~5\ : std_logic;
SIGNAL \u_baud_gen|Add0~6_combout\ : std_logic;
SIGNAL \u_baud_gen|Add0~7\ : std_logic;
SIGNAL \u_baud_gen|Add0~8_combout\ : std_logic;
SIGNAL \u_baud_gen|Add0~9\ : std_logic;
SIGNAL \u_baud_gen|Add0~10_combout\ : std_logic;
SIGNAL \u_baud_gen|Add0~11\ : std_logic;
SIGNAL \u_baud_gen|Add0~12_combout\ : std_logic;
SIGNAL \u_baud_gen|count~1_combout\ : std_logic;
SIGNAL \u_baud_gen|Add0~13\ : std_logic;
SIGNAL \u_baud_gen|Add0~14_combout\ : std_logic;
SIGNAL \u_baud_gen|Add0~15\ : std_logic;
SIGNAL \u_baud_gen|Add0~16_combout\ : std_logic;
SIGNAL \u_baud_gen|count~0_combout\ : std_logic;
SIGNAL \u_baud_gen|Equal0~0_combout\ : std_logic;
SIGNAL \u_baud_gen|count~2_combout\ : std_logic;
SIGNAL \u_baud_gen|Equal0~1_combout\ : std_logic;
SIGNAL \u_baud_gen|count~3_combout\ : std_logic;
SIGNAL \u_baud_gen|Equal0~2_combout\ : std_logic;
SIGNAL \u_baud_gen|s_tick_o~q\ : std_logic;
SIGNAL \u_uart_tx|Selector1~1_combout\ : std_logic;
SIGNAL \u_fifo_tx|fifo_cnt[0]~5_combout\ : std_logic;
SIGNAL \u_fifo_tx|Add2~0_combout\ : std_logic;
SIGNAL \u_fifo_rx|fifo_cnt[0]~5_combout\ : std_logic;
SIGNAL \u_fifo_rx|Add2~0_combout\ : std_logic;
SIGNAL \rx_i~input_o\ : std_logic;
SIGNAL \u_uart_rx|tick_cnt[0]~4_combout\ : std_logic;
SIGNAL \u_uart_rx|tick_cnt[3]~5_combout\ : std_logic;
SIGNAL \u_uart_rx|Selector1~6_combout\ : std_logic;
SIGNAL \u_uart_rx|Selector1~7_combout\ : std_logic;
SIGNAL \u_uart_rx|Selector1~8_combout\ : std_logic;
SIGNAL \u_uart_rx|state.START~q\ : std_logic;
SIGNAL \u_uart_rx|tick_cnt[0]~3_combout\ : std_logic;
SIGNAL \u_uart_rx|tick_cnt[0]~8_combout\ : std_logic;
SIGNAL \u_uart_rx|Add0~0_combout\ : std_logic;
SIGNAL \u_uart_rx|tick_cnt[2]~6_combout\ : std_logic;
SIGNAL \u_uart_rx|Equal2~0_combout\ : std_logic;
SIGNAL \u_uart_rx|Selector0~0_combout\ : std_logic;
SIGNAL \u_uart_rx|state.IDLE~q\ : std_logic;
SIGNAL \u_uart_rx|tick_cnt[3]~0_combout\ : std_logic;
SIGNAL \u_uart_rx|tick_cnt[3]~1_combout\ : std_logic;
SIGNAL \u_uart_rx|tick_cnt[3]~2_combout\ : std_logic;
SIGNAL \u_uart_rx|tick_cnt[1]~7_combout\ : std_logic;
SIGNAL \u_uart_rx|Equal2~1_combout\ : std_logic;
SIGNAL \u_uart_rx|Selector1~5_combout\ : std_logic;
SIGNAL \u_uart_rx|Selector2~0_combout\ : std_logic;
SIGNAL \u_uart_rx|state.DATA~q\ : std_logic;
SIGNAL \u_uart_rx|b_reg[0]~0_combout\ : std_logic;
SIGNAL \u_uart_rx|bit_cnt[0]~0_combout\ : std_logic;
SIGNAL \u_uart_rx|bit_cnt[0]~3_combout\ : std_logic;
SIGNAL \u_uart_rx|bit_cnt[1]~2_combout\ : std_logic;
SIGNAL \u_uart_rx|Add1~0_combout\ : std_logic;
SIGNAL \u_uart_rx|bit_cnt[2]~1_combout\ : std_logic;
SIGNAL \u_uart_rx|Selector1~3_combout\ : std_logic;
SIGNAL \u_uart_rx|Selector1~4_combout\ : std_logic;
SIGNAL \u_uart_rx|Selector1~9_combout\ : std_logic;
SIGNAL \u_uart_rx|Selector3~0_combout\ : std_logic;
SIGNAL \u_uart_rx|state.STOP~q\ : std_logic;
SIGNAL \u_uart_rx|Selector1~2_combout\ : std_logic;
SIGNAL \u_uart_rx|rx_done_o~feeder_combout\ : std_logic;
SIGNAL \u_uart_rx|rx_done_o~q\ : std_logic;
SIGNAL \u_fifo_rx|fifo_cnt[0]~7_combout\ : std_logic;
SIGNAL \u_fifo_rx|fifo_cnt[0]~6\ : std_logic;
SIGNAL \u_fifo_rx|fifo_cnt[1]~8_combout\ : std_logic;
SIGNAL \u_fifo_rx|Add2~1\ : std_logic;
SIGNAL \u_fifo_rx|Add2~2_combout\ : std_logic;
SIGNAL \u_fifo_rx|fifo_cnt[1]~9\ : std_logic;
SIGNAL \u_fifo_rx|fifo_cnt[2]~10_combout\ : std_logic;
SIGNAL \u_fifo_rx|Add2~3\ : std_logic;
SIGNAL \u_fifo_rx|Add2~4_combout\ : std_logic;
SIGNAL \u_fifo_rx|fifo_cnt[2]~11\ : std_logic;
SIGNAL \u_fifo_rx|fifo_cnt[3]~12_combout\ : std_logic;
SIGNAL \u_fifo_rx|Add2~5\ : std_logic;
SIGNAL \u_fifo_rx|Add2~6_combout\ : std_logic;
SIGNAL \u_fifo_rx|Equal2~0_combout\ : std_logic;
SIGNAL \u_fifo_rx|Equal1~0_combout\ : std_logic;
SIGNAL \u_fifo_rx|fifo_cnt[3]~13\ : std_logic;
SIGNAL \u_fifo_rx|fifo_cnt[4]~14_combout\ : std_logic;
SIGNAL \u_fifo_rx|Add2~7\ : std_logic;
SIGNAL \u_fifo_rx|Add2~8_combout\ : std_logic;
SIGNAL \u_fifo_tx|always0~0_combout\ : std_logic;
SIGNAL \u_fifo_tx|fifo_cnt[0]~15_combout\ : std_logic;
SIGNAL \u_fifo_tx|fifo_cnt[0]~6\ : std_logic;
SIGNAL \u_fifo_tx|fifo_cnt[1]~7_combout\ : std_logic;
SIGNAL \u_fifo_tx|Add2~1\ : std_logic;
SIGNAL \u_fifo_tx|Add2~2_combout\ : std_logic;
SIGNAL \u_fifo_tx|fifo_cnt[1]~8\ : std_logic;
SIGNAL \u_fifo_tx|fifo_cnt[2]~9_combout\ : std_logic;
SIGNAL \u_fifo_tx|Add2~3\ : std_logic;
SIGNAL \u_fifo_tx|Add2~4_combout\ : std_logic;
SIGNAL \u_fifo_tx|fifo_cnt[2]~10\ : std_logic;
SIGNAL \u_fifo_tx|fifo_cnt[3]~11_combout\ : std_logic;
SIGNAL \u_fifo_tx|Add2~5\ : std_logic;
SIGNAL \u_fifo_tx|Add2~6_combout\ : std_logic;
SIGNAL \u_fifo_tx|Equal2~0_combout\ : std_logic;
SIGNAL \u_fifo_tx|Equal1~0_combout\ : std_logic;
SIGNAL \u_fifo_tx|fifo_cnt[3]~12\ : std_logic;
SIGNAL \u_fifo_tx|fifo_cnt[4]~13_combout\ : std_logic;
SIGNAL \u_fifo_tx|Add2~7\ : std_logic;
SIGNAL \u_fifo_tx|Add2~8_combout\ : std_logic;
SIGNAL \u_uart_tx|tx_done_o~q\ : std_logic;
SIGNAL \u_tx_controller|uart_ready~0_combout\ : std_logic;
SIGNAL \u_tx_controller|uart_ready~q\ : std_logic;
SIGNAL \u_tx_controller|Selector0~0_combout\ : std_logic;
SIGNAL \u_tx_controller|Selector0~1_combout\ : std_logic;
SIGNAL \u_tx_controller|state.STATE_IDLE~q\ : std_logic;
SIGNAL \u_tx_controller|state~10_combout\ : std_logic;
SIGNAL \u_tx_controller|state.STATE_READ_FIFO~q\ : std_logic;
SIGNAL \u_tx_controller|fifo_rd_o~q\ : std_logic;
SIGNAL \u_tx_controller|uart_start_o~q\ : std_logic;
SIGNAL \u_uart_tx|b_reg[6]~3_combout\ : std_logic;
SIGNAL \u_uart_tx|Selector2~2_combout\ : std_logic;
SIGNAL \u_uart_tx|state.START~q\ : std_logic;
SIGNAL \u_uart_tx|Selector3~0_combout\ : std_logic;
SIGNAL \u_uart_tx|Add1~0_combout\ : std_logic;
SIGNAL \u_uart_tx|bit_cnt[0]~0_combout\ : std_logic;
SIGNAL \u_uart_tx|bit_cnt[2]~1_combout\ : std_logic;
SIGNAL \u_uart_tx|Selector1~2_combout\ : std_logic;
SIGNAL \u_uart_tx|Selector1~3_combout\ : std_logic;
SIGNAL \u_uart_tx|b_reg[6]~0_combout\ : std_logic;
SIGNAL \u_uart_tx|Selector1~4_combout\ : std_logic;
SIGNAL \u_uart_tx|Selector3~1_combout\ : std_logic;
SIGNAL \u_uart_tx|state.DATA~q\ : std_logic;
SIGNAL \u_uart_tx|bit_cnt[0]~3_combout\ : std_logic;
SIGNAL \u_uart_tx|bit_cnt[1]~2_combout\ : std_logic;
SIGNAL \u_uart_tx|Selector2~1_combout\ : std_logic;
SIGNAL \u_uart_tx|Selector4~0_combout\ : std_logic;
SIGNAL \u_uart_tx|state.STOP~q\ : std_logic;
SIGNAL \u_uart_tx|tick_cnt[0]~1_combout\ : std_logic;
SIGNAL \u_uart_tx|tick_cnt[0]~2_combout\ : std_logic;
SIGNAL \u_uart_tx|tick_cnt[0]~3_combout\ : std_logic;
SIGNAL \u_uart_tx|tick_cnt[0]~0_combout\ : std_logic;
SIGNAL \u_uart_tx|tick_cnt[0]~4_combout\ : std_logic;
SIGNAL \u_uart_tx|tick_cnt[0]~8_combout\ : std_logic;
SIGNAL \u_uart_tx|tick_cnt[1]~7_combout\ : std_logic;
SIGNAL \u_uart_tx|Add0~1_combout\ : std_logic;
SIGNAL \u_uart_tx|tick_cnt[2]~6_combout\ : std_logic;
SIGNAL \u_uart_tx|Add0~0_combout\ : std_logic;
SIGNAL \u_uart_tx|tick_cnt[3]~5_combout\ : std_logic;
SIGNAL \u_uart_tx|Equal1~0_combout\ : std_logic;
SIGNAL \u_uart_tx|Selector1~0_combout\ : std_logic;
SIGNAL \u_uart_tx|state.IDLE~0_combout\ : std_logic;
SIGNAL \u_uart_tx|state.IDLE~q\ : std_logic;
SIGNAL \u_uart_rx|b_reg[6]~feeder_combout\ : std_logic;
SIGNAL \u_uart_rx|b_reg[3]~feeder_combout\ : std_logic;
SIGNAL \u_uart_rx|b_reg[1]~feeder_combout\ : std_logic;
SIGNAL \u_uart_rx|b_reg[0]~feeder_combout\ : std_logic;
SIGNAL \u_uart_rx|data_o[0]~feeder_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory_rtl_0_bypass[9]~feeder_combout\ : std_logic;
SIGNAL \u_fifo_rx|w_ptr[0]~0_combout\ : std_logic;
SIGNAL \u_fifo_rx|w_ptr[1]~1_combout\ : std_logic;
SIGNAL \u_fifo_rx|w_ptr[1]~2_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory_rtl_0_bypass[1]~feeder_combout\ : std_logic;
SIGNAL \u_fifo_tx|w_ptr[0]~0_combout\ : std_logic;
SIGNAL \u_fifo_rx|Add1~0_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory_rtl_0_bypass[2]~0_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory~10_combout\ : std_logic;
SIGNAL \u_fifo_rx|comb~0_combout\ : std_logic;
SIGNAL \u_fifo_rx|w_ptr[2]~3_combout\ : std_logic;
SIGNAL \u_fifo_rx|w_ptr[3]~4_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory_rtl_0_bypass[7]~feeder_combout\ : std_logic;
SIGNAL \u_fifo_rx|Add1~1_combout\ : std_logic;
SIGNAL \u_fifo_rx|r_ptr[3]~feeder_combout\ : std_logic;
SIGNAL \u_fifo_rx|Add1~2_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory~11_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory~12_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory~0feeder_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory~0_q\ : std_logic;
SIGNAL \u_fifo_rx|memory~16_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory~17_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory~1_q\ : std_logic;
SIGNAL \u_fifo_tx|always0~0_wirecell_combout\ : std_logic;
SIGNAL \u_fifo_tx|w_ptr[0]~_wirecell_combout\ : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \u_uart_rx|data_o[1]~feeder_combout\ : std_logic;
SIGNAL \u_uart_rx|data_o[2]~feeder_combout\ : std_logic;
SIGNAL \u_uart_rx|data_o[4]~feeder_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a0~portbdataout\ : std_logic;
SIGNAL \u_fifo_rx|memory~9_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory~13_combout\ : std_logic;
SIGNAL \u_fifo_tx|r_ptr[0]~0_combout\ : std_logic;
SIGNAL \u_fifo_tx|always1~0_combout\ : std_logic;
SIGNAL \u_fifo_tx|Add1~0_combout\ : std_logic;
SIGNAL \u_fifo_tx|r_ptr[1]~feeder_combout\ : std_logic;
SIGNAL \u_fifo_tx|Add1~1_combout\ : std_logic;
SIGNAL \u_fifo_tx|r_ptr[2]~feeder_combout\ : std_logic;
SIGNAL \u_fifo_tx|Add1~2_combout\ : std_logic;
SIGNAL \u_fifo_tx|memory~10_combout\ : std_logic;
SIGNAL \u_fifo_tx|memory_rtl_0_bypass[3]~feeder_combout\ : std_logic;
SIGNAL \u_fifo_tx|memory_rtl_0_bypass[2]~0_combout\ : std_logic;
SIGNAL \u_fifo_tx|memory_rtl_0_bypass[1]~feeder_combout\ : std_logic;
SIGNAL \u_fifo_tx|memory~9_combout\ : std_logic;
SIGNAL \u_fifo_tx|comb~0_combout\ : std_logic;
SIGNAL \u_fifo_tx|memory_rtl_0_bypass[0]~1_combout\ : std_logic;
SIGNAL \u_uart_tx|b_reg[6]~1_combout\ : std_logic;
SIGNAL \u_fifo_tx|memory~11_combout\ : std_logic;
SIGNAL \u_fifo_tx|memory~12_combout\ : std_logic;
SIGNAL \u_fifo_tx|memory~1_q\ : std_logic;
SIGNAL \u_fifo_tx|memory~0feeder_combout\ : std_logic;
SIGNAL \u_fifo_tx|memory~0_q\ : std_logic;
SIGNAL \u_uart_tx|b_reg[6]~2_combout\ : std_logic;
SIGNAL \u_uart_tx|Selector12~0_combout\ : std_logic;
SIGNAL \u_fifo_tx|r_ptr[0]~_wirecell_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory~2_q\ : std_logic;
SIGNAL \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a1\ : std_logic;
SIGNAL \u_fifo_rx|memory~14_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory~15_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory_rtl_0_bypass[11]~feeder_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a2\ : std_logic;
SIGNAL \u_fifo_rx|memory~3_q\ : std_logic;
SIGNAL \u_fifo_rx|memory~18_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory~19_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory_rtl_0_bypass[12]~feeder_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory~4_q\ : std_logic;
SIGNAL \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a3\ : std_logic;
SIGNAL \u_fifo_rx|memory~20_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory~21_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory~5_q\ : std_logic;
SIGNAL \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a4\ : std_logic;
SIGNAL \u_fifo_rx|memory~22_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory~23_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory_rtl_0_bypass[14]~feeder_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory~6_q\ : std_logic;
SIGNAL \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a5\ : std_logic;
SIGNAL \u_fifo_rx|memory~24_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory~25_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory_rtl_0_bypass[15]~feeder_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory~7_q\ : std_logic;
SIGNAL \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a6\ : std_logic;
SIGNAL \u_fifo_rx|memory~26_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory~27_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory_rtl_0_bypass[16]~feeder_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory~8_q\ : std_logic;
SIGNAL \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a7\ : std_logic;
SIGNAL \u_fifo_rx|memory~28_combout\ : std_logic;
SIGNAL \u_fifo_rx|memory~29_combout\ : std_logic;
SIGNAL \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a3\ : std_logic;
SIGNAL \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a4\ : std_logic;
SIGNAL \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a5\ : std_logic;
SIGNAL \u_fifo_tx|memory~7feeder_combout\ : std_logic;
SIGNAL \u_fifo_tx|memory~7_q\ : std_logic;
SIGNAL \u_uart_tx|Selector6~0_combout\ : std_logic;
SIGNAL \u_uart_tx|Selector5~0_combout\ : std_logic;
SIGNAL \u_fifo_tx|memory~13_combout\ : std_logic;
SIGNAL \u_fifo_tx|memory~8_q\ : std_logic;
SIGNAL \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a7\ : std_logic;
SIGNAL \u_uart_tx|b_reg[7]~5_combout\ : std_logic;
SIGNAL \u_uart_tx|b_reg[7]~6_combout\ : std_logic;
SIGNAL \u_uart_tx|b_reg[7]~7_combout\ : std_logic;
SIGNAL \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a6\ : std_logic;
SIGNAL \u_uart_tx|Selector6~1_combout\ : std_logic;
SIGNAL \u_uart_tx|b_reg[6]~4_combout\ : std_logic;
SIGNAL \u_uart_tx|Selector7~0_combout\ : std_logic;
SIGNAL \u_fifo_tx|memory~6_q\ : std_logic;
SIGNAL \u_uart_tx|Selector7~1_combout\ : std_logic;
SIGNAL \u_fifo_tx|memory~5feeder_combout\ : std_logic;
SIGNAL \u_fifo_tx|memory~5_q\ : std_logic;
SIGNAL \u_uart_tx|Selector8~0_combout\ : std_logic;
SIGNAL \u_uart_tx|Selector8~1_combout\ : std_logic;
SIGNAL \u_uart_tx|Selector9~0_combout\ : std_logic;
SIGNAL \u_fifo_tx|memory~4feeder_combout\ : std_logic;
SIGNAL \u_fifo_tx|memory~4_q\ : std_logic;
SIGNAL \u_uart_tx|Selector9~1_combout\ : std_logic;
SIGNAL \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a2\ : std_logic;
SIGNAL \u_fifo_tx|memory~3_q\ : std_logic;
SIGNAL \u_uart_tx|Selector10~0_combout\ : std_logic;
SIGNAL \u_uart_tx|Selector10~1_combout\ : std_logic;
SIGNAL \u_uart_tx|Selector11~0_combout\ : std_logic;
SIGNAL \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a1\ : std_logic;
SIGNAL \u_fifo_tx|memory~2feeder_combout\ : std_logic;
SIGNAL \u_fifo_tx|memory~2_q\ : std_logic;
SIGNAL \u_uart_tx|Selector11~1_combout\ : std_logic;
SIGNAL \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a0~portbdataout\ : std_logic;
SIGNAL \u_uart_tx|Selector12~1_combout\ : std_logic;
SIGNAL \u_uart_tx|Selector0~0_combout\ : std_logic;
SIGNAL \u_uart_tx|tx_o~q\ : std_logic;
SIGNAL \u_fifo_tx|fifo_cnt\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \u_fifo_rx|memory_rtl_0_bypass\ : std_logic_vector(0 TO 16);
SIGNAL \u_fifo_tx|memory_rtl_0_bypass\ : std_logic_vector(0 TO 16);
SIGNAL \u_uart_rx|bit_cnt\ : std_logic_vector(2 DOWNTO 0);
SIGNAL \u_baud_gen|count\ : std_logic_vector(8 DOWNTO 0);
SIGNAL \u_fifo_rx|w_ptr\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \u_uart_rx|b_reg\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \u_fifo_tx|w_ptr\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \u_uart_rx|data_o\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \u_fifo_rx|fifo_cnt\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \u_fifo_rx|r_ptr\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \u_uart_rx|tick_cnt\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \u_fifo_tx|r_ptr\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \u_uart_tx|tick_cnt\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \u_uart_tx|bit_cnt\ : std_logic_vector(2 DOWNTO 0);
SIGNAL \u_uart_tx|b_reg\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \u_fifo_tx|ALT_INV_always1~0_combout\ : std_logic;
SIGNAL \u_uart_tx|ALT_INV_tx_o~q\ : std_logic;
SIGNAL \u_fifo_tx|ALT_INV_comb~0_combout\ : std_logic;
SIGNAL \u_fifo_tx|ALT_INV_always0~0_combout\ : std_logic;
SIGNAL \ALT_INV_rst_i~inputclkctrl_outclk\ : std_logic;
SIGNAL \u_fifo_tx|ALT_INV_always0~0_wirecell_combout\ : std_logic;

BEGIN

ww_clk_i <= clk_i;
ww_rst_i <= rst_i;
ww_rx_i <= rx_i;
tx_o <= ww_tx_o;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a0_PORTADATAIN_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & 
\u_fifo_rx|memory~29_combout\ & \u_fifo_rx|memory~27_combout\ & \u_fifo_rx|memory~25_combout\ & \u_fifo_rx|memory~23_combout\ & \u_fifo_rx|memory~21_combout\ & \u_fifo_rx|memory~19_combout\ & \u_fifo_rx|memory~15_combout\ & \u_fifo_rx|memory~13_combout\);

\u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a0_PORTAADDR_bus\ <= (\u_fifo_rx|r_ptr\(3) & \u_fifo_rx|r_ptr\(2) & \u_fifo_rx|r_ptr\(1) & \u_fifo_tx|w_ptr\(0));

\u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a0_PORTBADDR_bus\ <= (\u_fifo_tx|Add1~2_combout\ & \u_fifo_tx|Add1~1_combout\ & \u_fifo_tx|Add1~0_combout\ & \u_fifo_tx|r_ptr[0]~_wirecell_combout\);

\u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a0~portbdataout\ <= \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a0_PORTBDATAOUT_bus\(0);
\u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a1\ <= \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a0_PORTBDATAOUT_bus\(1);
\u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a2\ <= \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a0_PORTBDATAOUT_bus\(2);
\u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a3\ <= \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a0_PORTBDATAOUT_bus\(3);
\u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a4\ <= \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a0_PORTBDATAOUT_bus\(4);
\u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a5\ <= \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a0_PORTBDATAOUT_bus\(5);
\u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a6\ <= \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a0_PORTBDATAOUT_bus\(6);
\u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a7\ <= \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a0_PORTBDATAOUT_bus\(7);

\u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a0_PORTADATAIN_bus\ <= (gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & gnd & 
\u_uart_rx|data_o\(7) & \u_uart_rx|data_o\(6) & \u_uart_rx|data_o\(5) & \u_uart_rx|data_o\(4) & \u_uart_rx|data_o\(3) & \u_uart_rx|data_o\(2) & \u_uart_rx|data_o\(1) & \u_uart_rx|data_o\(0));

\u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a0_PORTAADDR_bus\ <= (\u_fifo_rx|w_ptr\(3) & \u_fifo_rx|w_ptr\(2) & \u_fifo_rx|w_ptr\(1) & \u_fifo_rx|w_ptr\(0));

\u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a0_PORTBADDR_bus\ <= (\u_fifo_rx|Add1~2_combout\ & \u_fifo_rx|Add1~1_combout\ & \u_fifo_rx|Add1~0_combout\ & \u_fifo_tx|w_ptr[0]~_wirecell_combout\);

\u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a0~portbdataout\ <= \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a0_PORTBDATAOUT_bus\(0);
\u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a1\ <= \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a0_PORTBDATAOUT_bus\(1);
\u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a2\ <= \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a0_PORTBDATAOUT_bus\(2);
\u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a3\ <= \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a0_PORTBDATAOUT_bus\(3);
\u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a4\ <= \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a0_PORTBDATAOUT_bus\(4);
\u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a5\ <= \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a0_PORTBDATAOUT_bus\(5);
\u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a6\ <= \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a0_PORTBDATAOUT_bus\(6);
\u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a7\ <= \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a0_PORTBDATAOUT_bus\(7);

\rst_i~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \rst_i~input_o\);

\clk_i~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clk_i~input_o\);
\u_fifo_tx|ALT_INV_always1~0_combout\ <= NOT \u_fifo_tx|always1~0_combout\;
\u_uart_tx|ALT_INV_tx_o~q\ <= NOT \u_uart_tx|tx_o~q\;
\u_fifo_tx|ALT_INV_comb~0_combout\ <= NOT \u_fifo_tx|comb~0_combout\;
\u_fifo_tx|ALT_INV_always0~0_combout\ <= NOT \u_fifo_tx|always0~0_combout\;
\ALT_INV_rst_i~inputclkctrl_outclk\ <= NOT \rst_i~inputclkctrl_outclk\;
\u_fifo_tx|ALT_INV_always0~0_wirecell_combout\ <= NOT \u_fifo_tx|always0~0_wirecell_combout\;

-- Location: IOOBUF_X115_Y48_N9
\tx_o~output\ : cycloneive_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \u_uart_tx|ALT_INV_tx_o~q\,
	devoe => ww_devoe,
	o => \tx_o~output_o\);

-- Location: IOIBUF_X0_Y36_N8
\clk_i~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk_i,
	o => \clk_i~input_o\);

-- Location: CLKCTRL_G2
\clk_i~inputclkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk_i~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk_i~inputclkctrl_outclk\);

-- Location: LCCOMB_X63_Y48_N6
\u_baud_gen|Add0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_baud_gen|Add0~0_combout\ = \u_baud_gen|count\(0) $ (VCC)
-- \u_baud_gen|Add0~1\ = CARRY(\u_baud_gen|count\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \u_baud_gen|count\(0),
	datad => VCC,
	combout => \u_baud_gen|Add0~0_combout\,
	cout => \u_baud_gen|Add0~1\);

-- Location: LCCOMB_X63_Y48_N8
\u_baud_gen|Add0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_baud_gen|Add0~2_combout\ = (\u_baud_gen|count\(1) & (!\u_baud_gen|Add0~1\)) # (!\u_baud_gen|count\(1) & ((\u_baud_gen|Add0~1\) # (GND)))
-- \u_baud_gen|Add0~3\ = CARRY((!\u_baud_gen|Add0~1\) # (!\u_baud_gen|count\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \u_baud_gen|count\(1),
	datad => VCC,
	cin => \u_baud_gen|Add0~1\,
	combout => \u_baud_gen|Add0~2_combout\,
	cout => \u_baud_gen|Add0~3\);

-- Location: IOIBUF_X0_Y36_N15
\rst_i~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_rst_i,
	o => \rst_i~input_o\);

-- Location: CLKCTRL_G4
\rst_i~inputclkctrl\ : cycloneive_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \rst_i~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \rst_i~inputclkctrl_outclk\);

-- Location: FF_X63_Y48_N9
\u_baud_gen|count[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_baud_gen|Add0~2_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_baud_gen|count\(1));

-- Location: LCCOMB_X63_Y48_N10
\u_baud_gen|Add0~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_baud_gen|Add0~4_combout\ = (\u_baud_gen|count\(2) & (\u_baud_gen|Add0~3\ $ (GND))) # (!\u_baud_gen|count\(2) & (!\u_baud_gen|Add0~3\ & VCC))
-- \u_baud_gen|Add0~5\ = CARRY((\u_baud_gen|count\(2) & !\u_baud_gen|Add0~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \u_baud_gen|count\(2),
	datad => VCC,
	cin => \u_baud_gen|Add0~3\,
	combout => \u_baud_gen|Add0~4_combout\,
	cout => \u_baud_gen|Add0~5\);

-- Location: LCCOMB_X63_Y48_N12
\u_baud_gen|Add0~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_baud_gen|Add0~6_combout\ = (\u_baud_gen|count\(3) & (!\u_baud_gen|Add0~5\)) # (!\u_baud_gen|count\(3) & ((\u_baud_gen|Add0~5\) # (GND)))
-- \u_baud_gen|Add0~7\ = CARRY((!\u_baud_gen|Add0~5\) # (!\u_baud_gen|count\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001011111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \u_baud_gen|count\(3),
	datad => VCC,
	cin => \u_baud_gen|Add0~5\,
	combout => \u_baud_gen|Add0~6_combout\,
	cout => \u_baud_gen|Add0~7\);

-- Location: FF_X63_Y48_N13
\u_baud_gen|count[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_baud_gen|Add0~6_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_baud_gen|count\(3));

-- Location: LCCOMB_X63_Y48_N14
\u_baud_gen|Add0~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_baud_gen|Add0~8_combout\ = (\u_baud_gen|count\(4) & (\u_baud_gen|Add0~7\ $ (GND))) # (!\u_baud_gen|count\(4) & (!\u_baud_gen|Add0~7\ & VCC))
-- \u_baud_gen|Add0~9\ = CARRY((\u_baud_gen|count\(4) & !\u_baud_gen|Add0~7\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \u_baud_gen|count\(4),
	datad => VCC,
	cin => \u_baud_gen|Add0~7\,
	combout => \u_baud_gen|Add0~8_combout\,
	cout => \u_baud_gen|Add0~9\);

-- Location: FF_X63_Y48_N15
\u_baud_gen|count[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_baud_gen|Add0~8_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_baud_gen|count\(4));

-- Location: LCCOMB_X63_Y48_N16
\u_baud_gen|Add0~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_baud_gen|Add0~10_combout\ = (\u_baud_gen|count\(5) & (!\u_baud_gen|Add0~9\)) # (!\u_baud_gen|count\(5) & ((\u_baud_gen|Add0~9\) # (GND)))
-- \u_baud_gen|Add0~11\ = CARRY((!\u_baud_gen|Add0~9\) # (!\u_baud_gen|count\(5)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \u_baud_gen|count\(5),
	datad => VCC,
	cin => \u_baud_gen|Add0~9\,
	combout => \u_baud_gen|Add0~10_combout\,
	cout => \u_baud_gen|Add0~11\);

-- Location: FF_X63_Y48_N17
\u_baud_gen|count[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_baud_gen|Add0~10_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_baud_gen|count\(5));

-- Location: LCCOMB_X63_Y48_N18
\u_baud_gen|Add0~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_baud_gen|Add0~12_combout\ = (\u_baud_gen|count\(6) & (\u_baud_gen|Add0~11\ $ (GND))) # (!\u_baud_gen|count\(6) & (!\u_baud_gen|Add0~11\ & VCC))
-- \u_baud_gen|Add0~13\ = CARRY((\u_baud_gen|count\(6) & !\u_baud_gen|Add0~11\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \u_baud_gen|count\(6),
	datad => VCC,
	cin => \u_baud_gen|Add0~11\,
	combout => \u_baud_gen|Add0~12_combout\,
	cout => \u_baud_gen|Add0~13\);

-- Location: LCCOMB_X63_Y48_N28
\u_baud_gen|count~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_baud_gen|count~1_combout\ = (\u_baud_gen|Add0~12_combout\ & (((\u_baud_gen|count\(0)) # (!\u_baud_gen|Equal0~0_combout\)) # (!\u_baud_gen|Equal0~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_baud_gen|Equal0~1_combout\,
	datab => \u_baud_gen|count\(0),
	datac => \u_baud_gen|Add0~12_combout\,
	datad => \u_baud_gen|Equal0~0_combout\,
	combout => \u_baud_gen|count~1_combout\);

-- Location: FF_X63_Y48_N29
\u_baud_gen|count[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_baud_gen|count~1_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_baud_gen|count\(6));

-- Location: LCCOMB_X63_Y48_N20
\u_baud_gen|Add0~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_baud_gen|Add0~14_combout\ = (\u_baud_gen|count\(7) & (!\u_baud_gen|Add0~13\)) # (!\u_baud_gen|count\(7) & ((\u_baud_gen|Add0~13\) # (GND)))
-- \u_baud_gen|Add0~15\ = CARRY((!\u_baud_gen|Add0~13\) # (!\u_baud_gen|count\(7)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \u_baud_gen|count\(7),
	datad => VCC,
	cin => \u_baud_gen|Add0~13\,
	combout => \u_baud_gen|Add0~14_combout\,
	cout => \u_baud_gen|Add0~15\);

-- Location: FF_X63_Y48_N21
\u_baud_gen|count[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_baud_gen|Add0~14_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_baud_gen|count\(7));

-- Location: LCCOMB_X63_Y48_N22
\u_baud_gen|Add0~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_baud_gen|Add0~16_combout\ = \u_baud_gen|count\(8) $ (!\u_baud_gen|Add0~15\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010110100101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \u_baud_gen|count\(8),
	cin => \u_baud_gen|Add0~15\,
	combout => \u_baud_gen|Add0~16_combout\);

-- Location: LCCOMB_X63_Y48_N30
\u_baud_gen|count~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_baud_gen|count~0_combout\ = (\u_baud_gen|Add0~16_combout\ & (((\u_baud_gen|count\(0)) # (!\u_baud_gen|Equal0~0_combout\)) # (!\u_baud_gen|Equal0~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_baud_gen|Equal0~1_combout\,
	datab => \u_baud_gen|count\(0),
	datac => \u_baud_gen|Add0~16_combout\,
	datad => \u_baud_gen|Equal0~0_combout\,
	combout => \u_baud_gen|count~0_combout\);

-- Location: FF_X63_Y48_N31
\u_baud_gen|count[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_baud_gen|count~0_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_baud_gen|count\(8));

-- Location: LCCOMB_X63_Y48_N0
\u_baud_gen|Equal0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_baud_gen|Equal0~0_combout\ = (\u_baud_gen|count\(6) & (!\u_baud_gen|count\(7) & (\u_baud_gen|count\(8) & !\u_baud_gen|count\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_baud_gen|count\(6),
	datab => \u_baud_gen|count\(7),
	datac => \u_baud_gen|count\(8),
	datad => \u_baud_gen|count\(5),
	combout => \u_baud_gen|Equal0~0_combout\);

-- Location: LCCOMB_X63_Y48_N26
\u_baud_gen|count~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_baud_gen|count~2_combout\ = (\u_baud_gen|Add0~4_combout\ & ((\u_baud_gen|count\(0)) # ((!\u_baud_gen|Equal0~0_combout\) # (!\u_baud_gen|Equal0~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000101010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_baud_gen|Add0~4_combout\,
	datab => \u_baud_gen|count\(0),
	datac => \u_baud_gen|Equal0~1_combout\,
	datad => \u_baud_gen|Equal0~0_combout\,
	combout => \u_baud_gen|count~2_combout\);

-- Location: FF_X63_Y48_N27
\u_baud_gen|count[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_baud_gen|count~2_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_baud_gen|count\(2));

-- Location: LCCOMB_X63_Y48_N24
\u_baud_gen|Equal0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_baud_gen|Equal0~1_combout\ = (\u_baud_gen|count\(2) & (!\u_baud_gen|count\(4) & (!\u_baud_gen|count\(1) & !\u_baud_gen|count\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_baud_gen|count\(2),
	datab => \u_baud_gen|count\(4),
	datac => \u_baud_gen|count\(1),
	datad => \u_baud_gen|count\(3),
	combout => \u_baud_gen|Equal0~1_combout\);

-- Location: LCCOMB_X63_Y48_N2
\u_baud_gen|count~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_baud_gen|count~3_combout\ = (\u_baud_gen|Add0~0_combout\ & (((\u_baud_gen|count\(0)) # (!\u_baud_gen|Equal0~0_combout\)) # (!\u_baud_gen|Equal0~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010001010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_baud_gen|Add0~0_combout\,
	datab => \u_baud_gen|Equal0~1_combout\,
	datac => \u_baud_gen|count\(0),
	datad => \u_baud_gen|Equal0~0_combout\,
	combout => \u_baud_gen|count~3_combout\);

-- Location: FF_X63_Y48_N3
\u_baud_gen|count[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_baud_gen|count~3_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_baud_gen|count\(0));

-- Location: LCCOMB_X63_Y48_N4
\u_baud_gen|Equal0~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_baud_gen|Equal0~2_combout\ = (!\u_baud_gen|count\(0) & (\u_baud_gen|Equal0~1_combout\ & \u_baud_gen|Equal0~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \u_baud_gen|count\(0),
	datac => \u_baud_gen|Equal0~1_combout\,
	datad => \u_baud_gen|Equal0~0_combout\,
	combout => \u_baud_gen|Equal0~2_combout\);

-- Location: FF_X63_Y48_N5
\u_baud_gen|s_tick_o\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_baud_gen|Equal0~2_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_baud_gen|s_tick_o~q\);

-- Location: LCCOMB_X65_Y48_N14
\u_uart_tx|Selector1~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector1~1_combout\ = (\u_uart_tx|Equal1~0_combout\) # (((!\u_uart_tx|state.STOP~q\ & !\u_uart_tx|state.START~q\)) # (!\u_baud_gen|s_tick_o~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111110111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|Equal1~0_combout\,
	datab => \u_uart_tx|state.STOP~q\,
	datac => \u_baud_gen|s_tick_o~q\,
	datad => \u_uart_tx|state.START~q\,
	combout => \u_uart_tx|Selector1~1_combout\);

-- Location: LCCOMB_X62_Y46_N18
\u_fifo_tx|fifo_cnt[0]~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|fifo_cnt[0]~5_combout\ = (\u_fifo_tx|Equal1~0_combout\ & (\u_fifo_tx|fifo_cnt\(0) $ (VCC))) # (!\u_fifo_tx|Equal1~0_combout\ & (\u_fifo_tx|fifo_cnt\(0) & VCC))
-- \u_fifo_tx|fifo_cnt[0]~6\ = CARRY((\u_fifo_tx|Equal1~0_combout\ & \u_fifo_tx|fifo_cnt\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|Equal1~0_combout\,
	datab => \u_fifo_tx|fifo_cnt\(0),
	datad => VCC,
	combout => \u_fifo_tx|fifo_cnt[0]~5_combout\,
	cout => \u_fifo_tx|fifo_cnt[0]~6\);

-- Location: LCCOMB_X62_Y46_N4
\u_fifo_tx|Add2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|Add2~0_combout\ = \u_fifo_tx|fifo_cnt\(0) $ (VCC)
-- \u_fifo_tx|Add2~1\ = CARRY(\u_fifo_tx|fifo_cnt\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \u_fifo_tx|fifo_cnt\(0),
	datad => VCC,
	combout => \u_fifo_tx|Add2~0_combout\,
	cout => \u_fifo_tx|Add2~1\);

-- Location: LCCOMB_X61_Y46_N10
\u_fifo_rx|fifo_cnt[0]~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|fifo_cnt[0]~5_combout\ = (\u_fifo_rx|Equal1~0_combout\ & (\u_fifo_rx|fifo_cnt\(0) & VCC)) # (!\u_fifo_rx|Equal1~0_combout\ & (\u_fifo_rx|fifo_cnt\(0) $ (VCC)))
-- \u_fifo_rx|fifo_cnt[0]~6\ = CARRY((!\u_fifo_rx|Equal1~0_combout\ & \u_fifo_rx|fifo_cnt\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001100101000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|Equal1~0_combout\,
	datab => \u_fifo_rx|fifo_cnt\(0),
	datad => VCC,
	combout => \u_fifo_rx|fifo_cnt[0]~5_combout\,
	cout => \u_fifo_rx|fifo_cnt[0]~6\);

-- Location: LCCOMB_X60_Y46_N14
\u_fifo_rx|Add2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|Add2~0_combout\ = \u_fifo_rx|fifo_cnt\(0) $ (VCC)
-- \u_fifo_rx|Add2~1\ = CARRY(\u_fifo_rx|fifo_cnt\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \u_fifo_rx|fifo_cnt\(0),
	datad => VCC,
	combout => \u_fifo_rx|Add2~0_combout\,
	cout => \u_fifo_rx|Add2~1\);

-- Location: IOIBUF_X60_Y73_N1
\rx_i~input\ : cycloneive_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_rx_i,
	o => \rx_i~input_o\);

-- Location: LCCOMB_X62_Y48_N0
\u_uart_rx|tick_cnt[0]~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|tick_cnt[0]~4_combout\ = (\u_uart_rx|state.IDLE~q\ & (!\u_uart_rx|tick_cnt[3]~2_combout\ & \u_uart_rx|tick_cnt[0]~3_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \u_uart_rx|state.IDLE~q\,
	datac => \u_uart_rx|tick_cnt[3]~2_combout\,
	datad => \u_uart_rx|tick_cnt[0]~3_combout\,
	combout => \u_uart_rx|tick_cnt[0]~4_combout\);

-- Location: LCCOMB_X62_Y48_N12
\u_uart_rx|tick_cnt[3]~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|tick_cnt[3]~5_combout\ = (\u_uart_rx|tick_cnt\(3) & ((\u_uart_rx|tick_cnt[3]~2_combout\) # ((!\u_uart_rx|Equal2~1_combout\ & \u_uart_rx|tick_cnt[0]~4_combout\)))) # (!\u_uart_rx|tick_cnt\(3) & (((\u_uart_rx|Equal2~1_combout\ & 
-- \u_uart_rx|tick_cnt[0]~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_rx|tick_cnt[3]~2_combout\,
	datab => \u_uart_rx|Equal2~1_combout\,
	datac => \u_uart_rx|tick_cnt\(3),
	datad => \u_uart_rx|tick_cnt[0]~4_combout\,
	combout => \u_uart_rx|tick_cnt[3]~5_combout\);

-- Location: FF_X62_Y48_N13
\u_uart_rx|tick_cnt[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_rx|tick_cnt[3]~5_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|tick_cnt\(3));

-- Location: LCCOMB_X61_Y48_N2
\u_uart_rx|Selector1~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|Selector1~6_combout\ = (!\rx_i~input_o\ & !\u_uart_rx|state.IDLE~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \rx_i~input_o\,
	datad => \u_uart_rx|state.IDLE~q\,
	combout => \u_uart_rx|Selector1~6_combout\);

-- Location: LCCOMB_X61_Y48_N28
\u_uart_rx|Selector1~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|Selector1~7_combout\ = (!\u_uart_rx|Selector1~4_combout\ & (\u_uart_rx|Selector1~6_combout\ & (\u_uart_rx|Selector1~5_combout\ & !\u_uart_rx|Selector1~2_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_rx|Selector1~4_combout\,
	datab => \u_uart_rx|Selector1~6_combout\,
	datac => \u_uart_rx|Selector1~5_combout\,
	datad => \u_uart_rx|Selector1~2_combout\,
	combout => \u_uart_rx|Selector1~7_combout\);

-- Location: LCCOMB_X61_Y48_N0
\u_uart_rx|Selector1~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|Selector1~8_combout\ = (\u_uart_rx|Selector1~7_combout\) # ((\u_uart_rx|Selector1~9_combout\ & (!\u_uart_rx|Selector1~2_combout\ & \u_uart_rx|state.START~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_rx|Selector1~9_combout\,
	datab => \u_uart_rx|Selector1~2_combout\,
	datac => \u_uart_rx|state.START~q\,
	datad => \u_uart_rx|Selector1~7_combout\,
	combout => \u_uart_rx|Selector1~8_combout\);

-- Location: FF_X61_Y48_N1
\u_uart_rx|state.START\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_rx|Selector1~8_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|state.START~q\);

-- Location: LCCOMB_X61_Y48_N14
\u_uart_rx|tick_cnt[0]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|tick_cnt[0]~3_combout\ = ((\u_uart_rx|state.DATA~q\ & (!\u_uart_rx|tick_cnt\(3))) # (!\u_uart_rx|state.DATA~q\ & ((\u_uart_rx|tick_cnt\(3)) # (!\u_uart_rx|state.START~q\)))) # (!\u_uart_rx|Equal2~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111110101111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_rx|Equal2~1_combout\,
	datab => \u_uart_rx|state.DATA~q\,
	datac => \u_uart_rx|tick_cnt\(3),
	datad => \u_uart_rx|state.START~q\,
	combout => \u_uart_rx|tick_cnt[0]~3_combout\);

-- Location: LCCOMB_X62_Y48_N10
\u_uart_rx|tick_cnt[0]~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|tick_cnt[0]~8_combout\ = (\u_uart_rx|tick_cnt[3]~2_combout\ & (((\u_uart_rx|tick_cnt\(0))))) # (!\u_uart_rx|tick_cnt[3]~2_combout\ & (\u_uart_rx|state.IDLE~q\ & (!\u_uart_rx|tick_cnt\(0) & \u_uart_rx|tick_cnt[0]~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_rx|tick_cnt[3]~2_combout\,
	datab => \u_uart_rx|state.IDLE~q\,
	datac => \u_uart_rx|tick_cnt\(0),
	datad => \u_uart_rx|tick_cnt[0]~3_combout\,
	combout => \u_uart_rx|tick_cnt[0]~8_combout\);

-- Location: FF_X62_Y48_N11
\u_uart_rx|tick_cnt[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_rx|tick_cnt[0]~8_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|tick_cnt\(0));

-- Location: LCCOMB_X62_Y48_N2
\u_uart_rx|Add0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|Add0~0_combout\ = \u_uart_rx|tick_cnt\(2) $ (((\u_uart_rx|tick_cnt\(1) & \u_uart_rx|tick_cnt\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \u_uart_rx|tick_cnt\(1),
	datac => \u_uart_rx|tick_cnt\(2),
	datad => \u_uart_rx|tick_cnt\(0),
	combout => \u_uart_rx|Add0~0_combout\);

-- Location: LCCOMB_X62_Y48_N22
\u_uart_rx|tick_cnt[2]~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|tick_cnt[2]~6_combout\ = (\u_uart_rx|tick_cnt[3]~2_combout\ & ((\u_uart_rx|tick_cnt\(2)) # ((\u_uart_rx|Add0~0_combout\ & \u_uart_rx|tick_cnt[0]~4_combout\)))) # (!\u_uart_rx|tick_cnt[3]~2_combout\ & (\u_uart_rx|Add0~0_combout\ & 
-- ((\u_uart_rx|tick_cnt[0]~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_rx|tick_cnt[3]~2_combout\,
	datab => \u_uart_rx|Add0~0_combout\,
	datac => \u_uart_rx|tick_cnt\(2),
	datad => \u_uart_rx|tick_cnt[0]~4_combout\,
	combout => \u_uart_rx|tick_cnt[2]~6_combout\);

-- Location: FF_X62_Y48_N23
\u_uart_rx|tick_cnt[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_rx|tick_cnt[2]~6_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|tick_cnt\(2));

-- Location: LCCOMB_X62_Y48_N28
\u_uart_rx|Equal2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|Equal2~0_combout\ = (\u_uart_rx|tick_cnt\(0) & (\u_uart_rx|tick_cnt\(1) & (\u_uart_rx|tick_cnt\(2) & \u_uart_rx|tick_cnt\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_rx|tick_cnt\(0),
	datab => \u_uart_rx|tick_cnt\(1),
	datac => \u_uart_rx|tick_cnt\(2),
	datad => \u_uart_rx|tick_cnt\(3),
	combout => \u_uart_rx|Equal2~0_combout\);

-- Location: LCCOMB_X61_Y48_N24
\u_uart_rx|Selector0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|Selector0~0_combout\ = (!\u_uart_rx|tick_cnt[3]~0_combout\ & (((!\u_uart_rx|Equal2~0_combout\) # (!\u_baud_gen|s_tick_o~q\)) # (!\u_uart_rx|state.STOP~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001010101010101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_rx|tick_cnt[3]~0_combout\,
	datab => \u_uart_rx|state.STOP~q\,
	datac => \u_baud_gen|s_tick_o~q\,
	datad => \u_uart_rx|Equal2~0_combout\,
	combout => \u_uart_rx|Selector0~0_combout\);

-- Location: FF_X61_Y48_N25
\u_uart_rx|state.IDLE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_rx|Selector0~0_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|state.IDLE~q\);

-- Location: LCCOMB_X61_Y48_N12
\u_uart_rx|tick_cnt[3]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|tick_cnt[3]~0_combout\ = (\rx_i~input_o\ & !\u_uart_rx|state.IDLE~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \rx_i~input_o\,
	datad => \u_uart_rx|state.IDLE~q\,
	combout => \u_uart_rx|tick_cnt[3]~0_combout\);

-- Location: LCCOMB_X61_Y48_N18
\u_uart_rx|tick_cnt[3]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|tick_cnt[3]~1_combout\ = (!\u_baud_gen|s_tick_o~q\ & ((\u_uart_rx|state.STOP~q\) # ((\u_uart_rx|state.DATA~q\) # (\u_uart_rx|state.START~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001100110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_rx|state.STOP~q\,
	datab => \u_baud_gen|s_tick_o~q\,
	datac => \u_uart_rx|state.DATA~q\,
	datad => \u_uart_rx|state.START~q\,
	combout => \u_uart_rx|tick_cnt[3]~1_combout\);

-- Location: LCCOMB_X61_Y48_N16
\u_uart_rx|tick_cnt[3]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|tick_cnt[3]~2_combout\ = (\u_uart_rx|tick_cnt[3]~0_combout\) # ((\u_uart_rx|tick_cnt[3]~1_combout\) # ((\u_uart_rx|Equal2~0_combout\ & \u_uart_rx|state.STOP~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_rx|tick_cnt[3]~0_combout\,
	datab => \u_uart_rx|Equal2~0_combout\,
	datac => \u_uart_rx|state.STOP~q\,
	datad => \u_uart_rx|tick_cnt[3]~1_combout\,
	combout => \u_uart_rx|tick_cnt[3]~2_combout\);

-- Location: LCCOMB_X62_Y48_N16
\u_uart_rx|tick_cnt[1]~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|tick_cnt[1]~7_combout\ = (\u_uart_rx|tick_cnt\(1) & ((\u_uart_rx|tick_cnt[3]~2_combout\) # ((\u_uart_rx|tick_cnt[0]~4_combout\ & !\u_uart_rx|tick_cnt\(0))))) # (!\u_uart_rx|tick_cnt\(1) & (((\u_uart_rx|tick_cnt[0]~4_combout\ & 
-- \u_uart_rx|tick_cnt\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010110011100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_rx|tick_cnt[3]~2_combout\,
	datab => \u_uart_rx|tick_cnt[0]~4_combout\,
	datac => \u_uart_rx|tick_cnt\(1),
	datad => \u_uart_rx|tick_cnt\(0),
	combout => \u_uart_rx|tick_cnt[1]~7_combout\);

-- Location: FF_X62_Y48_N17
\u_uart_rx|tick_cnt[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_rx|tick_cnt[1]~7_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|tick_cnt\(1));

-- Location: LCCOMB_X62_Y48_N6
\u_uart_rx|Equal2~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|Equal2~1_combout\ = (\u_uart_rx|tick_cnt\(1) & (\u_uart_rx|tick_cnt\(2) & \u_uart_rx|tick_cnt\(0)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \u_uart_rx|tick_cnt\(1),
	datac => \u_uart_rx|tick_cnt\(2),
	datad => \u_uart_rx|tick_cnt\(0),
	combout => \u_uart_rx|Equal2~1_combout\);

-- Location: LCCOMB_X61_Y48_N26
\u_uart_rx|Selector1~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|Selector1~5_combout\ = ((\u_uart_rx|tick_cnt\(3)) # ((!\u_uart_rx|state.START~q\) # (!\u_baud_gen|s_tick_o~q\))) # (!\u_uart_rx|Equal2~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_rx|Equal2~1_combout\,
	datab => \u_uart_rx|tick_cnt\(3),
	datac => \u_baud_gen|s_tick_o~q\,
	datad => \u_uart_rx|state.START~q\,
	combout => \u_uart_rx|Selector1~5_combout\);

-- Location: LCCOMB_X61_Y48_N4
\u_uart_rx|Selector2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|Selector2~0_combout\ = (!\u_uart_rx|Selector1~2_combout\ & ((\u_uart_rx|Selector1~9_combout\ & ((\u_uart_rx|state.DATA~q\))) # (!\u_uart_rx|Selector1~9_combout\ & (!\u_uart_rx|Selector1~5_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_rx|Selector1~5_combout\,
	datab => \u_uart_rx|Selector1~9_combout\,
	datac => \u_uart_rx|state.DATA~q\,
	datad => \u_uart_rx|Selector1~2_combout\,
	combout => \u_uart_rx|Selector2~0_combout\);

-- Location: FF_X61_Y48_N5
\u_uart_rx|state.DATA\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_rx|Selector2~0_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|state.DATA~q\);

-- Location: LCCOMB_X61_Y48_N20
\u_uart_rx|b_reg[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|b_reg[0]~0_combout\ = (\u_baud_gen|s_tick_o~q\ & (\u_uart_rx|state.DATA~q\ & \u_uart_rx|Equal2~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \u_baud_gen|s_tick_o~q\,
	datac => \u_uart_rx|state.DATA~q\,
	datad => \u_uart_rx|Equal2~0_combout\,
	combout => \u_uart_rx|b_reg[0]~0_combout\);

-- Location: LCCOMB_X61_Y48_N6
\u_uart_rx|bit_cnt[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|bit_cnt[0]~0_combout\ = (\u_uart_rx|Selector1~5_combout\ & ((\u_uart_rx|Selector1~3_combout\) # (!\u_uart_rx|b_reg[0]~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_rx|Selector1~3_combout\,
	datac => \u_uart_rx|Selector1~5_combout\,
	datad => \u_uart_rx|b_reg[0]~0_combout\,
	combout => \u_uart_rx|bit_cnt[0]~0_combout\);

-- Location: LCCOMB_X60_Y48_N4
\u_uart_rx|bit_cnt[0]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|bit_cnt[0]~3_combout\ = (\u_uart_rx|bit_cnt\(0) & ((\u_uart_rx|bit_cnt[0]~0_combout\))) # (!\u_uart_rx|bit_cnt\(0) & (\u_uart_rx|state.DATA~q\ & !\u_uart_rx|bit_cnt[0]~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_rx|state.DATA~q\,
	datac => \u_uart_rx|bit_cnt\(0),
	datad => \u_uart_rx|bit_cnt[0]~0_combout\,
	combout => \u_uart_rx|bit_cnt[0]~3_combout\);

-- Location: FF_X60_Y48_N5
\u_uart_rx|bit_cnt[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_rx|bit_cnt[0]~3_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|bit_cnt\(0));

-- Location: LCCOMB_X60_Y48_N22
\u_uart_rx|bit_cnt[1]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|bit_cnt[1]~2_combout\ = (\u_uart_rx|bit_cnt[0]~0_combout\ & (((\u_uart_rx|bit_cnt\(1))))) # (!\u_uart_rx|bit_cnt[0]~0_combout\ & (\u_uart_rx|state.DATA~q\ & (\u_uart_rx|bit_cnt\(0) $ (\u_uart_rx|bit_cnt\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_rx|state.DATA~q\,
	datab => \u_uart_rx|bit_cnt\(0),
	datac => \u_uart_rx|bit_cnt\(1),
	datad => \u_uart_rx|bit_cnt[0]~0_combout\,
	combout => \u_uart_rx|bit_cnt[1]~2_combout\);

-- Location: FF_X60_Y48_N23
\u_uart_rx|bit_cnt[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_rx|bit_cnt[1]~2_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|bit_cnt\(1));

-- Location: LCCOMB_X60_Y48_N20
\u_uart_rx|Add1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|Add1~0_combout\ = \u_uart_rx|bit_cnt\(2) $ (((\u_uart_rx|bit_cnt\(1) & \u_uart_rx|bit_cnt\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_rx|bit_cnt\(1),
	datac => \u_uart_rx|bit_cnt\(0),
	datad => \u_uart_rx|bit_cnt\(2),
	combout => \u_uart_rx|Add1~0_combout\);

-- Location: LCCOMB_X60_Y48_N0
\u_uart_rx|bit_cnt[2]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|bit_cnt[2]~1_combout\ = (\u_uart_rx|bit_cnt[0]~0_combout\ & (((\u_uart_rx|bit_cnt\(2))))) # (!\u_uart_rx|bit_cnt[0]~0_combout\ & (\u_uart_rx|state.DATA~q\ & (\u_uart_rx|Add1~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_rx|state.DATA~q\,
	datab => \u_uart_rx|Add1~0_combout\,
	datac => \u_uart_rx|bit_cnt\(2),
	datad => \u_uart_rx|bit_cnt[0]~0_combout\,
	combout => \u_uart_rx|bit_cnt[2]~1_combout\);

-- Location: FF_X60_Y48_N1
\u_uart_rx|bit_cnt[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_rx|bit_cnt[2]~1_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|bit_cnt\(2));

-- Location: LCCOMB_X60_Y48_N14
\u_uart_rx|Selector1~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|Selector1~3_combout\ = (\u_uart_rx|bit_cnt\(1) & (\u_uart_rx|bit_cnt\(0) & \u_uart_rx|bit_cnt\(2)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_rx|bit_cnt\(1),
	datac => \u_uart_rx|bit_cnt\(0),
	datad => \u_uart_rx|bit_cnt\(2),
	combout => \u_uart_rx|Selector1~3_combout\);

-- Location: LCCOMB_X61_Y48_N10
\u_uart_rx|Selector1~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|Selector1~4_combout\ = (\u_uart_rx|Selector1~3_combout\ & (\u_baud_gen|s_tick_o~q\ & (\u_uart_rx|state.DATA~q\ & \u_uart_rx|Equal2~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_rx|Selector1~3_combout\,
	datab => \u_baud_gen|s_tick_o~q\,
	datac => \u_uart_rx|state.DATA~q\,
	datad => \u_uart_rx|Equal2~0_combout\,
	combout => \u_uart_rx|Selector1~4_combout\);

-- Location: LCCOMB_X61_Y48_N22
\u_uart_rx|Selector1~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|Selector1~9_combout\ = (!\u_uart_rx|Selector1~4_combout\ & (\u_uart_rx|Selector1~5_combout\ & ((\rx_i~input_o\) # (\u_uart_rx|state.IDLE~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_rx|Selector1~4_combout\,
	datab => \rx_i~input_o\,
	datac => \u_uart_rx|Selector1~5_combout\,
	datad => \u_uart_rx|state.IDLE~q\,
	combout => \u_uart_rx|Selector1~9_combout\);

-- Location: LCCOMB_X61_Y48_N8
\u_uart_rx|Selector3~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|Selector3~0_combout\ = (!\u_uart_rx|Selector1~2_combout\ & ((\u_uart_rx|Selector1~9_combout\ & (\u_uart_rx|state.STOP~q\)) # (!\u_uart_rx|Selector1~9_combout\ & ((\u_uart_rx|Selector1~4_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000100100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_rx|Selector1~9_combout\,
	datab => \u_uart_rx|Selector1~2_combout\,
	datac => \u_uart_rx|state.STOP~q\,
	datad => \u_uart_rx|Selector1~4_combout\,
	combout => \u_uart_rx|Selector3~0_combout\);

-- Location: FF_X61_Y48_N9
\u_uart_rx|state.STOP\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_rx|Selector3~0_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|state.STOP~q\);

-- Location: LCCOMB_X61_Y48_N30
\u_uart_rx|Selector1~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|Selector1~2_combout\ = (\u_uart_rx|state.STOP~q\ & (\u_baud_gen|s_tick_o~q\ & \u_uart_rx|Equal2~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_rx|state.STOP~q\,
	datab => \u_baud_gen|s_tick_o~q\,
	datad => \u_uart_rx|Equal2~0_combout\,
	combout => \u_uart_rx|Selector1~2_combout\);

-- Location: LCCOMB_X61_Y46_N8
\u_uart_rx|rx_done_o~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|rx_done_o~feeder_combout\ = \u_uart_rx|Selector1~2_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \u_uart_rx|Selector1~2_combout\,
	combout => \u_uart_rx|rx_done_o~feeder_combout\);

-- Location: FF_X61_Y46_N9
\u_uart_rx|rx_done_o\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_rx|rx_done_o~feeder_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|rx_done_o~q\);

-- Location: LCCOMB_X61_Y46_N4
\u_fifo_rx|fifo_cnt[0]~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|fifo_cnt[0]~7_combout\ = (\u_fifo_tx|always0~0_combout\ & (\u_uart_rx|rx_done_o~q\ & ((!\u_fifo_rx|fifo_cnt\(4)) # (!\u_fifo_rx|Equal2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|always0~0_combout\,
	datab => \u_fifo_rx|Equal2~0_combout\,
	datac => \u_uart_rx|rx_done_o~q\,
	datad => \u_fifo_rx|fifo_cnt\(4),
	combout => \u_fifo_rx|fifo_cnt[0]~7_combout\);

-- Location: FF_X61_Y46_N11
\u_fifo_rx|fifo_cnt[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|fifo_cnt[0]~5_combout\,
	asdata => \u_fifo_rx|Add2~0_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => \u_fifo_rx|fifo_cnt[0]~7_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|fifo_cnt\(0));

-- Location: LCCOMB_X61_Y46_N12
\u_fifo_rx|fifo_cnt[1]~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|fifo_cnt[1]~8_combout\ = (\u_fifo_rx|Equal1~0_combout\ & ((\u_fifo_rx|fifo_cnt\(1) & (!\u_fifo_rx|fifo_cnt[0]~6\)) # (!\u_fifo_rx|fifo_cnt\(1) & ((\u_fifo_rx|fifo_cnt[0]~6\) # (GND))))) # (!\u_fifo_rx|Equal1~0_combout\ & 
-- ((\u_fifo_rx|fifo_cnt\(1) & (\u_fifo_rx|fifo_cnt[0]~6\ & VCC)) # (!\u_fifo_rx|fifo_cnt\(1) & (!\u_fifo_rx|fifo_cnt[0]~6\))))
-- \u_fifo_rx|fifo_cnt[1]~9\ = CARRY((\u_fifo_rx|Equal1~0_combout\ & ((!\u_fifo_rx|fifo_cnt[0]~6\) # (!\u_fifo_rx|fifo_cnt\(1)))) # (!\u_fifo_rx|Equal1~0_combout\ & (!\u_fifo_rx|fifo_cnt\(1) & !\u_fifo_rx|fifo_cnt[0]~6\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100100101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|Equal1~0_combout\,
	datab => \u_fifo_rx|fifo_cnt\(1),
	datad => VCC,
	cin => \u_fifo_rx|fifo_cnt[0]~6\,
	combout => \u_fifo_rx|fifo_cnt[1]~8_combout\,
	cout => \u_fifo_rx|fifo_cnt[1]~9\);

-- Location: LCCOMB_X60_Y46_N16
\u_fifo_rx|Add2~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|Add2~2_combout\ = (\u_fifo_rx|fifo_cnt\(1) & (!\u_fifo_rx|Add2~1\)) # (!\u_fifo_rx|fifo_cnt\(1) & ((\u_fifo_rx|Add2~1\) # (GND)))
-- \u_fifo_rx|Add2~3\ = CARRY((!\u_fifo_rx|Add2~1\) # (!\u_fifo_rx|fifo_cnt\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \u_fifo_rx|fifo_cnt\(1),
	datad => VCC,
	cin => \u_fifo_rx|Add2~1\,
	combout => \u_fifo_rx|Add2~2_combout\,
	cout => \u_fifo_rx|Add2~3\);

-- Location: FF_X61_Y46_N13
\u_fifo_rx|fifo_cnt[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|fifo_cnt[1]~8_combout\,
	asdata => \u_fifo_rx|Add2~2_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => \u_fifo_rx|fifo_cnt[0]~7_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|fifo_cnt\(1));

-- Location: LCCOMB_X61_Y46_N14
\u_fifo_rx|fifo_cnt[2]~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|fifo_cnt[2]~10_combout\ = ((\u_fifo_rx|Equal1~0_combout\ $ (\u_fifo_rx|fifo_cnt\(2) $ (\u_fifo_rx|fifo_cnt[1]~9\)))) # (GND)
-- \u_fifo_rx|fifo_cnt[2]~11\ = CARRY((\u_fifo_rx|Equal1~0_combout\ & (\u_fifo_rx|fifo_cnt\(2) & !\u_fifo_rx|fifo_cnt[1]~9\)) # (!\u_fifo_rx|Equal1~0_combout\ & ((\u_fifo_rx|fifo_cnt\(2)) # (!\u_fifo_rx|fifo_cnt[1]~9\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011001001101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|Equal1~0_combout\,
	datab => \u_fifo_rx|fifo_cnt\(2),
	datad => VCC,
	cin => \u_fifo_rx|fifo_cnt[1]~9\,
	combout => \u_fifo_rx|fifo_cnt[2]~10_combout\,
	cout => \u_fifo_rx|fifo_cnt[2]~11\);

-- Location: LCCOMB_X60_Y46_N18
\u_fifo_rx|Add2~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|Add2~4_combout\ = (\u_fifo_rx|fifo_cnt\(2) & (\u_fifo_rx|Add2~3\ $ (GND))) # (!\u_fifo_rx|fifo_cnt\(2) & (!\u_fifo_rx|Add2~3\ & VCC))
-- \u_fifo_rx|Add2~5\ = CARRY((\u_fifo_rx|fifo_cnt\(2) & !\u_fifo_rx|Add2~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100001100001100",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \u_fifo_rx|fifo_cnt\(2),
	datad => VCC,
	cin => \u_fifo_rx|Add2~3\,
	combout => \u_fifo_rx|Add2~4_combout\,
	cout => \u_fifo_rx|Add2~5\);

-- Location: FF_X61_Y46_N15
\u_fifo_rx|fifo_cnt[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|fifo_cnt[2]~10_combout\,
	asdata => \u_fifo_rx|Add2~4_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => \u_fifo_rx|fifo_cnt[0]~7_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|fifo_cnt\(2));

-- Location: LCCOMB_X61_Y46_N16
\u_fifo_rx|fifo_cnt[3]~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|fifo_cnt[3]~12_combout\ = (\u_fifo_rx|Equal1~0_combout\ & ((\u_fifo_rx|fifo_cnt\(3) & (!\u_fifo_rx|fifo_cnt[2]~11\)) # (!\u_fifo_rx|fifo_cnt\(3) & ((\u_fifo_rx|fifo_cnt[2]~11\) # (GND))))) # (!\u_fifo_rx|Equal1~0_combout\ & 
-- ((\u_fifo_rx|fifo_cnt\(3) & (\u_fifo_rx|fifo_cnt[2]~11\ & VCC)) # (!\u_fifo_rx|fifo_cnt\(3) & (!\u_fifo_rx|fifo_cnt[2]~11\))))
-- \u_fifo_rx|fifo_cnt[3]~13\ = CARRY((\u_fifo_rx|Equal1~0_combout\ & ((!\u_fifo_rx|fifo_cnt[2]~11\) # (!\u_fifo_rx|fifo_cnt\(3)))) # (!\u_fifo_rx|Equal1~0_combout\ & (!\u_fifo_rx|fifo_cnt\(3) & !\u_fifo_rx|fifo_cnt[2]~11\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100100101011",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|Equal1~0_combout\,
	datab => \u_fifo_rx|fifo_cnt\(3),
	datad => VCC,
	cin => \u_fifo_rx|fifo_cnt[2]~11\,
	combout => \u_fifo_rx|fifo_cnt[3]~12_combout\,
	cout => \u_fifo_rx|fifo_cnt[3]~13\);

-- Location: LCCOMB_X60_Y46_N20
\u_fifo_rx|Add2~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|Add2~6_combout\ = (\u_fifo_rx|fifo_cnt\(3) & (!\u_fifo_rx|Add2~5\)) # (!\u_fifo_rx|fifo_cnt\(3) & ((\u_fifo_rx|Add2~5\) # (GND)))
-- \u_fifo_rx|Add2~7\ = CARRY((!\u_fifo_rx|Add2~5\) # (!\u_fifo_rx|fifo_cnt\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \u_fifo_rx|fifo_cnt\(3),
	datad => VCC,
	cin => \u_fifo_rx|Add2~5\,
	combout => \u_fifo_rx|Add2~6_combout\,
	cout => \u_fifo_rx|Add2~7\);

-- Location: FF_X61_Y46_N17
\u_fifo_rx|fifo_cnt[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|fifo_cnt[3]~12_combout\,
	asdata => \u_fifo_rx|Add2~6_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => \u_fifo_rx|fifo_cnt[0]~7_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|fifo_cnt\(3));

-- Location: LCCOMB_X61_Y46_N24
\u_fifo_rx|Equal2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|Equal2~0_combout\ = (!\u_fifo_rx|fifo_cnt\(0) & (!\u_fifo_rx|fifo_cnt\(3) & (!\u_fifo_rx|fifo_cnt\(2) & !\u_fifo_rx|fifo_cnt\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|fifo_cnt\(0),
	datab => \u_fifo_rx|fifo_cnt\(3),
	datac => \u_fifo_rx|fifo_cnt\(2),
	datad => \u_fifo_rx|fifo_cnt\(1),
	combout => \u_fifo_rx|Equal2~0_combout\);

-- Location: LCCOMB_X61_Y46_N30
\u_fifo_rx|Equal1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|Equal1~0_combout\ = (\u_fifo_tx|always0~0_combout\) # ((\u_uart_rx|rx_done_o~q\ & ((!\u_fifo_rx|Equal2~0_combout\) # (!\u_fifo_rx|fifo_cnt\(4)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|fifo_cnt\(4),
	datab => \u_fifo_rx|Equal2~0_combout\,
	datac => \u_uart_rx|rx_done_o~q\,
	datad => \u_fifo_tx|always0~0_combout\,
	combout => \u_fifo_rx|Equal1~0_combout\);

-- Location: LCCOMB_X61_Y46_N18
\u_fifo_rx|fifo_cnt[4]~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|fifo_cnt[4]~14_combout\ = \u_fifo_rx|Equal1~0_combout\ $ (\u_fifo_rx|fifo_cnt[3]~13\ $ (\u_fifo_rx|fifo_cnt\(4)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010101011010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|Equal1~0_combout\,
	datad => \u_fifo_rx|fifo_cnt\(4),
	cin => \u_fifo_rx|fifo_cnt[3]~13\,
	combout => \u_fifo_rx|fifo_cnt[4]~14_combout\);

-- Location: LCCOMB_X60_Y46_N22
\u_fifo_rx|Add2~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|Add2~8_combout\ = \u_fifo_rx|Add2~7\ $ (!\u_fifo_rx|fifo_cnt\(4))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datad => \u_fifo_rx|fifo_cnt\(4),
	cin => \u_fifo_rx|Add2~7\,
	combout => \u_fifo_rx|Add2~8_combout\);

-- Location: FF_X61_Y46_N19
\u_fifo_rx|fifo_cnt[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|fifo_cnt[4]~14_combout\,
	asdata => \u_fifo_rx|Add2~8_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => \u_fifo_rx|fifo_cnt[0]~7_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|fifo_cnt\(4));

-- Location: LCCOMB_X62_Y46_N2
\u_fifo_tx|always0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|always0~0_combout\ = (\u_fifo_tx|fifo_cnt\(4) & ((\u_fifo_tx|Equal2~0_combout\) # ((!\u_fifo_rx|fifo_cnt\(4) & \u_fifo_rx|Equal2~0_combout\)))) # (!\u_fifo_tx|fifo_cnt\(4) & (((!\u_fifo_rx|fifo_cnt\(4) & \u_fifo_rx|Equal2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000111110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|fifo_cnt\(4),
	datab => \u_fifo_tx|Equal2~0_combout\,
	datac => \u_fifo_rx|fifo_cnt\(4),
	datad => \u_fifo_rx|Equal2~0_combout\,
	combout => \u_fifo_tx|always0~0_combout\);

-- Location: LCCOMB_X62_Y46_N0
\u_fifo_tx|fifo_cnt[0]~15\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|fifo_cnt[0]~15_combout\ = (!\u_fifo_tx|always0~0_combout\ & (((!\u_fifo_tx|fifo_cnt\(4) & \u_fifo_tx|Equal2~0_combout\)) # (!\u_tx_controller|fifo_rd_o~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001001100000011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|fifo_cnt\(4),
	datab => \u_fifo_tx|always0~0_combout\,
	datac => \u_tx_controller|fifo_rd_o~q\,
	datad => \u_fifo_tx|Equal2~0_combout\,
	combout => \u_fifo_tx|fifo_cnt[0]~15_combout\);

-- Location: FF_X62_Y46_N19
\u_fifo_tx|fifo_cnt[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_tx|fifo_cnt[0]~5_combout\,
	asdata => \u_fifo_tx|Add2~0_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => \u_fifo_tx|fifo_cnt[0]~15_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|fifo_cnt\(0));

-- Location: LCCOMB_X62_Y46_N20
\u_fifo_tx|fifo_cnt[1]~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|fifo_cnt[1]~7_combout\ = (\u_fifo_tx|Equal1~0_combout\ & ((\u_fifo_tx|fifo_cnt\(1) & (\u_fifo_tx|fifo_cnt[0]~6\ & VCC)) # (!\u_fifo_tx|fifo_cnt\(1) & (!\u_fifo_tx|fifo_cnt[0]~6\)))) # (!\u_fifo_tx|Equal1~0_combout\ & ((\u_fifo_tx|fifo_cnt\(1) & 
-- (!\u_fifo_tx|fifo_cnt[0]~6\)) # (!\u_fifo_tx|fifo_cnt\(1) & ((\u_fifo_tx|fifo_cnt[0]~6\) # (GND)))))
-- \u_fifo_tx|fifo_cnt[1]~8\ = CARRY((\u_fifo_tx|Equal1~0_combout\ & (!\u_fifo_tx|fifo_cnt\(1) & !\u_fifo_tx|fifo_cnt[0]~6\)) # (!\u_fifo_tx|Equal1~0_combout\ & ((!\u_fifo_tx|fifo_cnt[0]~6\) # (!\u_fifo_tx|fifo_cnt\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|Equal1~0_combout\,
	datab => \u_fifo_tx|fifo_cnt\(1),
	datad => VCC,
	cin => \u_fifo_tx|fifo_cnt[0]~6\,
	combout => \u_fifo_tx|fifo_cnt[1]~7_combout\,
	cout => \u_fifo_tx|fifo_cnt[1]~8\);

-- Location: LCCOMB_X62_Y46_N6
\u_fifo_tx|Add2~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|Add2~2_combout\ = (\u_fifo_tx|fifo_cnt\(1) & (!\u_fifo_tx|Add2~1\)) # (!\u_fifo_tx|fifo_cnt\(1) & ((\u_fifo_tx|Add2~1\) # (GND)))
-- \u_fifo_tx|Add2~3\ = CARRY((!\u_fifo_tx|Add2~1\) # (!\u_fifo_tx|fifo_cnt\(1)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \u_fifo_tx|fifo_cnt\(1),
	datad => VCC,
	cin => \u_fifo_tx|Add2~1\,
	combout => \u_fifo_tx|Add2~2_combout\,
	cout => \u_fifo_tx|Add2~3\);

-- Location: FF_X62_Y46_N21
\u_fifo_tx|fifo_cnt[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_tx|fifo_cnt[1]~7_combout\,
	asdata => \u_fifo_tx|Add2~2_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => \u_fifo_tx|fifo_cnt[0]~15_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|fifo_cnt\(1));

-- Location: LCCOMB_X62_Y46_N22
\u_fifo_tx|fifo_cnt[2]~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|fifo_cnt[2]~9_combout\ = ((\u_fifo_tx|fifo_cnt\(2) $ (\u_fifo_tx|Equal1~0_combout\ $ (!\u_fifo_tx|fifo_cnt[1]~8\)))) # (GND)
-- \u_fifo_tx|fifo_cnt[2]~10\ = CARRY((\u_fifo_tx|fifo_cnt\(2) & ((\u_fifo_tx|Equal1~0_combout\) # (!\u_fifo_tx|fifo_cnt[1]~8\))) # (!\u_fifo_tx|fifo_cnt\(2) & (\u_fifo_tx|Equal1~0_combout\ & !\u_fifo_tx|fifo_cnt[1]~8\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|fifo_cnt\(2),
	datab => \u_fifo_tx|Equal1~0_combout\,
	datad => VCC,
	cin => \u_fifo_tx|fifo_cnt[1]~8\,
	combout => \u_fifo_tx|fifo_cnt[2]~9_combout\,
	cout => \u_fifo_tx|fifo_cnt[2]~10\);

-- Location: LCCOMB_X62_Y46_N8
\u_fifo_tx|Add2~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|Add2~4_combout\ = (\u_fifo_tx|fifo_cnt\(2) & (\u_fifo_tx|Add2~3\ $ (GND))) # (!\u_fifo_tx|fifo_cnt\(2) & (!\u_fifo_tx|Add2~3\ & VCC))
-- \u_fifo_tx|Add2~5\ = CARRY((\u_fifo_tx|fifo_cnt\(2) & !\u_fifo_tx|Add2~3\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010100001010",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|fifo_cnt\(2),
	datad => VCC,
	cin => \u_fifo_tx|Add2~3\,
	combout => \u_fifo_tx|Add2~4_combout\,
	cout => \u_fifo_tx|Add2~5\);

-- Location: FF_X62_Y46_N23
\u_fifo_tx|fifo_cnt[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_tx|fifo_cnt[2]~9_combout\,
	asdata => \u_fifo_tx|Add2~4_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => \u_fifo_tx|fifo_cnt[0]~15_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|fifo_cnt\(2));

-- Location: LCCOMB_X62_Y46_N24
\u_fifo_tx|fifo_cnt[3]~11\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|fifo_cnt[3]~11_combout\ = (\u_fifo_tx|Equal1~0_combout\ & ((\u_fifo_tx|fifo_cnt\(3) & (\u_fifo_tx|fifo_cnt[2]~10\ & VCC)) # (!\u_fifo_tx|fifo_cnt\(3) & (!\u_fifo_tx|fifo_cnt[2]~10\)))) # (!\u_fifo_tx|Equal1~0_combout\ & 
-- ((\u_fifo_tx|fifo_cnt\(3) & (!\u_fifo_tx|fifo_cnt[2]~10\)) # (!\u_fifo_tx|fifo_cnt\(3) & ((\u_fifo_tx|fifo_cnt[2]~10\) # (GND)))))
-- \u_fifo_tx|fifo_cnt[3]~12\ = CARRY((\u_fifo_tx|Equal1~0_combout\ & (!\u_fifo_tx|fifo_cnt\(3) & !\u_fifo_tx|fifo_cnt[2]~10\)) # (!\u_fifo_tx|Equal1~0_combout\ & ((!\u_fifo_tx|fifo_cnt[2]~10\) # (!\u_fifo_tx|fifo_cnt\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|Equal1~0_combout\,
	datab => \u_fifo_tx|fifo_cnt\(3),
	datad => VCC,
	cin => \u_fifo_tx|fifo_cnt[2]~10\,
	combout => \u_fifo_tx|fifo_cnt[3]~11_combout\,
	cout => \u_fifo_tx|fifo_cnt[3]~12\);

-- Location: LCCOMB_X62_Y46_N10
\u_fifo_tx|Add2~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|Add2~6_combout\ = (\u_fifo_tx|fifo_cnt\(3) & (!\u_fifo_tx|Add2~5\)) # (!\u_fifo_tx|fifo_cnt\(3) & ((\u_fifo_tx|Add2~5\) # (GND)))
-- \u_fifo_tx|Add2~7\ = CARRY((!\u_fifo_tx|Add2~5\) # (!\u_fifo_tx|fifo_cnt\(3)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	datab => \u_fifo_tx|fifo_cnt\(3),
	datad => VCC,
	cin => \u_fifo_tx|Add2~5\,
	combout => \u_fifo_tx|Add2~6_combout\,
	cout => \u_fifo_tx|Add2~7\);

-- Location: FF_X62_Y46_N25
\u_fifo_tx|fifo_cnt[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_tx|fifo_cnt[3]~11_combout\,
	asdata => \u_fifo_tx|Add2~6_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => \u_fifo_tx|fifo_cnt[0]~15_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|fifo_cnt\(3));

-- Location: LCCOMB_X62_Y46_N16
\u_fifo_tx|Equal2~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|Equal2~0_combout\ = (!\u_fifo_tx|fifo_cnt\(0) & (!\u_fifo_tx|fifo_cnt\(3) & (!\u_fifo_tx|fifo_cnt\(2) & !\u_fifo_tx|fifo_cnt\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|fifo_cnt\(0),
	datab => \u_fifo_tx|fifo_cnt\(3),
	datac => \u_fifo_tx|fifo_cnt\(2),
	datad => \u_fifo_tx|fifo_cnt\(1),
	combout => \u_fifo_tx|Equal2~0_combout\);

-- Location: LCCOMB_X62_Y46_N28
\u_fifo_tx|Equal1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|Equal1~0_combout\ = (\u_tx_controller|fifo_rd_o~q\ & (\u_fifo_tx|always0~0_combout\ & ((\u_fifo_tx|fifo_cnt\(4)) # (!\u_fifo_tx|Equal2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|fifo_cnt\(4),
	datab => \u_fifo_tx|Equal2~0_combout\,
	datac => \u_tx_controller|fifo_rd_o~q\,
	datad => \u_fifo_tx|always0~0_combout\,
	combout => \u_fifo_tx|Equal1~0_combout\);

-- Location: LCCOMB_X62_Y46_N26
\u_fifo_tx|fifo_cnt[4]~13\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|fifo_cnt[4]~13_combout\ = \u_fifo_tx|fifo_cnt\(4) $ (\u_fifo_tx|fifo_cnt[3]~12\ $ (!\u_fifo_tx|Equal1~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101010100101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|fifo_cnt\(4),
	datad => \u_fifo_tx|Equal1~0_combout\,
	cin => \u_fifo_tx|fifo_cnt[3]~12\,
	combout => \u_fifo_tx|fifo_cnt[4]~13_combout\);

-- Location: LCCOMB_X62_Y46_N12
\u_fifo_tx|Add2~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|Add2~8_combout\ = \u_fifo_tx|fifo_cnt\(4) $ (!\u_fifo_tx|Add2~7\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010010110100101",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|fifo_cnt\(4),
	cin => \u_fifo_tx|Add2~7\,
	combout => \u_fifo_tx|Add2~8_combout\);

-- Location: FF_X62_Y46_N27
\u_fifo_tx|fifo_cnt[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_tx|fifo_cnt[4]~13_combout\,
	asdata => \u_fifo_tx|Add2~8_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => \u_fifo_tx|fifo_cnt[0]~15_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|fifo_cnt\(4));

-- Location: FF_X65_Y48_N25
\u_uart_tx|tx_done_o\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_uart_tx|Selector1~0_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_tx|tx_done_o~q\);

-- Location: LCCOMB_X65_Y48_N28
\u_tx_controller|uart_ready~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_tx_controller|uart_ready~0_combout\ = (\u_tx_controller|uart_start_o~q\) # ((!\u_uart_tx|tx_done_o~q\ & \u_tx_controller|uart_ready~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111101010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|tx_done_o~q\,
	datac => \u_tx_controller|uart_ready~q\,
	datad => \u_tx_controller|uart_start_o~q\,
	combout => \u_tx_controller|uart_ready~0_combout\);

-- Location: FF_X65_Y48_N29
\u_tx_controller|uart_ready\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_tx_controller|uart_ready~0_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_tx_controller|uart_ready~q\);

-- Location: LCCOMB_X65_Y48_N26
\u_tx_controller|Selector0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_tx_controller|Selector0~0_combout\ = (!\u_tx_controller|state.STATE_IDLE~q\ & ((\u_tx_controller|uart_ready~q\) # ((!\u_fifo_tx|fifo_cnt\(4) & \u_fifo_tx|Equal2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011011100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|fifo_cnt\(4),
	datab => \u_tx_controller|uart_ready~q\,
	datac => \u_fifo_tx|Equal2~0_combout\,
	datad => \u_tx_controller|state.STATE_IDLE~q\,
	combout => \u_tx_controller|Selector0~0_combout\);

-- Location: LCCOMB_X65_Y48_N2
\u_tx_controller|Selector0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_tx_controller|Selector0~1_combout\ = (!\u_tx_controller|Selector0~0_combout\ & !\u_tx_controller|fifo_rd_o~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010100000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_tx_controller|Selector0~0_combout\,
	datac => \u_tx_controller|fifo_rd_o~q\,
	combout => \u_tx_controller|Selector0~1_combout\);

-- Location: FF_X65_Y48_N3
\u_tx_controller|state.STATE_IDLE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_tx_controller|Selector0~1_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_tx_controller|state.STATE_IDLE~q\);

-- Location: LCCOMB_X65_Y48_N22
\u_tx_controller|state~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_tx_controller|state~10_combout\ = (!\u_tx_controller|uart_ready~q\ & (!\u_tx_controller|state.STATE_IDLE~q\ & ((\u_fifo_tx|fifo_cnt\(4)) # (!\u_fifo_tx|Equal2~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|fifo_cnt\(4),
	datab => \u_tx_controller|uart_ready~q\,
	datac => \u_fifo_tx|Equal2~0_combout\,
	datad => \u_tx_controller|state.STATE_IDLE~q\,
	combout => \u_tx_controller|state~10_combout\);

-- Location: FF_X65_Y48_N23
\u_tx_controller|state.STATE_READ_FIFO\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_tx_controller|state~10_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_tx_controller|state.STATE_READ_FIFO~q\);

-- Location: FF_X65_Y48_N7
\u_tx_controller|fifo_rd_o\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_tx_controller|state.STATE_READ_FIFO~q\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_tx_controller|fifo_rd_o~q\);

-- Location: FF_X65_Y48_N17
\u_tx_controller|uart_start_o\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_tx_controller|fifo_rd_o~q\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_tx_controller|uart_start_o~q\);

-- Location: LCCOMB_X65_Y48_N0
\u_uart_tx|b_reg[6]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|b_reg[6]~3_combout\ = (!\u_uart_tx|state.IDLE~q\ & \u_tx_controller|uart_start_o~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \u_uart_tx|state.IDLE~q\,
	datad => \u_tx_controller|uart_start_o~q\,
	combout => \u_uart_tx|b_reg[6]~3_combout\);

-- Location: LCCOMB_X66_Y48_N6
\u_uart_tx|Selector2~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector2~2_combout\ = (!\u_uart_tx|Selector2~1_combout\ & ((\u_uart_tx|b_reg[6]~3_combout\) # ((\u_uart_tx|Selector1~1_combout\ & \u_uart_tx|state.START~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|Selector1~1_combout\,
	datab => \u_uart_tx|b_reg[6]~3_combout\,
	datac => \u_uart_tx|state.START~q\,
	datad => \u_uart_tx|Selector2~1_combout\,
	combout => \u_uart_tx|Selector2~2_combout\);

-- Location: FF_X66_Y48_N7
\u_uart_tx|state.START\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_tx|Selector2~2_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_tx|state.START~q\);

-- Location: LCCOMB_X65_Y48_N16
\u_uart_tx|Selector3~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector3~0_combout\ = (!\u_uart_tx|Equal1~0_combout\ & (\u_baud_gen|s_tick_o~q\ & \u_uart_tx|state.START~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|Equal1~0_combout\,
	datab => \u_baud_gen|s_tick_o~q\,
	datad => \u_uart_tx|state.START~q\,
	combout => \u_uart_tx|Selector3~0_combout\);

-- Location: LCCOMB_X67_Y48_N0
\u_uart_tx|Add1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Add1~0_combout\ = (\u_uart_tx|bit_cnt\(0) & \u_uart_tx|bit_cnt\(1))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \u_uart_tx|bit_cnt\(0),
	datad => \u_uart_tx|bit_cnt\(1),
	combout => \u_uart_tx|Add1~0_combout\);

-- Location: LCCOMB_X66_Y48_N30
\u_uart_tx|bit_cnt[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|bit_cnt[0]~0_combout\ = (\u_uart_tx|Equal1~0_combout\) # (((!\u_uart_tx|state.START~q\ & !\u_uart_tx|Selector1~2_combout\)) # (!\u_baud_gen|s_tick_o~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|state.START~q\,
	datab => \u_uart_tx|Selector1~2_combout\,
	datac => \u_uart_tx|Equal1~0_combout\,
	datad => \u_baud_gen|s_tick_o~q\,
	combout => \u_uart_tx|bit_cnt[0]~0_combout\);

-- Location: LCCOMB_X67_Y48_N12
\u_uart_tx|bit_cnt[2]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|bit_cnt[2]~1_combout\ = (\u_uart_tx|bit_cnt[0]~0_combout\ & (((\u_uart_tx|bit_cnt\(2))))) # (!\u_uart_tx|bit_cnt[0]~0_combout\ & (\u_uart_tx|state.DATA~q\ & (\u_uart_tx|Add1~0_combout\ $ (\u_uart_tx|bit_cnt\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000001001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|Add1~0_combout\,
	datab => \u_uart_tx|state.DATA~q\,
	datac => \u_uart_tx|bit_cnt\(2),
	datad => \u_uart_tx|bit_cnt[0]~0_combout\,
	combout => \u_uart_tx|bit_cnt[2]~1_combout\);

-- Location: FF_X67_Y48_N13
\u_uart_tx|bit_cnt[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_tx|bit_cnt[2]~1_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_tx|bit_cnt\(2));

-- Location: LCCOMB_X67_Y48_N26
\u_uart_tx|Selector1~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector1~2_combout\ = (\u_uart_tx|state.DATA~q\ & (((!\u_uart_tx|bit_cnt\(2)) # (!\u_uart_tx|bit_cnt\(0))) # (!\u_uart_tx|bit_cnt\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|bit_cnt\(1),
	datab => \u_uart_tx|bit_cnt\(0),
	datac => \u_uart_tx|state.DATA~q\,
	datad => \u_uart_tx|bit_cnt\(2),
	combout => \u_uart_tx|Selector1~2_combout\);

-- Location: LCCOMB_X66_Y48_N4
\u_uart_tx|Selector1~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector1~3_combout\ = (\u_uart_tx|Selector1~2_combout\) # ((!\u_uart_tx|state.DATA~q\ & !\u_tx_controller|uart_start_o~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|state.DATA~q\,
	datac => \u_tx_controller|uart_start_o~q\,
	datad => \u_uart_tx|Selector1~2_combout\,
	combout => \u_uart_tx|Selector1~3_combout\);

-- Location: LCCOMB_X65_Y48_N24
\u_uart_tx|b_reg[6]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|b_reg[6]~0_combout\ = (\u_uart_tx|Equal1~0_combout\) # ((!\u_uart_tx|state.DATA~q\) # (!\u_baud_gen|s_tick_o~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|Equal1~0_combout\,
	datab => \u_baud_gen|s_tick_o~q\,
	datad => \u_uart_tx|state.DATA~q\,
	combout => \u_uart_tx|b_reg[6]~0_combout\);

-- Location: LCCOMB_X65_Y48_N20
\u_uart_tx|Selector1~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector1~4_combout\ = (\u_uart_tx|Selector1~1_combout\ & ((\u_uart_tx|Selector1~3_combout\) # ((\u_uart_tx|state.IDLE~q\ & \u_uart_tx|b_reg[6]~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100100010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|Selector1~3_combout\,
	datab => \u_uart_tx|Selector1~1_combout\,
	datac => \u_uart_tx|state.IDLE~q\,
	datad => \u_uart_tx|b_reg[6]~0_combout\,
	combout => \u_uart_tx|Selector1~4_combout\);

-- Location: LCCOMB_X65_Y48_N10
\u_uart_tx|Selector3~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector3~1_combout\ = (\u_uart_tx|Selector1~4_combout\ & (((\u_uart_tx|state.DATA~q\)))) # (!\u_uart_tx|Selector1~4_combout\ & (\u_uart_tx|Selector3~0_combout\ & (!\u_uart_tx|Selector1~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|Selector3~0_combout\,
	datab => \u_uart_tx|Selector1~0_combout\,
	datac => \u_uart_tx|state.DATA~q\,
	datad => \u_uart_tx|Selector1~4_combout\,
	combout => \u_uart_tx|Selector3~1_combout\);

-- Location: FF_X65_Y48_N11
\u_uart_tx|state.DATA\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_tx|Selector3~1_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_tx|state.DATA~q\);

-- Location: LCCOMB_X67_Y48_N28
\u_uart_tx|bit_cnt[0]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|bit_cnt[0]~3_combout\ = (\u_uart_tx|bit_cnt\(0) & ((\u_uart_tx|bit_cnt[0]~0_combout\))) # (!\u_uart_tx|bit_cnt\(0) & (\u_uart_tx|state.DATA~q\ & !\u_uart_tx|bit_cnt[0]~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \u_uart_tx|state.DATA~q\,
	datac => \u_uart_tx|bit_cnt\(0),
	datad => \u_uart_tx|bit_cnt[0]~0_combout\,
	combout => \u_uart_tx|bit_cnt[0]~3_combout\);

-- Location: FF_X67_Y48_N29
\u_uart_tx|bit_cnt[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_tx|bit_cnt[0]~3_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_tx|bit_cnt\(0));

-- Location: LCCOMB_X67_Y48_N6
\u_uart_tx|bit_cnt[1]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|bit_cnt[1]~2_combout\ = (\u_uart_tx|bit_cnt[0]~0_combout\ & (((\u_uart_tx|bit_cnt\(1))))) # (!\u_uart_tx|bit_cnt[0]~0_combout\ & (\u_uart_tx|state.DATA~q\ & (\u_uart_tx|bit_cnt\(0) $ (\u_uart_tx|bit_cnt\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000001001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|bit_cnt\(0),
	datab => \u_uart_tx|state.DATA~q\,
	datac => \u_uart_tx|bit_cnt\(1),
	datad => \u_uart_tx|bit_cnt[0]~0_combout\,
	combout => \u_uart_tx|bit_cnt[1]~2_combout\);

-- Location: FF_X67_Y48_N7
\u_uart_tx|bit_cnt[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_tx|bit_cnt[1]~2_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_tx|bit_cnt\(1));

-- Location: LCCOMB_X66_Y48_N10
\u_uart_tx|Selector2~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector2~1_combout\ = (\u_uart_tx|bit_cnt\(1) & (!\u_uart_tx|b_reg[6]~0_combout\ & (\u_uart_tx|bit_cnt\(2) & \u_uart_tx|bit_cnt\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|bit_cnt\(1),
	datab => \u_uart_tx|b_reg[6]~0_combout\,
	datac => \u_uart_tx|bit_cnt\(2),
	datad => \u_uart_tx|bit_cnt\(0),
	combout => \u_uart_tx|Selector2~1_combout\);

-- Location: LCCOMB_X66_Y48_N22
\u_uart_tx|Selector4~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector4~0_combout\ = (\u_uart_tx|Selector2~1_combout\) # ((\u_uart_tx|state.STOP~q\ & ((\u_uart_tx|Equal1~0_combout\) # (!\u_baud_gen|s_tick_o~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|Selector2~1_combout\,
	datab => \u_uart_tx|Equal1~0_combout\,
	datac => \u_uart_tx|state.STOP~q\,
	datad => \u_baud_gen|s_tick_o~q\,
	combout => \u_uart_tx|Selector4~0_combout\);

-- Location: FF_X66_Y48_N23
\u_uart_tx|state.STOP\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_tx|Selector4~0_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_tx|state.STOP~q\);

-- Location: LCCOMB_X65_Y48_N12
\u_uart_tx|tick_cnt[0]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|tick_cnt[0]~1_combout\ = (!\u_uart_tx|state.IDLE~q\ & !\u_tx_controller|uart_start_o~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \u_uart_tx|state.IDLE~q\,
	datad => \u_tx_controller|uart_start_o~q\,
	combout => \u_uart_tx|tick_cnt[0]~1_combout\);

-- Location: LCCOMB_X65_Y48_N18
\u_uart_tx|tick_cnt[0]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|tick_cnt[0]~2_combout\ = (!\u_baud_gen|s_tick_o~q\ & ((\u_uart_tx|state.START~q\) # ((\u_uart_tx|state.STOP~q\) # (\u_uart_tx|state.DATA~q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|state.START~q\,
	datab => \u_uart_tx|state.STOP~q\,
	datac => \u_baud_gen|s_tick_o~q\,
	datad => \u_uart_tx|state.DATA~q\,
	combout => \u_uart_tx|tick_cnt[0]~2_combout\);

-- Location: LCCOMB_X65_Y48_N4
\u_uart_tx|tick_cnt[0]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|tick_cnt[0]~3_combout\ = (\u_uart_tx|tick_cnt[0]~1_combout\) # ((\u_uart_tx|tick_cnt[0]~2_combout\) # ((!\u_uart_tx|Equal1~0_combout\ & \u_uart_tx|state.STOP~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|Equal1~0_combout\,
	datab => \u_uart_tx|state.STOP~q\,
	datac => \u_uart_tx|tick_cnt[0]~1_combout\,
	datad => \u_uart_tx|tick_cnt[0]~2_combout\,
	combout => \u_uart_tx|tick_cnt[0]~3_combout\);

-- Location: LCCOMB_X66_Y48_N18
\u_uart_tx|tick_cnt[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|tick_cnt[0]~0_combout\ = (\u_uart_tx|state.DATA~q\) # (\u_uart_tx|state.START~q\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|state.DATA~q\,
	datad => \u_uart_tx|state.START~q\,
	combout => \u_uart_tx|tick_cnt[0]~0_combout\);

-- Location: LCCOMB_X66_Y48_N28
\u_uart_tx|tick_cnt[0]~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|tick_cnt[0]~4_combout\ = (\u_uart_tx|state.IDLE~q\ & (!\u_uart_tx|tick_cnt[0]~3_combout\ & ((\u_uart_tx|Equal1~0_combout\) # (!\u_uart_tx|tick_cnt[0]~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000000010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|state.IDLE~q\,
	datab => \u_uart_tx|tick_cnt[0]~0_combout\,
	datac => \u_uart_tx|tick_cnt[0]~3_combout\,
	datad => \u_uart_tx|Equal1~0_combout\,
	combout => \u_uart_tx|tick_cnt[0]~4_combout\);

-- Location: LCCOMB_X66_Y48_N26
\u_uart_tx|tick_cnt[0]~8\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|tick_cnt[0]~8_combout\ = (\u_uart_tx|tick_cnt\(0) & (\u_uart_tx|tick_cnt[0]~3_combout\)) # (!\u_uart_tx|tick_cnt\(0) & ((\u_uart_tx|tick_cnt[0]~4_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \u_uart_tx|tick_cnt[0]~3_combout\,
	datac => \u_uart_tx|tick_cnt\(0),
	datad => \u_uart_tx|tick_cnt[0]~4_combout\,
	combout => \u_uart_tx|tick_cnt[0]~8_combout\);

-- Location: FF_X66_Y48_N27
\u_uart_tx|tick_cnt[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_tx|tick_cnt[0]~8_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_tx|tick_cnt\(0));

-- Location: LCCOMB_X66_Y48_N24
\u_uart_tx|tick_cnt[1]~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|tick_cnt[1]~7_combout\ = (\u_uart_tx|tick_cnt\(1) & ((\u_uart_tx|tick_cnt[0]~3_combout\) # ((!\u_uart_tx|tick_cnt\(0) & \u_uart_tx|tick_cnt[0]~4_combout\)))) # (!\u_uart_tx|tick_cnt\(1) & (\u_uart_tx|tick_cnt\(0) & 
-- ((\u_uart_tx|tick_cnt[0]~4_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|tick_cnt\(0),
	datab => \u_uart_tx|tick_cnt[0]~3_combout\,
	datac => \u_uart_tx|tick_cnt\(1),
	datad => \u_uart_tx|tick_cnt[0]~4_combout\,
	combout => \u_uart_tx|tick_cnt[1]~7_combout\);

-- Location: FF_X66_Y48_N25
\u_uart_tx|tick_cnt[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_tx|tick_cnt[1]~7_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_tx|tick_cnt\(1));

-- Location: LCCOMB_X66_Y48_N14
\u_uart_tx|Add0~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Add0~1_combout\ = \u_uart_tx|tick_cnt\(2) $ (((\u_uart_tx|tick_cnt\(1) & \u_uart_tx|tick_cnt\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \u_uart_tx|tick_cnt\(1),
	datac => \u_uart_tx|tick_cnt\(0),
	datad => \u_uart_tx|tick_cnt\(2),
	combout => \u_uart_tx|Add0~1_combout\);

-- Location: LCCOMB_X66_Y48_N2
\u_uart_tx|tick_cnt[2]~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|tick_cnt[2]~6_combout\ = (\u_uart_tx|Add0~1_combout\ & ((\u_uart_tx|tick_cnt[0]~4_combout\) # ((\u_uart_tx|tick_cnt[0]~3_combout\ & \u_uart_tx|tick_cnt\(2))))) # (!\u_uart_tx|Add0~1_combout\ & (\u_uart_tx|tick_cnt[0]~3_combout\ & 
-- (\u_uart_tx|tick_cnt\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|Add0~1_combout\,
	datab => \u_uart_tx|tick_cnt[0]~3_combout\,
	datac => \u_uart_tx|tick_cnt\(2),
	datad => \u_uart_tx|tick_cnt[0]~4_combout\,
	combout => \u_uart_tx|tick_cnt[2]~6_combout\);

-- Location: FF_X66_Y48_N3
\u_uart_tx|tick_cnt[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_tx|tick_cnt[2]~6_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_tx|tick_cnt\(2));

-- Location: LCCOMB_X66_Y48_N16
\u_uart_tx|Add0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Add0~0_combout\ = \u_uart_tx|tick_cnt\(3) $ (((\u_uart_tx|tick_cnt\(0) & (\u_uart_tx|tick_cnt\(1) & \u_uart_tx|tick_cnt\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|tick_cnt\(0),
	datab => \u_uart_tx|tick_cnt\(1),
	datac => \u_uart_tx|tick_cnt\(3),
	datad => \u_uart_tx|tick_cnt\(2),
	combout => \u_uart_tx|Add0~0_combout\);

-- Location: LCCOMB_X66_Y48_N8
\u_uart_tx|tick_cnt[3]~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|tick_cnt[3]~5_combout\ = (\u_uart_tx|Add0~0_combout\ & ((\u_uart_tx|tick_cnt[0]~4_combout\) # ((\u_uart_tx|tick_cnt[0]~3_combout\ & \u_uart_tx|tick_cnt\(3))))) # (!\u_uart_tx|Add0~0_combout\ & (\u_uart_tx|tick_cnt[0]~3_combout\ & 
-- (\u_uart_tx|tick_cnt\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|Add0~0_combout\,
	datab => \u_uart_tx|tick_cnt[0]~3_combout\,
	datac => \u_uart_tx|tick_cnt\(3),
	datad => \u_uart_tx|tick_cnt[0]~4_combout\,
	combout => \u_uart_tx|tick_cnt[3]~5_combout\);

-- Location: FF_X66_Y48_N9
\u_uart_tx|tick_cnt[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_tx|tick_cnt[3]~5_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_tx|tick_cnt\(3));

-- Location: LCCOMB_X66_Y48_N20
\u_uart_tx|Equal1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Equal1~0_combout\ = (((!\u_uart_tx|tick_cnt\(2)) # (!\u_uart_tx|tick_cnt\(3))) # (!\u_uart_tx|tick_cnt\(1))) # (!\u_uart_tx|tick_cnt\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|tick_cnt\(0),
	datab => \u_uart_tx|tick_cnt\(1),
	datac => \u_uart_tx|tick_cnt\(3),
	datad => \u_uart_tx|tick_cnt\(2),
	combout => \u_uart_tx|Equal1~0_combout\);

-- Location: LCCOMB_X65_Y48_N8
\u_uart_tx|Selector1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector1~0_combout\ = (!\u_uart_tx|Equal1~0_combout\ & (\u_baud_gen|s_tick_o~q\ & \u_uart_tx|state.STOP~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|Equal1~0_combout\,
	datac => \u_baud_gen|s_tick_o~q\,
	datad => \u_uart_tx|state.STOP~q\,
	combout => \u_uart_tx|Selector1~0_combout\);

-- Location: LCCOMB_X65_Y48_N30
\u_uart_tx|state.IDLE~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|state.IDLE~0_combout\ = (\u_uart_tx|Selector1~4_combout\ & ((\u_uart_tx|state.IDLE~q\))) # (!\u_uart_tx|Selector1~4_combout\ & (!\u_uart_tx|Selector1~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \u_uart_tx|Selector1~0_combout\,
	datac => \u_uart_tx|state.IDLE~q\,
	datad => \u_uart_tx|Selector1~4_combout\,
	combout => \u_uart_tx|state.IDLE~0_combout\);

-- Location: FF_X65_Y48_N31
\u_uart_tx|state.IDLE\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_tx|state.IDLE~0_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_tx|state.IDLE~q\);

-- Location: FF_X61_Y48_N31
\u_uart_rx|b_reg[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \rx_i~input_o\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => VCC,
	ena => \u_uart_rx|b_reg[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|b_reg\(7));

-- Location: LCCOMB_X61_Y47_N14
\u_uart_rx|b_reg[6]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|b_reg[6]~feeder_combout\ = \u_uart_rx|b_reg\(7)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \u_uart_rx|b_reg\(7),
	combout => \u_uart_rx|b_reg[6]~feeder_combout\);

-- Location: FF_X61_Y47_N15
\u_uart_rx|b_reg[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_rx|b_reg[6]~feeder_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \u_uart_rx|b_reg[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|b_reg\(6));

-- Location: FF_X61_Y47_N23
\u_uart_rx|b_reg[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_uart_rx|b_reg\(6),
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => VCC,
	ena => \u_uart_rx|b_reg[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|b_reg\(5));

-- Location: FF_X61_Y47_N19
\u_uart_rx|b_reg[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_uart_rx|b_reg\(5),
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => VCC,
	ena => \u_uart_rx|b_reg[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|b_reg\(4));

-- Location: LCCOMB_X61_Y47_N26
\u_uart_rx|b_reg[3]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|b_reg[3]~feeder_combout\ = \u_uart_rx|b_reg\(4)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \u_uart_rx|b_reg\(4),
	combout => \u_uart_rx|b_reg[3]~feeder_combout\);

-- Location: FF_X61_Y47_N27
\u_uart_rx|b_reg[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_rx|b_reg[3]~feeder_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \u_uart_rx|b_reg[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|b_reg\(3));

-- Location: FF_X61_Y47_N3
\u_uart_rx|b_reg[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_uart_rx|b_reg\(3),
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => VCC,
	ena => \u_uart_rx|b_reg[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|b_reg\(2));

-- Location: LCCOMB_X61_Y47_N10
\u_uart_rx|b_reg[1]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|b_reg[1]~feeder_combout\ = \u_uart_rx|b_reg\(2)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \u_uart_rx|b_reg\(2),
	combout => \u_uart_rx|b_reg[1]~feeder_combout\);

-- Location: FF_X61_Y47_N11
\u_uart_rx|b_reg[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_rx|b_reg[1]~feeder_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \u_uart_rx|b_reg[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|b_reg\(1));

-- Location: LCCOMB_X61_Y47_N28
\u_uart_rx|b_reg[0]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|b_reg[0]~feeder_combout\ = \u_uart_rx|b_reg\(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \u_uart_rx|b_reg\(1),
	combout => \u_uart_rx|b_reg[0]~feeder_combout\);

-- Location: FF_X61_Y47_N29
\u_uart_rx|b_reg[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_rx|b_reg[0]~feeder_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \u_uart_rx|b_reg[0]~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|b_reg\(0));

-- Location: LCCOMB_X61_Y47_N0
\u_uart_rx|data_o[0]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|data_o[0]~feeder_combout\ = \u_uart_rx|b_reg\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \u_uart_rx|b_reg\(0),
	combout => \u_uart_rx|data_o[0]~feeder_combout\);

-- Location: FF_X61_Y47_N1
\u_uart_rx|data_o[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_rx|data_o[0]~feeder_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \u_uart_rx|Selector1~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|data_o\(0));

-- Location: LCCOMB_X65_Y47_N14
\u_fifo_rx|memory_rtl_0_bypass[9]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory_rtl_0_bypass[9]~feeder_combout\ = \u_uart_rx|data_o\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \u_uart_rx|data_o\(0),
	combout => \u_fifo_rx|memory_rtl_0_bypass[9]~feeder_combout\);

-- Location: FF_X65_Y47_N15
\u_fifo_rx|memory_rtl_0_bypass[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|memory_rtl_0_bypass[9]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory_rtl_0_bypass\(9));

-- Location: LCCOMB_X61_Y46_N26
\u_fifo_rx|w_ptr[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|w_ptr[0]~0_combout\ = \u_fifo_rx|w_ptr\(0) $ (((\u_uart_rx|rx_done_o~q\ & ((!\u_fifo_rx|Equal2~0_combout\) # (!\u_fifo_rx|fifo_cnt\(4))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101001001011010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_rx|rx_done_o~q\,
	datab => \u_fifo_rx|fifo_cnt\(4),
	datac => \u_fifo_rx|w_ptr\(0),
	datad => \u_fifo_rx|Equal2~0_combout\,
	combout => \u_fifo_rx|w_ptr[0]~0_combout\);

-- Location: FF_X61_Y46_N27
\u_fifo_rx|w_ptr[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|w_ptr[0]~0_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|w_ptr\(0));

-- Location: LCCOMB_X62_Y46_N14
\u_fifo_rx|w_ptr[1]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|w_ptr[1]~1_combout\ = (\u_uart_rx|rx_done_o~q\ & (\u_fifo_rx|w_ptr\(0) & ((!\u_fifo_rx|Equal2~0_combout\) # (!\u_fifo_rx|fifo_cnt\(4)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_rx|rx_done_o~q\,
	datab => \u_fifo_rx|fifo_cnt\(4),
	datac => \u_fifo_rx|w_ptr\(0),
	datad => \u_fifo_rx|Equal2~0_combout\,
	combout => \u_fifo_rx|w_ptr[1]~1_combout\);

-- Location: LCCOMB_X63_Y47_N22
\u_fifo_rx|w_ptr[1]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|w_ptr[1]~2_combout\ = \u_fifo_rx|w_ptr\(1) $ (\u_fifo_rx|w_ptr[1]~1_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \u_fifo_rx|w_ptr\(1),
	datad => \u_fifo_rx|w_ptr[1]~1_combout\,
	combout => \u_fifo_rx|w_ptr[1]~2_combout\);

-- Location: FF_X63_Y47_N1
\u_fifo_rx|w_ptr[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_fifo_rx|w_ptr[1]~2_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|w_ptr\(1));

-- Location: FF_X63_Y46_N23
\u_fifo_rx|memory_rtl_0_bypass[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_fifo_rx|w_ptr\(1),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory_rtl_0_bypass\(3));

-- Location: LCCOMB_X63_Y46_N4
\u_fifo_rx|memory_rtl_0_bypass[1]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory_rtl_0_bypass[1]~feeder_combout\ = \u_fifo_rx|w_ptr\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \u_fifo_rx|w_ptr\(0),
	combout => \u_fifo_rx|memory_rtl_0_bypass[1]~feeder_combout\);

-- Location: FF_X63_Y46_N5
\u_fifo_rx|memory_rtl_0_bypass[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|memory_rtl_0_bypass[1]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory_rtl_0_bypass\(1));

-- Location: FF_X63_Y46_N3
\u_fifo_rx|r_ptr[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_fifo_rx|Add1~0_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => VCC,
	ena => \u_fifo_tx|ALT_INV_always0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|r_ptr\(1));

-- Location: LCCOMB_X63_Y46_N24
\u_fifo_tx|w_ptr[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|w_ptr[0]~0_combout\ = !\u_fifo_tx|w_ptr\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \u_fifo_tx|w_ptr\(0),
	combout => \u_fifo_tx|w_ptr[0]~0_combout\);

-- Location: FF_X63_Y46_N25
\u_fifo_tx|w_ptr[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_tx|w_ptr[0]~0_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \u_fifo_tx|ALT_INV_always0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|w_ptr\(0));

-- Location: LCCOMB_X63_Y46_N18
\u_fifo_rx|Add1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|Add1~0_combout\ = \u_fifo_rx|r_ptr\(1) $ (\u_fifo_tx|w_ptr\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011001111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \u_fifo_rx|r_ptr\(1),
	datad => \u_fifo_tx|w_ptr\(0),
	combout => \u_fifo_rx|Add1~0_combout\);

-- Location: FF_X63_Y46_N9
\u_fifo_rx|memory_rtl_0_bypass[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_fifo_rx|Add1~0_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => VCC,
	ena => \u_fifo_tx|ALT_INV_always0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory_rtl_0_bypass\(4));

-- Location: LCCOMB_X63_Y46_N26
\u_fifo_rx|memory_rtl_0_bypass[2]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory_rtl_0_bypass[2]~0_combout\ = !\u_fifo_tx|w_ptr\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \u_fifo_tx|w_ptr\(0),
	combout => \u_fifo_rx|memory_rtl_0_bypass[2]~0_combout\);

-- Location: FF_X63_Y46_N27
\u_fifo_rx|memory_rtl_0_bypass[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|memory_rtl_0_bypass[2]~0_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \u_fifo_tx|ALT_INV_always0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory_rtl_0_bypass\(2));

-- Location: LCCOMB_X63_Y46_N8
\u_fifo_rx|memory~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory~10_combout\ = (\u_fifo_rx|memory_rtl_0_bypass\(3) & (\u_fifo_rx|memory_rtl_0_bypass\(4) & (\u_fifo_rx|memory_rtl_0_bypass\(1) $ (!\u_fifo_rx|memory_rtl_0_bypass\(2))))) # (!\u_fifo_rx|memory_rtl_0_bypass\(3) & 
-- (!\u_fifo_rx|memory_rtl_0_bypass\(4) & (\u_fifo_rx|memory_rtl_0_bypass\(1) $ (!\u_fifo_rx|memory_rtl_0_bypass\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000010000100001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|memory_rtl_0_bypass\(3),
	datab => \u_fifo_rx|memory_rtl_0_bypass\(1),
	datac => \u_fifo_rx|memory_rtl_0_bypass\(4),
	datad => \u_fifo_rx|memory_rtl_0_bypass\(2),
	combout => \u_fifo_rx|memory~10_combout\);

-- Location: LCCOMB_X61_Y46_N0
\u_fifo_rx|comb~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|comb~0_combout\ = (!\rst_i~input_o\ & (\u_uart_rx|rx_done_o~q\ & ((!\u_fifo_rx|Equal2~0_combout\) # (!\u_fifo_rx|fifo_cnt\(4)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|fifo_cnt\(4),
	datab => \rst_i~input_o\,
	datac => \u_uart_rx|rx_done_o~q\,
	datad => \u_fifo_rx|Equal2~0_combout\,
	combout => \u_fifo_rx|comb~0_combout\);

-- Location: FF_X63_Y46_N1
\u_fifo_rx|memory_rtl_0_bypass[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_fifo_rx|comb~0_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory_rtl_0_bypass\(0));

-- Location: LCCOMB_X63_Y47_N26
\u_fifo_rx|w_ptr[2]~3\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|w_ptr[2]~3_combout\ = \u_fifo_rx|w_ptr\(2) $ (((\u_fifo_rx|w_ptr\(1) & \u_fifo_rx|w_ptr[1]~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \u_fifo_rx|w_ptr\(1),
	datac => \u_fifo_rx|w_ptr\(2),
	datad => \u_fifo_rx|w_ptr[1]~1_combout\,
	combout => \u_fifo_rx|w_ptr[2]~3_combout\);

-- Location: FF_X63_Y47_N27
\u_fifo_rx|w_ptr[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|w_ptr[2]~3_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|w_ptr\(2));

-- Location: FF_X63_Y46_N31
\u_fifo_rx|memory_rtl_0_bypass[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_fifo_rx|w_ptr\(2),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory_rtl_0_bypass\(5));

-- Location: LCCOMB_X63_Y47_N20
\u_fifo_rx|w_ptr[3]~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|w_ptr[3]~4_combout\ = \u_fifo_rx|w_ptr\(3) $ (((\u_fifo_rx|w_ptr\(2) & (\u_fifo_rx|w_ptr\(1) & \u_fifo_rx|w_ptr[1]~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|w_ptr\(2),
	datab => \u_fifo_rx|w_ptr\(1),
	datac => \u_fifo_rx|w_ptr\(3),
	datad => \u_fifo_rx|w_ptr[1]~1_combout\,
	combout => \u_fifo_rx|w_ptr[3]~4_combout\);

-- Location: FF_X63_Y47_N21
\u_fifo_rx|w_ptr[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|w_ptr[3]~4_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|w_ptr\(3));

-- Location: LCCOMB_X63_Y46_N28
\u_fifo_rx|memory_rtl_0_bypass[7]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory_rtl_0_bypass[7]~feeder_combout\ = \u_fifo_rx|w_ptr\(3)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \u_fifo_rx|w_ptr\(3),
	combout => \u_fifo_rx|memory_rtl_0_bypass[7]~feeder_combout\);

-- Location: FF_X63_Y46_N29
\u_fifo_rx|memory_rtl_0_bypass[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|memory_rtl_0_bypass[7]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory_rtl_0_bypass\(7));

-- Location: FF_X63_Y46_N17
\u_fifo_rx|r_ptr[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_fifo_rx|Add1~1_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => VCC,
	ena => \u_fifo_tx|ALT_INV_always0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|r_ptr\(2));

-- Location: LCCOMB_X63_Y46_N30
\u_fifo_rx|Add1~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|Add1~1_combout\ = \u_fifo_rx|r_ptr\(2) $ (((\u_fifo_rx|r_ptr\(1) & \u_fifo_tx|w_ptr\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|r_ptr\(2),
	datab => \u_fifo_rx|r_ptr\(1),
	datad => \u_fifo_tx|w_ptr\(0),
	combout => \u_fifo_rx|Add1~1_combout\);

-- Location: FF_X63_Y46_N21
\u_fifo_rx|memory_rtl_0_bypass[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_fifo_rx|Add1~1_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => VCC,
	ena => \u_fifo_tx|ALT_INV_always0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory_rtl_0_bypass\(6));

-- Location: LCCOMB_X63_Y46_N14
\u_fifo_rx|r_ptr[3]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|r_ptr[3]~feeder_combout\ = \u_fifo_rx|Add1~2_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \u_fifo_rx|Add1~2_combout\,
	combout => \u_fifo_rx|r_ptr[3]~feeder_combout\);

-- Location: FF_X63_Y46_N15
\u_fifo_rx|r_ptr[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|r_ptr[3]~feeder_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \u_fifo_tx|ALT_INV_always0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|r_ptr\(3));

-- Location: LCCOMB_X63_Y46_N2
\u_fifo_rx|Add1~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|Add1~2_combout\ = \u_fifo_rx|r_ptr\(3) $ (((\u_fifo_rx|r_ptr\(2) & (\u_fifo_rx|r_ptr\(1) & \u_fifo_tx|w_ptr\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110110011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|r_ptr\(2),
	datab => \u_fifo_rx|r_ptr\(3),
	datac => \u_fifo_rx|r_ptr\(1),
	datad => \u_fifo_tx|w_ptr\(0),
	combout => \u_fifo_rx|Add1~2_combout\);

-- Location: FF_X63_Y46_N19
\u_fifo_rx|memory_rtl_0_bypass[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_fifo_rx|Add1~2_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => VCC,
	ena => \u_fifo_tx|ALT_INV_always0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory_rtl_0_bypass\(8));

-- Location: LCCOMB_X63_Y46_N20
\u_fifo_rx|memory~11\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory~11_combout\ = (\u_fifo_rx|memory_rtl_0_bypass\(5) & (\u_fifo_rx|memory_rtl_0_bypass\(6) & (\u_fifo_rx|memory_rtl_0_bypass\(7) $ (!\u_fifo_rx|memory_rtl_0_bypass\(8))))) # (!\u_fifo_rx|memory_rtl_0_bypass\(5) & 
-- (!\u_fifo_rx|memory_rtl_0_bypass\(6) & (\u_fifo_rx|memory_rtl_0_bypass\(7) $ (!\u_fifo_rx|memory_rtl_0_bypass\(8)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000010000100001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|memory_rtl_0_bypass\(5),
	datab => \u_fifo_rx|memory_rtl_0_bypass\(7),
	datac => \u_fifo_rx|memory_rtl_0_bypass\(6),
	datad => \u_fifo_rx|memory_rtl_0_bypass\(8),
	combout => \u_fifo_rx|memory~11_combout\);

-- Location: LCCOMB_X63_Y46_N0
\u_fifo_rx|memory~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory~12_combout\ = (\u_fifo_rx|memory~10_combout\ & (\u_fifo_rx|memory_rtl_0_bypass\(0) & \u_fifo_rx|memory~11_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \u_fifo_rx|memory~10_combout\,
	datac => \u_fifo_rx|memory_rtl_0_bypass\(0),
	datad => \u_fifo_rx|memory~11_combout\,
	combout => \u_fifo_rx|memory~12_combout\);

-- Location: LCCOMB_X62_Y47_N18
\u_fifo_rx|memory~0feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory~0feeder_combout\ = VCC

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \u_fifo_rx|memory~0feeder_combout\);

-- Location: FF_X62_Y47_N19
\u_fifo_rx|memory~0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|memory~0feeder_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \u_fifo_tx|ALT_INV_always0~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory~0_q\);

-- Location: LCCOMB_X63_Y47_N0
\u_fifo_rx|memory~16\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory~16_combout\ = (!\u_fifo_rx|w_ptr\(2) & (!\u_fifo_rx|w_ptr\(0) & (!\u_fifo_rx|w_ptr\(1) & !\u_fifo_rx|w_ptr\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|w_ptr\(2),
	datab => \u_fifo_rx|w_ptr\(0),
	datac => \u_fifo_rx|w_ptr\(1),
	datad => \u_fifo_rx|w_ptr\(3),
	combout => \u_fifo_rx|memory~16_combout\);

-- Location: LCCOMB_X63_Y47_N16
\u_fifo_rx|memory~17\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory~17_combout\ = (\u_fifo_rx|memory~16_combout\ & \u_fifo_rx|comb~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \u_fifo_rx|memory~16_combout\,
	datad => \u_fifo_rx|comb~0_combout\,
	combout => \u_fifo_rx|memory~17_combout\);

-- Location: FF_X65_Y47_N25
\u_fifo_rx|memory~1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_uart_rx|data_o\(0),
	sload => VCC,
	ena => \u_fifo_rx|memory~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory~1_q\);

-- Location: LCCOMB_X63_Y47_N10
\u_fifo_tx|always0~0_wirecell\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|always0~0_wirecell_combout\ = !\u_fifo_tx|always0~0_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \u_fifo_tx|always0~0_combout\,
	combout => \u_fifo_tx|always0~0_wirecell_combout\);

-- Location: LCCOMB_X63_Y46_N22
\u_fifo_tx|w_ptr[0]~_wirecell\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|w_ptr[0]~_wirecell_combout\ = !\u_fifo_tx|w_ptr\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \u_fifo_tx|w_ptr\(0),
	combout => \u_fifo_tx|w_ptr[0]~_wirecell_combout\);

-- Location: LCCOMB_X65_Y46_N30
\~QUARTUS_CREATED_GND~I\ : cycloneive_lcell_comb
-- Equation(s):
-- \~QUARTUS_CREATED_GND~I_combout\ = GND

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \~QUARTUS_CREATED_GND~I_combout\);

-- Location: LCCOMB_X61_Y47_N6
\u_uart_rx|data_o[1]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|data_o[1]~feeder_combout\ = \u_uart_rx|b_reg\(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \u_uart_rx|b_reg\(1),
	combout => \u_uart_rx|data_o[1]~feeder_combout\);

-- Location: FF_X61_Y47_N7
\u_uart_rx|data_o[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_rx|data_o[1]~feeder_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \u_uart_rx|Selector1~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|data_o\(1));

-- Location: LCCOMB_X61_Y47_N12
\u_uart_rx|data_o[2]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|data_o[2]~feeder_combout\ = \u_uart_rx|b_reg\(2)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \u_uart_rx|b_reg\(2),
	combout => \u_uart_rx|data_o[2]~feeder_combout\);

-- Location: FF_X61_Y47_N13
\u_uart_rx|data_o[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_rx|data_o[2]~feeder_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \u_uart_rx|Selector1~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|data_o\(2));

-- Location: FF_X61_Y47_N5
\u_uart_rx|data_o[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_uart_rx|b_reg\(3),
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => VCC,
	ena => \u_uart_rx|Selector1~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|data_o\(3));

-- Location: LCCOMB_X61_Y47_N16
\u_uart_rx|data_o[4]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_rx|data_o[4]~feeder_combout\ = \u_uart_rx|b_reg\(4)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \u_uart_rx|b_reg\(4),
	combout => \u_uart_rx|data_o[4]~feeder_combout\);

-- Location: FF_X61_Y47_N17
\u_uart_rx|data_o[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_rx|data_o[4]~feeder_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \u_uart_rx|Selector1~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|data_o\(4));

-- Location: FF_X61_Y47_N25
\u_uart_rx|data_o[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_uart_rx|b_reg\(5),
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => VCC,
	ena => \u_uart_rx|Selector1~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|data_o\(5));

-- Location: FF_X61_Y47_N9
\u_uart_rx|data_o[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_uart_rx|b_reg\(6),
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => VCC,
	ena => \u_uart_rx|Selector1~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|data_o\(6));

-- Location: FF_X61_Y47_N21
\u_uart_rx|data_o[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_uart_rx|b_reg\(7),
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => VCC,
	ena => \u_uart_rx|Selector1~2_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_rx|data_o\(7));

-- Location: M9K_X64_Y47_N0
\u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a0\ : cycloneive_ram_block
-- pragma translate_off
GENERIC MAP (
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "fifo:u_fifo_rx|altsyncram:memory_rtl_0|altsyncram_5pd1:auto_generated|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 36,
	port_a_first_address => 0,
	port_a_first_bit_number => 0,
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 8,
	port_a_read_during_write_mode => "new_data_with_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "none",
	port_b_data_out_clock => "none",
	port_b_data_width => 36,
	port_b_first_address => 0,
	port_b_first_bit_number => 0,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 8,
	port_b_read_during_write_mode => "new_data_with_nbe_read",
	port_b_read_enable_clock => "clock0",
	ram_block_type => "M9K")
-- pragma translate_on
PORT MAP (
	portawe => \u_fifo_rx|comb~0_combout\,
	portbre => VCC,
	portbaddrstall => \u_fifo_tx|ALT_INV_always0~0_wirecell_combout\,
	clk0 => \clk_i~inputclkctrl_outclk\,
	portadatain => \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a0_PORTADATAIN_bus\,
	portaaddr => \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a0_PORTAADDR_bus\,
	portbaddr => \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a0_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a0_PORTBDATAOUT_bus\);

-- Location: LCCOMB_X65_Y47_N24
\u_fifo_rx|memory~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory~9_combout\ = (\u_fifo_rx|memory~0_q\ & ((\u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a0~portbdataout\))) # (!\u_fifo_rx|memory~0_q\ & (\u_fifo_rx|memory~1_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|memory~0_q\,
	datac => \u_fifo_rx|memory~1_q\,
	datad => \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a0~portbdataout\,
	combout => \u_fifo_rx|memory~9_combout\);

-- Location: LCCOMB_X65_Y47_N16
\u_fifo_rx|memory~13\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory~13_combout\ = (\u_fifo_rx|memory~12_combout\ & (\u_fifo_rx|memory_rtl_0_bypass\(9))) # (!\u_fifo_rx|memory~12_combout\ & ((\u_fifo_rx|memory~9_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \u_fifo_rx|memory_rtl_0_bypass\(9),
	datac => \u_fifo_rx|memory~12_combout\,
	datad => \u_fifo_rx|memory~9_combout\,
	combout => \u_fifo_rx|memory~13_combout\);

-- Location: FF_X65_Y47_N17
\u_fifo_tx|memory_rtl_0_bypass[9]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|memory~13_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory_rtl_0_bypass\(9));

-- Location: FF_X65_Y46_N31
\u_fifo_tx|memory_rtl_0_bypass[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_fifo_rx|r_ptr\(3),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory_rtl_0_bypass\(7));

-- Location: FF_X65_Y46_N23
\u_fifo_tx|memory_rtl_0_bypass[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_fifo_rx|r_ptr\(2),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory_rtl_0_bypass\(5));

-- Location: LCCOMB_X65_Y46_N16
\u_fifo_tx|r_ptr[0]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|r_ptr[0]~0_combout\ = !\u_fifo_tx|r_ptr\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \u_fifo_tx|r_ptr\(0),
	combout => \u_fifo_tx|r_ptr[0]~0_combout\);

-- Location: LCCOMB_X62_Y46_N30
\u_fifo_tx|always1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|always1~0_combout\ = (\u_tx_controller|fifo_rd_o~q\ & ((\u_fifo_tx|fifo_cnt\(4)) # (!\u_fifo_tx|Equal2~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010001010100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_tx_controller|fifo_rd_o~q\,
	datab => \u_fifo_tx|Equal2~0_combout\,
	datac => \u_fifo_tx|fifo_cnt\(4),
	combout => \u_fifo_tx|always1~0_combout\);

-- Location: FF_X65_Y46_N17
\u_fifo_tx|r_ptr[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_tx|r_ptr[0]~0_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \u_fifo_tx|always1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|r_ptr\(0));

-- Location: LCCOMB_X65_Y46_N22
\u_fifo_tx|Add1~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|Add1~0_combout\ = \u_fifo_tx|r_ptr\(1) $ (\u_fifo_tx|r_ptr\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101010110101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|r_ptr\(1),
	datad => \u_fifo_tx|r_ptr\(0),
	combout => \u_fifo_tx|Add1~0_combout\);

-- Location: LCCOMB_X65_Y46_N10
\u_fifo_tx|r_ptr[1]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|r_ptr[1]~feeder_combout\ = \u_fifo_tx|Add1~0_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \u_fifo_tx|Add1~0_combout\,
	combout => \u_fifo_tx|r_ptr[1]~feeder_combout\);

-- Location: FF_X65_Y46_N11
\u_fifo_tx|r_ptr[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_tx|r_ptr[1]~feeder_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \u_fifo_tx|always1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|r_ptr\(1));

-- Location: FF_X65_Y46_N9
\u_fifo_tx|r_ptr[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_tx|Add1~2_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \u_fifo_tx|always1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|r_ptr\(3));

-- Location: LCCOMB_X65_Y46_N26
\u_fifo_tx|Add1~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|Add1~1_combout\ = \u_fifo_tx|r_ptr\(2) $ (((\u_fifo_tx|r_ptr\(0) & \u_fifo_tx|r_ptr\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|r_ptr\(2),
	datab => \u_fifo_tx|r_ptr\(0),
	datad => \u_fifo_tx|r_ptr\(1),
	combout => \u_fifo_tx|Add1~1_combout\);

-- Location: LCCOMB_X65_Y46_N12
\u_fifo_tx|r_ptr[2]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|r_ptr[2]~feeder_combout\ = \u_fifo_tx|Add1~1_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \u_fifo_tx|Add1~1_combout\,
	combout => \u_fifo_tx|r_ptr[2]~feeder_combout\);

-- Location: FF_X65_Y46_N13
\u_fifo_tx|r_ptr[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_tx|r_ptr[2]~feeder_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \u_fifo_tx|always1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|r_ptr\(2));

-- Location: LCCOMB_X65_Y46_N8
\u_fifo_tx|Add1~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|Add1~2_combout\ = \u_fifo_tx|r_ptr\(3) $ (((\u_fifo_tx|r_ptr\(1) & (\u_fifo_tx|r_ptr\(0) & \u_fifo_tx|r_ptr\(2)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111100011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|r_ptr\(1),
	datab => \u_fifo_tx|r_ptr\(0),
	datac => \u_fifo_tx|r_ptr\(3),
	datad => \u_fifo_tx|r_ptr\(2),
	combout => \u_fifo_tx|Add1~2_combout\);

-- Location: FF_X65_Y46_N1
\u_fifo_tx|memory_rtl_0_bypass[8]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_fifo_tx|Add1~2_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => VCC,
	ena => \u_fifo_tx|always1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory_rtl_0_bypass\(8));

-- Location: FF_X65_Y46_N29
\u_fifo_tx|memory_rtl_0_bypass[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_fifo_tx|Add1~1_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => VCC,
	ena => \u_fifo_tx|always1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory_rtl_0_bypass\(6));

-- Location: LCCOMB_X65_Y46_N0
\u_fifo_tx|memory~10\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|memory~10_combout\ = (\u_fifo_tx|memory_rtl_0_bypass\(7) & ((\u_fifo_tx|memory_rtl_0_bypass\(5) $ (\u_fifo_tx|memory_rtl_0_bypass\(6))) # (!\u_fifo_tx|memory_rtl_0_bypass\(8)))) # (!\u_fifo_tx|memory_rtl_0_bypass\(7) & 
-- ((\u_fifo_tx|memory_rtl_0_bypass\(8)) # (\u_fifo_tx|memory_rtl_0_bypass\(5) $ (\u_fifo_tx|memory_rtl_0_bypass\(6)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111101111011110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|memory_rtl_0_bypass\(7),
	datab => \u_fifo_tx|memory_rtl_0_bypass\(5),
	datac => \u_fifo_tx|memory_rtl_0_bypass\(8),
	datad => \u_fifo_tx|memory_rtl_0_bypass\(6),
	combout => \u_fifo_tx|memory~10_combout\);

-- Location: LCCOMB_X65_Y46_N6
\u_fifo_tx|memory_rtl_0_bypass[3]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|memory_rtl_0_bypass[3]~feeder_combout\ = \u_fifo_rx|r_ptr\(1)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \u_fifo_rx|r_ptr\(1),
	combout => \u_fifo_tx|memory_rtl_0_bypass[3]~feeder_combout\);

-- Location: FF_X65_Y46_N7
\u_fifo_tx|memory_rtl_0_bypass[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_tx|memory_rtl_0_bypass[3]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory_rtl_0_bypass\(3));

-- Location: LCCOMB_X65_Y46_N4
\u_fifo_tx|memory_rtl_0_bypass[2]~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|memory_rtl_0_bypass[2]~0_combout\ = !\u_fifo_tx|r_ptr\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \u_fifo_tx|r_ptr\(0),
	combout => \u_fifo_tx|memory_rtl_0_bypass[2]~0_combout\);

-- Location: FF_X65_Y46_N5
\u_fifo_tx|memory_rtl_0_bypass[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_tx|memory_rtl_0_bypass[2]~0_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \u_fifo_tx|always1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory_rtl_0_bypass\(2));

-- Location: FF_X65_Y46_N25
\u_fifo_tx|memory_rtl_0_bypass[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_fifo_tx|Add1~0_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	sload => VCC,
	ena => \u_fifo_tx|always1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory_rtl_0_bypass\(4));

-- Location: LCCOMB_X65_Y46_N2
\u_fifo_tx|memory_rtl_0_bypass[1]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|memory_rtl_0_bypass[1]~feeder_combout\ = \u_fifo_tx|w_ptr\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \u_fifo_tx|w_ptr\(0),
	combout => \u_fifo_tx|memory_rtl_0_bypass[1]~feeder_combout\);

-- Location: FF_X65_Y46_N3
\u_fifo_tx|memory_rtl_0_bypass[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_tx|memory_rtl_0_bypass[1]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory_rtl_0_bypass\(1));

-- Location: LCCOMB_X65_Y46_N24
\u_fifo_tx|memory~9\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|memory~9_combout\ = (\u_fifo_tx|memory_rtl_0_bypass\(3) & ((\u_fifo_tx|memory_rtl_0_bypass\(2) $ (\u_fifo_tx|memory_rtl_0_bypass\(1))) # (!\u_fifo_tx|memory_rtl_0_bypass\(4)))) # (!\u_fifo_tx|memory_rtl_0_bypass\(3) & 
-- ((\u_fifo_tx|memory_rtl_0_bypass\(4)) # (\u_fifo_tx|memory_rtl_0_bypass\(2) $ (\u_fifo_tx|memory_rtl_0_bypass\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111101111011110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|memory_rtl_0_bypass\(3),
	datab => \u_fifo_tx|memory_rtl_0_bypass\(2),
	datac => \u_fifo_tx|memory_rtl_0_bypass\(4),
	datad => \u_fifo_tx|memory_rtl_0_bypass\(1),
	combout => \u_fifo_tx|memory~9_combout\);

-- Location: LCCOMB_X61_Y46_N6
\u_fifo_tx|comb~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|comb~0_combout\ = (\rst_i~input_o\) # (\u_fifo_tx|always0~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \rst_i~input_o\,
	datad => \u_fifo_tx|always0~0_combout\,
	combout => \u_fifo_tx|comb~0_combout\);

-- Location: LCCOMB_X65_Y46_N14
\u_fifo_tx|memory_rtl_0_bypass[0]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|memory_rtl_0_bypass[0]~1_combout\ = !\u_fifo_tx|comb~0_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \u_fifo_tx|comb~0_combout\,
	combout => \u_fifo_tx|memory_rtl_0_bypass[0]~1_combout\);

-- Location: FF_X65_Y46_N15
\u_fifo_tx|memory_rtl_0_bypass[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_tx|memory_rtl_0_bypass[0]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory_rtl_0_bypass\(0));

-- Location: LCCOMB_X66_Y46_N0
\u_uart_tx|b_reg[6]~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|b_reg[6]~1_combout\ = (!\u_uart_tx|state.DATA~q\ & ((\u_fifo_tx|memory~10_combout\) # ((\u_fifo_tx|memory~9_combout\) # (!\u_fifo_tx|memory_rtl_0_bypass\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111000001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|memory~10_combout\,
	datab => \u_fifo_tx|memory~9_combout\,
	datac => \u_uart_tx|state.DATA~q\,
	datad => \u_fifo_tx|memory_rtl_0_bypass\(0),
	combout => \u_uart_tx|b_reg[6]~1_combout\);

-- Location: LCCOMB_X63_Y46_N6
\u_fifo_tx|memory~11\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|memory~11_combout\ = (!\u_fifo_rx|r_ptr\(2) & (!\u_fifo_rx|r_ptr\(1) & (!\u_fifo_rx|r_ptr\(3) & !\u_fifo_tx|w_ptr\(0))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|r_ptr\(2),
	datab => \u_fifo_rx|r_ptr\(1),
	datac => \u_fifo_rx|r_ptr\(3),
	datad => \u_fifo_tx|w_ptr\(0),
	combout => \u_fifo_tx|memory~11_combout\);

-- Location: LCCOMB_X62_Y47_N28
\u_fifo_tx|memory~12\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|memory~12_combout\ = (!\rst_i~input_o\ & (\u_fifo_tx|memory~11_combout\ & !\u_fifo_tx|always0~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \rst_i~input_o\,
	datab => \u_fifo_tx|memory~11_combout\,
	datad => \u_fifo_tx|always0~0_combout\,
	combout => \u_fifo_tx|memory~12_combout\);

-- Location: FF_X66_Y47_N31
\u_fifo_tx|memory~1\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_fifo_rx|memory~13_combout\,
	sload => VCC,
	ena => \u_fifo_tx|memory~12_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory~1_q\);

-- Location: LCCOMB_X65_Y46_N20
\u_fifo_tx|memory~0feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|memory~0feeder_combout\ = VCC

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \u_fifo_tx|memory~0feeder_combout\);

-- Location: FF_X65_Y46_N21
\u_fifo_tx|memory~0\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_tx|memory~0feeder_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \u_fifo_tx|always1~0_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory~0_q\);

-- Location: LCCOMB_X66_Y47_N4
\u_uart_tx|b_reg[6]~2\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|b_reg[6]~2_combout\ = (\u_uart_tx|state.DATA~q\) # ((\u_fifo_tx|memory~0_q\ & \u_uart_tx|b_reg[6]~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|memory~0_q\,
	datab => \u_uart_tx|state.DATA~q\,
	datad => \u_uart_tx|b_reg[6]~1_combout\,
	combout => \u_uart_tx|b_reg[6]~2_combout\);

-- Location: LCCOMB_X66_Y47_N30
\u_uart_tx|Selector12~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector12~0_combout\ = (\u_uart_tx|b_reg[6]~1_combout\ & (((\u_fifo_tx|memory~1_q\) # (\u_uart_tx|b_reg[6]~2_combout\)))) # (!\u_uart_tx|b_reg[6]~1_combout\ & (\u_fifo_tx|memory_rtl_0_bypass\(9) & ((!\u_uart_tx|b_reg[6]~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|memory_rtl_0_bypass\(9),
	datab => \u_uart_tx|b_reg[6]~1_combout\,
	datac => \u_fifo_tx|memory~1_q\,
	datad => \u_uart_tx|b_reg[6]~2_combout\,
	combout => \u_uart_tx|Selector12~0_combout\);

-- Location: LCCOMB_X65_Y46_N18
\u_fifo_tx|r_ptr[0]~_wirecell\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|r_ptr[0]~_wirecell_combout\ = !\u_fifo_tx|r_ptr\(0)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \u_fifo_tx|r_ptr\(0),
	combout => \u_fifo_tx|r_ptr[0]~_wirecell_combout\);

-- Location: FF_X63_Y47_N11
\u_fifo_rx|memory_rtl_0_bypass[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_uart_rx|data_o\(1),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory_rtl_0_bypass\(10));

-- Location: FF_X63_Y47_N17
\u_fifo_rx|memory~2\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_uart_rx|data_o\(1),
	sload => VCC,
	ena => \u_fifo_rx|memory~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory~2_q\);

-- Location: LCCOMB_X63_Y47_N12
\u_fifo_rx|memory~14\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory~14_combout\ = (\u_fifo_rx|memory~0_q\ & ((\u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a1\))) # (!\u_fifo_rx|memory~0_q\ & (\u_fifo_rx|memory~2_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|memory~0_q\,
	datab => \u_fifo_rx|memory~2_q\,
	datad => \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a1\,
	combout => \u_fifo_rx|memory~14_combout\);

-- Location: LCCOMB_X63_Y47_N14
\u_fifo_rx|memory~15\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory~15_combout\ = (\u_fifo_rx|memory~12_combout\ & (\u_fifo_rx|memory_rtl_0_bypass\(10))) # (!\u_fifo_rx|memory~12_combout\ & ((\u_fifo_rx|memory~14_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|memory_rtl_0_bypass\(10),
	datab => \u_fifo_rx|memory~12_combout\,
	datad => \u_fifo_rx|memory~14_combout\,
	combout => \u_fifo_rx|memory~15_combout\);

-- Location: LCCOMB_X65_Y47_N22
\u_fifo_rx|memory_rtl_0_bypass[11]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory_rtl_0_bypass[11]~feeder_combout\ = \u_uart_rx|data_o\(2)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \u_uart_rx|data_o\(2),
	combout => \u_fifo_rx|memory_rtl_0_bypass[11]~feeder_combout\);

-- Location: FF_X65_Y47_N23
\u_fifo_rx|memory_rtl_0_bypass[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|memory_rtl_0_bypass[11]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory_rtl_0_bypass\(11));

-- Location: FF_X65_Y47_N13
\u_fifo_rx|memory~3\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_uart_rx|data_o\(2),
	sload => VCC,
	ena => \u_fifo_rx|memory~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory~3_q\);

-- Location: LCCOMB_X65_Y47_N12
\u_fifo_rx|memory~18\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory~18_combout\ = (\u_fifo_rx|memory~0_q\ & (\u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a2\)) # (!\u_fifo_rx|memory~0_q\ & ((\u_fifo_rx|memory~3_q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a2\,
	datac => \u_fifo_rx|memory~3_q\,
	datad => \u_fifo_rx|memory~0_q\,
	combout => \u_fifo_rx|memory~18_combout\);

-- Location: LCCOMB_X65_Y47_N6
\u_fifo_rx|memory~19\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory~19_combout\ = (\u_fifo_rx|memory~12_combout\ & (\u_fifo_rx|memory_rtl_0_bypass\(11))) # (!\u_fifo_rx|memory~12_combout\ & ((\u_fifo_rx|memory~18_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|memory_rtl_0_bypass\(11),
	datac => \u_fifo_rx|memory~12_combout\,
	datad => \u_fifo_rx|memory~18_combout\,
	combout => \u_fifo_rx|memory~19_combout\);

-- Location: LCCOMB_X65_Y47_N30
\u_fifo_rx|memory_rtl_0_bypass[12]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory_rtl_0_bypass[12]~feeder_combout\ = \u_uart_rx|data_o\(3)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \u_uart_rx|data_o\(3),
	combout => \u_fifo_rx|memory_rtl_0_bypass[12]~feeder_combout\);

-- Location: FF_X65_Y47_N31
\u_fifo_rx|memory_rtl_0_bypass[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|memory_rtl_0_bypass[12]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory_rtl_0_bypass\(12));

-- Location: FF_X65_Y47_N21
\u_fifo_rx|memory~4\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_uart_rx|data_o\(3),
	sload => VCC,
	ena => \u_fifo_rx|memory~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory~4_q\);

-- Location: LCCOMB_X65_Y47_N20
\u_fifo_rx|memory~20\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory~20_combout\ = (\u_fifo_rx|memory~0_q\ & ((\u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a3\))) # (!\u_fifo_rx|memory~0_q\ & (\u_fifo_rx|memory~4_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|memory~0_q\,
	datac => \u_fifo_rx|memory~4_q\,
	datad => \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a3\,
	combout => \u_fifo_rx|memory~20_combout\);

-- Location: LCCOMB_X65_Y47_N0
\u_fifo_rx|memory~21\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory~21_combout\ = (\u_fifo_rx|memory~12_combout\ & (\u_fifo_rx|memory_rtl_0_bypass\(12))) # (!\u_fifo_rx|memory~12_combout\ & ((\u_fifo_rx|memory~20_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010111110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|memory_rtl_0_bypass\(12),
	datac => \u_fifo_rx|memory~12_combout\,
	datad => \u_fifo_rx|memory~20_combout\,
	combout => \u_fifo_rx|memory~21_combout\);

-- Location: FF_X63_Y47_N23
\u_fifo_rx|memory_rtl_0_bypass[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_uart_rx|data_o\(4),
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory_rtl_0_bypass\(13));

-- Location: FF_X63_Y47_N7
\u_fifo_rx|memory~5\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_uart_rx|data_o\(4),
	sload => VCC,
	ena => \u_fifo_rx|memory~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory~5_q\);

-- Location: LCCOMB_X63_Y47_N6
\u_fifo_rx|memory~22\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory~22_combout\ = (\u_fifo_rx|memory~0_q\ & ((\u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a4\))) # (!\u_fifo_rx|memory~0_q\ & (\u_fifo_rx|memory~5_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|memory~0_q\,
	datac => \u_fifo_rx|memory~5_q\,
	datad => \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a4\,
	combout => \u_fifo_rx|memory~22_combout\);

-- Location: LCCOMB_X63_Y47_N24
\u_fifo_rx|memory~23\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory~23_combout\ = (\u_fifo_rx|memory~12_combout\ & (\u_fifo_rx|memory_rtl_0_bypass\(13))) # (!\u_fifo_rx|memory~12_combout\ & ((\u_fifo_rx|memory~22_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \u_fifo_rx|memory~12_combout\,
	datac => \u_fifo_rx|memory_rtl_0_bypass\(13),
	datad => \u_fifo_rx|memory~22_combout\,
	combout => \u_fifo_rx|memory~23_combout\);

-- Location: LCCOMB_X65_Y47_N28
\u_fifo_rx|memory_rtl_0_bypass[14]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory_rtl_0_bypass[14]~feeder_combout\ = \u_uart_rx|data_o\(5)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \u_uart_rx|data_o\(5),
	combout => \u_fifo_rx|memory_rtl_0_bypass[14]~feeder_combout\);

-- Location: FF_X65_Y47_N29
\u_fifo_rx|memory_rtl_0_bypass[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|memory_rtl_0_bypass[14]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory_rtl_0_bypass\(14));

-- Location: FF_X65_Y47_N3
\u_fifo_rx|memory~6\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_uart_rx|data_o\(5),
	sload => VCC,
	ena => \u_fifo_rx|memory~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory~6_q\);

-- Location: LCCOMB_X65_Y47_N2
\u_fifo_rx|memory~24\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory~24_combout\ = (\u_fifo_rx|memory~0_q\ & ((\u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a5\))) # (!\u_fifo_rx|memory~0_q\ & (\u_fifo_rx|memory~6_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|memory~0_q\,
	datac => \u_fifo_rx|memory~6_q\,
	datad => \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a5\,
	combout => \u_fifo_rx|memory~24_combout\);

-- Location: LCCOMB_X65_Y47_N26
\u_fifo_rx|memory~25\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory~25_combout\ = (\u_fifo_rx|memory~12_combout\ & (\u_fifo_rx|memory_rtl_0_bypass\(14))) # (!\u_fifo_rx|memory~12_combout\ & ((\u_fifo_rx|memory~24_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \u_fifo_rx|memory_rtl_0_bypass\(14),
	datac => \u_fifo_rx|memory~12_combout\,
	datad => \u_fifo_rx|memory~24_combout\,
	combout => \u_fifo_rx|memory~25_combout\);

-- Location: LCCOMB_X63_Y47_N4
\u_fifo_rx|memory_rtl_0_bypass[15]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory_rtl_0_bypass[15]~feeder_combout\ = \u_uart_rx|data_o\(6)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \u_uart_rx|data_o\(6),
	combout => \u_fifo_rx|memory_rtl_0_bypass[15]~feeder_combout\);

-- Location: FF_X63_Y47_N5
\u_fifo_rx|memory_rtl_0_bypass[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|memory_rtl_0_bypass[15]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory_rtl_0_bypass\(15));

-- Location: FF_X63_Y47_N19
\u_fifo_rx|memory~7\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_uart_rx|data_o\(6),
	sload => VCC,
	ena => \u_fifo_rx|memory~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory~7_q\);

-- Location: LCCOMB_X63_Y47_N18
\u_fifo_rx|memory~26\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory~26_combout\ = (\u_fifo_rx|memory~0_q\ & ((\u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a6\))) # (!\u_fifo_rx|memory~0_q\ & (\u_fifo_rx|memory~7_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|memory~0_q\,
	datac => \u_fifo_rx|memory~7_q\,
	datad => \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a6\,
	combout => \u_fifo_rx|memory~26_combout\);

-- Location: LCCOMB_X63_Y47_N28
\u_fifo_rx|memory~27\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory~27_combout\ = (\u_fifo_rx|memory~12_combout\ & (\u_fifo_rx|memory_rtl_0_bypass\(15))) # (!\u_fifo_rx|memory~12_combout\ & ((\u_fifo_rx|memory~26_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \u_fifo_rx|memory~12_combout\,
	datac => \u_fifo_rx|memory_rtl_0_bypass\(15),
	datad => \u_fifo_rx|memory~26_combout\,
	combout => \u_fifo_rx|memory~27_combout\);

-- Location: LCCOMB_X63_Y47_N8
\u_fifo_rx|memory_rtl_0_bypass[16]~feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory_rtl_0_bypass[16]~feeder_combout\ = \u_uart_rx|data_o\(7)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \u_uart_rx|data_o\(7),
	combout => \u_fifo_rx|memory_rtl_0_bypass[16]~feeder_combout\);

-- Location: FF_X63_Y47_N9
\u_fifo_rx|memory_rtl_0_bypass[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|memory_rtl_0_bypass[16]~feeder_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory_rtl_0_bypass\(16));

-- Location: FF_X63_Y47_N3
\u_fifo_rx|memory~8\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_uart_rx|data_o\(7),
	sload => VCC,
	ena => \u_fifo_rx|memory~17_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_rx|memory~8_q\);

-- Location: LCCOMB_X63_Y47_N2
\u_fifo_rx|memory~28\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory~28_combout\ = (\u_fifo_rx|memory~0_q\ & ((\u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a7\))) # (!\u_fifo_rx|memory~0_q\ & (\u_fifo_rx|memory~8_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|memory~0_q\,
	datac => \u_fifo_rx|memory~8_q\,
	datad => \u_fifo_rx|memory_rtl_0|auto_generated|ram_block1a7\,
	combout => \u_fifo_rx|memory~28_combout\);

-- Location: LCCOMB_X63_Y47_N30
\u_fifo_rx|memory~29\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_rx|memory~29_combout\ = (\u_fifo_rx|memory~12_combout\ & (\u_fifo_rx|memory_rtl_0_bypass\(16))) # (!\u_fifo_rx|memory~12_combout\ & ((\u_fifo_rx|memory~28_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_rx|memory_rtl_0_bypass\(16),
	datab => \u_fifo_rx|memory~12_combout\,
	datad => \u_fifo_rx|memory~28_combout\,
	combout => \u_fifo_rx|memory~29_combout\);

-- Location: M9K_X64_Y46_N0
\u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a0\ : cycloneive_ram_block
-- pragma translate_off
GENERIC MAP (
	data_interleave_offset_in_bits => 1,
	data_interleave_width_in_bits => 1,
	logical_ram_name => "fifo:u_fifo_tx|altsyncram:memory_rtl_0|altsyncram_5pd1:auto_generated|ALTSYNCRAM",
	mixed_port_feed_through_mode => "dont_care",
	operation_mode => "dual_port",
	port_a_address_clear => "none",
	port_a_address_width => 4,
	port_a_byte_enable_clock => "none",
	port_a_data_out_clear => "none",
	port_a_data_out_clock => "none",
	port_a_data_width => 36,
	port_a_first_address => 0,
	port_a_first_bit_number => 0,
	port_a_last_address => 15,
	port_a_logical_ram_depth => 16,
	port_a_logical_ram_width => 8,
	port_a_read_during_write_mode => "new_data_with_nbe_read",
	port_b_address_clear => "none",
	port_b_address_clock => "clock0",
	port_b_address_width => 4,
	port_b_data_out_clear => "none",
	port_b_data_out_clock => "none",
	port_b_data_width => 36,
	port_b_first_address => 0,
	port_b_first_bit_number => 0,
	port_b_last_address => 15,
	port_b_logical_ram_depth => 16,
	port_b_logical_ram_width => 8,
	port_b_read_during_write_mode => "new_data_with_nbe_read",
	port_b_read_enable_clock => "clock0",
	ram_block_type => "M9K")
-- pragma translate_on
PORT MAP (
	portawe => \u_fifo_tx|ALT_INV_comb~0_combout\,
	portbre => VCC,
	portbaddrstall => \u_fifo_tx|ALT_INV_always1~0_combout\,
	clk0 => \clk_i~inputclkctrl_outclk\,
	portadatain => \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a0_PORTADATAIN_bus\,
	portaaddr => \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a0_PORTAADDR_bus\,
	portbaddr => \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a0_PORTBADDR_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	portbdataout => \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a0_PORTBDATAOUT_bus\);

-- Location: FF_X65_Y47_N27
\u_fifo_tx|memory_rtl_0_bypass[14]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|memory~25_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory_rtl_0_bypass\(14));

-- Location: LCCOMB_X62_Y47_N20
\u_fifo_tx|memory~7feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|memory~7feeder_combout\ = \u_fifo_rx|memory~27_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \u_fifo_rx|memory~27_combout\,
	combout => \u_fifo_tx|memory~7feeder_combout\);

-- Location: FF_X62_Y47_N21
\u_fifo_tx|memory~7\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_tx|memory~7feeder_combout\,
	ena => \u_fifo_tx|memory~12_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory~7_q\);

-- Location: FF_X63_Y47_N29
\u_fifo_tx|memory_rtl_0_bypass[15]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|memory~27_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory_rtl_0_bypass\(15));

-- Location: LCCOMB_X66_Y47_N18
\u_uart_tx|Selector6~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector6~0_combout\ = (\u_uart_tx|b_reg[6]~1_combout\ & ((\u_fifo_tx|memory~7_q\) # ((\u_uart_tx|b_reg[6]~2_combout\)))) # (!\u_uart_tx|b_reg[6]~1_combout\ & (((\u_fifo_tx|memory_rtl_0_bypass\(15) & !\u_uart_tx|b_reg[6]~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110010111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|memory~7_q\,
	datab => \u_uart_tx|b_reg[6]~1_combout\,
	datac => \u_fifo_tx|memory_rtl_0_bypass\(15),
	datad => \u_uart_tx|b_reg[6]~2_combout\,
	combout => \u_uart_tx|Selector6~0_combout\);

-- Location: LCCOMB_X65_Y48_N6
\u_uart_tx|Selector5~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector5~0_combout\ = (\u_uart_tx|state.IDLE~q\ & ((!\u_uart_tx|b_reg[6]~0_combout\))) # (!\u_uart_tx|state.IDLE~q\ & (\u_tx_controller|uart_start_o~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100010011101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|state.IDLE~q\,
	datab => \u_tx_controller|uart_start_o~q\,
	datad => \u_uart_tx|b_reg[6]~0_combout\,
	combout => \u_uart_tx|Selector5~0_combout\);

-- Location: LCCOMB_X65_Y46_N28
\u_fifo_tx|memory~13\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|memory~13_combout\ = ((\u_fifo_tx|memory~10_combout\) # (\u_fifo_tx|memory~9_combout\)) # (!\u_fifo_tx|memory_rtl_0_bypass\(0))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111011101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|memory_rtl_0_bypass\(0),
	datab => \u_fifo_tx|memory~10_combout\,
	datad => \u_fifo_tx|memory~9_combout\,
	combout => \u_fifo_tx|memory~13_combout\);

-- Location: FF_X63_Y47_N31
\u_fifo_tx|memory_rtl_0_bypass[16]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|memory~29_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory_rtl_0_bypass\(16));

-- Location: FF_X62_Y47_N29
\u_fifo_tx|memory~8\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_fifo_rx|memory~29_combout\,
	sload => VCC,
	ena => \u_fifo_tx|memory~12_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory~8_q\);

-- Location: LCCOMB_X63_Y46_N16
\u_uart_tx|b_reg[7]~5\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|b_reg[7]~5_combout\ = (\u_fifo_tx|memory~0_q\ & ((\u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a7\))) # (!\u_fifo_tx|memory~0_q\ & (\u_fifo_tx|memory~8_q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|memory~0_q\,
	datab => \u_fifo_tx|memory~8_q\,
	datad => \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a7\,
	combout => \u_uart_tx|b_reg[7]~5_combout\);

-- Location: LCCOMB_X63_Y46_N10
\u_uart_tx|b_reg[7]~6\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|b_reg[7]~6_combout\ = (\u_fifo_tx|memory~13_combout\ & ((\u_uart_tx|b_reg[7]~5_combout\))) # (!\u_fifo_tx|memory~13_combout\ & (\u_fifo_tx|memory_rtl_0_bypass\(16)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|memory~13_combout\,
	datac => \u_fifo_tx|memory_rtl_0_bypass\(16),
	datad => \u_uart_tx|b_reg[7]~5_combout\,
	combout => \u_uart_tx|b_reg[7]~6_combout\);

-- Location: LCCOMB_X63_Y46_N12
\u_uart_tx|b_reg[7]~7\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|b_reg[7]~7_combout\ = (\u_uart_tx|Selector5~0_combout\ & (!\u_uart_tx|state.IDLE~q\ & ((\u_uart_tx|b_reg[7]~6_combout\)))) # (!\u_uart_tx|Selector5~0_combout\ & (((\u_uart_tx|b_reg\(7)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111010000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|state.IDLE~q\,
	datab => \u_uart_tx|Selector5~0_combout\,
	datac => \u_uart_tx|b_reg\(7),
	datad => \u_uart_tx|b_reg[7]~6_combout\,
	combout => \u_uart_tx|b_reg[7]~7_combout\);

-- Location: FF_X63_Y46_N13
\u_uart_tx|b_reg[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_tx|b_reg[7]~7_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_tx|b_reg\(7));

-- Location: LCCOMB_X66_Y47_N26
\u_uart_tx|Selector6~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector6~1_combout\ = (\u_uart_tx|Selector6~0_combout\ & (((\u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a6\) # (!\u_uart_tx|b_reg[6]~2_combout\)))) # (!\u_uart_tx|Selector6~0_combout\ & (\u_uart_tx|b_reg\(7) & 
-- ((\u_uart_tx|b_reg[6]~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|Selector6~0_combout\,
	datab => \u_uart_tx|b_reg\(7),
	datac => \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a6\,
	datad => \u_uart_tx|b_reg[6]~2_combout\,
	combout => \u_uart_tx|Selector6~1_combout\);

-- Location: LCCOMB_X66_Y48_N0
\u_uart_tx|b_reg[6]~4\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|b_reg[6]~4_combout\ = (\u_uart_tx|b_reg[6]~3_combout\) # ((\u_uart_tx|state.DATA~q\ & (!\u_uart_tx|Equal1~0_combout\ & \u_baud_gen|s_tick_o~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|state.DATA~q\,
	datab => \u_uart_tx|Equal1~0_combout\,
	datac => \u_uart_tx|b_reg[6]~3_combout\,
	datad => \u_baud_gen|s_tick_o~q\,
	combout => \u_uart_tx|b_reg[6]~4_combout\);

-- Location: FF_X66_Y47_N27
\u_uart_tx|b_reg[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_tx|Selector6~1_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \u_uart_tx|b_reg[6]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_tx|b_reg\(6));

-- Location: LCCOMB_X66_Y47_N0
\u_uart_tx|Selector7~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector7~0_combout\ = (\u_uart_tx|b_reg[6]~1_combout\ & (((\u_uart_tx|b_reg[6]~2_combout\)))) # (!\u_uart_tx|b_reg[6]~1_combout\ & ((\u_uart_tx|b_reg[6]~2_combout\ & ((\u_uart_tx|b_reg\(6)))) # (!\u_uart_tx|b_reg[6]~2_combout\ & 
-- (\u_fifo_tx|memory_rtl_0_bypass\(14)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|memory_rtl_0_bypass\(14),
	datab => \u_uart_tx|b_reg[6]~1_combout\,
	datac => \u_uart_tx|b_reg\(6),
	datad => \u_uart_tx|b_reg[6]~2_combout\,
	combout => \u_uart_tx|Selector7~0_combout\);

-- Location: FF_X66_Y47_N5
\u_fifo_tx|memory~6\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_fifo_rx|memory~25_combout\,
	sload => VCC,
	ena => \u_fifo_tx|memory~12_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory~6_q\);

-- Location: LCCOMB_X66_Y47_N14
\u_uart_tx|Selector7~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector7~1_combout\ = (\u_uart_tx|Selector7~0_combout\ & ((\u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a5\) # ((!\u_uart_tx|b_reg[6]~1_combout\)))) # (!\u_uart_tx|Selector7~0_combout\ & (((\u_fifo_tx|memory~6_q\ & 
-- \u_uart_tx|b_reg[6]~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a5\,
	datab => \u_uart_tx|Selector7~0_combout\,
	datac => \u_fifo_tx|memory~6_q\,
	datad => \u_uart_tx|b_reg[6]~1_combout\,
	combout => \u_uart_tx|Selector7~1_combout\);

-- Location: FF_X66_Y47_N15
\u_uart_tx|b_reg[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_tx|Selector7~1_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \u_uart_tx|b_reg[6]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_tx|b_reg\(5));

-- Location: LCCOMB_X62_Y47_N22
\u_fifo_tx|memory~5feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|memory~5feeder_combout\ = \u_fifo_rx|memory~23_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \u_fifo_rx|memory~23_combout\,
	combout => \u_fifo_tx|memory~5feeder_combout\);

-- Location: FF_X62_Y47_N23
\u_fifo_tx|memory~5\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_tx|memory~5feeder_combout\,
	ena => \u_fifo_tx|memory~12_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory~5_q\);

-- Location: FF_X63_Y47_N25
\u_fifo_tx|memory_rtl_0_bypass[13]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|memory~23_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory_rtl_0_bypass\(13));

-- Location: LCCOMB_X66_Y47_N28
\u_uart_tx|Selector8~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector8~0_combout\ = (\u_uart_tx|b_reg[6]~1_combout\ & ((\u_fifo_tx|memory~5_q\) # ((\u_uart_tx|b_reg[6]~2_combout\)))) # (!\u_uart_tx|b_reg[6]~1_combout\ & (((\u_fifo_tx|memory_rtl_0_bypass\(13) & !\u_uart_tx|b_reg[6]~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110010111000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|memory~5_q\,
	datab => \u_uart_tx|b_reg[6]~1_combout\,
	datac => \u_fifo_tx|memory_rtl_0_bypass\(13),
	datad => \u_uart_tx|b_reg[6]~2_combout\,
	combout => \u_uart_tx|Selector8~0_combout\);

-- Location: LCCOMB_X66_Y47_N6
\u_uart_tx|Selector8~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector8~1_combout\ = (\u_uart_tx|b_reg[6]~2_combout\ & ((\u_uart_tx|Selector8~0_combout\ & (\u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a4\)) # (!\u_uart_tx|Selector8~0_combout\ & ((\u_uart_tx|b_reg\(5)))))) # 
-- (!\u_uart_tx|b_reg[6]~2_combout\ & (((\u_uart_tx|Selector8~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|b_reg[6]~2_combout\,
	datab => \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a4\,
	datac => \u_uart_tx|b_reg\(5),
	datad => \u_uart_tx|Selector8~0_combout\,
	combout => \u_uart_tx|Selector8~1_combout\);

-- Location: FF_X66_Y47_N7
\u_uart_tx|b_reg[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_tx|Selector8~1_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \u_uart_tx|b_reg[6]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_tx|b_reg\(4));

-- Location: FF_X65_Y47_N1
\u_fifo_tx|memory_rtl_0_bypass[12]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|memory~21_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory_rtl_0_bypass\(12));

-- Location: LCCOMB_X66_Y47_N20
\u_uart_tx|Selector9~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector9~0_combout\ = (\u_uart_tx|b_reg[6]~1_combout\ & (((\u_uart_tx|b_reg[6]~2_combout\)))) # (!\u_uart_tx|b_reg[6]~1_combout\ & ((\u_uart_tx|b_reg[6]~2_combout\ & (\u_uart_tx|b_reg\(4))) # (!\u_uart_tx|b_reg[6]~2_combout\ & 
-- ((\u_fifo_tx|memory_rtl_0_bypass\(12))))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111000110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|b_reg\(4),
	datab => \u_uart_tx|b_reg[6]~1_combout\,
	datac => \u_fifo_tx|memory_rtl_0_bypass\(12),
	datad => \u_uart_tx|b_reg[6]~2_combout\,
	combout => \u_uart_tx|Selector9~0_combout\);

-- Location: LCCOMB_X66_Y47_N8
\u_fifo_tx|memory~4feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|memory~4feeder_combout\ = \u_fifo_rx|memory~21_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \u_fifo_rx|memory~21_combout\,
	combout => \u_fifo_tx|memory~4feeder_combout\);

-- Location: FF_X66_Y47_N9
\u_fifo_tx|memory~4\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_tx|memory~4feeder_combout\,
	ena => \u_fifo_tx|memory~12_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory~4_q\);

-- Location: LCCOMB_X66_Y47_N12
\u_uart_tx|Selector9~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector9~1_combout\ = (\u_uart_tx|Selector9~0_combout\ & ((\u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a3\) # ((!\u_uart_tx|b_reg[6]~1_combout\)))) # (!\u_uart_tx|Selector9~0_combout\ & (((\u_fifo_tx|memory~4_q\ & 
-- \u_uart_tx|b_reg[6]~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a3\,
	datab => \u_uart_tx|Selector9~0_combout\,
	datac => \u_fifo_tx|memory~4_q\,
	datad => \u_uart_tx|b_reg[6]~1_combout\,
	combout => \u_uart_tx|Selector9~1_combout\);

-- Location: FF_X66_Y47_N13
\u_uart_tx|b_reg[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_tx|Selector9~1_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \u_uart_tx|b_reg[6]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_tx|b_reg\(3));

-- Location: FF_X65_Y47_N7
\u_fifo_tx|memory_rtl_0_bypass[11]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_rx|memory~19_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory_rtl_0_bypass\(11));

-- Location: FF_X66_Y47_N23
\u_fifo_tx|memory~3\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_fifo_rx|memory~19_combout\,
	sload => VCC,
	ena => \u_fifo_tx|memory~12_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory~3_q\);

-- Location: LCCOMB_X66_Y47_N22
\u_uart_tx|Selector10~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector10~0_combout\ = (\u_uart_tx|b_reg[6]~1_combout\ & (((\u_fifo_tx|memory~3_q\) # (\u_uart_tx|b_reg[6]~2_combout\)))) # (!\u_uart_tx|b_reg[6]~1_combout\ & (\u_fifo_tx|memory_rtl_0_bypass\(11) & ((!\u_uart_tx|b_reg[6]~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_fifo_tx|memory_rtl_0_bypass\(11),
	datab => \u_uart_tx|b_reg[6]~1_combout\,
	datac => \u_fifo_tx|memory~3_q\,
	datad => \u_uart_tx|b_reg[6]~2_combout\,
	combout => \u_uart_tx|Selector10~0_combout\);

-- Location: LCCOMB_X66_Y47_N24
\u_uart_tx|Selector10~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector10~1_combout\ = (\u_uart_tx|b_reg[6]~2_combout\ & ((\u_uart_tx|Selector10~0_combout\ & ((\u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a2\))) # (!\u_uart_tx|Selector10~0_combout\ & (\u_uart_tx|b_reg\(3))))) # 
-- (!\u_uart_tx|b_reg[6]~2_combout\ & (((\u_uart_tx|Selector10~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|b_reg[6]~2_combout\,
	datab => \u_uart_tx|b_reg\(3),
	datac => \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a2\,
	datad => \u_uart_tx|Selector10~0_combout\,
	combout => \u_uart_tx|Selector10~1_combout\);

-- Location: FF_X66_Y47_N25
\u_uart_tx|b_reg[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_tx|Selector10~1_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \u_uart_tx|b_reg[6]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_tx|b_reg\(2));

-- Location: FF_X63_Y47_N13
\u_fifo_tx|memory_rtl_0_bypass[10]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	asdata => \u_fifo_rx|memory~15_combout\,
	sload => VCC,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory_rtl_0_bypass\(10));

-- Location: LCCOMB_X66_Y47_N10
\u_uart_tx|Selector11~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector11~0_combout\ = (\u_uart_tx|b_reg[6]~2_combout\ & ((\u_uart_tx|b_reg\(2)) # ((\u_uart_tx|b_reg[6]~1_combout\)))) # (!\u_uart_tx|b_reg[6]~2_combout\ & (((\u_fifo_tx|memory_rtl_0_bypass\(10) & !\u_uart_tx|b_reg[6]~1_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|b_reg[6]~2_combout\,
	datab => \u_uart_tx|b_reg\(2),
	datac => \u_fifo_tx|memory_rtl_0_bypass\(10),
	datad => \u_uart_tx|b_reg[6]~1_combout\,
	combout => \u_uart_tx|Selector11~0_combout\);

-- Location: LCCOMB_X62_Y47_N16
\u_fifo_tx|memory~2feeder\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_fifo_tx|memory~2feeder_combout\ = \u_fifo_rx|memory~15_combout\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \u_fifo_rx|memory~15_combout\,
	combout => \u_fifo_tx|memory~2feeder_combout\);

-- Location: FF_X62_Y47_N17
\u_fifo_tx|memory~2\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_fifo_tx|memory~2feeder_combout\,
	ena => \u_fifo_tx|memory~12_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_fifo_tx|memory~2_q\);

-- Location: LCCOMB_X66_Y47_N2
\u_uart_tx|Selector11~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector11~1_combout\ = (\u_uart_tx|Selector11~0_combout\ & (((\u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a1\)) # (!\u_uart_tx|b_reg[6]~1_combout\))) # (!\u_uart_tx|Selector11~0_combout\ & (\u_uart_tx|b_reg[6]~1_combout\ & 
-- ((\u_fifo_tx|memory~2_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110011010100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|Selector11~0_combout\,
	datab => \u_uart_tx|b_reg[6]~1_combout\,
	datac => \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a1\,
	datad => \u_fifo_tx|memory~2_q\,
	combout => \u_uart_tx|Selector11~1_combout\);

-- Location: FF_X66_Y47_N3
\u_uart_tx|b_reg[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_tx|Selector11~1_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \u_uart_tx|b_reg[6]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_tx|b_reg\(1));

-- Location: LCCOMB_X66_Y47_N16
\u_uart_tx|Selector12~1\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector12~1_combout\ = (\u_uart_tx|Selector12~0_combout\ & (((\u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a0~portbdataout\) # (!\u_uart_tx|b_reg[6]~2_combout\)))) # (!\u_uart_tx|Selector12~0_combout\ & (\u_uart_tx|b_reg\(1) & 
-- ((\u_uart_tx|b_reg[6]~2_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|Selector12~0_combout\,
	datab => \u_uart_tx|b_reg\(1),
	datac => \u_fifo_tx|memory_rtl_0|auto_generated|ram_block1a0~portbdataout\,
	datad => \u_uart_tx|b_reg[6]~2_combout\,
	combout => \u_uart_tx|Selector12~1_combout\);

-- Location: FF_X66_Y47_N17
\u_uart_tx|b_reg[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_tx|Selector12~1_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	ena => \u_uart_tx|b_reg[6]~4_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_tx|b_reg\(0));

-- Location: LCCOMB_X66_Y48_N12
\u_uart_tx|Selector0~0\ : cycloneive_lcell_comb
-- Equation(s):
-- \u_uart_tx|Selector0~0_combout\ = (\u_uart_tx|state.IDLE~q\ & (!\u_uart_tx|state.STOP~q\ & ((!\u_uart_tx|state.DATA~q\) # (!\u_uart_tx|b_reg\(0)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \u_uart_tx|state.IDLE~q\,
	datab => \u_uart_tx|b_reg\(0),
	datac => \u_uart_tx|state.STOP~q\,
	datad => \u_uart_tx|state.DATA~q\,
	combout => \u_uart_tx|Selector0~0_combout\);

-- Location: FF_X66_Y48_N13
\u_uart_tx|tx_o\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk_i~inputclkctrl_outclk\,
	d => \u_uart_tx|Selector0~0_combout\,
	clrn => \ALT_INV_rst_i~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \u_uart_tx|tx_o~q\);

ww_tx_o <= \tx_o~output_o\;
END structure;


