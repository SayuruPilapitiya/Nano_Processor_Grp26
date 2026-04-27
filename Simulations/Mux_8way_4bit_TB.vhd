----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 10:07:39 PM
-- Design Name: 
-- Module Name: Mux_8way_4bit_TB - Behavioral
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

entity Mux_8way_4bit_TB is
end Mux_8way_4bit_TB;

architecture Behavioral of Mux_8way_4bit_TB is
    signal i0, i1, i2, i3, i4, i5, i6, i7, y : STD_LOGIC_VECTOR(3 downto 0);
    signal sel : STD_LOGIC_VECTOR(2 downto 0);
begin
    uut: entity work.Mux_8way_4bit
        port map (Input0 => i0, Input1 => i1, Input2 => i2, Input3 => i3,
                  Input4 => i4, Input5 => i5, Input6 => i6, Input7 => i7,
                  Sel => sel, Y => y);
    
    stim: process
    begin
        i0 <= "0000"; i1 <= "0001"; i2 <= "0010"; i3 <= "0011";
        i4 <= "0100"; i5 <= "0101"; i6 <= "0110"; i7 <= "0111";
        sel <= "000"; wait for 10 ns;  -- y=0000
        sel <= "001"; wait for 10 ns;  -- y=0001
        sel <= "010"; wait for 10 ns;  -- y=0010
        sel <= "011"; wait for 10 ns;  -- y=0011
        sel <= "100"; wait for 10 ns;  -- y=0100
        sel <= "101"; wait for 10 ns;  -- y=0101
        sel <= "110"; wait for 10 ns;  -- y=0110
        sel <= "111"; wait for 10 ns;  -- y=0111
        wait;
    end process;
end Behavioral;