----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 04:11:18 PM
-- Design Name: 
-- Module Name: Slow_Clock_TB - Behavioral
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

entity Slow_Clock_TB is
end Slow_Clock_TB;

architecture Behavioral of Slow_Clock_TB is
    signal clk_in  : STD_LOGIC := '0';
    signal reset   : STD_LOGIC := '1';
    signal clk_out : STD_LOGIC;
    constant clk_period : time := 10 ns;
begin
    uut: entity work.Slow_Clock
        generic map (SIM_MODE => true)
        port map (Clk_in => clk_in, Reset => reset, Clk_out => clk_out);
    
    clk_process: process
    begin
        clk_in <= '0'; wait for clk_period/2;
        clk_in <= '1'; wait for clk_period/2;
    end process;
    
    stim: process
    begin
        reset <= '1'; wait for clk_period * 2;
        reset <= '0'; wait for clk_period * 100;
        reset <= '1'; wait for clk_period * 5;
        reset <= '0'; wait for clk_period * 50;
        wait;
    end process;
end Behavioral;