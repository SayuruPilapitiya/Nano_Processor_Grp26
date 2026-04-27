Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder_1_to_2 is
    Port ( I : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (1 downto 0));
end Decoder_1_to_2;

architecture Behavioral of Decoder_1_to_2 is

begin
    Y(0) <= not I;
    Y(1) <= I;

end Behavioral;
