----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:28:36 09/28/2016 
-- Design Name: 
-- Module Name:    USBWriter - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity USBWriter is
    Port ( RESET : in STD_LOGIC;
           RXF : in  STD_LOGIC;
           TXE : in  STD_LOGIC;
           OE : out  STD_LOGIC;
           RD : out  STD_LOGIC;
           WR : out  STD_LOGIC;
           USB_CLK : in STD_LOGIC;
           ADBUS : inout  STD_LOGIC_VECTOR (7 downto 0);
           DEBUG : out  STD_LOGIC_VECTOR (3 downto 0));
end USBWriter;

architecture Behavioral of USBWriter is
    constant BLOCK_COUNT : integer := 4;

    type WRITE_STATE_TYPE is (Idle, Writing, EndWrite, Stall);
    signal write_state : WRITE_STATE_TYPE := Idle;

    signal adbus_buf_master : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    signal adbus_buf_slave : std_logic_vector (7 downto 0) := "ZZZZZZZZ";
    signal writing_master : STD_LOGIC := '0';
    signal writing_slave : STD_LOGIC := '0';

    signal counter : integer range 0 to 7:= 0;
    signal byte_count : integer range 0 to 511:= 0;
    signal delay : integer range 0 to 15:= 0;
begin
    WR <= '0' when (writing_master = '1' and writing_slave = '1') else '1';
    RD <= '1';
    ADBUS <= adbus_buf_slave;
    OE <= '1';

    process (USB_CLK, RESET)
    begin
        if (RESET = '0') then
            write_state <= Idle;
            adbus_buf_master <= "00000000";
            adbus_buf_slave <= "ZZZZZZZZ";
            DEBUG <= "0000";
            counter <= 0;
            writing_master <= '0';
            writing_slave <= '0';
            byte_count <= 0;
            delay <= 0;
        else 
            if (falling_edge(USB_CLK)) then
                writing_slave <= writing_master;
                if (writing_master = '1') then
                    adbus_buf_slave <= adbus_buf_master;
                else
                    adbus_buf_slave <= "ZZZZZZZZ";
                end if;
            end if;
            if (rising_edge(USB_CLK)) then
                DEBUG(0) <= TXE;
                DEBUG(1) <= RXF;
                case write_state is
                    when Idle =>
                        DEBUG(2) <= '0';
                        DEBUG(3) <= '0';
                        if (TXE = '0') then
                            if (delay > 5) then
                                -- 512 data - 2 header bytes - 1 off by
                                byte_count <= (512 - 2 - 1);
                                write_state <= Writing;
                            else
                                delay <= delay + 1;
                            end if;
                        end if;
                    when Writing =>
                        DEBUG(2) <= '1';
                        DEBUG(3) <= '0';
                        if (TXE = '1') then
                            write_state <= Idle;
                            writing_master <= '0';
                        else
                            writing_master <= '1';
                            case counter is
                                when 0 =>
                                    adbus_buf_master <= "00000001";
                                when 1 =>
                                    adbus_buf_master <= "00000010";
                                when 2 =>
                                    adbus_buf_master <= "00000100";
                                when 3 =>
                                    adbus_buf_master <= "00001000";
                                when 4 =>
                                    adbus_buf_master <= "00010000";
                                when 5 =>
                                    adbus_buf_master <= "00100000";
                                when 6 =>
                                    adbus_buf_master <= "01000000";
                                when 7 =>
                                    adbus_buf_master <= "10000000";
                            end case;
                            if (counter = 7) then
                                counter <= 0;
                            else
                                counter <= counter + 1;
                            end if;
                            if (byte_count = 0) then
                                write_state <= EndWrite;
                            else
                                byte_count <= byte_count - 1;
                            end if;
                        end if;
                    when EndWrite =>
                        DEBUG(2) <= '0';
                        DEBUG(3) <= '1';
                        write_state <= Stall;
                    when Stall =>
                        DEBUG(2) <= '1';
                        DEBUG(3) <= '1';
                        writing_master <= '0';
                        if (delay = 0) then
                            write_state <= Idle;
                        else
                            delay <= delay - 1;
                        end if;
                end case;
            end if;
        end if;
    end process;
end Behavioral;
