library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all; 


entity Program_ROM is
    Port ( Address : in STD_LOGIC_VECTOR (2 downto 0);
           Instruction : out STD_LOGIC_VECTOR (11 downto 0));
end Program_ROM;

architecture Behavioral of Program_ROM is

type rom_type is array (0 to 7) of std_logic_vector(11 downto 0);

    signal instructions : rom_type := (
        "100001110011",-- 10 000 111 1111
        "100011100001",-- 10 001 110 1110
--        "100101011101",-- 10 010 101 1101
        "000100011101",-- 00 010 001 1101
        "100111001100",-- 10 011 100 1100
        "101000111011",-- 10 100 011 1011
        "101010101010",-- 10 101 010 1010
        "101100010001",-- 10 110 001 0001
        "101110001000");-- 10 111 000 1000
        
begin
    Instruction <= instructions(to_integer(unsigned(address)));


end Behavioral;
