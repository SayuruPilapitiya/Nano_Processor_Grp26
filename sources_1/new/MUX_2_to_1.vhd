
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_2_to_1 is
    Port ( B1 : in STD_LOGIC_VECTOR (2 downto 0) ;
           B2 : in STD_LOGIC_VECTOR (2 downto 0) ;
           Bus_Sel : in STD_LOGIC;
           BOut : out STD_LOGIC_VECTOR (2 downto 0));
end MUX_2_to_1;

architecture Behavioral of MUX_2_to_1 is

component Decoder_1_to_2 Port ( 
    I : in STD_LOGIC ;
    Y : out STD_LOGIC_VECTOR (1 downto 0));
end component;

signal Y : STD_LOGIC_VECTOR (1 downto 0);

begin
    Deocder : Decoder_1_to_2 port map(
        I => Bus_Sel,
        Y => Y);
        
    Bout(0) <= (B1(0) and Y(0)) or (B2(0) and Y(1));
    Bout(1) <= (B1(1) and Y(0)) or (B2(1) and Y(1));
    Bout(2) <= (B1(2) and Y(0)) or (B2(2) and Y(1));
        


end Behavioral;
