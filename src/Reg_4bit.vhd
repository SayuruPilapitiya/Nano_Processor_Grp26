----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 05:42:09 PM
-- Design Name: 
-- Module Name: Reg_4bit - Behavioral
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

entity Reg_4bit is
    Port ( 
        D     : in  STD_LOGIC_VECTOR (3 downto 0);
        En    : in  STD_LOGIC; -- Enable bit
        Clk   : in  STD_LOGIC;
        Reset : in  STD_LOGIC; -- Asynchronous reset
        Q     : out STD_LOGIC_VECTOR (3 downto 0)
    );
end Reg_4bit;

architecture Behavioral of Reg_4bit is
begin
    process (Clk, Reset)
    begin
        if Reset = '1' then
            Q <= "0000"; -- Clear the register when reset button is pressed
        elsif rising_edge(Clk) then
            if En = '1' then
                Q <= D;  -- Only save new data if Enabled
            end if;
        end if;
    end process;
end Behavioral;
