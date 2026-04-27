library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX_4Bit_8_to_1 is Port ( 
    Address : in STD_LOGIC_VECTOR (2 downto 0);
    B0 : in STD_LOGIC_VECTOR (3 downto 0);
    B1 : in STD_LOGIC_VECTOR (3 downto 0);
    B2 : in STD_LOGIC_VECTOR (3 downto 0);
    B3 : in STD_LOGIC_VECTOR (3 downto 0);
    B4 : in STD_LOGIC_VECTOR (3 downto 0);
    B5 : in STD_LOGIC_VECTOR (3 downto 0);
    B6 : in STD_LOGIC_VECTOR (3 downto 0);
    B7 : in STD_LOGIC_VECTOR (3 downto 0);
    B_Out : out STD_LOGIC_VECTOR (3 downto 0));
end MUX_4Bit_8_to_1;

architecture Behavioral of MUX_4Bit_8_to_1 is

component Decoder_3_to_8 Port ( 
    I : in STD_LOGIC_VECTOR (2 downto 0);
    EN : in STD_LOGIC;
    Y : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal Reg_Sel : STD_LOGIC_VECTOR (7 downto 0);

begin
    Adder_Decoder : Decoder_3_to_8 port map(
        I => Address,
        EN => '1',
        Y => Reg_Sel);
    
    B_Out(0) <= (B0(0) and Reg_Sel(0)) or (B1(0) and Reg_Sel(1)) or (B2(0) and Reg_Sel(2)) or (B3(0) and Reg_Sel(3)) or (B4(0) and Reg_Sel(4)) or (B5(0) and Reg_Sel(5)) or (B6(0) and Reg_Sel(6)) or (B7(0) and Reg_Sel(7));
    B_Out(1) <= (B0(1) and Reg_Sel(0)) or (B1(1) and Reg_Sel(1)) or (B2(1) and Reg_Sel(2)) or (B3(1) and Reg_Sel(3)) or (B4(1) and Reg_Sel(4)) or (B5(1) and Reg_Sel(5)) or (B6(1) and Reg_Sel(6)) or (B7(1) and Reg_Sel(7));
    B_Out(2) <= (B0(2) and Reg_Sel(0)) or (B1(2) and Reg_Sel(1)) or (B2(2) and Reg_Sel(2)) or (B3(2) and Reg_Sel(3)) or (B4(2) and Reg_Sel(4)) or (B5(2) and Reg_Sel(5)) or (B6(2) and Reg_Sel(6)) or (B7(2) and Reg_Sel(7));
    B_Out(3) <= (B0(3) and Reg_Sel(0)) or (B1(3) and Reg_Sel(1)) or (B2(3) and Reg_Sel(2)) or (B3(3) and Reg_Sel(3)) or (B4(3) and Reg_Sel(4)) or (B5(3) and Reg_Sel(5)) or (B6(3) and Reg_Sel(6)) or (B7(3) and Reg_Sel(7));


end Behavioral;
