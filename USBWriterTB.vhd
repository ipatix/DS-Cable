--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:45:19 09/30/2016
-- Design Name:   
-- Module Name:   /home/michael/Xilinx/DSCable/USBWriterTB.vhd
-- Project Name:  DSCable
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: USBWriter
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY USBWriterTB IS
END USBWriterTB;
 
ARCHITECTURE behavior OF USBWriterTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT USBWriter
    PORT(
         RESET : IN  std_logic;
         RXF : IN  std_logic;
         TXE : IN  std_logic;
         OE : OUT  std_logic;
         RD : OUT  std_logic;
         WR : OUT  std_logic;
         USB_CLK : IN  std_logic;
         ADBUS : INOUT  std_logic_vector(7 downto 0);
         DEBUG : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal RESET : std_logic := '1';
   signal RXF : std_logic := '1';
   signal TXE : std_logic := '1';
   signal USB_CLK : std_logic := '0';

	--BiDirs
   signal ADBUS : std_logic_vector(7 downto 0);

 	--Outputs
   signal OE : std_logic;
   signal RD : std_logic;
   signal WR : std_logic;
   signal DEBUG : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant USB_CLK_period : time := 16 ns;
   
   signal internal_signal : STD_LOGIC_VECTOR (7 downto 0) := "11111111";
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: USBWriter PORT MAP (
          RESET => RESET,
          RXF => RXF,
          TXE => TXE,
          OE => OE,
          RD => RD,
          WR => WR,
          USB_CLK => USB_CLK,
          ADBUS => ADBUS,
          DEBUG => DEBUG
        );

   -- Clock process definitions
   USB_CLK_process :process
   begin
		USB_CLK <= '0';
		wait for USB_CLK_period/2;
		USB_CLK <= '1';
		wait for USB_CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 200 ns;	

      -- insert stimulus here
      
      wait until rising_edge(USB_CLK);
      TXE <= '0';
      
      wait until WR = '0';
      
      for I in 0 to 511 loop 
         wait until rising_edge(USB_CLK);
         if (WR = '0') then
            internal_signal <= ADBUS;
         end if;
      end loop;
      wait until falling_edge(USB_CLK);
      TXE <= '1';
      wait until rising_edge(USB_CLK);
      wait until WR = '1';
      
      for i in 0 to 10 loop
          wait until rising_edge(USB_CLK);
      end loop;
      
      TXE <= '0';
      wait until WR = '0';
      
      for I in 0 to 511 loop 
         wait until rising_edge(USB_CLK);
         if (WR = '0') then
            internal_signal <= ADBUS;
         end if;
      end loop;
      
      wait until falling_edge(USB_CLK);
      TXE <= '1';
      wait until rising_edge(USB_CLK);
      wait until WR = '1';
      
      for i in 0 to 10 loop
          wait until rising_edge(USB_CLK);
      end loop;

      wait;
   end process;

END;
