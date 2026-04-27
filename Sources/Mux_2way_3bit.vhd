----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 09:58:36 PM
-- Design Name: 
-- Module Name: Mux_2way_3bit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 2-way 3-bit multiplexer for PC input selection
--              Selects between PC+1 (normal) and Jump Address (JZR)
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2way_3bit is
    Port (
        A   : in  STD_LOGIC_VECTOR (2 downto 0);  -- PC+1 from 3-bit adder
        B   : in  STD_LOGIC_VECTOR (2 downto 0);  -- Jump address from decoder
        Sel : in  STD_LOGIC;                       -- Jump_En control signal
        Y   : out STD_LOGIC_VECTOR (2 downto 0)   -- Selected address to PC
    );
end Mux_2way_3bit;

architecture Behavioral of Mux_2way_3bit is
begin
    Y <= A when Sel = '0' else B;
end Behavioral;