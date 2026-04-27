----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/23/2026 01:46:52 PM
-- Design Name: 
-- Module Name: Reg_3bit_Rising - Behavioral
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

entity Reg_3bit_Rising is
    Port ( Clk : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (11 downto 0);
           Res : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (11 downto 0));
end Reg_3bit_Rising;

architecture Behavioral of Reg_3bit_Rising is

begin


end Behavioral;
