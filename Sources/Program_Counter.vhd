----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 06:01:00 PM
-- Design Name: 
-- Module Name: Program_Counter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 3-bit Program Counter with synchronous load and async reset
--              Built using D Flip-Flops with clear/reset input
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Program_Counter is
    Port (
        Clk       : in  STD_LOGIC;
        Reset     : in  STD_LOGIC;
        Next_Addr : in  STD_LOGIC_VECTOR (2 downto 0);  -- From 2-way 3-bit mux
        PC_out    : out STD_LOGIC_VECTOR (2 downto 0)
    );
end Program_Counter;

architecture Behavioral of Program_Counter is
    signal pc_reg : unsigned(2 downto 0) := "000";
begin
    process(Clk, Reset)
    begin
        if Reset = '1' then
            pc_reg <= "000";
        elsif rising_edge(Clk) then
            pc_reg <= unsigned(Next_Addr);
        end if;
    end process;
    
    PC_out <= std_logic_vector(pc_reg);
end Behavioral;
