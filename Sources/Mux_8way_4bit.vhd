----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 10:02:32 PM
-- Design Name: 
-- Module Name: Mux_8way_4bit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 8-way 4-bit multiplexer for register output selection
--              Selects one of 8 register values to place on data bus
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

entity Mux_8way_4bit is
    Port (
        Input0 : in  STD_LOGIC_VECTOR (3 downto 0);
        Input1 : in  STD_LOGIC_VECTOR (3 downto 0);
        Input2 : in  STD_LOGIC_VECTOR (3 downto 0);
        Input3 : in  STD_LOGIC_VECTOR (3 downto 0);
        Input4 : in  STD_LOGIC_VECTOR (3 downto 0);
        Input5 : in  STD_LOGIC_VECTOR (3 downto 0);
        Input6 : in  STD_LOGIC_VECTOR (3 downto 0);
        Input7 : in  STD_LOGIC_VECTOR (3 downto 0);
        Sel    : in  STD_LOGIC_VECTOR (2 downto 0);
        Y      : out STD_LOGIC_VECTOR (3 downto 0)
    );
end Mux_8way_4bit;

architecture Behavioral of Mux_8way_4bit is
begin
    process(Sel, Input0, Input1, Input2, Input3, Input4, Input5, Input6, Input7)
    begin
        case Sel is
            when "000" => Y <= Input0;
            when "001" => Y <= Input1;
            when "010" => Y <= Input2;
            when "011" => Y <= Input3;
            when "100" => Y <= Input4;
            when "101" => Y <= Input5;
            when "110" => Y <= Input6;
            when "111" => Y <= Input7;
            when others => Y <= (others => '0');
        end case;
    end process;
end Behavioral;