----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2026 11:48:19 AM
-- Design Name: 
-- Module Name: Adder_Subtractor_4bit_TB - Behavioral
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

entity Adder_Subtractor_4bit_TB is
end Adder_Subtractor_4bit_TB;

architecture Behavioral of Adder_Subtractor_4bit_TB is
    signal a, b, result       : STD_LOGIC_VECTOR(3 downto 0);
    signal mode               : STD_LOGIC;
    signal zero_f, carry_f, overflow_f : STD_LOGIC;
begin
    uut: entity work.Adder_Subtractor_4bit
        port map (
            A             => a,
            B             => b,
            Mode          => mode,
            Result        => result,
            Zero_Flag     => zero_f,
            Carry_Flag    => carry_f,
            Overflow_Flag => overflow_f
        );
    
    stim: process
    begin
        -- ADDITION TESTS (Mode = 0)
        mode <= '0';
        
        -- Test 1: 0 + 0 = 0
        a <= "0000"; b <= "0000"; wait for 10 ns;
        -- Test 2: 2 + 3 = 5
        a <= "0010"; b <= "0011"; wait for 10 ns;
        -- Test 3: 5 + 3 = 8 (OVERFLOW! Pos+Pos=Neg)
        a <= "0101"; b <= "0011"; wait for 10 ns;
        -- Test 4: 7 + 1 = 8 (OVERFLOW! Pos+Pos=Neg)
        a <= "0111"; b <= "0001"; wait for 10 ns;
        -- Test 5: 7 + 7 = 14 = -2 in signed (OVERFLOW! Pos+Pos=Neg)
        a <= "0111"; b <= "0111"; wait for 10 ns;
        -- Test 6: -4 + -5 = -9 ? +7 in 4-bit (OVERFLOW! Neg+Neg=Pos)
        a <= "1100"; b <= "1011"; wait for 10 ns;
        -- Test 7: -1 + -1 = -2
        a <= "1111"; b <= "1111"; wait for 10 ns;
        -- Test 8: -2 + 5 = 3
        a <= "1110"; b <= "0101"; wait for 10 ns;
        -- Test 9: 15 + 1 = 0 (unsigned overflow, carry out)
        a <= "1111"; b <= "0001"; wait for 10 ns;
        
        -- SUBTRACTION TESTS (Mode = 1)
        mode <= '1';
        -- Test 10: 5 - 3 = 2
        a <= "0101"; b <= "0011"; wait for 10 ns;
        -- Test 11: 3 - 5 = -2
        a <= "0011"; b <= "0101"; wait for 10 ns;
        -- Test 12: 0 - 5 = -5 (NEG simulation)
        a <= "0000"; b <= "0101"; wait for 10 ns;
        -- Test 13: 5 - 5 = 0
        a <= "0101"; b <= "0101"; wait for 10 ns;
        -- Test 14: 5 - (-3) = 8 (OVERFLOW! Pos-Neg=Neg)
        a <= "0101"; b <= "1101"; wait for 10 ns;
        -- Test 15: -5 - 3 = -8
        a <= "1011"; b <= "0011"; wait for 10 ns;
        -- Test 16: -3 - (-5) = +2
        a <= "1101"; b <= "1011"; wait for 10 ns;
        -- Test 17: -8 - 1 = -9 
        a <= "1000"; b <= "0001"; wait for 10 ns;
        -- Test 18: 7 - (-1) = 8 (OVERFLOW! Pos-Neg=Neg)
        a <= "0111"; b <= "1111"; wait for 10 ns;

        -- NEG SIMULATION (Mode=1, A=0)
        -- Test 19: NEG 3 ? 0 - 3 = -3
        a <= "0000"; b <= "0011"; wait for 10 ns;
        -- Test 20: NEG 6 ? 0 - 6 = -6
        a <= "0000"; b <= "0110"; wait for 10 ns;
        -- Test 21: NEG 0 ? 0 - 0 = 0
        a <= "0000"; b <= "0000"; wait for 10 ns;
        -- Test 22: NEG -8 ? 0 - (-8) = 8 (OVERFLOW!)
        a <= "0000"; b <= "1000"; wait for 10 ns;
        
        wait;
    end process;
end Behavioral;