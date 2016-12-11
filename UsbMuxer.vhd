----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:12:46 10/13/2016 
-- Design Name: 
-- Module Name:    UsbMuxer - Behavioral 
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
use IEEE.std_logic_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UsbMuxer is
    Port 
    (
        reset : in std_logic;

        usb_clk : in  std_logic;
        rxf : in  std_logic;
        txe : in  std_logic;
        adbus : inout  std_logic_vector (7 downto 0);
        rd : out  std_logic;
        wr : out  std_logic;
        siwu : out  std_logic;

        ldr : in std_logic_vector (5 downto 0);
        ldg : in std_logic_vector (5 downto 0);
        ldb : in std_logic_vector (5 downto 0);
        dclk : in std_logic;
        vsync : in std_logic;

        spi_clk : out std_logic;
        spi_dout : out std_logic;
        spi_cs : out std_logic;
        spi_din : in std_logic;

        leds : out std_logic_vector (3 downto 0)
    );
end UsbMuxer;

architecture Behavioral of UsbMuxer is
    COMPONENT VideoInterface
        PORT
        (
            i_ldr : in std_logic_vector (5 downto 0);
            i_ldg : in std_logic_vector (5 downto 0);
            i_ldb : in std_logic_vector (5 downto 0);
            i_dclk : in std_logic;
            i_vsync : in std_logic;
            i_rst : in std_logic;
            i_usb_clk : in std_logic;
            i_usb_rd : in std_logic;          
            o_usb_empty : out std_logic;
            o_usb_data : out std_logic_vector (31 downto 0)
        );
    END COMPONENT;
    COMPONENT MCP3204_Interface
        PORT
        (
            iRST : in std_logic;
            iUSB_CLK : in std_logic;
            iRD : in std_logic;
            iDin : in std_logic;          
            oDATA : out std_logic_vector (31 downto 0);
            oEMPTY : out std_logic;
            oSPI_CLK : out std_logic;
            oCS : out std_logic;
            oDout : out std_logic
        );
    END COMPONENT;
    COMPONENT usb_buffer
        PORT
        (
            rst : IN std_logic;
            wr_clk : IN std_logic;
            rd_clk : IN std_logic;
            din : IN std_logic_vector(7 downto 0);
            wr_en : IN std_logic;
            rd_en : IN std_logic;          
            dout : OUT std_logic_vector(7 downto 0);
            full : OUT std_logic;
            empty : OUT std_logic
        );
    END COMPONENT;

    -- video
    signal video_fifo_empty : std_logic;
    signal video_fifo_data : std_logic_vector (31 downto 0);
    signal video_fifo_rd : std_logic := '0';
    signal video_interface_clk : std_logic;

    -- audio
    signal audio_fifo_empty : std_logic;
    signal audio_fifo_data : std_logic_vector (31 downto 0);
    signal audio_fifo_rd : std_logic := '0';
    signal audio_interface_clk : std_logic;

    -- usb
    signal usb_fifo_din : std_logic_vector (7 downto 0) := "00000000";
    signal usb_fifo_wr_en : std_logic := '0';
    signal usb_fifo_full : std_logic;
    signal usb_fifo_dout : std_logic_vector (7 downto 0);
    signal usb_fifo_rd_en : std_logic;
    signal usb_fifo_empty : std_logic;
    signal usb_fifo_rd_clk : std_logic;
    signal usb_fifo_wr_clk : std_logic;

    signal usb_fifo_delayed_empty : std_logic;

    -- etc
    type transfer_type is (Audio, Video);
    signal pump_type : transfer_type := Audio;
    type transfer_index is (VeryUpperByte, UpperByte, LowerByte, VeryLowByte);
    signal pump_index : transfer_index := VeryUpperByte;

    -- usb state
    signal write_state_1 : std_logic := '0';
    signal write_state_2 : std_logic := '0';
begin
    Inst_Video: VideoInterface PORT MAP
    (
        i_ldr => ldr,
        i_ldg => ldg,
        i_ldb => ldb,
        i_dclk => dclk,
        i_vsync => vsync,
        i_rst => reset,
        o_usb_empty => video_fifo_empty,
        i_usb_clk => video_interface_clk,
        o_usb_data => video_fifo_data,
        i_usb_rd => video_fifo_rd
    );
    Inst_MCP3204: MCP3204_Interface PORT MAP
    (
        iRST => reset,
        oDATA => audio_fifo_data,
        iUSB_CLK => audio_interface_clk,
        iRD => audio_fifo_rd,
        oEMPTY => audio_fifo_empty,
        oSPI_CLK => spi_clk,
        oCS => spi_cs,
        oDout => spi_dout,
        iDin => spi_din
    );
    Inst_usb_buffer: usb_buffer PORT MAP
    (
        wr_clk => usb_fifo_wr_clk,
        rd_clk => usb_fifo_rd_clk,
        rst => reset,
        din => usb_fifo_din,
        wr_en => usb_fifo_wr_en,
        rd_en => usb_fifo_rd_en,
        dout => usb_fifo_dout,
        full => usb_fifo_full,
        empty => usb_fifo_empty
    );
    rd <= '1';
    siwu <= '1';

    leds(0) <= spi_din;
    leds(1) <= '0';
    leds(2) <= txe;
    leds(3) <= rxf;

    audio_interface_clk <= usb_clk;
    video_interface_clk <= usb_clk;
    usb_fifo_rd_clk <= usb_clk;
    usb_fifo_wr_clk <= usb_clk;

    muxer: process (usb_clk, reset)
    begin
        if (reset = '1') then
            audio_fifo_rd <= '0';
            video_fifo_rd <= '0';
            pump_index <= VeryUpperByte;
            pump_type <= Audio;
            usb_fifo_din <= "00000000";
            usb_fifo_wr_en <= '0';
        else
            if (falling_edge(usb_clk)) then
                if (usb_fifo_full = '0') then
                    case pump_index is
                        when VeryUpperByte =>
                            video_fifo_rd <= '0';
                            audio_fifo_rd <= '0';
                            if (audio_fifo_empty = '0') then
                                pump_type <= Audio;
                                pump_index <= UpperByte;
                                usb_fifo_din <= audio_fifo_data (31 downto 24);
                                usb_fifo_wr_en <= '1';
                            elsif (video_fifo_empty = '0') then
                                pump_type <= Video;
                                pump_index <= UpperByte;
                                usb_fifo_din <= video_fifo_data (31 downto 24);
                                usb_fifo_wr_en <= '1';
                            else
                                usb_fifo_din <= "00000000";
                                usb_fifo_wr_en <= '0';
                            end if;
                        when UpperByte =>
                            video_fifo_rd <= '0';
                            audio_fifo_rd <= '0';
                            if (pump_type = Audio) then
                                pump_index <= LowerByte;
                                usb_fifo_din <= audio_fifo_data (23 downto 16);
                                usb_fifo_wr_en <= '1';
                            else
                                pump_index <= LowerByte;
                                usb_fifo_din <= video_fifo_data (23 downto 16);
                                usb_fifo_wr_en <= '1';
                            end if;
                        when LowerByte =>
                            video_fifo_rd <= '0';
                            audio_fifo_rd <= '0';
                            if (pump_type = Audio) then
                                pump_index <= VeryLowByte;
                                usb_fifo_din <= audio_fifo_data (15 downto 8);
                                usb_fifo_wr_en <= '1';
                            else
                                pump_index <= VeryLowByte;
                                usb_fifo_din <= video_fifo_data (15 downto 8);
                                usb_fifo_wr_en <= '1';
                            end if;
                        when VeryLowByte =>
                            if (pump_type = Audio) then
                                pump_index <= VeryUpperByte;
                                usb_fifo_din <= audio_fifo_data (7 downto 0);
                                usb_fifo_wr_en <= '1';

                                video_fifo_rd <= '0';
                                audio_fifo_rd <= '1';
                            else
                                pump_index <= VeryUpperByte;
                                usb_fifo_din <= video_fifo_data (7 downto 0);
                                usb_fifo_wr_en <= '1';

                                video_fifo_rd <= '1';
                                audio_fifo_rd <= '0';
                            end if;
                    end case;
                else
                    video_fifo_rd <= '0';
                    audio_fifo_rd <= '0';
                    usb_fifo_wr_en <= '0';
                end if;
            end if; -- end if usb_clk edge
        end if;
    end process;

    usb_fifo_delayed_empty <= transport usb_fifo_empty after 2 ns;

    usb_fifo_rd_en <= '1' when (usb_fifo_delayed_empty = '0') and 
            (txe = '0') and (write_state_1 = '1') and
            (write_state_2 = '1') else '0';

    adbus <= usb_fifo_dout;
    wr <= '0' when (usb_fifo_empty = '0') and 
            (txe = '0') and (write_state_1 = '1') and
            (write_state_2 = '1') else '1';

    usb_writer : process (usb_clk, reset)
    begin
        if (reset = '1') then
        else
            if (rising_edge(usb_clk)) then
                if (txe = '0') then
                    if (write_state_1 = '1') then
                        write_state_2 <= '1';
                    else
                        write_state_1 <= '1';
                    end if;
                else
                    write_state_1 <= '0';
                    write_state_2 <= '0';
                end if;
            end if;
        end if;
    end process;
end Behavioral;

