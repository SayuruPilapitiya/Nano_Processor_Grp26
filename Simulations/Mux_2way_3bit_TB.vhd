----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 10:07:39 PM
-- Design Name: 
-- Module Name: Mux_2way_3bit_TB - Behavioral
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

entity Mux_2way_3bit_TB is
end Mux_2way_3bit_TB;

architecture Behavioral of Mux_2way_3bit_TB is
    signal a, b, y : STD_LOGIC_VECTOR(2 downto 0);
    signal sel : STD_LOGIC;
begin
    uut: entity work.Mux_2way_3bit port map (A => a, B => b, Sel => sel, Y => y);
    
    stim: process
    begin
        a <= "001"; b <= "101"; sel <= '0'; wait for 10 ns;  -- y=001
        sel <= '1'; wait for 10 ns;  -- y=101
        a <= "111"; b <= "000"; sel <= '0'; wait for 10 ns;  -- y=111
        sel <= '1'; wait for 10 ns;  -- y=000
        a <= "010"; b <= "110"; sel <= '0'; wait for 10 ns;
        sel <= '1'; wait for 10 ns;
        wait;
    end process;
end Behavioral;