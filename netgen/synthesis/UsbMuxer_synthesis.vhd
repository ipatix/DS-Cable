--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: P.20131013
--  \   \         Application: netgen
--  /   /         Filename: UsbMuxer_synthesis.vhd
-- /___/   /\     Timestamp: Thu Nov 10 00:21:08 2016
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -intstyle ise -ar Structure -tm UsbMuxer -w -dir netgen/synthesis -ofmt vhdl -sim UsbMuxer.ngc UsbMuxer_synthesis.vhd 
-- Device	: xc6slx4-3-cpg196
-- Input file	: UsbMuxer.ngc
-- Output file	: /home/michael/Xilinx/DSCable/netgen/synthesis/UsbMuxer_synthesis.vhd
-- # of Entities	: 1
-- Design Name	: UsbMuxer
-- Xilinx	: /opt/Xilinx/14.7/ISE_DS/ISE/
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Command Line Tools User Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------


-- synthesis translate_off
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use UNISIM.VPKG.ALL;

entity UsbMuxer is
  port (
    reset : in STD_LOGIC := 'X'; 
    usb_clk : in STD_LOGIC := 'X'; 
    rxf : in STD_LOGIC := 'X'; 
    txe : in STD_LOGIC := 'X'; 
    dclk : in STD_LOGIC := 'X'; 
    vsync : in STD_LOGIC := 'X'; 
    spi_din : in STD_LOGIC := 'X'; 
    rd : out STD_LOGIC; 
    wr : out STD_LOGIC; 
    siwu : out STD_LOGIC; 
    spi_clk : out STD_LOGIC; 
    spi_dout : out STD_LOGIC; 
    spi_cs : out STD_LOGIC; 
    ldr : in STD_LOGIC_VECTOR ( 5 downto 0 ); 
    ldg : in STD_LOGIC_VECTOR ( 5 downto 0 ); 
    ldb : in STD_LOGIC_VECTOR ( 5 downto 0 ); 
    adbus : inout STD_LOGIC_VECTOR ( 7 downto 0 ); 
    leds : out STD_LOGIC_VECTOR ( 3 downto 0 ) 
  );
end UsbMuxer;

architecture Structure of UsbMuxer is
  component scr_fifo
    port (
      rst : in STD_LOGIC := 'X'; 
      wr_clk : in STD_LOGIC := 'X'; 
      rd_clk : in STD_LOGIC := 'X'; 
      wr_en : in STD_LOGIC := 'X'; 
      rd_en : in STD_LOGIC := 'X'; 
      full : out STD_LOGIC; 
      empty : out STD_LOGIC; 
      din : in STD_LOGIC_VECTOR ( 36 downto 0 ); 
      dout : out STD_LOGIC_VECTOR ( 36 downto 0 ) 
    );
  end component;
  component video_buffer
    port (
      clk : in STD_LOGIC := 'X'; 
      rst : in STD_LOGIC := 'X'; 
      wr_en : in STD_LOGIC := 'X'; 
      rd_en : in STD_LOGIC := 'X'; 
      full : out STD_LOGIC; 
      empty : out STD_LOGIC; 
      din : in STD_LOGIC_VECTOR ( 19 downto 0 ); 
      dout : out STD_LOGIC_VECTOR ( 19 downto 0 ) 
    );
  end component;
  component adc_buffer
    port (
      clk : in STD_LOGIC := 'X'; 
      rst : in STD_LOGIC := 'X'; 
      wr_en : in STD_LOGIC := 'X'; 
      rd_en : in STD_LOGIC := 'X'; 
      full : out STD_LOGIC; 
      empty : out STD_LOGIC; 
      din : in STD_LOGIC_VECTOR ( 23 downto 0 ); 
      dout : out STD_LOGIC_VECTOR ( 23 downto 0 ) 
    );
  end component;
  signal ldr_5_IBUF_0 : STD_LOGIC; 
  signal ldr_4_IBUF_1 : STD_LOGIC; 
  signal ldr_3_IBUF_2 : STD_LOGIC; 
  signal ldr_2_IBUF_3 : STD_LOGIC; 
  signal ldr_1_IBUF_4 : STD_LOGIC; 
  signal ldr_0_IBUF_5 : STD_LOGIC; 
  signal ldg_5_IBUF_6 : STD_LOGIC; 
  signal ldg_4_IBUF_7 : STD_LOGIC; 
  signal ldg_3_IBUF_8 : STD_LOGIC; 
  signal ldg_2_IBUF_9 : STD_LOGIC; 
  signal ldg_1_IBUF_10 : STD_LOGIC; 
  signal ldg_0_IBUF_11 : STD_LOGIC; 
  signal ldb_5_IBUF_12 : STD_LOGIC; 
  signal ldb_4_IBUF_13 : STD_LOGIC; 
  signal ldb_3_IBUF_14 : STD_LOGIC; 
  signal ldb_2_IBUF_15 : STD_LOGIC; 
  signal ldb_1_IBUF_16 : STD_LOGIC; 
  signal ldb_0_IBUF_17 : STD_LOGIC; 
  signal reset_IBUF_18 : STD_LOGIC; 
  signal usb_clk_BUFGP_19 : STD_LOGIC; 
  signal leds_3_OBUF_20 : STD_LOGIC; 
  signal leds_2_OBUF_21 : STD_LOGIC; 
  signal dclk_IBUF_BUFG_22 : STD_LOGIC; 
  signal vsync_IBUF_23 : STD_LOGIC; 
  signal leds_0_OBUF_24 : STD_LOGIC; 
  signal video_fifo_data_25_Q : STD_LOGIC; 
  signal video_fifo_data_24_Q : STD_LOGIC; 
  signal video_fifo_data_21_Q : STD_LOGIC; 
  signal video_fifo_data_20_Q : STD_LOGIC; 
  signal video_fifo_data_19_Q : STD_LOGIC; 
  signal video_fifo_data_18_Q : STD_LOGIC; 
  signal video_fifo_data_17_Q : STD_LOGIC; 
  signal video_fifo_data_16_Q : STD_LOGIC; 
  signal video_fifo_data_13_Q : STD_LOGIC; 
  signal video_fifo_data_12_Q : STD_LOGIC; 
  signal video_fifo_data_11_Q : STD_LOGIC; 
  signal video_fifo_data_10_Q : STD_LOGIC; 
  signal video_fifo_data_9_Q : STD_LOGIC; 
  signal video_fifo_data_8_Q : STD_LOGIC; 
  signal video_fifo_data_5_Q : STD_LOGIC; 
  signal video_fifo_data_4_Q : STD_LOGIC; 
  signal video_fifo_data_3_Q : STD_LOGIC; 
  signal video_fifo_data_2_Q : STD_LOGIC; 
  signal video_fifo_data_1_Q : STD_LOGIC; 
  signal video_fifo_data_0_Q : STD_LOGIC; 
  signal video_fifo_empty : STD_LOGIC; 
  signal audio_fifo_empty : STD_LOGIC; 
  signal Inst_MCP3204_spi_clock_buf_71 : STD_LOGIC; 
  signal Inst_MCP3204_spi_cs_buf_72 : STD_LOGIC; 
  signal Inst_MCP3204_spi_dout_buf_73 : STD_LOGIC; 
  signal write_state_74 : STD_LOGIC; 
  signal pump_index_FSM_FFd1_75 : STD_LOGIC; 
  signal pump_index_FSM_FFd2_76 : STD_LOGIC; 
  signal audio_fifo_rd_77 : STD_LOGIC; 
  signal pump_type_78 : STD_LOGIC; 
  signal PWR_11_o_usb_clk_DFF_160_79 : STD_LOGIC; 
  signal video_fifo_rd_80 : STD_LOGIC; 
  signal txe_INV_54_o : STD_LOGIC; 
  signal GND_3_o_video_fifo_rd_MUX_264_o : STD_LOGIC; 
  signal GND_3_o_audio_fifo_rd_MUX_265_o : STD_LOGIC; 
  signal wr_OBUF_100 : STD_LOGIC; 
  signal siwu_OBUF_109 : STD_LOGIC; 
  signal leds_1_OBUF_110 : STD_LOGIC; 
  signal PWR_11_o_usb_clk_DFF_160_inv : STD_LOGIC; 
  signal Q_n0112_inv : STD_LOGIC; 
  signal Q_n0121_inv : STD_LOGIC; 
  signal pump_index_FSM_FFd2_In : STD_LOGIC; 
  signal pump_index_FSM_FFd1_In : STD_LOGIC; 
  signal Inst_Video_n0059_inv : STD_LOGIC; 
  signal Inst_Video_is_top_INV_11_o : STD_LOGIC; 
  signal Inst_Video_fifo_video_full_fifo_scr_empty_AND_4_o : STD_LOGIC; 
  signal Inst_Video_GND_4_o_is_top_MUX_78_o : STD_LOGIC; 
  signal Inst_Video_fifo_scr_full_INV_4_o : STD_LOGIC; 
  signal Inst_Video_is_top_160 : STD_LOGIC; 
  signal Inst_Video_fifo_video_wr_en_161 : STD_LOGIC; 
  signal Inst_Video_fifo_scr_rd_en_162 : STD_LOGIC; 
  signal Inst_Video_i_vsync_reset_OR_1_o : STD_LOGIC; 
  signal Inst_Video_fifo_video_full : STD_LOGIC; 
  signal Inst_Video_fifo_scr_wr_en_258 : STD_LOGIC; 
  signal Inst_Video_is_vsync_259 : STD_LOGIC; 
  signal Inst_Video_fifo_scr_empty : STD_LOGIC; 
  signal Inst_Video_fifo_scr_full : STD_LOGIC; 
  signal Inst_MCP3204_n0675_inv1_299 : STD_LOGIC; 
  signal Inst_MCP3204_sample_state_buf_FSM_FFd3_In2_300 : STD_LOGIC; 
  signal Inst_MCP3204_n0373_inv2 : STD_LOGIC; 
  signal Inst_MCP3204_sample_state_buf_FSM_FFd4_In12 : STD_LOGIC; 
  signal Inst_MCP3204_sample_state_buf_FSM_FFd3_In1 : STD_LOGIC; 
  signal Inst_MCP3204_n0675_inv2 : STD_LOGIC; 
  signal Inst_MCP3204_Mcount_spi_clock_counter3 : STD_LOGIC; 
  signal Inst_MCP3204_Mcount_spi_clock_counter2 : STD_LOGIC; 
  signal Inst_MCP3204_Mcount_spi_clock_counter1 : STD_LOGIC; 
  signal Inst_MCP3204_Mcount_spi_clock_counter : STD_LOGIC; 
  signal Inst_MCP3204_sample_idle_inv : STD_LOGIC; 
  signal Inst_MCP3204_Mcount_sample_counter10 : STD_LOGIC; 
  signal Inst_MCP3204_Mcount_sample_counter9 : STD_LOGIC; 
  signal Inst_MCP3204_Mcount_sample_counter8 : STD_LOGIC; 
  signal Inst_MCP3204_Mcount_sample_counter7 : STD_LOGIC; 
  signal Inst_MCP3204_Mcount_sample_counter6 : STD_LOGIC; 
  signal Inst_MCP3204_Mcount_sample_counter5 : STD_LOGIC; 
  signal Inst_MCP3204_Mcount_sample_counter4 : STD_LOGIC; 
  signal Inst_MCP3204_Mcount_sample_counter3 : STD_LOGIC; 
  signal Inst_MCP3204_Mcount_sample_counter2 : STD_LOGIC; 
  signal Inst_MCP3204_Mcount_sample_counter1 : STD_LOGIC; 
  signal Inst_MCP3204_Mcount_sample_counter : STD_LOGIC; 
  signal Inst_MCP3204_iUSB_CLK_inv : STD_LOGIC; 
  signal Inst_MCP3204_sample_state_buf_FSM_FFd1_In_343 : STD_LOGIC; 
  signal Inst_MCP3204_sample_state_buf_FSM_FFd2_In : STD_LOGIC; 
  signal Inst_MCP3204_sample_state_buf_FSM_FFd3_In : STD_LOGIC; 
  signal Inst_MCP3204_sample_state_buf_FSM_FFd4_In : STD_LOGIC; 
  signal Inst_MCP3204_sample_state_buf_FSM_FFd5_In : STD_LOGIC; 
  signal Inst_MCP3204_sample_state_buf_FSM_FFd6_In_348 : STD_LOGIC; 
  signal Inst_MCP3204_n0373_inv : STD_LOGIC; 
  signal Inst_MCP3204_n0316_inv : STD_LOGIC; 
  signal Inst_MCP3204_n0675_inv : STD_LOGIC; 
  signal Inst_MCP3204_n0649_inv_352 : STD_LOGIC; 
  signal Inst_MCP3204_n0511_inv_353 : STD_LOGIC; 
  signal Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o : STD_LOGIC; 
  signal Inst_MCP3204_fifo_wr_en_407 : STD_LOGIC; 
  signal Inst_MCP3204_sample_side_buf_408 : STD_LOGIC; 
  signal Inst_MCP3204_sample_idle_409 : STD_LOGIC; 
  signal Inst_MCP3204_sample_state_buf_FSM_FFd6_410 : STD_LOGIC; 
  signal Inst_MCP3204_sample_state_buf_FSM_FFd5_411 : STD_LOGIC; 
  signal Inst_MCP3204_sample_state_buf_FSM_FFd4_412 : STD_LOGIC; 
  signal Inst_MCP3204_sample_state_buf_FSM_FFd3_413 : STD_LOGIC; 
  signal Inst_MCP3204_sample_state_buf_FSM_FFd2_414 : STD_LOGIC; 
  signal Inst_MCP3204_sample_state_buf_FSM_FFd1_415 : STD_LOGIC; 
  signal Inst_MCP3204_fifo_full : STD_LOGIC; 
  signal n0094_7_1_428 : STD_LOGIC; 
  signal n0094_7_2_429 : STD_LOGIC; 
  signal n0094_6_1_430 : STD_LOGIC; 
  signal n0094_6_2_431 : STD_LOGIC; 
  signal n0094_5_1_432 : STD_LOGIC; 
  signal n0094_5_2_433 : STD_LOGIC; 
  signal n0094_4_1_434 : STD_LOGIC; 
  signal n0094_4_2_435 : STD_LOGIC; 
  signal n0094_3_1_436 : STD_LOGIC; 
  signal n0094_3_2_437 : STD_LOGIC; 
  signal n0094_2_1_438 : STD_LOGIC; 
  signal n0094_2_2_439 : STD_LOGIC; 
  signal n0094_1_3_440 : STD_LOGIC; 
  signal n0094_0_3_441 : STD_LOGIC; 
  signal N0 : STD_LOGIC; 
  signal N4 : STD_LOGIC; 
  signal N6 : STD_LOGIC; 
  signal N8 : STD_LOGIC; 
  signal N10 : STD_LOGIC; 
  signal N11 : STD_LOGIC; 
  signal N12 : STD_LOGIC; 
  signal N13 : STD_LOGIC; 
  signal N14 : STD_LOGIC; 
  signal N15 : STD_LOGIC; 
  signal N16 : STD_LOGIC; 
  signal N17 : STD_LOGIC; 
  signal PWR_11_o_usb_clk_DFF_160_rstpot_489 : STD_LOGIC; 
  signal pump_type_rstpot_490 : STD_LOGIC; 
  signal Inst_MCP3204_sample_idle_rstpot_491 : STD_LOGIC; 
  signal Inst_MCP3204_sample_side_buf_rstpot_492 : STD_LOGIC; 
  signal Inst_MCP3204_spi_dout_buf_rstpot_493 : STD_LOGIC; 
  signal Inst_MCP3204_spi_cs_buf_rstpot_494 : STD_LOGIC; 
  signal Inst_MCP3204_spi_clock_buf_rstpot_495 : STD_LOGIC; 
  signal N26 : STD_LOGIC; 
  signal N27 : STD_LOGIC; 
  signal N28 : STD_LOGIC; 
  signal N29 : STD_LOGIC; 
  signal dclk_IBUF_500 : STD_LOGIC; 
  signal audio_fifo_data : STD_LOGIC_VECTOR ( 23 downto 0 ); 
  signal adbus_buf : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal n0094 : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT : STD_LOGIC_VECTOR ( 18 downto 0 ); 
  signal Inst_Video_fifo_video_din : STD_LOGIC_VECTOR ( 19 downto 0 ); 
  signal Inst_Video_video_data_final : STD_LOGIC_VECTOR ( 36 downto 0 ); 
  signal Inst_Video_fifo_scr_din : STD_LOGIC_VECTOR ( 36 downto 0 ); 
  signal Inst_Video_video_data_top : STD_LOGIC_VECTOR ( 18 downto 0 ); 
  signal Inst_Video_fifo_scr_dout : STD_LOGIC_VECTOR ( 36 downto 0 ); 
  signal Inst_MCP3204_Mcount_sample_counter_lut : STD_LOGIC_VECTOR ( 10 downto 0 ); 
  signal Inst_MCP3204_Mcount_sample_counter_cy : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal Inst_MCP3204_fifo_in : STD_LOGIC_VECTOR ( 23 downto 0 ); 
  signal Inst_MCP3204_sample_val_right : STD_LOGIC_VECTOR ( 11 downto 0 ); 
  signal Inst_MCP3204_sample_val_left : STD_LOGIC_VECTOR ( 11 downto 0 ); 
  signal Inst_MCP3204_spi_clock_counter : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal Inst_MCP3204_sample_counter : STD_LOGIC_VECTOR ( 10 downto 0 ); 
begin
  XST_VCC : VCC
    port map (
      P => siwu_OBUF_109
    );
  XST_GND : GND
    port map (
      G => leds_1_OBUF_110
    );
  write_state : FDC_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CLR => reset_IBUF_18,
      D => txe_INV_54_o,
      Q => write_state_74
    );
  audio_fifo_rd : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Q_n0112_inv,
      CLR => reset_IBUF_18,
      D => GND_3_o_audio_fifo_rd_MUX_265_o,
      Q => audio_fifo_rd_77
    );
  video_fifo_rd : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Q_n0112_inv,
      CLR => reset_IBUF_18,
      D => GND_3_o_video_fifo_rd_MUX_264_o,
      Q => video_fifo_rd_80
    );
  adbus_buf_0 : FD_1
    port map (
      C => usb_clk_BUFGP_19,
      D => n0094(0),
      Q => adbus_buf(0)
    );
  adbus_buf_1 : FD_1
    port map (
      C => usb_clk_BUFGP_19,
      D => n0094(1),
      Q => adbus_buf(1)
    );
  adbus_buf_2 : FD_1
    port map (
      C => usb_clk_BUFGP_19,
      D => n0094(2),
      Q => adbus_buf(2)
    );
  adbus_buf_3 : FD_1
    port map (
      C => usb_clk_BUFGP_19,
      D => n0094(3),
      Q => adbus_buf(3)
    );
  adbus_buf_4 : FD_1
    port map (
      C => usb_clk_BUFGP_19,
      D => n0094(4),
      Q => adbus_buf(4)
    );
  adbus_buf_5 : FD_1
    port map (
      C => usb_clk_BUFGP_19,
      D => n0094(5),
      Q => adbus_buf(5)
    );
  adbus_buf_6 : FD_1
    port map (
      C => usb_clk_BUFGP_19,
      D => n0094(6),
      Q => adbus_buf(6)
    );
  adbus_buf_7 : FD_1
    port map (
      C => usb_clk_BUFGP_19,
      D => n0094(7),
      Q => adbus_buf(7)
    );
  pump_index_FSM_FFd1 : FDC_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CLR => reset_IBUF_18,
      D => pump_index_FSM_FFd1_In,
      Q => pump_index_FSM_FFd1_75
    );
  pump_index_FSM_FFd2 : FDC_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CLR => reset_IBUF_18,
      D => pump_index_FSM_FFd2_In,
      Q => pump_index_FSM_FFd2_76
    );
  Inst_Video_fifo_video_din_19 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_Video_fifo_video_full_fifo_scr_empty_AND_4_o,
      CLR => reset_IBUF_18,
      D => Inst_Video_is_top_INV_11_o,
      Q => Inst_Video_fifo_video_din(19)
    );
  Inst_Video_fifo_video_din_18 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_Video_fifo_video_full_fifo_scr_empty_AND_4_o,
      CLR => reset_IBUF_18,
      D => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(18),
      Q => Inst_Video_fifo_video_din(18)
    );
  Inst_Video_fifo_video_din_17 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_Video_fifo_video_full_fifo_scr_empty_AND_4_o,
      CLR => reset_IBUF_18,
      D => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(17),
      Q => Inst_Video_fifo_video_din(17)
    );
  Inst_Video_fifo_video_din_16 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_Video_fifo_video_full_fifo_scr_empty_AND_4_o,
      CLR => reset_IBUF_18,
      D => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(16),
      Q => Inst_Video_fifo_video_din(16)
    );
  Inst_Video_fifo_video_din_15 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_Video_fifo_video_full_fifo_scr_empty_AND_4_o,
      CLR => reset_IBUF_18,
      D => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(15),
      Q => Inst_Video_fifo_video_din(15)
    );
  Inst_Video_fifo_video_din_14 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_Video_fifo_video_full_fifo_scr_empty_AND_4_o,
      CLR => reset_IBUF_18,
      D => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(14),
      Q => Inst_Video_fifo_video_din(14)
    );
  Inst_Video_fifo_video_din_13 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_Video_fifo_video_full_fifo_scr_empty_AND_4_o,
      CLR => reset_IBUF_18,
      D => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(13),
      Q => Inst_Video_fifo_video_din(13)
    );
  Inst_Video_fifo_video_din_12 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_Video_fifo_video_full_fifo_scr_empty_AND_4_o,
      CLR => reset_IBUF_18,
      D => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(12),
      Q => Inst_Video_fifo_video_din(12)
    );
  Inst_Video_fifo_video_din_11 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_Video_fifo_video_full_fifo_scr_empty_AND_4_o,
      CLR => reset_IBUF_18,
      D => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(11),
      Q => Inst_Video_fifo_video_din(11)
    );
  Inst_Video_fifo_video_din_10 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_Video_fifo_video_full_fifo_scr_empty_AND_4_o,
      CLR => reset_IBUF_18,
      D => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(10),
      Q => Inst_Video_fifo_video_din(10)
    );
  Inst_Video_fifo_video_din_9 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_Video_fifo_video_full_fifo_scr_empty_AND_4_o,
      CLR => reset_IBUF_18,
      D => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(9),
      Q => Inst_Video_fifo_video_din(9)
    );
  Inst_Video_fifo_video_din_8 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_Video_fifo_video_full_fifo_scr_empty_AND_4_o,
      CLR => reset_IBUF_18,
      D => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(8),
      Q => Inst_Video_fifo_video_din(8)
    );
  Inst_Video_fifo_video_din_7 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_Video_fifo_video_full_fifo_scr_empty_AND_4_o,
      CLR => reset_IBUF_18,
      D => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(7),
      Q => Inst_Video_fifo_video_din(7)
    );
  Inst_Video_fifo_video_din_6 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_Video_fifo_video_full_fifo_scr_empty_AND_4_o,
      CLR => reset_IBUF_18,
      D => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(6),
      Q => Inst_Video_fifo_video_din(6)
    );
  Inst_Video_fifo_video_din_5 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_Video_fifo_video_full_fifo_scr_empty_AND_4_o,
      CLR => reset_IBUF_18,
      D => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(5),
      Q => Inst_Video_fifo_video_din(5)
    );
  Inst_Video_fifo_video_din_4 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_Video_fifo_video_full_fifo_scr_empty_AND_4_o,
      CLR => reset_IBUF_18,
      D => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(4),
      Q => Inst_Video_fifo_video_din(4)
    );
  Inst_Video_fifo_video_din_3 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_Video_fifo_video_full_fifo_scr_empty_AND_4_o,
      CLR => reset_IBUF_18,
      D => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(3),
      Q => Inst_Video_fifo_video_din(3)
    );
  Inst_Video_fifo_video_din_2 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_Video_fifo_video_full_fifo_scr_empty_AND_4_o,
      CLR => reset_IBUF_18,
      D => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(2),
      Q => Inst_Video_fifo_video_din(2)
    );
  Inst_Video_fifo_video_din_1 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_Video_fifo_video_full_fifo_scr_empty_AND_4_o,
      CLR => reset_IBUF_18,
      D => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(1),
      Q => Inst_Video_fifo_video_din(1)
    );
  Inst_Video_fifo_video_din_0 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_Video_fifo_video_full_fifo_scr_empty_AND_4_o,
      CLR => reset_IBUF_18,
      D => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(0),
      Q => Inst_Video_fifo_video_din(0)
    );
  Inst_Video_fifo_scr_din_36 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(36),
      Q => Inst_Video_fifo_scr_din(36)
    );
  Inst_Video_fifo_scr_din_35 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(35),
      Q => Inst_Video_fifo_scr_din(35)
    );
  Inst_Video_fifo_scr_din_34 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(34),
      Q => Inst_Video_fifo_scr_din(34)
    );
  Inst_Video_fifo_scr_din_33 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(33),
      Q => Inst_Video_fifo_scr_din(33)
    );
  Inst_Video_fifo_scr_din_32 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(32),
      Q => Inst_Video_fifo_scr_din(32)
    );
  Inst_Video_fifo_scr_din_31 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(31),
      Q => Inst_Video_fifo_scr_din(31)
    );
  Inst_Video_fifo_scr_din_30 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(30),
      Q => Inst_Video_fifo_scr_din(30)
    );
  Inst_Video_fifo_scr_din_29 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(29),
      Q => Inst_Video_fifo_scr_din(29)
    );
  Inst_Video_fifo_scr_din_28 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(28),
      Q => Inst_Video_fifo_scr_din(28)
    );
  Inst_Video_fifo_scr_din_27 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(27),
      Q => Inst_Video_fifo_scr_din(27)
    );
  Inst_Video_fifo_scr_din_26 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(26),
      Q => Inst_Video_fifo_scr_din(26)
    );
  Inst_Video_fifo_scr_din_25 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(25),
      Q => Inst_Video_fifo_scr_din(25)
    );
  Inst_Video_fifo_scr_din_24 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(24),
      Q => Inst_Video_fifo_scr_din(24)
    );
  Inst_Video_fifo_scr_din_23 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(23),
      Q => Inst_Video_fifo_scr_din(23)
    );
  Inst_Video_fifo_scr_din_22 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(22),
      Q => Inst_Video_fifo_scr_din(22)
    );
  Inst_Video_fifo_scr_din_21 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(21),
      Q => Inst_Video_fifo_scr_din(21)
    );
  Inst_Video_fifo_scr_din_20 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(20),
      Q => Inst_Video_fifo_scr_din(20)
    );
  Inst_Video_fifo_scr_din_19 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(19),
      Q => Inst_Video_fifo_scr_din(19)
    );
  Inst_Video_fifo_scr_din_18 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(18),
      Q => Inst_Video_fifo_scr_din(18)
    );
  Inst_Video_fifo_scr_din_17 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(17),
      Q => Inst_Video_fifo_scr_din(17)
    );
  Inst_Video_fifo_scr_din_16 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(16),
      Q => Inst_Video_fifo_scr_din(16)
    );
  Inst_Video_fifo_scr_din_15 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(15),
      Q => Inst_Video_fifo_scr_din(15)
    );
  Inst_Video_fifo_scr_din_14 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(14),
      Q => Inst_Video_fifo_scr_din(14)
    );
  Inst_Video_fifo_scr_din_13 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(13),
      Q => Inst_Video_fifo_scr_din(13)
    );
  Inst_Video_fifo_scr_din_12 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(12),
      Q => Inst_Video_fifo_scr_din(12)
    );
  Inst_Video_fifo_scr_din_11 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(11),
      Q => Inst_Video_fifo_scr_din(11)
    );
  Inst_Video_fifo_scr_din_10 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(10),
      Q => Inst_Video_fifo_scr_din(10)
    );
  Inst_Video_fifo_scr_din_9 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(9),
      Q => Inst_Video_fifo_scr_din(9)
    );
  Inst_Video_fifo_scr_din_8 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(8),
      Q => Inst_Video_fifo_scr_din(8)
    );
  Inst_Video_fifo_scr_din_7 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(7),
      Q => Inst_Video_fifo_scr_din(7)
    );
  Inst_Video_fifo_scr_din_6 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(6),
      Q => Inst_Video_fifo_scr_din(6)
    );
  Inst_Video_fifo_scr_din_5 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(5),
      Q => Inst_Video_fifo_scr_din(5)
    );
  Inst_Video_fifo_scr_din_4 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(4),
      Q => Inst_Video_fifo_scr_din(4)
    );
  Inst_Video_fifo_scr_din_3 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(3),
      Q => Inst_Video_fifo_scr_din(3)
    );
  Inst_Video_fifo_scr_din_2 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(2),
      Q => Inst_Video_fifo_scr_din(2)
    );
  Inst_Video_fifo_scr_din_1 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(1),
      Q => Inst_Video_fifo_scr_din(1)
    );
  Inst_Video_fifo_scr_din_0 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_final(0),
      Q => Inst_Video_fifo_scr_din(0)
    );
  Inst_Video_fifo_scr_rd_en : FDC_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CLR => reset_IBUF_18,
      D => Inst_Video_GND_4_o_is_top_MUX_78_o,
      Q => Inst_Video_fifo_scr_rd_en_162
    );
  Inst_Video_video_data_final_36 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_top(18),
      Q => Inst_Video_video_data_final(36)
    );
  Inst_Video_video_data_final_35 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_top(17),
      Q => Inst_Video_video_data_final(35)
    );
  Inst_Video_video_data_final_34 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_top(16),
      Q => Inst_Video_video_data_final(34)
    );
  Inst_Video_video_data_final_33 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_top(15),
      Q => Inst_Video_video_data_final(33)
    );
  Inst_Video_video_data_final_32 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_top(14),
      Q => Inst_Video_video_data_final(32)
    );
  Inst_Video_video_data_final_31 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_top(13),
      Q => Inst_Video_video_data_final(31)
    );
  Inst_Video_video_data_final_30 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_top(12),
      Q => Inst_Video_video_data_final(30)
    );
  Inst_Video_video_data_final_29 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_top(11),
      Q => Inst_Video_video_data_final(29)
    );
  Inst_Video_video_data_final_28 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_top(10),
      Q => Inst_Video_video_data_final(28)
    );
  Inst_Video_video_data_final_27 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_top(9),
      Q => Inst_Video_video_data_final(27)
    );
  Inst_Video_video_data_final_26 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_top(8),
      Q => Inst_Video_video_data_final(26)
    );
  Inst_Video_video_data_final_25 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_top(7),
      Q => Inst_Video_video_data_final(25)
    );
  Inst_Video_video_data_final_24 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_top(6),
      Q => Inst_Video_video_data_final(24)
    );
  Inst_Video_video_data_final_23 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_top(5),
      Q => Inst_Video_video_data_final(23)
    );
  Inst_Video_video_data_final_22 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_top(4),
      Q => Inst_Video_video_data_final(22)
    );
  Inst_Video_video_data_final_21 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_top(3),
      Q => Inst_Video_video_data_final(21)
    );
  Inst_Video_video_data_final_20 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_top(2),
      Q => Inst_Video_video_data_final(20)
    );
  Inst_Video_video_data_final_19 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_top(1),
      Q => Inst_Video_video_data_final(19)
    );
  Inst_Video_video_data_final_18 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => Inst_Video_video_data_top(0),
      Q => Inst_Video_video_data_final(18)
    );
  Inst_Video_video_data_final_17 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => ldr_5_IBUF_0,
      Q => Inst_Video_video_data_final(17)
    );
  Inst_Video_video_data_final_16 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => ldr_4_IBUF_1,
      Q => Inst_Video_video_data_final(16)
    );
  Inst_Video_video_data_final_15 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => ldr_3_IBUF_2,
      Q => Inst_Video_video_data_final(15)
    );
  Inst_Video_video_data_final_14 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => ldr_2_IBUF_3,
      Q => Inst_Video_video_data_final(14)
    );
  Inst_Video_video_data_final_13 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => ldr_1_IBUF_4,
      Q => Inst_Video_video_data_final(13)
    );
  Inst_Video_video_data_final_12 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => ldr_0_IBUF_5,
      Q => Inst_Video_video_data_final(12)
    );
  Inst_Video_video_data_final_11 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => ldg_5_IBUF_6,
      Q => Inst_Video_video_data_final(11)
    );
  Inst_Video_video_data_final_10 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => ldg_4_IBUF_7,
      Q => Inst_Video_video_data_final(10)
    );
  Inst_Video_video_data_final_9 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => ldg_3_IBUF_8,
      Q => Inst_Video_video_data_final(9)
    );
  Inst_Video_video_data_final_8 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => ldg_2_IBUF_9,
      Q => Inst_Video_video_data_final(8)
    );
  Inst_Video_video_data_final_7 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => ldg_1_IBUF_10,
      Q => Inst_Video_video_data_final(7)
    );
  Inst_Video_video_data_final_6 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => ldg_0_IBUF_11,
      Q => Inst_Video_video_data_final(6)
    );
  Inst_Video_video_data_final_5 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => ldb_5_IBUF_12,
      Q => Inst_Video_video_data_final(5)
    );
  Inst_Video_video_data_final_4 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => ldb_4_IBUF_13,
      Q => Inst_Video_video_data_final(4)
    );
  Inst_Video_video_data_final_3 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => ldb_3_IBUF_14,
      Q => Inst_Video_video_data_final(3)
    );
  Inst_Video_video_data_final_2 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => ldb_2_IBUF_15,
      Q => Inst_Video_video_data_final(2)
    );
  Inst_Video_video_data_final_1 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => ldb_1_IBUF_16,
      Q => Inst_Video_video_data_final(1)
    );
  Inst_Video_video_data_final_0 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => Inst_Video_n0059_inv,
      CLR => reset_IBUF_18,
      D => ldb_0_IBUF_17,
      Q => Inst_Video_video_data_final(0)
    );
  Inst_Video_video_data_top_18 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_is_vsync_259,
      Q => Inst_Video_video_data_top(18)
    );
  Inst_Video_video_data_top_17 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => ldr_5_IBUF_0,
      Q => Inst_Video_video_data_top(17)
    );
  Inst_Video_video_data_top_16 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => ldr_4_IBUF_1,
      Q => Inst_Video_video_data_top(16)
    );
  Inst_Video_video_data_top_15 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => ldr_3_IBUF_2,
      Q => Inst_Video_video_data_top(15)
    );
  Inst_Video_video_data_top_14 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => ldr_2_IBUF_3,
      Q => Inst_Video_video_data_top(14)
    );
  Inst_Video_video_data_top_13 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => ldr_1_IBUF_4,
      Q => Inst_Video_video_data_top(13)
    );
  Inst_Video_video_data_top_12 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => ldr_0_IBUF_5,
      Q => Inst_Video_video_data_top(12)
    );
  Inst_Video_video_data_top_11 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => ldg_5_IBUF_6,
      Q => Inst_Video_video_data_top(11)
    );
  Inst_Video_video_data_top_10 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => ldg_4_IBUF_7,
      Q => Inst_Video_video_data_top(10)
    );
  Inst_Video_video_data_top_9 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => ldg_3_IBUF_8,
      Q => Inst_Video_video_data_top(9)
    );
  Inst_Video_video_data_top_8 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => ldg_2_IBUF_9,
      Q => Inst_Video_video_data_top(8)
    );
  Inst_Video_video_data_top_7 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => ldg_1_IBUF_10,
      Q => Inst_Video_video_data_top(7)
    );
  Inst_Video_video_data_top_6 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => ldg_0_IBUF_11,
      Q => Inst_Video_video_data_top(6)
    );
  Inst_Video_video_data_top_5 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => ldb_5_IBUF_12,
      Q => Inst_Video_video_data_top(5)
    );
  Inst_Video_video_data_top_4 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => ldb_4_IBUF_13,
      Q => Inst_Video_video_data_top(4)
    );
  Inst_Video_video_data_top_3 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => ldb_3_IBUF_14,
      Q => Inst_Video_video_data_top(3)
    );
  Inst_Video_video_data_top_2 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => ldb_2_IBUF_15,
      Q => Inst_Video_video_data_top(2)
    );
  Inst_Video_video_data_top_1 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => ldb_1_IBUF_16,
      Q => Inst_Video_video_data_top(1)
    );
  Inst_Video_video_data_top_0 : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => ldb_0_IBUF_17,
      Q => Inst_Video_video_data_top(0)
    );
  Inst_Video_fifo_video_wr_en : FDC_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CLR => reset_IBUF_18,
      D => Inst_Video_fifo_video_full_fifo_scr_empty_AND_4_o,
      Q => Inst_Video_fifo_video_wr_en_161
    );
  Inst_Video_is_top : FDPE_1
    generic map(
      INIT => '1'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_Video_fifo_video_full_fifo_scr_empty_AND_4_o,
      D => Inst_Video_is_top_INV_11_o,
      PRE => reset_IBUF_18,
      Q => Inst_Video_is_top_160
    );
  Inst_Video_fifo_scr_wr_en : FDCE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      CE => vsync_IBUF_23,
      CLR => reset_IBUF_18,
      D => Inst_Video_fifo_scr_full_INV_4_o,
      Q => Inst_Video_fifo_scr_wr_en_258
    );
  Inst_Video_is_vsync : FDP_1
    generic map(
      INIT => '1'
    )
    port map (
      C => dclk_IBUF_BUFG_22,
      D => leds_1_OBUF_110,
      PRE => Inst_Video_i_vsync_reset_OR_1_o,
      Q => Inst_Video_is_vsync_259
    );
  Inst_MCP3204_sample_counter_10 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => Inst_MCP3204_iUSB_CLK_inv,
      CLR => reset_IBUF_18,
      D => Inst_MCP3204_Mcount_sample_counter10,
      Q => Inst_MCP3204_sample_counter(10)
    );
  Inst_MCP3204_sample_counter_9 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => Inst_MCP3204_iUSB_CLK_inv,
      CLR => reset_IBUF_18,
      D => Inst_MCP3204_Mcount_sample_counter9,
      Q => Inst_MCP3204_sample_counter(9)
    );
  Inst_MCP3204_sample_counter_8 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => Inst_MCP3204_iUSB_CLK_inv,
      CLR => reset_IBUF_18,
      D => Inst_MCP3204_Mcount_sample_counter8,
      Q => Inst_MCP3204_sample_counter(8)
    );
  Inst_MCP3204_sample_counter_7 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => Inst_MCP3204_iUSB_CLK_inv,
      CLR => reset_IBUF_18,
      D => Inst_MCP3204_Mcount_sample_counter7,
      Q => Inst_MCP3204_sample_counter(7)
    );
  Inst_MCP3204_sample_counter_6 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => Inst_MCP3204_iUSB_CLK_inv,
      CLR => reset_IBUF_18,
      D => Inst_MCP3204_Mcount_sample_counter6,
      Q => Inst_MCP3204_sample_counter(6)
    );
  Inst_MCP3204_sample_counter_5 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => Inst_MCP3204_iUSB_CLK_inv,
      CLR => reset_IBUF_18,
      D => Inst_MCP3204_Mcount_sample_counter5,
      Q => Inst_MCP3204_sample_counter(5)
    );
  Inst_MCP3204_sample_counter_4 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => Inst_MCP3204_iUSB_CLK_inv,
      CLR => reset_IBUF_18,
      D => Inst_MCP3204_Mcount_sample_counter4,
      Q => Inst_MCP3204_sample_counter(4)
    );
  Inst_MCP3204_sample_counter_3 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => Inst_MCP3204_iUSB_CLK_inv,
      CLR => reset_IBUF_18,
      D => Inst_MCP3204_Mcount_sample_counter3,
      Q => Inst_MCP3204_sample_counter(3)
    );
  Inst_MCP3204_sample_counter_2 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => Inst_MCP3204_iUSB_CLK_inv,
      CLR => reset_IBUF_18,
      D => Inst_MCP3204_Mcount_sample_counter2,
      Q => Inst_MCP3204_sample_counter(2)
    );
  Inst_MCP3204_sample_counter_1 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => Inst_MCP3204_iUSB_CLK_inv,
      CLR => reset_IBUF_18,
      D => Inst_MCP3204_Mcount_sample_counter1,
      Q => Inst_MCP3204_sample_counter(1)
    );
  Inst_MCP3204_sample_counter_0 : FDC
    generic map(
      INIT => '0'
    )
    port map (
      C => Inst_MCP3204_iUSB_CLK_inv,
      CLR => reset_IBUF_18,
      D => Inst_MCP3204_Mcount_sample_counter,
      Q => Inst_MCP3204_sample_counter(0)
    );
  Inst_MCP3204_sample_state_buf_FSM_FFd1 : FDC_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CLR => reset_IBUF_18,
      D => Inst_MCP3204_sample_state_buf_FSM_FFd1_In_343,
      Q => Inst_MCP3204_sample_state_buf_FSM_FFd1_415
    );
  Inst_MCP3204_spi_clock_counter_3 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => Inst_MCP3204_iUSB_CLK_inv,
      CE => Inst_MCP3204_sample_idle_inv,
      CLR => reset_IBUF_18,
      D => Inst_MCP3204_Mcount_spi_clock_counter3,
      Q => Inst_MCP3204_spi_clock_counter(3)
    );
  Inst_MCP3204_spi_clock_counter_2 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => Inst_MCP3204_iUSB_CLK_inv,
      CE => Inst_MCP3204_sample_idle_inv,
      CLR => reset_IBUF_18,
      D => Inst_MCP3204_Mcount_spi_clock_counter2,
      Q => Inst_MCP3204_spi_clock_counter(2)
    );
  Inst_MCP3204_spi_clock_counter_1 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => Inst_MCP3204_iUSB_CLK_inv,
      CE => Inst_MCP3204_sample_idle_inv,
      CLR => reset_IBUF_18,
      D => Inst_MCP3204_Mcount_spi_clock_counter1,
      Q => Inst_MCP3204_spi_clock_counter(1)
    );
  Inst_MCP3204_spi_clock_counter_0 : FDCE
    generic map(
      INIT => '0'
    )
    port map (
      C => Inst_MCP3204_iUSB_CLK_inv,
      CE => Inst_MCP3204_sample_idle_inv,
      CLR => reset_IBUF_18,
      D => Inst_MCP3204_Mcount_spi_clock_counter,
      Q => Inst_MCP3204_spi_clock_counter(0)
    );
  Inst_MCP3204_sample_state_buf_FSM_FFd3 : FDC_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CLR => reset_IBUF_18,
      D => Inst_MCP3204_sample_state_buf_FSM_FFd3_In,
      Q => Inst_MCP3204_sample_state_buf_FSM_FFd3_413
    );
  Inst_MCP3204_sample_state_buf_FSM_FFd4 : FDC_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CLR => reset_IBUF_18,
      D => Inst_MCP3204_sample_state_buf_FSM_FFd4_In,
      Q => Inst_MCP3204_sample_state_buf_FSM_FFd4_412
    );
  Inst_MCP3204_sample_state_buf_FSM_FFd2 : FDC_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CLR => reset_IBUF_18,
      D => Inst_MCP3204_sample_state_buf_FSM_FFd2_In,
      Q => Inst_MCP3204_sample_state_buf_FSM_FFd2_414
    );
  Inst_MCP3204_sample_state_buf_FSM_FFd6 : FDC_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CLR => reset_IBUF_18,
      D => Inst_MCP3204_sample_state_buf_FSM_FFd6_In_348,
      Q => Inst_MCP3204_sample_state_buf_FSM_FFd6_410
    );
  Inst_MCP3204_sample_state_buf_FSM_FFd5 : FDC_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CLR => reset_IBUF_18,
      D => Inst_MCP3204_sample_state_buf_FSM_FFd5_In,
      Q => Inst_MCP3204_sample_state_buf_FSM_FFd5_411
    );
  Inst_MCP3204_Mcount_sample_counter_xor_10_Q : XORCY
    port map (
      CI => Inst_MCP3204_Mcount_sample_counter_cy(9),
      LI => Inst_MCP3204_Mcount_sample_counter_lut(10),
      O => Inst_MCP3204_Mcount_sample_counter10
    );
  Inst_MCP3204_Mcount_sample_counter_lut_10_Q : LUT3
    generic map(
      INIT => X"1B"
    )
    port map (
      I0 => Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o,
      I1 => Inst_MCP3204_sample_counter(10),
      I2 => siwu_OBUF_109,
      O => Inst_MCP3204_Mcount_sample_counter_lut(10)
    );
  Inst_MCP3204_Mcount_sample_counter_xor_9_Q : XORCY
    port map (
      CI => Inst_MCP3204_Mcount_sample_counter_cy(8),
      LI => Inst_MCP3204_Mcount_sample_counter_lut(9),
      O => Inst_MCP3204_Mcount_sample_counter9
    );
  Inst_MCP3204_Mcount_sample_counter_cy_9_Q : MUXCY
    port map (
      CI => Inst_MCP3204_Mcount_sample_counter_cy(8),
      DI => siwu_OBUF_109,
      S => Inst_MCP3204_Mcount_sample_counter_lut(9),
      O => Inst_MCP3204_Mcount_sample_counter_cy(9)
    );
  Inst_MCP3204_Mcount_sample_counter_lut_9_Q : LUT3
    generic map(
      INIT => X"1B"
    )
    port map (
      I0 => Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o,
      I1 => Inst_MCP3204_sample_counter(9),
      I2 => leds_1_OBUF_110,
      O => Inst_MCP3204_Mcount_sample_counter_lut(9)
    );
  Inst_MCP3204_Mcount_sample_counter_xor_8_Q : XORCY
    port map (
      CI => Inst_MCP3204_Mcount_sample_counter_cy(7),
      LI => Inst_MCP3204_Mcount_sample_counter_lut(8),
      O => Inst_MCP3204_Mcount_sample_counter8
    );
  Inst_MCP3204_Mcount_sample_counter_cy_8_Q : MUXCY
    port map (
      CI => Inst_MCP3204_Mcount_sample_counter_cy(7),
      DI => siwu_OBUF_109,
      S => Inst_MCP3204_Mcount_sample_counter_lut(8),
      O => Inst_MCP3204_Mcount_sample_counter_cy(8)
    );
  Inst_MCP3204_Mcount_sample_counter_lut_8_Q : LUT3
    generic map(
      INIT => X"1B"
    )
    port map (
      I0 => Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o,
      I1 => Inst_MCP3204_sample_counter(8),
      I2 => leds_1_OBUF_110,
      O => Inst_MCP3204_Mcount_sample_counter_lut(8)
    );
  Inst_MCP3204_Mcount_sample_counter_xor_7_Q : XORCY
    port map (
      CI => Inst_MCP3204_Mcount_sample_counter_cy(6),
      LI => Inst_MCP3204_Mcount_sample_counter_lut(7),
      O => Inst_MCP3204_Mcount_sample_counter7
    );
  Inst_MCP3204_Mcount_sample_counter_cy_7_Q : MUXCY
    port map (
      CI => Inst_MCP3204_Mcount_sample_counter_cy(6),
      DI => siwu_OBUF_109,
      S => Inst_MCP3204_Mcount_sample_counter_lut(7),
      O => Inst_MCP3204_Mcount_sample_counter_cy(7)
    );
  Inst_MCP3204_Mcount_sample_counter_lut_7_Q : LUT3
    generic map(
      INIT => X"1B"
    )
    port map (
      I0 => Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o,
      I1 => Inst_MCP3204_sample_counter(7),
      I2 => siwu_OBUF_109,
      O => Inst_MCP3204_Mcount_sample_counter_lut(7)
    );
  Inst_MCP3204_Mcount_sample_counter_xor_6_Q : XORCY
    port map (
      CI => Inst_MCP3204_Mcount_sample_counter_cy(5),
      LI => Inst_MCP3204_Mcount_sample_counter_lut(6),
      O => Inst_MCP3204_Mcount_sample_counter6
    );
  Inst_MCP3204_Mcount_sample_counter_cy_6_Q : MUXCY
    port map (
      CI => Inst_MCP3204_Mcount_sample_counter_cy(5),
      DI => siwu_OBUF_109,
      S => Inst_MCP3204_Mcount_sample_counter_lut(6),
      O => Inst_MCP3204_Mcount_sample_counter_cy(6)
    );
  Inst_MCP3204_Mcount_sample_counter_lut_6_Q : LUT3
    generic map(
      INIT => X"1B"
    )
    port map (
      I0 => Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o,
      I1 => Inst_MCP3204_sample_counter(6),
      I2 => siwu_OBUF_109,
      O => Inst_MCP3204_Mcount_sample_counter_lut(6)
    );
  Inst_MCP3204_Mcount_sample_counter_xor_5_Q : XORCY
    port map (
      CI => Inst_MCP3204_Mcount_sample_counter_cy(4),
      LI => Inst_MCP3204_Mcount_sample_counter_lut(5),
      O => Inst_MCP3204_Mcount_sample_counter5
    );
  Inst_MCP3204_Mcount_sample_counter_cy_5_Q : MUXCY
    port map (
      CI => Inst_MCP3204_Mcount_sample_counter_cy(4),
      DI => siwu_OBUF_109,
      S => Inst_MCP3204_Mcount_sample_counter_lut(5),
      O => Inst_MCP3204_Mcount_sample_counter_cy(5)
    );
  Inst_MCP3204_Mcount_sample_counter_lut_5_Q : LUT3
    generic map(
      INIT => X"1B"
    )
    port map (
      I0 => Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o,
      I1 => Inst_MCP3204_sample_counter(5),
      I2 => siwu_OBUF_109,
      O => Inst_MCP3204_Mcount_sample_counter_lut(5)
    );
  Inst_MCP3204_Mcount_sample_counter_xor_4_Q : XORCY
    port map (
      CI => Inst_MCP3204_Mcount_sample_counter_cy(3),
      LI => Inst_MCP3204_Mcount_sample_counter_lut(4),
      O => Inst_MCP3204_Mcount_sample_counter4
    );
  Inst_MCP3204_Mcount_sample_counter_cy_4_Q : MUXCY
    port map (
      CI => Inst_MCP3204_Mcount_sample_counter_cy(3),
      DI => siwu_OBUF_109,
      S => Inst_MCP3204_Mcount_sample_counter_lut(4),
      O => Inst_MCP3204_Mcount_sample_counter_cy(4)
    );
  Inst_MCP3204_Mcount_sample_counter_lut_4_Q : LUT3
    generic map(
      INIT => X"1B"
    )
    port map (
      I0 => Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o,
      I1 => Inst_MCP3204_sample_counter(4),
      I2 => leds_1_OBUF_110,
      O => Inst_MCP3204_Mcount_sample_counter_lut(4)
    );
  Inst_MCP3204_Mcount_sample_counter_xor_3_Q : XORCY
    port map (
      CI => Inst_MCP3204_Mcount_sample_counter_cy(2),
      LI => Inst_MCP3204_Mcount_sample_counter_lut(3),
      O => Inst_MCP3204_Mcount_sample_counter3
    );
  Inst_MCP3204_Mcount_sample_counter_cy_3_Q : MUXCY
    port map (
      CI => Inst_MCP3204_Mcount_sample_counter_cy(2),
      DI => siwu_OBUF_109,
      S => Inst_MCP3204_Mcount_sample_counter_lut(3),
      O => Inst_MCP3204_Mcount_sample_counter_cy(3)
    );
  Inst_MCP3204_Mcount_sample_counter_lut_3_Q : LUT3
    generic map(
      INIT => X"1B"
    )
    port map (
      I0 => Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o,
      I1 => Inst_MCP3204_sample_counter(3),
      I2 => leds_1_OBUF_110,
      O => Inst_MCP3204_Mcount_sample_counter_lut(3)
    );
  Inst_MCP3204_Mcount_sample_counter_xor_2_Q : XORCY
    port map (
      CI => Inst_MCP3204_Mcount_sample_counter_cy(1),
      LI => Inst_MCP3204_Mcount_sample_counter_lut(2),
      O => Inst_MCP3204_Mcount_sample_counter2
    );
  Inst_MCP3204_Mcount_sample_counter_cy_2_Q : MUXCY
    port map (
      CI => Inst_MCP3204_Mcount_sample_counter_cy(1),
      DI => siwu_OBUF_109,
      S => Inst_MCP3204_Mcount_sample_counter_lut(2),
      O => Inst_MCP3204_Mcount_sample_counter_cy(2)
    );
  Inst_MCP3204_Mcount_sample_counter_lut_2_Q : LUT3
    generic map(
      INIT => X"1B"
    )
    port map (
      I0 => Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o,
      I1 => Inst_MCP3204_sample_counter(2),
      I2 => leds_1_OBUF_110,
      O => Inst_MCP3204_Mcount_sample_counter_lut(2)
    );
  Inst_MCP3204_Mcount_sample_counter_xor_1_Q : XORCY
    port map (
      CI => Inst_MCP3204_Mcount_sample_counter_cy(0),
      LI => Inst_MCP3204_Mcount_sample_counter_lut(1),
      O => Inst_MCP3204_Mcount_sample_counter1
    );
  Inst_MCP3204_Mcount_sample_counter_cy_1_Q : MUXCY
    port map (
      CI => Inst_MCP3204_Mcount_sample_counter_cy(0),
      DI => siwu_OBUF_109,
      S => Inst_MCP3204_Mcount_sample_counter_lut(1),
      O => Inst_MCP3204_Mcount_sample_counter_cy(1)
    );
  Inst_MCP3204_Mcount_sample_counter_lut_1_Q : LUT3
    generic map(
      INIT => X"1B"
    )
    port map (
      I0 => Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o,
      I1 => Inst_MCP3204_sample_counter(1),
      I2 => leds_1_OBUF_110,
      O => Inst_MCP3204_Mcount_sample_counter_lut(1)
    );
  Inst_MCP3204_Mcount_sample_counter_xor_0_Q : XORCY
    port map (
      CI => Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o,
      LI => Inst_MCP3204_Mcount_sample_counter_lut(0),
      O => Inst_MCP3204_Mcount_sample_counter
    );
  Inst_MCP3204_Mcount_sample_counter_cy_0_Q : MUXCY
    port map (
      CI => Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o,
      DI => siwu_OBUF_109,
      S => Inst_MCP3204_Mcount_sample_counter_lut(0),
      O => Inst_MCP3204_Mcount_sample_counter_cy(0)
    );
  Inst_MCP3204_Mcount_sample_counter_lut_0_Q : LUT3
    generic map(
      INIT => X"1B"
    )
    port map (
      I0 => Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o,
      I1 => Inst_MCP3204_sample_counter(0),
      I2 => siwu_OBUF_109,
      O => Inst_MCP3204_Mcount_sample_counter_lut(0)
    );
  Inst_MCP3204_fifo_in_23 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0675_inv,
      D => Inst_MCP3204_sample_val_left(11),
      Q => Inst_MCP3204_fifo_in(23)
    );
  Inst_MCP3204_fifo_in_22 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0675_inv,
      D => Inst_MCP3204_sample_val_left(10),
      Q => Inst_MCP3204_fifo_in(22)
    );
  Inst_MCP3204_fifo_in_21 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0675_inv,
      D => Inst_MCP3204_sample_val_left(9),
      Q => Inst_MCP3204_fifo_in(21)
    );
  Inst_MCP3204_fifo_in_20 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0675_inv,
      D => Inst_MCP3204_sample_val_left(8),
      Q => Inst_MCP3204_fifo_in(20)
    );
  Inst_MCP3204_fifo_in_19 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0675_inv,
      D => Inst_MCP3204_sample_val_left(7),
      Q => Inst_MCP3204_fifo_in(19)
    );
  Inst_MCP3204_fifo_in_18 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0675_inv,
      D => Inst_MCP3204_sample_val_left(6),
      Q => Inst_MCP3204_fifo_in(18)
    );
  Inst_MCP3204_fifo_in_17 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0675_inv,
      D => Inst_MCP3204_sample_val_left(5),
      Q => Inst_MCP3204_fifo_in(17)
    );
  Inst_MCP3204_fifo_in_16 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0675_inv,
      D => Inst_MCP3204_sample_val_left(4),
      Q => Inst_MCP3204_fifo_in(16)
    );
  Inst_MCP3204_fifo_in_15 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0675_inv,
      D => Inst_MCP3204_sample_val_left(3),
      Q => Inst_MCP3204_fifo_in(15)
    );
  Inst_MCP3204_fifo_in_14 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0675_inv,
      D => Inst_MCP3204_sample_val_left(2),
      Q => Inst_MCP3204_fifo_in(14)
    );
  Inst_MCP3204_fifo_in_13 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0675_inv,
      D => Inst_MCP3204_sample_val_left(1),
      Q => Inst_MCP3204_fifo_in(13)
    );
  Inst_MCP3204_fifo_in_12 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0675_inv,
      D => Inst_MCP3204_sample_val_left(0),
      Q => Inst_MCP3204_fifo_in(12)
    );
  Inst_MCP3204_fifo_in_11 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0675_inv,
      D => Inst_MCP3204_sample_val_right(11),
      Q => Inst_MCP3204_fifo_in(11)
    );
  Inst_MCP3204_fifo_in_10 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0675_inv,
      D => Inst_MCP3204_sample_val_right(10),
      Q => Inst_MCP3204_fifo_in(10)
    );
  Inst_MCP3204_fifo_in_9 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0675_inv,
      D => Inst_MCP3204_sample_val_right(9),
      Q => Inst_MCP3204_fifo_in(9)
    );
  Inst_MCP3204_fifo_in_8 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0675_inv,
      D => Inst_MCP3204_sample_val_right(8),
      Q => Inst_MCP3204_fifo_in(8)
    );
  Inst_MCP3204_fifo_in_7 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0675_inv,
      D => Inst_MCP3204_sample_val_right(7),
      Q => Inst_MCP3204_fifo_in(7)
    );
  Inst_MCP3204_fifo_in_6 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0675_inv,
      D => Inst_MCP3204_sample_val_right(6),
      Q => Inst_MCP3204_fifo_in(6)
    );
  Inst_MCP3204_fifo_in_5 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0675_inv,
      D => Inst_MCP3204_sample_val_right(5),
      Q => Inst_MCP3204_fifo_in(5)
    );
  Inst_MCP3204_fifo_in_4 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0675_inv,
      D => Inst_MCP3204_sample_val_right(4),
      Q => Inst_MCP3204_fifo_in(4)
    );
  Inst_MCP3204_fifo_in_3 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0675_inv,
      D => Inst_MCP3204_sample_val_right(3),
      Q => Inst_MCP3204_fifo_in(3)
    );
  Inst_MCP3204_fifo_in_2 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0675_inv,
      D => Inst_MCP3204_sample_val_right(2),
      Q => Inst_MCP3204_fifo_in(2)
    );
  Inst_MCP3204_fifo_in_1 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0675_inv,
      D => Inst_MCP3204_sample_val_right(1),
      Q => Inst_MCP3204_fifo_in(1)
    );
  Inst_MCP3204_fifo_in_0 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0675_inv,
      D => Inst_MCP3204_sample_val_right(0),
      Q => Inst_MCP3204_fifo_in(0)
    );
  Inst_MCP3204_sample_val_right_11 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0649_inv_352,
      D => Inst_MCP3204_sample_val_right(10),
      Q => Inst_MCP3204_sample_val_right(11)
    );
  Inst_MCP3204_sample_val_right_10 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0649_inv_352,
      D => Inst_MCP3204_sample_val_right(9),
      Q => Inst_MCP3204_sample_val_right(10)
    );
  Inst_MCP3204_sample_val_right_9 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0649_inv_352,
      D => Inst_MCP3204_sample_val_right(8),
      Q => Inst_MCP3204_sample_val_right(9)
    );
  Inst_MCP3204_sample_val_right_8 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0649_inv_352,
      D => Inst_MCP3204_sample_val_right(7),
      Q => Inst_MCP3204_sample_val_right(8)
    );
  Inst_MCP3204_sample_val_right_7 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0649_inv_352,
      D => Inst_MCP3204_sample_val_right(6),
      Q => Inst_MCP3204_sample_val_right(7)
    );
  Inst_MCP3204_sample_val_right_6 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0649_inv_352,
      D => Inst_MCP3204_sample_val_right(5),
      Q => Inst_MCP3204_sample_val_right(6)
    );
  Inst_MCP3204_sample_val_right_5 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0649_inv_352,
      D => Inst_MCP3204_sample_val_right(4),
      Q => Inst_MCP3204_sample_val_right(5)
    );
  Inst_MCP3204_sample_val_right_4 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0649_inv_352,
      D => Inst_MCP3204_sample_val_right(3),
      Q => Inst_MCP3204_sample_val_right(4)
    );
  Inst_MCP3204_sample_val_right_3 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0649_inv_352,
      D => Inst_MCP3204_sample_val_right(2),
      Q => Inst_MCP3204_sample_val_right(3)
    );
  Inst_MCP3204_sample_val_right_2 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0649_inv_352,
      D => Inst_MCP3204_sample_val_right(1),
      Q => Inst_MCP3204_sample_val_right(2)
    );
  Inst_MCP3204_sample_val_right_1 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0649_inv_352,
      D => Inst_MCP3204_sample_val_right(0),
      Q => Inst_MCP3204_sample_val_right(1)
    );
  Inst_MCP3204_sample_val_right_0 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0649_inv_352,
      D => leds_0_OBUF_24,
      Q => Inst_MCP3204_sample_val_right(0)
    );
  Inst_MCP3204_sample_val_left_11 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0511_inv_353,
      D => Inst_MCP3204_sample_val_left(10),
      Q => Inst_MCP3204_sample_val_left(11)
    );
  Inst_MCP3204_sample_val_left_10 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0511_inv_353,
      D => Inst_MCP3204_sample_val_left(9),
      Q => Inst_MCP3204_sample_val_left(10)
    );
  Inst_MCP3204_sample_val_left_9 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0511_inv_353,
      D => Inst_MCP3204_sample_val_left(8),
      Q => Inst_MCP3204_sample_val_left(9)
    );
  Inst_MCP3204_sample_val_left_8 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0511_inv_353,
      D => Inst_MCP3204_sample_val_left(7),
      Q => Inst_MCP3204_sample_val_left(8)
    );
  Inst_MCP3204_sample_val_left_7 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0511_inv_353,
      D => Inst_MCP3204_sample_val_left(6),
      Q => Inst_MCP3204_sample_val_left(7)
    );
  Inst_MCP3204_sample_val_left_6 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0511_inv_353,
      D => Inst_MCP3204_sample_val_left(5),
      Q => Inst_MCP3204_sample_val_left(6)
    );
  Inst_MCP3204_sample_val_left_5 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0511_inv_353,
      D => Inst_MCP3204_sample_val_left(4),
      Q => Inst_MCP3204_sample_val_left(5)
    );
  Inst_MCP3204_sample_val_left_4 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0511_inv_353,
      D => Inst_MCP3204_sample_val_left(3),
      Q => Inst_MCP3204_sample_val_left(4)
    );
  Inst_MCP3204_sample_val_left_3 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0511_inv_353,
      D => Inst_MCP3204_sample_val_left(2),
      Q => Inst_MCP3204_sample_val_left(3)
    );
  Inst_MCP3204_sample_val_left_2 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0511_inv_353,
      D => Inst_MCP3204_sample_val_left(1),
      Q => Inst_MCP3204_sample_val_left(2)
    );
  Inst_MCP3204_sample_val_left_1 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0511_inv_353,
      D => Inst_MCP3204_sample_val_left(0),
      Q => Inst_MCP3204_sample_val_left(1)
    );
  Inst_MCP3204_sample_val_left_0 : FDE_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CE => Inst_MCP3204_n0511_inv_353,
      D => leds_0_OBUF_24,
      Q => Inst_MCP3204_sample_val_left(0)
    );
  Q_n0112_inv1 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => leds_2_OBUF_21,
      I1 => write_state_74,
      O => Q_n0112_inv
    );
  pump_index_FSM_FFd2_In1 : LUT6
    generic map(
      INIT => X"9C9C9C9C8C9C9C9C"
    )
    port map (
      I0 => leds_2_OBUF_21,
      I1 => pump_index_FSM_FFd2_76,
      I2 => write_state_74,
      I3 => audio_fifo_empty,
      I4 => video_fifo_empty,
      I5 => pump_index_FSM_FFd1_75,
      O => pump_index_FSM_FFd2_In
    );
  wr1 : LUT2
    generic map(
      INIT => X"D"
    )
    port map (
      I0 => write_state_74,
      I1 => leds_2_OBUF_21,
      O => wr_OBUF_100
    );
  GND_3_o_video_fifo_rd_MUX_264_o1 : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => pump_type_78,
      I1 => pump_index_FSM_FFd2_76,
      I2 => pump_index_FSM_FFd1_75,
      I3 => leds_2_OBUF_21,
      O => GND_3_o_video_fifo_rd_MUX_264_o
    );
  GND_3_o_audio_fifo_rd_MUX_265_o1 : LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      I0 => pump_type_78,
      I1 => pump_index_FSM_FFd2_76,
      I2 => pump_index_FSM_FFd1_75,
      I3 => leds_2_OBUF_21,
      O => GND_3_o_audio_fifo_rd_MUX_265_o
    );
  Q_n0121_inv11 : LUT6
    generic map(
      INIT => X"0000010001000100"
    )
    port map (
      I0 => pump_index_FSM_FFd2_76,
      I1 => pump_index_FSM_FFd1_75,
      I2 => leds_2_OBUF_21,
      I3 => write_state_74,
      I4 => video_fifo_empty,
      I5 => audio_fifo_empty,
      O => Q_n0121_inv
    );
  pump_index_FSM_FFd1_In11 : LUT4
    generic map(
      INIT => X"C6CC"
    )
    port map (
      I0 => pump_index_FSM_FFd2_76,
      I1 => pump_index_FSM_FFd1_75,
      I2 => leds_2_OBUF_21,
      I3 => write_state_74,
      O => pump_index_FSM_FFd1_In
    );
  Inst_Video_Mmux_GND_4_o_is_top_MUX_78_o11 : LUT3
    generic map(
      INIT => X"02"
    )
    port map (
      I0 => Inst_Video_is_top_160,
      I1 => Inst_Video_fifo_video_full,
      I2 => Inst_Video_fifo_scr_empty,
      O => Inst_Video_GND_4_o_is_top_MUX_78_o
    );
  Inst_Video_Mmux_GND_4_o_PWR_4_o_mux_8_OUT11 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => Inst_Video_is_top_160,
      I1 => Inst_Video_fifo_scr_dout(0),
      I2 => Inst_Video_fifo_scr_dout(18),
      O => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(0)
    );
  Inst_Video_Mmux_GND_4_o_PWR_4_o_mux_8_OUT21 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => Inst_Video_is_top_160,
      I1 => Inst_Video_fifo_scr_dout(10),
      I2 => Inst_Video_fifo_scr_dout(28),
      O => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(10)
    );
  Inst_Video_Mmux_GND_4_o_PWR_4_o_mux_8_OUT31 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => Inst_Video_is_top_160,
      I1 => Inst_Video_fifo_scr_dout(11),
      I2 => Inst_Video_fifo_scr_dout(29),
      O => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(11)
    );
  Inst_Video_Mmux_GND_4_o_PWR_4_o_mux_8_OUT41 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => Inst_Video_is_top_160,
      I1 => Inst_Video_fifo_scr_dout(12),
      I2 => Inst_Video_fifo_scr_dout(30),
      O => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(12)
    );
  Inst_Video_Mmux_GND_4_o_PWR_4_o_mux_8_OUT51 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => Inst_Video_is_top_160,
      I1 => Inst_Video_fifo_scr_dout(13),
      I2 => Inst_Video_fifo_scr_dout(31),
      O => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(13)
    );
  Inst_Video_Mmux_GND_4_o_PWR_4_o_mux_8_OUT61 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => Inst_Video_is_top_160,
      I1 => Inst_Video_fifo_scr_dout(14),
      I2 => Inst_Video_fifo_scr_dout(32),
      O => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(14)
    );
  Inst_Video_Mmux_GND_4_o_PWR_4_o_mux_8_OUT71 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => Inst_Video_is_top_160,
      I1 => Inst_Video_fifo_scr_dout(15),
      I2 => Inst_Video_fifo_scr_dout(33),
      O => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(15)
    );
  Inst_Video_Mmux_GND_4_o_PWR_4_o_mux_8_OUT81 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => Inst_Video_is_top_160,
      I1 => Inst_Video_fifo_scr_dout(16),
      I2 => Inst_Video_fifo_scr_dout(34),
      O => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(16)
    );
  Inst_Video_Mmux_GND_4_o_PWR_4_o_mux_8_OUT91 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => Inst_Video_is_top_160,
      I1 => Inst_Video_fifo_scr_dout(17),
      I2 => Inst_Video_fifo_scr_dout(35),
      O => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(17)
    );
  Inst_Video_Mmux_GND_4_o_PWR_4_o_mux_8_OUT101 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => Inst_Video_is_top_160,
      I1 => Inst_Video_fifo_scr_dout(36),
      O => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(18)
    );
  Inst_Video_Mmux_GND_4_o_PWR_4_o_mux_8_OUT121 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => Inst_Video_is_top_160,
      I1 => Inst_Video_fifo_scr_dout(1),
      I2 => Inst_Video_fifo_scr_dout(19),
      O => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(1)
    );
  Inst_Video_Mmux_GND_4_o_PWR_4_o_mux_8_OUT131 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => Inst_Video_is_top_160,
      I1 => Inst_Video_fifo_scr_dout(2),
      I2 => Inst_Video_fifo_scr_dout(20),
      O => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(2)
    );
  Inst_Video_Mmux_GND_4_o_PWR_4_o_mux_8_OUT141 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => Inst_Video_is_top_160,
      I1 => Inst_Video_fifo_scr_dout(3),
      I2 => Inst_Video_fifo_scr_dout(21),
      O => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(3)
    );
  Inst_Video_Mmux_GND_4_o_PWR_4_o_mux_8_OUT151 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => Inst_Video_is_top_160,
      I1 => Inst_Video_fifo_scr_dout(4),
      I2 => Inst_Video_fifo_scr_dout(22),
      O => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(4)
    );
  Inst_Video_Mmux_GND_4_o_PWR_4_o_mux_8_OUT161 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => Inst_Video_is_top_160,
      I1 => Inst_Video_fifo_scr_dout(5),
      I2 => Inst_Video_fifo_scr_dout(23),
      O => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(5)
    );
  Inst_Video_Mmux_GND_4_o_PWR_4_o_mux_8_OUT171 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => Inst_Video_is_top_160,
      I1 => Inst_Video_fifo_scr_dout(6),
      I2 => Inst_Video_fifo_scr_dout(24),
      O => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(6)
    );
  Inst_Video_Mmux_GND_4_o_PWR_4_o_mux_8_OUT181 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => Inst_Video_is_top_160,
      I1 => Inst_Video_fifo_scr_dout(7),
      I2 => Inst_Video_fifo_scr_dout(25),
      O => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(7)
    );
  Inst_Video_Mmux_GND_4_o_PWR_4_o_mux_8_OUT191 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => Inst_Video_is_top_160,
      I1 => Inst_Video_fifo_scr_dout(8),
      I2 => Inst_Video_fifo_scr_dout(26),
      O => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(8)
    );
  Inst_Video_Mmux_GND_4_o_PWR_4_o_mux_8_OUT201 : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => Inst_Video_is_top_160,
      I1 => Inst_Video_fifo_scr_dout(9),
      I2 => Inst_Video_fifo_scr_dout(27),
      O => Inst_Video_GND_4_o_PWR_4_o_mux_8_OUT(9)
    );
  Inst_Video_n0059_inv1 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => vsync_IBUF_23,
      I1 => dclk_IBUF_500,
      O => Inst_Video_n0059_inv
    );
  Inst_Video_fifo_video_full_fifo_scr_empty_AND_4_o1 : LUT2
    generic map(
      INIT => X"1"
    )
    port map (
      I0 => Inst_Video_fifo_video_full,
      I1 => Inst_Video_fifo_scr_empty,
      O => Inst_Video_fifo_video_full_fifo_scr_empty_AND_4_o
    );
  Inst_Video_i_vsync_reset_OR_1_o1 : LUT2
    generic map(
      INIT => X"D"
    )
    port map (
      I0 => vsync_IBUF_23,
      I1 => reset_IBUF_18,
      O => Inst_Video_i_vsync_reset_OR_1_o
    );
  Inst_MCP3204_sample_state_buf_FSM_FFd5_In1 : LUT6
    generic map(
      INIT => X"80D5AAD580AAAAAA"
    )
    port map (
      I0 => Inst_MCP3204_sample_state_buf_FSM_FFd5_411,
      I1 => Inst_MCP3204_sample_state_buf_FSM_FFd4_412,
      I2 => Inst_MCP3204_sample_state_buf_FSM_FFd4_In12,
      I3 => Inst_MCP3204_sample_state_buf_FSM_FFd3_In2_300,
      I4 => Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o,
      I5 => Inst_MCP3204_sample_state_buf_FSM_FFd6_410,
      O => Inst_MCP3204_sample_state_buf_FSM_FFd5_In
    );
  Inst_MCP3204_sample_state_buf_FSM_FFd4_In1 : LUT6
    generic map(
      INIT => X"BAAA1222BAAA9AAA"
    )
    port map (
      I0 => Inst_MCP3204_sample_state_buf_FSM_FFd4_412,
      I1 => Inst_MCP3204_sample_state_buf_FSM_FFd3_In2_300,
      I2 => Inst_MCP3204_sample_state_buf_FSM_FFd5_411,
      I3 => Inst_MCP3204_sample_state_buf_FSM_FFd6_410,
      I4 => Inst_MCP3204_sample_state_buf_FSM_FFd4_In12,
      I5 => Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o,
      O => Inst_MCP3204_sample_state_buf_FSM_FFd4_In
    );
  Inst_MCP3204_n0675_inv11 : LUT5
    generic map(
      INIT => X"20000000"
    )
    port map (
      I0 => Inst_MCP3204_sample_state_buf_FSM_FFd6_410,
      I1 => Inst_MCP3204_sample_state_buf_FSM_FFd3_In2_300,
      I2 => Inst_MCP3204_sample_state_buf_FSM_FFd1_415,
      I3 => Inst_MCP3204_sample_state_buf_FSM_FFd4_412,
      I4 => Inst_MCP3204_sample_state_buf_FSM_FFd5_411,
      O => Inst_MCP3204_n0675_inv1_299
    );
  Inst_MCP3204_sample_state_buf_FSM_FFd3_In21 : LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
    port map (
      I0 => Inst_MCP3204_sample_idle_409,
      I1 => Inst_MCP3204_spi_clock_counter(3),
      I2 => Inst_MCP3204_spi_clock_counter(1),
      I3 => Inst_MCP3204_spi_clock_counter(2),
      I4 => Inst_MCP3204_spi_clock_counter(0),
      O => Inst_MCP3204_sample_state_buf_FSM_FFd3_In2_300
    );
  Inst_MCP3204_Mcount_spi_clock_counter_xor_0_11 : LUT4
    generic map(
      INIT => X"5554"
    )
    port map (
      I0 => Inst_MCP3204_spi_clock_counter(0),
      I1 => Inst_MCP3204_spi_clock_counter(1),
      I2 => Inst_MCP3204_spi_clock_counter(2),
      I3 => Inst_MCP3204_spi_clock_counter(3),
      O => Inst_MCP3204_Mcount_spi_clock_counter
    );
  Inst_MCP3204_n0316_inv1 : LUT6
    generic map(
      INIT => X"8000800080008002"
    )
    port map (
      I0 => Inst_MCP3204_n0373_inv2,
      I1 => Inst_MCP3204_sample_state_buf_FSM_FFd5_411,
      I2 => Inst_MCP3204_sample_state_buf_FSM_FFd4_412,
      I3 => Inst_MCP3204_sample_state_buf_FSM_FFd1_415,
      I4 => Inst_MCP3204_sample_state_buf_FSM_FFd3_413,
      I5 => Inst_MCP3204_sample_state_buf_FSM_FFd2_414,
      O => Inst_MCP3204_n0316_inv
    );
  Inst_MCP3204_Mcount_spi_clock_counter31 : LUT4
    generic map(
      INIT => X"AAA9"
    )
    port map (
      I0 => Inst_MCP3204_spi_clock_counter(3),
      I1 => Inst_MCP3204_spi_clock_counter(0),
      I2 => Inst_MCP3204_spi_clock_counter(1),
      I3 => Inst_MCP3204_spi_clock_counter(2),
      O => Inst_MCP3204_Mcount_spi_clock_counter3
    );
  Inst_MCP3204_n0675_inv21 : LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => Inst_MCP3204_sample_side_buf_408,
      I1 => Inst_MCP3204_n0675_inv1_299,
      I2 => Inst_MCP3204_fifo_full,
      O => Inst_MCP3204_n0675_inv2
    );
  Inst_MCP3204_n0373_inv21 : LUT3
    generic map(
      INIT => X"01"
    )
    port map (
      I0 => reset_IBUF_18,
      I1 => Inst_MCP3204_sample_state_buf_FSM_FFd3_In2_300,
      I2 => Inst_MCP3204_sample_state_buf_FSM_FFd6_410,
      O => Inst_MCP3204_n0373_inv2
    );
  Inst_MCP3204_n0373_inv1 : LUT5
    generic map(
      INIT => X"00020202"
    )
    port map (
      I0 => Inst_MCP3204_n0373_inv2,
      I1 => Inst_MCP3204_sample_state_buf_FSM_FFd2_414,
      I2 => Inst_MCP3204_sample_state_buf_FSM_FFd1_415,
      I3 => Inst_MCP3204_sample_state_buf_FSM_FFd4_412,
      I4 => Inst_MCP3204_sample_state_buf_FSM_FFd3_413,
      O => Inst_MCP3204_n0373_inv
    );
  Inst_MCP3204_sample_state_buf_FSM_FFd4_In121 : LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => Inst_MCP3204_sample_state_buf_FSM_FFd1_415,
      I1 => Inst_MCP3204_sample_side_buf_408,
      I2 => Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o,
      O => Inst_MCP3204_sample_state_buf_FSM_FFd4_In12
    );
  Inst_MCP3204_sample_state_buf_FSM_FFd3_In2 : LUT6
    generic map(
      INIT => X"41404141C9C8C9C9"
    )
    port map (
      I0 => Inst_MCP3204_sample_state_buf_FSM_FFd3_In2_300,
      I1 => Inst_MCP3204_sample_state_buf_FSM_FFd3_413,
      I2 => Inst_MCP3204_sample_state_buf_FSM_FFd3_In1,
      I3 => Inst_MCP3204_sample_state_buf_FSM_FFd2_414,
      I4 => Inst_MCP3204_sample_state_buf_FSM_FFd1_415,
      I5 => Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o,
      O => Inst_MCP3204_sample_state_buf_FSM_FFd3_In
    );
  Inst_MCP3204_sample_state_buf_FSM_FFd3_In11 : LUT3
    generic map(
      INIT => X"7F"
    )
    port map (
      I0 => Inst_MCP3204_sample_state_buf_FSM_FFd4_412,
      I1 => Inst_MCP3204_sample_state_buf_FSM_FFd6_410,
      I2 => Inst_MCP3204_sample_state_buf_FSM_FFd5_411,
      O => Inst_MCP3204_sample_state_buf_FSM_FFd3_In1
    );
  Inst_MCP3204_sample_state_buf_FSM_FFd2_In1 : LUT5
    generic map(
      INIT => X"2122A9AA"
    )
    port map (
      I0 => Inst_MCP3204_sample_state_buf_FSM_FFd2_414,
      I1 => Inst_MCP3204_sample_state_buf_FSM_FFd3_In2_300,
      I2 => Inst_MCP3204_sample_state_buf_FSM_FFd3_In1,
      I3 => Inst_MCP3204_sample_state_buf_FSM_FFd3_413,
      I4 => Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o,
      O => Inst_MCP3204_sample_state_buf_FSM_FFd2_In
    );
  Inst_MCP3204_Mcount_spi_clock_counter_xor_2_11 : LUT3
    generic map(
      INIT => X"A9"
    )
    port map (
      I0 => Inst_MCP3204_spi_clock_counter(2),
      I1 => Inst_MCP3204_spi_clock_counter(0),
      I2 => Inst_MCP3204_spi_clock_counter(1),
      O => Inst_MCP3204_Mcount_spi_clock_counter2
    );
  Inst_MCP3204_Mcount_spi_clock_counter_xor_1_11 : LUT2
    generic map(
      INIT => X"9"
    )
    port map (
      I0 => Inst_MCP3204_spi_clock_counter(0),
      I1 => Inst_MCP3204_spi_clock_counter(1),
      O => Inst_MCP3204_Mcount_spi_clock_counter1
    );
  n0094_7_1 : LUT5
    generic map(
      INIT => X"1515BF15"
    )
    port map (
      I0 => pump_index_FSM_FFd1_75,
      I1 => audio_fifo_empty,
      I2 => video_fifo_empty,
      I3 => audio_fifo_data(15),
      I4 => pump_type_78,
      O => n0094_7_1_428
    );
  n0094_7_2 : LUT6
    generic map(
      INIT => X"7775575522200200"
    )
    port map (
      I0 => pump_index_FSM_FFd2_76,
      I1 => pump_type_78,
      I2 => pump_index_FSM_FFd1_75,
      I3 => audio_fifo_data(23),
      I4 => audio_fifo_data(7),
      I5 => n0094_7_1_428,
      O => n0094_7_2_429
    );
  n0094_7_3 : LUT4
    generic map(
      INIT => X"AEA2"
    )
    port map (
      I0 => N10,
      I1 => write_state_74,
      I2 => leds_2_OBUF_21,
      I3 => n0094_7_2_429,
      O => n0094(7)
    );
  n0094_6_1 : LUT5
    generic map(
      INIT => X"0404AE04"
    )
    port map (
      I0 => pump_index_FSM_FFd1_75,
      I1 => audio_fifo_empty,
      I2 => video_fifo_empty,
      I3 => audio_fifo_data(14),
      I4 => pump_type_78,
      O => n0094_6_1_430
    );
  n0094_6_2 : LUT6
    generic map(
      INIT => X"7775575522200200"
    )
    port map (
      I0 => pump_index_FSM_FFd2_76,
      I1 => pump_type_78,
      I2 => pump_index_FSM_FFd1_75,
      I3 => audio_fifo_data(22),
      I4 => audio_fifo_data(6),
      I5 => n0094_6_1_430,
      O => n0094_6_2_431
    );
  n0094_6_3 : LUT4
    generic map(
      INIT => X"AEA2"
    )
    port map (
      I0 => N11,
      I1 => write_state_74,
      I2 => leds_2_OBUF_21,
      I3 => n0094_6_2_431,
      O => n0094(6)
    );
  n0094_5_1 : LUT5
    generic map(
      INIT => X"22200200"
    )
    port map (
      I0 => pump_index_FSM_FFd1_75,
      I1 => pump_index_FSM_FFd2_76,
      I2 => pump_type_78,
      I3 => audio_fifo_data(13),
      I4 => video_fifo_data_13_Q,
      O => n0094_5_1_432
    );
  n0094_5_2 : LUT6
    generic map(
      INIT => X"FEBADC9876325410"
    )
    port map (
      I0 => pump_type_78,
      I1 => pump_index_FSM_FFd1_75,
      I2 => audio_fifo_data(21),
      I3 => audio_fifo_data(5),
      I4 => video_fifo_data_21_Q,
      I5 => video_fifo_data_5_Q,
      O => n0094_5_2_433
    );
  n0094_5_3 : LUT6
    generic map(
      INIT => X"BABABA8ABABA8A8A"
    )
    port map (
      I0 => N12,
      I1 => leds_2_OBUF_21,
      I2 => write_state_74,
      I3 => pump_index_FSM_FFd2_76,
      I4 => n0094_5_1_432,
      I5 => n0094_5_2_433,
      O => n0094(5)
    );
  n0094_4_1 : LUT5
    generic map(
      INIT => X"22200200"
    )
    port map (
      I0 => pump_index_FSM_FFd1_75,
      I1 => pump_index_FSM_FFd2_76,
      I2 => pump_type_78,
      I3 => audio_fifo_data(12),
      I4 => video_fifo_data_12_Q,
      O => n0094_4_1_434
    );
  n0094_4_2 : LUT6
    generic map(
      INIT => X"FEBADC9876325410"
    )
    port map (
      I0 => pump_type_78,
      I1 => pump_index_FSM_FFd1_75,
      I2 => audio_fifo_data(20),
      I3 => audio_fifo_data(4),
      I4 => video_fifo_data_20_Q,
      I5 => video_fifo_data_4_Q,
      O => n0094_4_2_435
    );
  n0094_4_3 : LUT6
    generic map(
      INIT => X"BABABA8ABABA8A8A"
    )
    port map (
      I0 => N13,
      I1 => leds_2_OBUF_21,
      I2 => write_state_74,
      I3 => pump_index_FSM_FFd2_76,
      I4 => n0094_4_1_434,
      I5 => n0094_4_2_435,
      O => n0094(4)
    );
  n0094_3_1 : LUT5
    generic map(
      INIT => X"22200200"
    )
    port map (
      I0 => pump_index_FSM_FFd1_75,
      I1 => pump_index_FSM_FFd2_76,
      I2 => pump_type_78,
      I3 => audio_fifo_data(11),
      I4 => video_fifo_data_11_Q,
      O => n0094_3_1_436
    );
  n0094_3_2 : LUT6
    generic map(
      INIT => X"FEBADC9876325410"
    )
    port map (
      I0 => pump_type_78,
      I1 => pump_index_FSM_FFd1_75,
      I2 => audio_fifo_data(19),
      I3 => audio_fifo_data(3),
      I4 => video_fifo_data_19_Q,
      I5 => video_fifo_data_3_Q,
      O => n0094_3_2_437
    );
  n0094_3_3 : LUT6
    generic map(
      INIT => X"BABABA8ABABA8A8A"
    )
    port map (
      I0 => N14,
      I1 => leds_2_OBUF_21,
      I2 => write_state_74,
      I3 => pump_index_FSM_FFd2_76,
      I4 => n0094_3_1_436,
      I5 => n0094_3_2_437,
      O => n0094(3)
    );
  n0094_2_1 : LUT5
    generic map(
      INIT => X"22200200"
    )
    port map (
      I0 => pump_index_FSM_FFd1_75,
      I1 => pump_index_FSM_FFd2_76,
      I2 => pump_type_78,
      I3 => audio_fifo_data(10),
      I4 => video_fifo_data_10_Q,
      O => n0094_2_1_438
    );
  n0094_2_2 : LUT6
    generic map(
      INIT => X"FEBADC9876325410"
    )
    port map (
      I0 => pump_type_78,
      I1 => pump_index_FSM_FFd1_75,
      I2 => audio_fifo_data(18),
      I3 => audio_fifo_data(2),
      I4 => video_fifo_data_18_Q,
      I5 => video_fifo_data_2_Q,
      O => n0094_2_2_439
    );
  n0094_2_3 : LUT6
    generic map(
      INIT => X"BABABA8ABABA8A8A"
    )
    port map (
      I0 => N15,
      I1 => leds_2_OBUF_21,
      I2 => write_state_74,
      I3 => pump_index_FSM_FFd2_76,
      I4 => n0094_2_1_438,
      I5 => n0094_2_2_439,
      O => n0094(2)
    );
  n0094_1_3 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => video_fifo_empty,
      I1 => video_fifo_data_25_Q,
      O => n0094_1_3_440
    );
  n0094_0_3 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => video_fifo_empty,
      I1 => video_fifo_data_24_Q,
      O => n0094_0_3_441
    );
  Inst_MCP3204_n0649_inv_SW0 : LUT5
    generic map(
      INIT => X"C111D111"
    )
    port map (
      I0 => Inst_MCP3204_sample_state_buf_FSM_FFd2_414,
      I1 => Inst_MCP3204_sample_state_buf_FSM_FFd1_415,
      I2 => Inst_MCP3204_sample_state_buf_FSM_FFd5_411,
      I3 => Inst_MCP3204_sample_state_buf_FSM_FFd4_412,
      I4 => Inst_MCP3204_sample_state_buf_FSM_FFd3_413,
      O => N0
    );
  Inst_MCP3204_n0649_inv : LUT5
    generic map(
      INIT => X"00000040"
    )
    port map (
      I0 => Inst_MCP3204_sample_state_buf_FSM_FFd3_In2_300,
      I1 => Inst_MCP3204_sample_side_buf_408,
      I2 => Inst_MCP3204_sample_state_buf_FSM_FFd6_410,
      I3 => reset_IBUF_18,
      I4 => N0,
      O => Inst_MCP3204_n0649_inv_352
    );
  Inst_MCP3204_n0511_inv : LUT5
    generic map(
      INIT => X"00000010"
    )
    port map (
      I0 => Inst_MCP3204_sample_state_buf_FSM_FFd3_In2_300,
      I1 => Inst_MCP3204_sample_side_buf_408,
      I2 => Inst_MCP3204_sample_state_buf_FSM_FFd6_410,
      I3 => reset_IBUF_18,
      I4 => N0,
      O => Inst_MCP3204_n0511_inv_353
    );
  Inst_MCP3204_sample_state_buf_FSM_FFd6_In_SW0 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => Inst_MCP3204_sample_state_buf_FSM_FFd1_415,
      I1 => Inst_MCP3204_sample_side_buf_408,
      O => N4
    );
  Inst_MCP3204_sample_state_buf_FSM_FFd6_In : LUT6
    generic map(
      INIT => X"5343434343434343"
    )
    port map (
      I0 => Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o,
      I1 => Inst_MCP3204_sample_state_buf_FSM_FFd3_In2_300,
      I2 => Inst_MCP3204_sample_state_buf_FSM_FFd6_410,
      I3 => Inst_MCP3204_sample_state_buf_FSM_FFd4_412,
      I4 => Inst_MCP3204_sample_state_buf_FSM_FFd5_411,
      I5 => N4,
      O => Inst_MCP3204_sample_state_buf_FSM_FFd6_In_348
    );
  Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o_10_SW0 : LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
    port map (
      I0 => Inst_MCP3204_sample_counter(8),
      I1 => Inst_MCP3204_sample_counter(3),
      I2 => Inst_MCP3204_sample_counter(9),
      I3 => Inst_MCP3204_sample_counter(4),
      I4 => Inst_MCP3204_sample_counter(5),
      I5 => Inst_MCP3204_sample_counter(10),
      O => N6
    );
  Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o_10_Q : LUT6
    generic map(
      INIT => X"0000000000000001"
    )
    port map (
      I0 => Inst_MCP3204_sample_counter(1),
      I1 => Inst_MCP3204_sample_counter(0),
      I2 => Inst_MCP3204_sample_counter(7),
      I3 => Inst_MCP3204_sample_counter(6),
      I4 => Inst_MCP3204_sample_counter(2),
      I5 => N6,
      O => Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o
    );
  Inst_MCP3204_sample_state_buf_FSM_FFd1_In_SW0 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => Inst_MCP3204_sample_state_buf_FSM_FFd3_413,
      I1 => Inst_MCP3204_sample_state_buf_FSM_FFd2_414,
      O => N8
    );
  Inst_MCP3204_sample_state_buf_FSM_FFd1_In : LUT6
    generic map(
      INIT => X"22AA22FF22AA2220"
    )
    port map (
      I0 => Inst_MCP3204_sample_state_buf_FSM_FFd1_415,
      I1 => Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o,
      I2 => Inst_MCP3204_sample_side_buf_408,
      I3 => Inst_MCP3204_sample_state_buf_FSM_FFd3_In2_300,
      I4 => Inst_MCP3204_sample_state_buf_FSM_FFd3_In1,
      I5 => N8,
      O => Inst_MCP3204_sample_state_buf_FSM_FFd1_In_343
    );
  dclk_IBUF : IBUF
    port map (
      I => dclk,
      O => dclk_IBUF_500
    );
  ldr_5_IBUF : IBUF
    port map (
      I => ldr(5),
      O => ldr_5_IBUF_0
    );
  ldr_4_IBUF : IBUF
    port map (
      I => ldr(4),
      O => ldr_4_IBUF_1
    );
  ldr_3_IBUF : IBUF
    port map (
      I => ldr(3),
      O => ldr_3_IBUF_2
    );
  ldr_2_IBUF : IBUF
    port map (
      I => ldr(2),
      O => ldr_2_IBUF_3
    );
  ldr_1_IBUF : IBUF
    port map (
      I => ldr(1),
      O => ldr_1_IBUF_4
    );
  ldr_0_IBUF : IBUF
    port map (
      I => ldr(0),
      O => ldr_0_IBUF_5
    );
  ldg_5_IBUF : IBUF
    port map (
      I => ldg(5),
      O => ldg_5_IBUF_6
    );
  ldg_4_IBUF : IBUF
    port map (
      I => ldg(4),
      O => ldg_4_IBUF_7
    );
  ldg_3_IBUF : IBUF
    port map (
      I => ldg(3),
      O => ldg_3_IBUF_8
    );
  ldg_2_IBUF : IBUF
    port map (
      I => ldg(2),
      O => ldg_2_IBUF_9
    );
  ldg_1_IBUF : IBUF
    port map (
      I => ldg(1),
      O => ldg_1_IBUF_10
    );
  ldg_0_IBUF : IBUF
    port map (
      I => ldg(0),
      O => ldg_0_IBUF_11
    );
  ldb_5_IBUF : IBUF
    port map (
      I => ldb(5),
      O => ldb_5_IBUF_12
    );
  ldb_4_IBUF : IBUF
    port map (
      I => ldb(4),
      O => ldb_4_IBUF_13
    );
  ldb_3_IBUF : IBUF
    port map (
      I => ldb(3),
      O => ldb_3_IBUF_14
    );
  ldb_2_IBUF : IBUF
    port map (
      I => ldb(2),
      O => ldb_2_IBUF_15
    );
  ldb_1_IBUF : IBUF
    port map (
      I => ldb(1),
      O => ldb_1_IBUF_16
    );
  ldb_0_IBUF : IBUF
    port map (
      I => ldb(0),
      O => ldb_0_IBUF_17
    );
  reset_IBUF : IBUF
    port map (
      I => reset,
      O => reset_IBUF_18
    );
  rxf_IBUF : IBUF
    port map (
      I => rxf,
      O => leds_3_OBUF_20
    );
  txe_IBUF : IBUF
    port map (
      I => txe,
      O => leds_2_OBUF_21
    );
  vsync_IBUF : IBUF
    port map (
      I => vsync,
      O => vsync_IBUF_23
    );
  spi_din_IBUF : IBUF
    port map (
      I => spi_din,
      O => leds_0_OBUF_24
    );
  adbus_7_IOBUF : IOBUF
    port map (
      I => adbus_buf(7),
      T => PWR_11_o_usb_clk_DFF_160_inv,
      O => N10,
      IO => adbus(7)
    );
  adbus_6_IOBUF : IOBUF
    port map (
      I => adbus_buf(6),
      T => PWR_11_o_usb_clk_DFF_160_inv,
      O => N11,
      IO => adbus(6)
    );
  adbus_5_IOBUF : IOBUF
    port map (
      I => adbus_buf(5),
      T => PWR_11_o_usb_clk_DFF_160_inv,
      O => N12,
      IO => adbus(5)
    );
  adbus_4_IOBUF : IOBUF
    port map (
      I => adbus_buf(4),
      T => PWR_11_o_usb_clk_DFF_160_inv,
      O => N13,
      IO => adbus(4)
    );
  adbus_3_IOBUF : IOBUF
    port map (
      I => adbus_buf(3),
      T => PWR_11_o_usb_clk_DFF_160_inv,
      O => N14,
      IO => adbus(3)
    );
  adbus_2_IOBUF : IOBUF
    port map (
      I => adbus_buf(2),
      T => PWR_11_o_usb_clk_DFF_160_inv,
      O => N15,
      IO => adbus(2)
    );
  adbus_1_IOBUF : IOBUF
    port map (
      I => adbus_buf(1),
      T => PWR_11_o_usb_clk_DFF_160_inv,
      O => N16,
      IO => adbus(1)
    );
  adbus_0_IOBUF : IOBUF
    port map (
      I => adbus_buf(0),
      T => PWR_11_o_usb_clk_DFF_160_inv,
      O => N17,
      IO => adbus(0)
    );
  leds_3_OBUF : OBUF
    port map (
      I => leds_3_OBUF_20,
      O => leds(3)
    );
  leds_2_OBUF : OBUF
    port map (
      I => leds_2_OBUF_21,
      O => leds(2)
    );
  leds_1_OBUF : OBUF
    port map (
      I => leds_1_OBUF_110,
      O => leds(1)
    );
  leds_0_OBUF : OBUF
    port map (
      I => leds_0_OBUF_24,
      O => leds(0)
    );
  rd_OBUF : OBUF
    port map (
      I => siwu_OBUF_109,
      O => rd
    );
  wr_OBUF : OBUF
    port map (
      I => wr_OBUF_100,
      O => wr
    );
  siwu_OBUF : OBUF
    port map (
      I => siwu_OBUF_109,
      O => siwu
    );
  spi_clk_OBUF : OBUF
    port map (
      I => Inst_MCP3204_spi_clock_buf_71,
      O => spi_clk
    );
  spi_dout_OBUF : OBUF
    port map (
      I => Inst_MCP3204_spi_dout_buf_73,
      O => spi_dout
    );
  spi_cs_OBUF : OBUF
    port map (
      I => Inst_MCP3204_spi_cs_buf_72,
      O => spi_cs
    );
  PWR_11_o_usb_clk_DFF_160 : FDC_1
    port map (
      C => usb_clk_BUFGP_19,
      CLR => reset_IBUF_18,
      D => PWR_11_o_usb_clk_DFF_160_rstpot_489,
      Q => PWR_11_o_usb_clk_DFF_160_79
    );
  pump_type_rstpot : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => Q_n0121_inv,
      I1 => audio_fifo_empty,
      I2 => pump_type_78,
      O => pump_type_rstpot_490
    );
  pump_type : FDC_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CLR => reset_IBUF_18,
      D => pump_type_rstpot_490,
      Q => pump_type_78
    );
  Inst_MCP3204_sample_idle : FDP_1
    generic map(
      INIT => '1'
    )
    port map (
      C => usb_clk_BUFGP_19,
      D => Inst_MCP3204_sample_idle_rstpot_491,
      PRE => reset_IBUF_18,
      Q => Inst_MCP3204_sample_idle_409
    );
  Inst_MCP3204_fifo_wr_en : FDC_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CLR => reset_IBUF_18,
      D => Inst_MCP3204_n0675_inv2,
      Q => Inst_MCP3204_fifo_wr_en_407
    );
  Inst_MCP3204_sample_side_buf : FDC_1
    generic map(
      INIT => '0'
    )
    port map (
      C => usb_clk_BUFGP_19,
      CLR => reset_IBUF_18,
      D => Inst_MCP3204_sample_side_buf_rstpot_492,
      Q => Inst_MCP3204_sample_side_buf_408
    );
  Inst_MCP3204_spi_dout_buf : FD_1
    generic map(
      INIT => '1'
    )
    port map (
      C => usb_clk_BUFGP_19,
      D => Inst_MCP3204_spi_dout_buf_rstpot_493,
      Q => Inst_MCP3204_spi_dout_buf_73
    );
  Inst_MCP3204_spi_cs_buf_rstpot : LUT3
    generic map(
      INIT => X"D8"
    )
    port map (
      I0 => Inst_MCP3204_n0316_inv,
      I1 => Inst_MCP3204_sample_state_buf_FSM_FFd1_415,
      I2 => Inst_MCP3204_spi_cs_buf_72,
      O => Inst_MCP3204_spi_cs_buf_rstpot_494
    );
  Inst_MCP3204_spi_cs_buf : FD_1
    generic map(
      INIT => '1'
    )
    port map (
      C => usb_clk_BUFGP_19,
      D => Inst_MCP3204_spi_cs_buf_rstpot_494,
      Q => Inst_MCP3204_spi_cs_buf_72
    );
  Inst_MCP3204_spi_clock_buf : FD_1
    generic map(
      INIT => '1'
    )
    port map (
      C => usb_clk_BUFGP_19,
      D => Inst_MCP3204_spi_clock_buf_rstpot_495,
      Q => Inst_MCP3204_spi_clock_buf_71
    );
  Inst_MCP3204_sample_side_buf_rstpot : LUT3
    generic map(
      INIT => X"72"
    )
    port map (
      I0 => Inst_MCP3204_sample_side_buf_408,
      I1 => Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o,
      I2 => Inst_MCP3204_n0675_inv1_299,
      O => Inst_MCP3204_sample_side_buf_rstpot_492
    );
  Inst_MCP3204_sample_idle_rstpot : LUT4
    generic map(
      INIT => X"F444"
    )
    port map (
      I0 => Inst_MCP3204_GND_8_o_sample_counter_10_equal_2_o,
      I1 => Inst_MCP3204_sample_idle_409,
      I2 => Inst_MCP3204_sample_side_buf_408,
      I3 => Inst_MCP3204_n0675_inv1_299,
      O => Inst_MCP3204_sample_idle_rstpot_491
    );
  PWR_11_o_usb_clk_DFF_160_rstpot : LUT3
    generic map(
      INIT => X"F4"
    )
    port map (
      I0 => leds_2_OBUF_21,
      I1 => write_state_74,
      I2 => PWR_11_o_usb_clk_DFF_160_79,
      O => PWR_11_o_usb_clk_DFF_160_rstpot_489
    );
  Inst_MCP3204_spi_dout_buf_rstpot : LUT6
    generic map(
      INIT => X"DDD5FFF78880AAA2"
    )
    port map (
      I0 => Inst_MCP3204_n0373_inv,
      I1 => Inst_MCP3204_sample_state_buf_FSM_FFd3_413,
      I2 => Inst_MCP3204_sample_state_buf_FSM_FFd5_411,
      I3 => Inst_MCP3204_sample_side_buf_408,
      I4 => Inst_MCP3204_sample_state_buf_FSM_FFd4_412,
      I5 => Inst_MCP3204_spi_dout_buf_73,
      O => Inst_MCP3204_spi_dout_buf_rstpot_493
    );
  Inst_MCP3204_spi_clock_buf_rstpot : LUT4
    generic map(
      INIT => X"ABA8"
    )
    port map (
      I0 => Inst_MCP3204_spi_clock_buf_71,
      I1 => reset_IBUF_18,
      I2 => Inst_MCP3204_sample_state_buf_FSM_FFd3_In2_300,
      I3 => Inst_MCP3204_sample_state_buf_FSM_FFd6_410,
      O => Inst_MCP3204_spi_clock_buf_rstpot_495
    );
  Inst_MCP3204_n0675_inv1 : LUT4
    generic map(
      INIT => X"0040"
    )
    port map (
      I0 => reset_IBUF_18,
      I1 => Inst_MCP3204_sample_side_buf_408,
      I2 => Inst_MCP3204_n0675_inv1_299,
      I3 => Inst_MCP3204_fifo_full,
      O => Inst_MCP3204_n0675_inv
    );
  n0094_1_4_F : LUT6
    generic map(
      INIT => X"FBC87340C8C84040"
    )
    port map (
      I0 => pump_type_78,
      I1 => pump_index_FSM_FFd1_75,
      I2 => audio_fifo_data(9),
      I3 => audio_fifo_empty,
      I4 => video_fifo_data_9_Q,
      I5 => n0094_1_3_440,
      O => N26
    );
  n0094_1_4_G : LUT6
    generic map(
      INIT => X"FEBA7632DC985410"
    )
    port map (
      I0 => pump_type_78,
      I1 => pump_index_FSM_FFd1_75,
      I2 => audio_fifo_data(17),
      I3 => audio_fifo_data(1),
      I4 => video_fifo_data_1_Q,
      I5 => video_fifo_data_17_Q,
      O => N27
    );
  n0094_0_4_F : LUT6
    generic map(
      INIT => X"FBC87340C8C84040"
    )
    port map (
      I0 => pump_type_78,
      I1 => pump_index_FSM_FFd1_75,
      I2 => audio_fifo_data(8),
      I3 => audio_fifo_empty,
      I4 => video_fifo_data_8_Q,
      I5 => n0094_0_3_441,
      O => N28
    );
  n0094_0_4_G : LUT6
    generic map(
      INIT => X"FEBA7632DC985410"
    )
    port map (
      I0 => pump_type_78,
      I1 => pump_index_FSM_FFd1_75,
      I2 => audio_fifo_data(16),
      I3 => audio_fifo_data(0),
      I4 => video_fifo_data_0_Q,
      I5 => video_fifo_data_16_Q,
      O => N29
    );
  n0094_1_5 : LUT6
    generic map(
      INIT => X"DCDC8CDCDC8C8C8C"
    )
    port map (
      I0 => leds_2_OBUF_21,
      I1 => N16,
      I2 => write_state_74,
      I3 => pump_index_FSM_FFd2_76,
      I4 => N27,
      I5 => N26,
      O => n0094(1)
    );
  n0094_0_5 : LUT6
    generic map(
      INIT => X"DCDC8CDCDC8C8C8C"
    )
    port map (
      I0 => leds_2_OBUF_21,
      I1 => N17,
      I2 => write_state_74,
      I3 => pump_index_FSM_FFd2_76,
      I4 => N29,
      I5 => N28,
      O => n0094(0)
    );
  usb_clk_BUFGP : BUFGP
    port map (
      I => usb_clk,
      O => usb_clk_BUFGP_19
    );
  dclk_IBUF_BUFG : BUFG
    port map (
      O => dclk_IBUF_BUFG_22,
      I => dclk_IBUF_500
    );
  txe_INV_54_o1_INV_0 : INV
    port map (
      I => leds_2_OBUF_21,
      O => txe_INV_54_o
    );
  PWR_11_o_usb_clk_DFF_160_inv1_INV_0 : INV
    port map (
      I => PWR_11_o_usb_clk_DFF_160_79,
      O => PWR_11_o_usb_clk_DFF_160_inv
    );
  Inst_Video_is_top_INV_11_o1_INV_0 : INV
    port map (
      I => Inst_Video_is_top_160,
      O => Inst_Video_is_top_INV_11_o
    );
  Inst_Video_fifo_scr_full_INV_4_o1_INV_0 : INV
    port map (
      I => Inst_Video_fifo_scr_full,
      O => Inst_Video_fifo_scr_full_INV_4_o
    );
  Inst_MCP3204_sample_idle_inv1_INV_0 : INV
    port map (
      I => Inst_MCP3204_sample_idle_409,
      O => Inst_MCP3204_sample_idle_inv
    );
  Inst_MCP3204_iUSB_CLK_inv1_INV_0 : INV
    port map (
      I => usb_clk_BUFGP_19,
      O => Inst_MCP3204_iUSB_CLK_inv
    );
  Inst_Video_Inst_scr_fifo : scr_fifo
    port map (
      rst => reset_IBUF_18,
      wr_clk => dclk_IBUF_BUFG_22,
      rd_clk => usb_clk_BUFGP_19,
      wr_en => Inst_Video_fifo_scr_wr_en_258,
      rd_en => Inst_Video_fifo_scr_rd_en_162,
      full => Inst_Video_fifo_scr_full,
      empty => Inst_Video_fifo_scr_empty,
      din(36) => Inst_Video_fifo_scr_din(36),
      din(35) => Inst_Video_fifo_scr_din(35),
      din(34) => Inst_Video_fifo_scr_din(34),
      din(33) => Inst_Video_fifo_scr_din(33),
      din(32) => Inst_Video_fifo_scr_din(32),
      din(31) => Inst_Video_fifo_scr_din(31),
      din(30) => Inst_Video_fifo_scr_din(30),
      din(29) => Inst_Video_fifo_scr_din(29),
      din(28) => Inst_Video_fifo_scr_din(28),
      din(27) => Inst_Video_fifo_scr_din(27),
      din(26) => Inst_Video_fifo_scr_din(26),
      din(25) => Inst_Video_fifo_scr_din(25),
      din(24) => Inst_Video_fifo_scr_din(24),
      din(23) => Inst_Video_fifo_scr_din(23),
      din(22) => Inst_Video_fifo_scr_din(22),
      din(21) => Inst_Video_fifo_scr_din(21),
      din(20) => Inst_Video_fifo_scr_din(20),
      din(19) => Inst_Video_fifo_scr_din(19),
      din(18) => Inst_Video_fifo_scr_din(18),
      din(17) => Inst_Video_fifo_scr_din(17),
      din(16) => Inst_Video_fifo_scr_din(16),
      din(15) => Inst_Video_fifo_scr_din(15),
      din(14) => Inst_Video_fifo_scr_din(14),
      din(13) => Inst_Video_fifo_scr_din(13),
      din(12) => Inst_Video_fifo_scr_din(12),
      din(11) => Inst_Video_fifo_scr_din(11),
      din(10) => Inst_Video_fifo_scr_din(10),
      din(9) => Inst_Video_fifo_scr_din(9),
      din(8) => Inst_Video_fifo_scr_din(8),
      din(7) => Inst_Video_fifo_scr_din(7),
      din(6) => Inst_Video_fifo_scr_din(6),
      din(5) => Inst_Video_fifo_scr_din(5),
      din(4) => Inst_Video_fifo_scr_din(4),
      din(3) => Inst_Video_fifo_scr_din(3),
      din(2) => Inst_Video_fifo_scr_din(2),
      din(1) => Inst_Video_fifo_scr_din(1),
      din(0) => Inst_Video_fifo_scr_din(0),
      dout(36) => Inst_Video_fifo_scr_dout(36),
      dout(35) => Inst_Video_fifo_scr_dout(35),
      dout(34) => Inst_Video_fifo_scr_dout(34),
      dout(33) => Inst_Video_fifo_scr_dout(33),
      dout(32) => Inst_Video_fifo_scr_dout(32),
      dout(31) => Inst_Video_fifo_scr_dout(31),
      dout(30) => Inst_Video_fifo_scr_dout(30),
      dout(29) => Inst_Video_fifo_scr_dout(29),
      dout(28) => Inst_Video_fifo_scr_dout(28),
      dout(27) => Inst_Video_fifo_scr_dout(27),
      dout(26) => Inst_Video_fifo_scr_dout(26),
      dout(25) => Inst_Video_fifo_scr_dout(25),
      dout(24) => Inst_Video_fifo_scr_dout(24),
      dout(23) => Inst_Video_fifo_scr_dout(23),
      dout(22) => Inst_Video_fifo_scr_dout(22),
      dout(21) => Inst_Video_fifo_scr_dout(21),
      dout(20) => Inst_Video_fifo_scr_dout(20),
      dout(19) => Inst_Video_fifo_scr_dout(19),
      dout(18) => Inst_Video_fifo_scr_dout(18),
      dout(17) => Inst_Video_fifo_scr_dout(17),
      dout(16) => Inst_Video_fifo_scr_dout(16),
      dout(15) => Inst_Video_fifo_scr_dout(15),
      dout(14) => Inst_Video_fifo_scr_dout(14),
      dout(13) => Inst_Video_fifo_scr_dout(13),
      dout(12) => Inst_Video_fifo_scr_dout(12),
      dout(11) => Inst_Video_fifo_scr_dout(11),
      dout(10) => Inst_Video_fifo_scr_dout(10),
      dout(9) => Inst_Video_fifo_scr_dout(9),
      dout(8) => Inst_Video_fifo_scr_dout(8),
      dout(7) => Inst_Video_fifo_scr_dout(7),
      dout(6) => Inst_Video_fifo_scr_dout(6),
      dout(5) => Inst_Video_fifo_scr_dout(5),
      dout(4) => Inst_Video_fifo_scr_dout(4),
      dout(3) => Inst_Video_fifo_scr_dout(3),
      dout(2) => Inst_Video_fifo_scr_dout(2),
      dout(1) => Inst_Video_fifo_scr_dout(1),
      dout(0) => Inst_Video_fifo_scr_dout(0)
    );
  Inst_Video_Inst_video_buffer : video_buffer
    port map (
      clk => usb_clk_BUFGP_19,
      rst => reset_IBUF_18,
      wr_en => Inst_Video_fifo_video_wr_en_161,
      rd_en => video_fifo_rd_80,
      full => Inst_Video_fifo_video_full,
      empty => video_fifo_empty,
      din(19) => Inst_Video_fifo_video_din(19),
      din(18) => Inst_Video_fifo_video_din(18),
      din(17) => Inst_Video_fifo_video_din(17),
      din(16) => Inst_Video_fifo_video_din(16),
      din(15) => Inst_Video_fifo_video_din(15),
      din(14) => Inst_Video_fifo_video_din(14),
      din(13) => Inst_Video_fifo_video_din(13),
      din(12) => Inst_Video_fifo_video_din(12),
      din(11) => Inst_Video_fifo_video_din(11),
      din(10) => Inst_Video_fifo_video_din(10),
      din(9) => Inst_Video_fifo_video_din(9),
      din(8) => Inst_Video_fifo_video_din(8),
      din(7) => Inst_Video_fifo_video_din(7),
      din(6) => Inst_Video_fifo_video_din(6),
      din(5) => Inst_Video_fifo_video_din(5),
      din(4) => Inst_Video_fifo_video_din(4),
      din(3) => Inst_Video_fifo_video_din(3),
      din(2) => Inst_Video_fifo_video_din(2),
      din(1) => Inst_Video_fifo_video_din(1),
      din(0) => Inst_Video_fifo_video_din(0),
      dout(19) => video_fifo_data_25_Q,
      dout(18) => video_fifo_data_24_Q,
      dout(17) => video_fifo_data_21_Q,
      dout(16) => video_fifo_data_20_Q,
      dout(15) => video_fifo_data_19_Q,
      dout(14) => video_fifo_data_18_Q,
      dout(13) => video_fifo_data_17_Q,
      dout(12) => video_fifo_data_16_Q,
      dout(11) => video_fifo_data_13_Q,
      dout(10) => video_fifo_data_12_Q,
      dout(9) => video_fifo_data_11_Q,
      dout(8) => video_fifo_data_10_Q,
      dout(7) => video_fifo_data_9_Q,
      dout(6) => video_fifo_data_8_Q,
      dout(5) => video_fifo_data_5_Q,
      dout(4) => video_fifo_data_4_Q,
      dout(3) => video_fifo_data_3_Q,
      dout(2) => video_fifo_data_2_Q,
      dout(1) => video_fifo_data_1_Q,
      dout(0) => video_fifo_data_0_Q
    );
  Inst_MCP3204_Inst_adc_buffer : adc_buffer
    port map (
      clk => usb_clk_BUFGP_19,
      rst => reset_IBUF_18,
      wr_en => Inst_MCP3204_fifo_wr_en_407,
      rd_en => audio_fifo_rd_77,
      full => Inst_MCP3204_fifo_full,
      empty => audio_fifo_empty,
      din(23) => Inst_MCP3204_fifo_in(23),
      din(22) => Inst_MCP3204_fifo_in(22),
      din(21) => Inst_MCP3204_fifo_in(21),
      din(20) => Inst_MCP3204_fifo_in(20),
      din(19) => Inst_MCP3204_fifo_in(19),
      din(18) => Inst_MCP3204_fifo_in(18),
      din(17) => Inst_MCP3204_fifo_in(17),
      din(16) => Inst_MCP3204_fifo_in(16),
      din(15) => Inst_MCP3204_fifo_in(15),
      din(14) => Inst_MCP3204_fifo_in(14),
      din(13) => Inst_MCP3204_fifo_in(13),
      din(12) => Inst_MCP3204_fifo_in(12),
      din(11) => Inst_MCP3204_fifo_in(11),
      din(10) => Inst_MCP3204_fifo_in(10),
      din(9) => Inst_MCP3204_fifo_in(9),
      din(8) => Inst_MCP3204_fifo_in(8),
      din(7) => Inst_MCP3204_fifo_in(7),
      din(6) => Inst_MCP3204_fifo_in(6),
      din(5) => Inst_MCP3204_fifo_in(5),
      din(4) => Inst_MCP3204_fifo_in(4),
      din(3) => Inst_MCP3204_fifo_in(3),
      din(2) => Inst_MCP3204_fifo_in(2),
      din(1) => Inst_MCP3204_fifo_in(1),
      din(0) => Inst_MCP3204_fifo_in(0),
      dout(23) => audio_fifo_data(23),
      dout(22) => audio_fifo_data(22),
      dout(21) => audio_fifo_data(21),
      dout(20) => audio_fifo_data(20),
      dout(19) => audio_fifo_data(19),
      dout(18) => audio_fifo_data(18),
      dout(17) => audio_fifo_data(17),
      dout(16) => audio_fifo_data(16),
      dout(15) => audio_fifo_data(15),
      dout(14) => audio_fifo_data(14),
      dout(13) => audio_fifo_data(13),
      dout(12) => audio_fifo_data(12),
      dout(11) => audio_fifo_data(11),
      dout(10) => audio_fifo_data(10),
      dout(9) => audio_fifo_data(9),
      dout(8) => audio_fifo_data(8),
      dout(7) => audio_fifo_data(7),
      dout(6) => audio_fifo_data(6),
      dout(5) => audio_fifo_data(5),
      dout(4) => audio_fifo_data(4),
      dout(3) => audio_fifo_data(3),
      dout(2) => audio_fifo_data(2),
      dout(1) => audio_fifo_data(1),
      dout(0) => audio_fifo_data(0)
    );

end Structure;

-- synthesis translate_on
