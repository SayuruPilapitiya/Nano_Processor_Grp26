----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 10:07:39 PM
-- Design Name: 
-- Module Name: ROM_Program_TB - Behavioral
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

entity ROM_Program_TB is
end ROM_Program_TB;

architecture Behavioral of ROM_Program_TB is
    signal address : STD_LOGIC_VECTOR(2 downto 0);
    signal instruction : STD_LOGIC_VECTOR(11 downto 0);
begin
    uut: entity work.ROM_Program port map (Address => address, Instruction => instruction);
    
    stim: process
    begin
        address <= "000"; wait for 10 ns;  -- MOVI R7,0 ? 101110000000
        address <= "001"; wait for 10 ns;  -- MOVI R1,1 ? 100010000001
        address <= "010"; wait for 10 ns;  -- ADD R7,R1 ? 001110010000
        address <= "011"; wait for 10 ns;  -- MOVI R1,2 ? 100010000010
        address <= "100"; wait for 10 ns;  -- ADD R7,R1 ? 001110010000
        address <= "101"; wait for 10 ns;  -- MOVI R1,3 ? 100010000011
        address <= "110"; wait for 10 ns;  -- ADD R7,R1 ? 001110010000
        address <= "111"; wait for 10 ns;  -- JZR R0,0 ? 110000000000
        wait;
    end process;
end Behavioral;