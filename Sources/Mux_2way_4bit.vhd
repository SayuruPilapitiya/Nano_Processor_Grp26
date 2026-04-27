----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 10:00:44 PM
-- Design Name: 
-- Module Name: Mux_2way_4bit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 2-way 4-bit multiplexer for ALU input selection
--              Used to select between register data and immediate/R0
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Mux_2way_4bit is
    Port (
        A   : in  STD_LOGIC_VECTOR (3 downto 0);
        B   : in  STD_LOGIC_VECTOR (3 downto 0);
        Sel : in  STD_LOGIC;
        Y   : out STD_LOGIC_VECTOR (3 downto 0)
    );
end Mux_2way_4bit;

architecture Behavioral of Mux_2way_4bit is
begin
    Y <= A when Sel = '0' else B;
end Behavioral;