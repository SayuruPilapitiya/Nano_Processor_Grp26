----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 04:24:15 PM
-- Design Name: 
-- Module Name: Adder_3bit_TB - Behavioral
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

entity Adder_3bit_TB is
end Adder_3bit_TB;

architecture Behavioral of Adder_3bit_TB is
    signal A, Sum : STD_LOGIC_VECTOR(2 downto 0);
begin
    uut: entity work.Adder_3bit port map (A => A, Sum => Sum);
    
    stim: process
    begin
        A <= "000"; wait for 10 ns;  -- 001
        A <= "001"; wait for 10 ns;  -- 010
        A <= "010"; wait for 10 ns;  -- 011
        A <= "011"; wait for 10 ns;  -- 100
        A <= "100"; wait for 10 ns;  -- 101
        A <= "101"; wait for 10 ns;  -- 110
        A <= "110"; wait for 10 ns;  -- 111
        A <= "111"; wait for 10 ns;  -- 000 (wrap)
        wait;
    end process;
end Behavioral;