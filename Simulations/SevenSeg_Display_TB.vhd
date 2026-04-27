----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2026 12:03:55 PM
-- Design Name: 
-- Module Name: SevenSeg_Display_TB - Behavioral
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

entity SevenSeg_Display_TB is
end SevenSeg_Display_TB;

architecture Behavioral of SevenSeg_Display_TB is
    signal data_in : STD_LOGIC_VECTOR(3 downto 0);
    signal seg_out : STD_LOGIC_VECTOR(6 downto 0);
    signal anode_out : STD_LOGIC_VECTOR(3 downto 0);
begin
    uut: entity work.SevenSeg_Display
        port map (Data_In => data_in, Seg_Out => seg_out, Anode_Out => anode_out);
    
    stim: process
    begin
        data_in <= "0000"; wait for 10 ns;  -- 0
        data_in <= "0001"; wait for 10 ns;  -- 1
        data_in <= "0010"; wait for 10 ns;  -- 2
        data_in <= "0011"; wait for 10 ns;  -- 3
        data_in <= "0100"; wait for 10 ns;  -- 4
        data_in <= "0101"; wait for 10 ns;  -- 5
        data_in <= "0110"; wait for 10 ns;  -- 6 ? Final answer!
        data_in <= "0111"; wait for 10 ns;  -- 7
        data_in <= "1000"; wait for 10 ns;  -- 8
        data_in <= "1001"; wait for 10 ns;  -- 9
        wait;
    end process;
end Behavioral;