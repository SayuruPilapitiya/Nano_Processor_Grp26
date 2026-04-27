----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 10:07:39 PM
-- Design Name: 
-- Module Name: Decoder_3to8_TB - Behavioral
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


----------------------------------------------------------------------------------
-- Engineer: [Your Name]
-- Module Name: Decoder_3_to_8_TB
-- Description: Testbench for 3-to-8 Decoder
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder_3_to_8_TB is
end Decoder_3_to_8_TB;

architecture Behavioral of Decoder_3_to_8_TB is
    signal Sel    : STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal En     : STD_LOGIC := '0';
    signal Output : STD_LOGIC_VECTOR(7 downto 0);
begin
    uut: entity work.Decoder_3_to_8
        port map (
            Sel    => Sel,
            En     => En,
            Output => Output
        );
    
    stim: process
    begin
        -- Let signals settle
        wait for 10 ns;
        
        -- Test 1: Enable OFF (all outputs should be 0)
        En <= '0';
        Sel <= "000"; wait for 10 ns;
        Sel <= "101"; wait for 10 ns;
        
        -- Test 2: Enable ON (one-hot outputs)
        En <= '1';
        Sel <= "000"; wait for 10 ns;  -- Output = 00000001
        Sel <= "001"; wait for 10 ns;  -- Output = 00000010
        Sel <= "010"; wait for 10 ns;  -- Output = 00000100
        Sel <= "011"; wait for 10 ns;  -- Output = 00001000
        Sel <= "100"; wait for 10 ns;  -- Output = 00010000
        Sel <= "101"; wait for 10 ns;  -- Output = 00100000
        Sel <= "110"; wait for 10 ns;  -- Output = 01000000
        Sel <= "111"; wait for 10 ns;  -- Output = 10000000
        
        -- Test 3: Enable off mid-selection
        Sel <= "011";
        En <= '0'; wait for 10 ns;  -- Output = 00000000
        En <= '1'; wait for 10 ns;  -- Output = 00001000
        
        wait;
    end process;
end Behavioral;