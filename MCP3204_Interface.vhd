----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:56:38 10/03/2016 
-- Design Name: 
-- Module Name:    MCP3204_Interface - Behavioral 
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

entity MCP3204_Interface is
    Port 
    ( 
        iRST : in STD_LOGIC;
        oDATA : out  STD_LOGIC_VECTOR (31 downto 0);
        iUSB_CLK : in  STD_LOGIC;
        iRD : in  STD_LOGIC;
        oEMPTY : out  STD_LOGIC;
        oSPI_CLK : out  STD_LOGIC;
        oCS : out  STD_LOGIC;
        oDOUT : out  STD_LOGIC; -- from FPGA to ADC
        iDIN : in  STD_LOGIC
    );  -- from ADC to FPGA
end MCP3204_Interface;

architecture Behavioral of MCP3204_Interface is
    COMPONENT adc_buffer
        PORT
        (
            clk : IN std_logic;
            rst : IN std_logic;
            din : IN std_logic_vector(23 downto 0);
            wr_en : IN std_logic;
            rd_en : IN std_logic;          
            dout : OUT std_logic_vector(23 downto 0);
            full : OUT std_logic;
            empty : OUT std_logic
        );
    END COMPONENT;
    
    type SAMPLE_STATE is (
    start_f, start_r, sgl_f, sgl_r, d2_f, d2_r, d1_f, d1_r, d0_f, d0_r, 
    sample_f, sample_r, null_f, null_r, b11_f, b11_r, b10_f, b10_r,
    b9_f, b9_r, b8_f, b8_r, b7_f, b7_r, b6_f, b6_r, b5_f, b5_r, b4_f, b4_r,
    b3_f, b3_r, b2_f, b2_r, b1_f, b1_r, b0_f, b0_r, end_f, end_r);
    signal sample_state_buf : SAMPLE_STATE := start_f;
    type SAMPLE_SIDE is (left, right);
    signal sample_side_buf : SAMPLE_SIDE := left;

    signal fifo_in : std_logic_vector (23 downto 0) := (others => '0');
    signal fifo_out : std_logic_vector (23 downto 0);
    signal fifo_wr_en : std_logic := '0';
    signal fifo_rd_en : std_logic := '0';
    signal fifo_full : std_logic;
    signal fifo_empty : std_logic;
    signal fifo_clk : std_logic;
    signal fifo_rst : std_logic;

    signal sample_idle : std_logic := '1';
    signal sample_counter : integer range 0 to 1250:= 0;
    signal sample_put : std_logic := '0';

    signal sample_val_left : std_logic_vector (11 downto 0) := "000000000000";
    signal sample_val_right : std_logic_vector (11 downto 0) := "000000000000";

    signal spi_clock_counter : integer range 0 to 15 := 0;
    signal spi_clock_buf : std_logic := '1';
    signal spi_cs_buf : std_logic := '1';
    signal spi_dout_buf : std_logic := '1';
    
    signal nspi_clock : std_logic;
    signal nspi_cs : std_logic;
    signal nspi_dout : std_logic;
begin
    Inst_adc_buffer: adc_buffer PORT MAP
    (
        clk => fifo_clk,
        rst => fifo_rst,
        din => fifo_in,
        wr_en => fifo_wr_en,
        rd_en => fifo_rd_en,
        dout => fifo_out,
        full => fifo_full,
        empty => fifo_empty
    );
    
    oSPI_CLK <= nspi_clock;
    oCS <= nspi_cs;
    oDOUT <= nspi_dout;

    nspi_clock <= not spi_clock_buf;
    nspi_cs <= not spi_cs_buf;
    nspi_dout <= not spi_dout_buf;

    oEMPTY <= fifo_empty;
    oDATA <= "10000000" & fifo_out;

    fifo_rd_en <= iRD;
    fifo_clk <= iUSB_CLK;
    fifo_rst <= iRST;

    process (iUSB_CLK, iRST)
    begin
        if (iRST = '1') then
            sample_state_buf <= start_f;
            sample_side_buf <= left;
            fifo_wr_en <= '0';
            sample_counter <= 0;
            spi_clock_counter <= 0;
            sample_idle <= '1';
            sample_put <= '0';
        else
            if (falling_edge(iUSB_CLK)) then
                if (sample_counter = 0) then
                    -- new sample to be fetched every 48000th second
                    sample_counter <= (1250 - 1);
                    sample_state_buf <= start_f;
                    sample_side_buf <= left;
                    sample_idle <= '0';
                else
                    sample_counter <= sample_counter - 1;
                end if;

                if (sample_put = '1') then
                    fifo_wr_en <= '0';
                    sample_put <= '0';
                end if;

                if (sample_idle = '0') then
                    -- sampling phase not idle, let's count down the SPI clock
                    if (spi_clock_counter > 0) then
                        spi_clock_counter <= spi_clock_counter - 1;
                    else
                        spi_clock_counter <= (15 - 1);
                        -- do the actual work that is supposed to get done each spi flank
                        case sample_state_buf is
                            when start_f => -- falling edge
                                spi_clock_buf <= '0';
                                spi_cs_buf <= '0';
                                spi_dout_buf <= '1';
                                sample_state_buf <= start_r;
                            when start_r => -- rising edge
                                spi_clock_buf <= '1';
                                sample_state_buf <= sgl_f;
                            when sgl_f =>
                                spi_clock_buf <= '0';
                                spi_dout_buf <= '1';
                                sample_state_buf <= sgl_r;
                            when sgl_r =>
                                spi_clock_buf <= '1';
                                sample_state_buf <= d2_f;
                            when d2_f =>
                                spi_clock_buf <= '0';
                                spi_dout_buf <= '0';
                                sample_state_buf <= d2_r;
                            when d2_r =>
                                spi_clock_buf <= '1';
                                sample_state_buf <= d1_f;
                            when d1_f => 
                                spi_clock_buf <= '0';
                                spi_dout_buf <= '0';
                                sample_state_buf <= d1_r;
                            when d1_r =>
                                spi_clock_buf <= '1';
                                sample_state_buf <= d0_f;
                            when d0_f => 
                                spi_clock_buf <= '0';
                                if (sample_side_buf = left) then
                                    spi_dout_buf <= '0';
                                else
                                    spi_dout_buf <= '1';
                                end if;
                                sample_state_buf <= d0_r;
                            when d0_r => 
                                spi_clock_buf <= '1';
                                sample_state_buf <= sample_f;
                            when sample_f => 
                                spi_clock_buf <= '0';
                                spi_dout_buf <= '1';
                                sample_state_buf <= sample_r;
                            when sample_r => 
                                spi_clock_buf <= '1';
                                sample_state_buf <= null_f;
                            when null_f => 
                                spi_clock_buf <= '0';
                                sample_state_buf <= null_r;
                            when null_r => 
                                spi_clock_buf <= '1';
                                sample_state_buf <= b11_f;
                            when b11_f =>
                                spi_clock_buf <= '0';
                                sample_state_buf <= b11_r;
                            when b11_r => 
                                spi_clock_buf <= '1';
                                if (sample_side_buf = left) then
                                    -- added not for inverted input
                                    sample_val_left <= sample_val_left (10 downto 0) & not iDIN;
                                else
                                    sample_val_right <= sample_val_right (10 downto 0) & not iDIN;
                                end if;
                                sample_state_buf <= b10_f;
                            when b10_f => 
                                spi_clock_buf <= '0';
                                sample_state_buf <= b10_r;
                            when b10_r =>
                                spi_clock_buf <= '1';
                                if (sample_side_buf = left) then
                                    sample_val_left <= sample_val_left (10 downto 0) & not iDIN;
                                else
                                    sample_val_right <= sample_val_right (10 downto 0) & not iDIN;
                                end if;
                                sample_state_buf <= b9_f;
                            when b9_f =>
                                spi_clock_buf <= '0';
                                sample_state_buf <= b9_r;
                            when b9_r => 
                                spi_clock_buf <= '1';
                                if (sample_side_buf = left) then
                                    sample_val_left <= sample_val_left (10 downto 0) & not iDIN;
                                else
                                    sample_val_right <= sample_val_right (10 downto 0) & not iDIN;
                                end if;
                                sample_state_buf <= b8_f;
                            when b8_f =>
                                spi_clock_buf <= '0';
                                sample_state_buf <= b8_r;
                            when b8_r =>
                                spi_clock_buf <= '1';
                                if (sample_side_buf = left) then
                                    sample_val_left <= sample_val_left (10 downto 0) & not iDIN;
                                else
                                    sample_val_right <= sample_val_right (10 downto 0) & not iDIN;
                                end if;
                                sample_state_buf <= b7_f;
                            when b7_f =>
                                spi_clock_buf <= '0';
                                sample_state_buf <= b7_r;
                            when b7_r =>
                                spi_clock_buf <= '1';
                                if (sample_side_buf = left) then
                                    sample_val_left <= sample_val_left (10 downto 0) & not iDIN;
                                else
                                    sample_val_right <= sample_val_right (10 downto 0) & not iDIN;
                                end if;
                                sample_state_buf <= b6_f;
                            when b6_f =>
                                spi_clock_buf <= '0';
                                sample_state_buf <= b6_r;
                            when b6_r =>
                                spi_clock_buf <= '1';
                                if (sample_side_buf = left) then
                                    sample_val_left <= sample_val_left (10 downto 0) & not iDIN;
                                else
                                    sample_val_right <= sample_val_right (10 downto 0) & not iDIN;
                                end if;
                                sample_state_buf <= b5_f;
                            when b5_f =>
                                spi_clock_buf <= '0';
                                sample_state_buf <= b5_r;
                            when b5_r =>
                                spi_clock_buf <= '1';
                                if (sample_side_buf = left) then
                                    sample_val_left <= sample_val_left (10 downto 0) & not iDIN;
                                else
                                    sample_val_right <= sample_val_right (10 downto 0) & not iDIN;
                                end if;
                                sample_state_buf <= b4_f;
                            when b4_f =>
                                spi_clock_buf <= '0';
                                sample_state_buf <= b4_r;
                            when b4_r =>
                                spi_clock_buf <= '1';
                                if (sample_side_buf = left) then
                                    sample_val_left <= sample_val_left (10 downto 0) & not iDIN;
                                else
                                    sample_val_right <= sample_val_right (10 downto 0) & not iDIN;
                                end if;
                                sample_state_buf <= b3_f;
                            when b3_f =>
                                spi_clock_buf <= '0';
                                sample_state_buf <= b3_r;
                            when b3_r =>
                                spi_clock_buf <= '1';
                                if (sample_side_buf = left) then
                                    sample_val_left <= sample_val_left (10 downto 0) & not iDIN;
                                else
                                    sample_val_right <= sample_val_right (10 downto 0) & not iDIN;
                                end if;
                                sample_state_buf <= b2_f;
                            when b2_f =>
                                spi_clock_buf <= '0';
                                sample_state_buf <= b2_r;
                            when b2_r =>
                                spi_clock_buf <= '1';
                                if (sample_side_buf = left) then
                                    sample_val_left <= sample_val_left (10 downto 0) & not iDIN;
                                else
                                    sample_val_right <= sample_val_right (10 downto 0) & not iDIN;
                                end if;
                                sample_state_buf <= b1_f;
                            when b1_f =>
                                spi_clock_buf <= '0';
                                sample_state_buf <= b1_r;
                            when b1_r =>
                                spi_clock_buf <= '1';
                                if (sample_side_buf = left) then
                                    sample_val_left <= sample_val_left (10 downto 0) & not iDIN;
                                else
                                    sample_val_right <= sample_val_right (10 downto 0) & not iDIN;
                                end if;
                                sample_state_buf <= b0_f;
                            when b0_f =>
                                spi_clock_buf <= '0';
                                sample_state_buf <= b0_r;
                            when b0_r =>
                                spi_clock_buf <= '1';
                                if (sample_side_buf = left) then
                                    sample_val_left <= sample_val_left (10 downto 0) & not iDIN;
                                else
                                    sample_val_right <= sample_val_right (10 downto 0) & not iDIN;
                                end if;
                                sample_state_buf <= end_f;
                            when end_f =>
                                spi_clock_buf <= '0';
                                spi_cs_buf <= '1';
                                sample_state_buf <= end_r;
                            when end_r =>
                                spi_clock_buf <= '1';
                                if (sample_side_buf = left) then
                                    sample_side_buf <= right;
                                    sample_state_buf <= start_f;
                                else
                                    sample_idle <= '1';
                                    if (fifo_full = '0') then
                                        sample_put <= '1';
                                        fifo_wr_en <= '1';
                                        fifo_in <= sample_val_left & sample_val_right;
                                    end if;
                                end if;
                        end case;
                    end if;
                end if;
            end if;
        end if;
    end process;
end Behavioral;
