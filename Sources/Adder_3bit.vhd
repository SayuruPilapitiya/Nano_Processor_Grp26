----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 04:22:21 PM
-- Design Name: 
-- Module Name: Adder_3bit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 3-bit adder for Program Counter increment (PC+1)
--              Natural wrap-around: 111 + 1 = 000
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

entity Adder_3bit is
    Port (
        A   : in  STD_LOGIC_VECTOR (2 downto 0);
        Sum : out STD_LOGIC_VECTOR (2 downto 0)
    );
end Adder_3bit;

architecture Behavioral of Adder_3bit is
begin
    Sum <= std_logic_vector(unsigned(A) + 1);
end Behavioral;
