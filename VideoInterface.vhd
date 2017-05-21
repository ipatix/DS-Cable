----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:30:53 10/10/2016 
-- Design Name: 
-- Module Name:    VideoInterface - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VideoInterface is
    Port 
    (
        i_ldr : in  std_logic_vector (5 downto 0);
        i_ldg : in  std_logic_vector (5 downto 0);
        i_ldb : in  std_logic_vector (5 downto 0);
        i_dclk : in  std_logic;
        i_vsync : in  std_logic;

        i_rst : in std_logic;
        o_usb_empty : out std_logic;
        i_usb_clk : in std_logic;
        o_usb_data : out std_logic_vector (31 downto 0);
        i_usb_rd : in std_logic
    );
end VideoInterface;

architecture Behavioral of VideoInterface is
    -- ***************************************
    COMPONENT scr_fifo
        PORT
        (
            rst : IN std_logic;
            wr_clk : IN std_logic;
            rd_clk : IN std_logic;
            din : IN std_logic_vector(36 downto 0);
            wr_en : IN std_logic;
            rd_en : IN std_logic;          
            dout : OUT std_logic_vector(36 downto 0);
            full : OUT std_logic;
            empty : OUT std_logic
        );
    END COMPONENT;

    -- ***************************************
    COMPONENT video_buffer
        PORT
        (
            clk : IN std_logic;
            rst : IN std_logic;
            din : IN std_logic_vector(19 downto 0);
            wr_en : IN std_logic;
            rd_en : IN std_logic;          
            dout : OUT std_logic_vector(19 downto 0);
            full : OUT std_logic;
            empty : OUT std_logic
        );
    END COMPONENT;
    -- ***************************************
    
    -- lcd input signals
    signal i_ndclk : std_logic;

    -- screen fifo signals
    signal fifo_scr_din : std_logic_vector (36 downto 0) := (others => '0');
    signal fifo_scr_wr_en : std_logic := '0';
    signal fifo_scr_rd_en : std_logic := '0';
    signal fifo_scr_dout : std_logic_vector (36 downto 0);
    signal fifo_scr_full : std_logic;
    signal fifo_scr_empty : std_logic;
    -- video buffer fifo signals
    signal fifo_video_din : std_logic_vector (19 downto 0) := (others => '0');
    signal fifo_video_wr_en : std_logic := '0';
    signal fifo_video_rd_en : std_logic;
    signal fifo_video_dout : std_logic_vector (19 downto 0);
    signal fifo_video_full : std_logic;
    signal fifo_video_empty : std_logic;
    -- etc
    signal reset : std_logic;
    signal usb_clk : std_logic;

    signal is_vsync : std_logic := '1';

    signal video_data_final : std_logic_vector (36 downto 0) := (others => '0');
    signal video_data_top : std_logic_vector (18 downto 0) := (others => '0');

    signal is_top : std_logic := '1';
begin
    -- lcd signals
    i_ndclk <= not i_dclk;
    
    -- other signals
    reset <= i_rst;
    usb_clk <= i_usb_clk;

    o_usb_empty <= fifo_video_empty;
    -- o_usb_data <= "110000" & TV & "00" & RRRRRR & "00" & GGGGGG & "00" & BBBBBB
    o_usb_data <= "110000" & fifo_video_dout (19 downto 18) & 
                  "00" & fifo_video_dout (17 downto 12) &
                  "00" & fifo_video_dout (11 downto 6) &
                  "00" & fifo_video_dout (5 downto 0);
    fifo_video_rd_en <= i_usb_rd;


    -- ***************************************
    Inst_scr_fifo: scr_fifo PORT MAP 
    (
        rst => reset,
        wr_clk => i_ndclk,
        rd_clk => usb_clk,
        din => fifo_scr_din,
        wr_en => fifo_scr_wr_en,
        rd_en => fifo_scr_rd_en,
        dout => fifo_scr_dout,
        full => fifo_scr_full,
        empty => fifo_scr_empty
    );
    -- ***************************************
    Inst_video_buffer: video_buffer PORT MAP 
    (
        clk => usb_clk,
        rst => reset,
        din => fifo_video_din,
        wr_en => fifo_video_wr_en,
        rd_en => fifo_video_rd_en,
        dout => fifo_video_dout,
        full => fifo_video_full,
        empty => fifo_video_empty
    );
    -- ***************************************
    -- DS interface process
    process (i_ndclk, i_vsync, reset, usb_clk)
    begin
        if (reset = '1') then
            is_top <= '1';
            is_vsync <= '1';
            video_data_top <= (others => '0');
            video_data_final <= (others => '0');
            fifo_scr_din <= (others => '0');
            fifo_scr_wr_en <= '0';
            fifo_scr_rd_en <= '0';
            fifo_video_din <= (others => '0');
            fifo_video_wr_en <= '0';
        else
            -- added not for inverted input
            if (not i_vsync = '0') then
                is_vsync <= '1';
            else
                if (falling_edge(i_ndclk)) then
                -- step 1
                    -- not added for inverted inputs
                    video_data_top <= is_vsync & not (i_ldr & i_ldg & i_ldb);
                    is_vsync <= '0';
                -- step 3
                    fifo_scr_din <= video_data_final;
                    if (fifo_scr_full = '0') then
                        fifo_scr_wr_en <= '1';
                    else
                        fifo_scr_wr_en <= '0';
                    end if;
                end if;
                if (rising_edge(i_ndclk)) then
                -- step 2
                    -- not added for inverted inputs
                    video_data_final <= video_data_top & not (i_ldr & i_ldg & i_ldb);
                end if;
            end if;
            if (falling_edge(usb_clk)) then
                if ((fifo_video_full = '0') and (fifo_scr_empty = '0')) then
                    if (is_top = '0') then
                        fifo_video_din <= "1" & fifo_scr_dout (36 downto 18);
                        fifo_scr_rd_en <= '0';
                        fifo_video_wr_en <= '1';
                        is_top <= '1';
                    else
                        fifo_video_din <= "00" & fifo_scr_dout (17 downto 0);
                        fifo_scr_rd_en <= '1';
                        fifo_video_wr_en <= '1';
                        is_top <= '0';
                    end if;
                else
                    fifo_scr_rd_en <= '0';
                    fifo_video_wr_en <= '0';
                end if;
            end if;
        end if;
    end process;
end Behavioral;
