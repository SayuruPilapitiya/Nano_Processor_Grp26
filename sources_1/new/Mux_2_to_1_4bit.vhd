----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 06:02:10 PM
-- Design Name: 
-- Module Name: Mux_2_to_1_4bit - Behavioral
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

entity Mux_2_to_1_4bit is
    Port ( 
        D0  : in  STD_LOGIC_VECTOR (3 downto 0); -- Add/Sub output
        D1  : in  STD_LOGIC_VECTOR (3 downto 0); -- Immediate Value
        Sel : in  STD_LOGIC;
        Y   : out STD_LOGIC_VECTOR (3 downto 0)
    );
end Mux_2_to_1_4bit;

architecture Behavioral of Mux_2_to_1_4bit is
begin
    with Sel select
        Y <= D0 when '0',
             D1 when '1',
             "0000" when others;
end Behavioral;