----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 06:04:14 PM
-- Design Name: 
-- Module Name: Program_Counter_TB - Behavioral
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

entity Program_Counter_TB is
end Program_Counter_TB;

architecture Behavioral of Program_Counter_TB is
    signal clk, reset : STD_LOGIC := '0';
    signal next_addr, pc_out : STD_LOGIC_VECTOR(2 downto 0);
    constant clk_period : time := 10 ns;
begin
    uut: entity work.Program_Counter
        port map (Clk => clk, Reset => reset, Next_Addr => next_addr, PC_out => pc_out);
    
    clk_process: process
    begin
        clk <= '0'; wait for clk_period/2;
        clk <= '1'; wait for clk_period/2;
    end process;
    
    stim: process
    begin
        reset <= '1'; wait for clk_period * 2;
        reset <= '0';
        next_addr <= "001"; wait for clk_period;
        next_addr <= "010"; wait for clk_period;
        next_addr <= "011"; wait for clk_period;
        next_addr <= "100"; wait for clk_period;
        next_addr <= "101"; wait for clk_period;
        next_addr <= "110"; wait for clk_period;
        next_addr <= "111"; wait for clk_period;
        next_addr <= "000"; wait for clk_period;
        next_addr <= "101"; wait for clk_period;
        reset <= '1'; wait for clk_period;
        reset <= '0'; wait for clk_period;
        wait;
    end process;
end Behavioral;
