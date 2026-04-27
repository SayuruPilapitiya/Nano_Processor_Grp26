library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_4Bit_2_to1 is
    Port ( B1 : in STD_LOGIC_VECTOR (3 downto 0);
           B2 : in STD_LOGIC_VECTOR (3 downto 0);
           Bus_Sel : in STD_LOGIC;
           B_Out : out STD_LOGIC_VECTOR (3 downto 0));
end MUX_4Bit_2_to1;

architecture Behavioral of MUX_4Bit_2_to1 is

component Decoder_1_to_2 Port ( 
    I : in STD_LOGIC;
    Y : out STD_LOGIC_VECTOR (1 downto 0));
end component;

signal Y : STD_LOGIC_VECTOR (1 downto 0);

begin
    Deocder : Decoder_1_to_2 port map(
        I => Bus_Sel,
        Y => Y);
        
    B_out(0) <= (B1(0) and Y(0)) or (B2(0) and Y(1));
    B_out(1) <= (B1(1) and Y(0)) or (B2(1) and Y(1));
    B_out(2) <= (B1(2) and Y(0)) or (B2(2) and Y(1));
    B_out(3) <= (B1(3) and Y(0)) or (B2(3) and Y(1));


end Behavioral;
