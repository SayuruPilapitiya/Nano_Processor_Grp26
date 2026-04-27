----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2026 11:20:34 AM
-- Design Name: 
-- Module Name: SevenSeg_Display - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 4-bit value to 7-segment display decoder
--              Active LOW segments (common anode on Basys 3)
--              Only rightmost digit activated
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SevenSeg_Display is
    Port (
        Data_In   : in  STD_LOGIC_VECTOR (3 downto 0);
        Seg_Out   : out STD_LOGIC_VECTOR (6 downto 0);  -- g,f,e,d,c,b,a
        Anode_Out : out STD_LOGIC_VECTOR (3 downto 0)   -- Common anode select
    );
end SevenSeg_Display;

architecture Behavioral of SevenSeg_Display is
begin
    -- Activate only rightmost digit (active LOW for common anode)
    Anode_Out <= "1110";
    
    process(Data_In)
    begin
        case Data_In is
            -- Segments: g f e d c b a (active LOW)
            when "0000" => Seg_Out <= "1000000"; -- 0
            when "0001" => Seg_Out <= "1111001"; -- 1
            when "0010" => Seg_Out <= "0100100"; -- 2
            when "0011" => Seg_Out <= "0110000"; -- 3
            when "0100" => Seg_Out <= "0011001"; -- 4
            when "0101" => Seg_Out <= "0010010"; -- 5
            when "0110" => Seg_Out <= "0000010"; -- 6
            when "0111" => Seg_Out <= "1111000"; -- 7
            when "1000" => Seg_Out <= "0000000"; -- 8
            when "1001" => Seg_Out <= "0010000"; -- 9
            when "1010" => Seg_Out <= "0001000"; -- A
            when "1011" => Seg_Out <= "0000011"; -- b
            when "1100" => Seg_Out <= "1000110"; -- C
            when "1101" => Seg_Out <= "0100001"; -- d
            when "1110" => Seg_Out <= "0000110"; -- E
            when "1111" => Seg_Out <= "0001110"; -- F
            when others => Seg_Out <= "1111111"; -- Blank
        end case;
    end process;
end Behavioral;