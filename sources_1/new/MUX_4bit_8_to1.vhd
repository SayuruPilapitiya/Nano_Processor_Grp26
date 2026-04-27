----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2026 04:58:01 PM
-- Design Name: 
-- Module Name: MUX_4bit_8_to1 - Behavioral
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

entity MUX_4bit_8_to1 is
    Port ( B1 : in STD_LOGIC_VECTOR (3 downto 0);
           B2 : in STD_LOGIC_VECTOR (3 downto 0);
           Bus_Sel : in STD_LOGIC_VECTOR (2 downto 0);
           B_Out : out STD_LOGIC_VECTOR (3 downto 0));
end MUX_4bit_8_to1;

architecture Behavioral of MUX_4bit_8_to1 is

begin


end Behavioral;
