--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:50:15 10/04/2016
-- Design Name:   
-- Module Name:   /home/michael/Xilinx/DSCable/MCP3204_Interface_TB.vhd
-- Project Name:  DSCable
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MCP3204_Interface
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

ENTITY MCP3204_Interface_TB IS
    END MCP3204_Interface_TB;

ARCHITECTURE behavior OF MCP3204_Interface_TB IS 

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT MCP3204_Interface
        PORT(
                iRST : IN  std_logic;
                oDATA : OUT  std_logic_vector(31 downto 0);
                iUSB_CLK : IN  std_logic;
                iRD : IN  std_logic;
                oEMPTY : OUT  std_logic;
                oSPI_CLK : OUT  std_logic;
                oCS : OUT  std_logic;
                oDOUT : OUT  std_logic;
                iDIN : IN  std_logic
            );
    END COMPONENT;


   --Inputs
    signal iRST : std_logic := '0';
    signal iUSB_CLK : std_logic := '0';
    signal iRD : std_logic := '0';
    signal iDIN : std_logic := '1';

   --Outputs
    signal oDATA : std_logic_vector(31 downto 0);
    signal oEMPTY : std_logic;
    signal oSPI_CLK : std_logic;
    signal oCS : std_logic;
    signal oDOUT : std_logic;

   -- Clock period definitions
    constant iUSB_CLK_period : time := 16 ns;

BEGIN

   -- Instantiate the Unit Under Test (UUT)
    uut: MCP3204_Interface PORT MAP (
                                        iRST => iRST,
                                        oDATA => oDATA,
                                        iUSB_CLK => iUSB_CLK,
                                        iRD => iRD,
                                        oEMPTY => oEMPTY,
                                        oSPI_CLK => oSPI_CLK,
                                        oCS => oCS,
                                        oDOUT => oDOUT,
                                        iDIN => iDIN
                                    );

   -- Clock process definitions
    iUSB_CLK_process :process
    begin
        iUSB_CLK <= '0';
        wait for iUSB_CLK_period/2;
        iUSB_CLK <= '1';
        wait for iUSB_CLK_period/2;
    end process;

   -- Stimulus process
    stim_proc: process
    begin
      -- hold reset state for 100 ns.
        irst <= '1';
        wait for 100 ns;
        irst <= '0';
        
        wait for 2000*iUSB_CLK_period;

        wait;
    end process;

END;
