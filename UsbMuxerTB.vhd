--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:07:58 10/18/2016
-- Design Name:   
-- Module Name:   /home/michael/Xilinx/DSCable/UsbMuxerTB.vhd
-- Project Name:  DSCable
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: UsbMuxer
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

ENTITY UsbMuxerTB IS
    END UsbMuxerTB;

ARCHITECTURE behavior OF UsbMuxerTB IS 

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT UsbMuxer
        PORT
        (
            reset : IN  std_logic;
            usb_clk : IN  std_logic;
            rxf : IN  std_logic;
            txe : IN  std_logic;
            adbus : INOUT  std_logic_vector(7 downto 0);
            rd : OUT  std_logic;
            wr : OUT  std_logic;
            siwu : OUT  std_logic;
            ldr : IN  std_logic_vector(5 downto 0);
            ldg : IN  std_logic_vector(5 downto 0);
            ldb : IN  std_logic_vector(5 downto 0);
            dclk : IN  std_logic;
            vsync : IN  std_logic;
            spi_clk : OUT  std_logic;
            spi_dout : OUT  std_logic;
            spi_cs : OUT  std_logic;
            spi_din : IN  std_logic;
            leds : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;


    --Inputs
    signal reset : std_logic := '0';
    signal usb_clk : std_logic := '0';
    signal rxf : std_logic := '1';
    signal txe : std_logic := '1';
    signal ldr : std_logic_vector(5 downto 0) := (others => '0');
    signal ldg : std_logic_vector(5 downto 0) := (others => '0');
    signal ldb : std_logic_vector(5 downto 0) := (others => '0');
    signal dclk : std_logic := '1';
    signal vsync : std_logic := '1';
    signal spi_din : std_logic := '1';

    --BiDirs
    signal adbus : std_logic_vector(7 downto 0):= "ZZZZZZZZ";

    --Outputs
    signal rd : std_logic;
    signal wr : std_logic;
    signal siwu : std_logic;
    signal spi_clk : std_logic;
    signal spi_dout : std_logic;
    signal spi_cs : std_logic;
    signal leds : std_logic_vector(3 downto 0);

    -- Clock period definitions
    constant usb_clk_period : time := 16 ns;
    constant dclk_period : time := 200 ns;

    -- etc
    signal internal_signal : std_logic_vector(7 downto 0) := "00000000";
    signal dummy_video : std_logic_vector(17 downto 0) := (others => '0');
BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: UsbMuxer PORT MAP 
    (
        reset => reset,
        usb_clk => usb_clk,
        rxf => rxf,
        txe => txe,
        adbus => adbus,
        rd => rd,
        wr => wr,
        siwu => siwu,
        ldr => ldr,
        ldg => ldg,
        ldb => ldb,
        dclk => dclk,
        vsync => vsync,
        spi_clk => spi_clk,
        spi_dout => spi_dout,
        spi_cs => spi_cs,
        spi_din => spi_din,
        leds => leds
    );
    
    process (spi_clk)
    begin
        if (falling_edge(spi_clk)) then
            spi_din <= '1';
        end if;
    end process;

    -- Clock process definitions
    usb_clk_process :process
    begin
        usb_clk <= '0';
        wait for usb_clk_period/2;
        usb_clk <= '1';
        wait for usb_clk_period/2;
    end process;

    dclk_process :process
    begin
        dclk <= '0';
        wait for dclk_period/2;
        dclk <= '1';
        wait for dclk_period/2;
    end process;
    
    video_proc: process
    begin
        while (true) loop
            wait until rising_edge(dclk);
            wait for 50 ns;
            dummy_video <= std_logic_vector(to_unsigned(
                    to_integer(unsigned(dummy_video) + 1), 18));
            --ldr <= dummy_video (5 downto 0);
            --ldg <= dummy_video (11 downto 6);
            --ldb <= dummy_video (17 downto 12);
            ldr <= "111111";
            ldg <= "111111";
            ldb <= "111111";
            wait until falling_edge(dclk);
            wait for 50 ns;
            dummy_video <= std_logic_vector(to_unsigned(
                    to_integer(unsigned(dummy_video) + 1), 18));
            --ldr <= dummy_video (5 downto 0);
            --ldg <= dummy_video (11 downto 6);
            --ldb <= dummy_video (17 downto 12);
            ldr <= "111111";
            ldg <= "111111";
            ldb <= "111111";
        end loop;
    end process;

    -- Stimulus process
    stim_proc: process
    begin		
        -- hold reset state for 100 ns.
        wait for 100 ns;	

        wait for usb_clk_period*10;

        -- insert stimulus here

        wait until rising_edge(usb_clk);
        txe <= '0';

        for I in 0 to 510 loop
            wait until rising_edge(usb_clk);
            if (wr = '0') then
                internal_signal <= adbus;
            end if;
        end loop;
        
        txe <= '1';
        for I in 0 to 100 loop
            wait until rising_edge(usb_clk);
        end loop;

        txe <= '0';
        for I in 0 to 3000 loop
            wait until rising_edge(usb_clk);
            if (wr = '0') then
                internal_signal <= adbus;
            end if;
        end loop;

        wait;
    end process;

END;
