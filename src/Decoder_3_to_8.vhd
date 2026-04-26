----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 05:43:46 PM
-- Design Name: 
-- Module Name: Decoder_3_to_8 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Decoder_3_to_8 is
    Port ( 
        I : in  STD_LOGIC_VECTOR (2 downto 0);
        Y : out STD_LOGIC_VECTOR (7 downto 0)
    );
end Decoder_3_to_8;

architecture Behavioral of Decoder_3_to_8 is
begin
    process(I)
    begin
        -- Default all to 0
        Y <= "00000000";
        
        -- Set the specific bit high based on the 3-bit input
        case I is
            when "000" => Y(0) <= '1';
            when "001" => Y(1) <= '1';
            when "010" => Y(2) <= '1';
            when "011" => Y(3) <= '1';
            when "100" => Y(4) <= '1';
            when "101" => Y(5) <= '1';
            when "110" => Y(6) <= '1';
            when "111" => Y(7) <= '1';
            when others => Y <= "00000000";
        end case;
    end process;
end Behavioral;
