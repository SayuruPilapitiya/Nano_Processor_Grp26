----------------------------------------------------------------------------------
-- Company: UOM CSE
-- Engineer: Lahiru Januka
-- Create Date: 02/24/2026 02:10:53 PM
-- Design Name: 2_to_4_decoder
-- Module Name: Decoder_2_to_4 - Behavioral
-- Project Name: Lab 4
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder_2_to_4 is
    Port ( Sel : in STD_LOGIC_VECTOR (1 downto 0);
           En : in STD_LOGIC;
           Output : out STD_LOGIC_VECTOR (3 downto 0));
end Decoder_2_to_4;

architecture Behavioral of Decoder_2_to_4 is

begin
    Output(0) <= En and (not Sel(0)) and (not Sel(1));
    Output(1) <= En and Sel(0) and (not Sel(1));
    Output(2) <= En and (not Sel(0)) and Sel(1);
    Output(3) <= En and Sel(0) and Sel(1);

end Behavioral;