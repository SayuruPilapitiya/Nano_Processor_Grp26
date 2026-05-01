----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/28/2026 07:29:44 AM
-- Design Name: 
-- Module Name: Slow_Clock - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Slow_Clock is
    Port ( 
        Clk_in  : in  STD_LOGIC; -- 100 MHz physical clock from the board
        Clk_out : out STD_LOGIC  -- Slowed down clock for your processor
    );
end Slow_Clock;

architecture Behavioral of Slow_Clock is

    -- 100 MHz = 100,000,000 clock cycles per second.
    -- To toggle the clock every 1 second (creating a 2-second full cycle),
    -- we count to 100,000,000. 
    constant MAX_COUNT : integer := 100000000;
    signal count       : integer range 1 to MAX_COUNT := 1;
    signal clk_status  : std_logic := '0';

begin

    process (Clk_in)
    begin
        if rising_edge(Clk_in) then
            count <= count + 1;
            
            if (count = MAX_COUNT) then
                clk_status <= not clk_status; -- Flip the signal
                count <= 1;                   -- Reset the counter
            end if;
        end if;
    end process;
    
    Clk_out <= clk_status;

end Behavioral;
