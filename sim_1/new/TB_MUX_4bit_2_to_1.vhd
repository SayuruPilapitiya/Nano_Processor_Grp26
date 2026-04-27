library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_MUX_4bit_2_to_1 is
--  Port ( );
end TB_MUX_4bit_2_to_1;

architecture Behavioral of TB_MUX_4bit_2_to_1 is

component MUX_4Bit_2_to1 port ( 
    B1 : in STD_LOGIC_VECTOR (3 downto 0);
    B2 : in STD_LOGIC_VECTOR (3 downto 0);
    Bus_Sel : in STD_LOGIC;
    B_Out : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal B1 : STD_LOGIC_VECTOR (3 downto 0);
signal B2 : STD_LOGIC_VECTOR (3 downto 0);
signal Bus_Sel : STD_LOGIC;
signal B_Out : STD_LOGIC_VECTOR (3 downto 0);

begin

    UUT : MUX_4Bit_2_to1 port map (
        B1 => B1,
        B2 => B2,
        Bus_Sel => Bus_Sel,
        B_out => B_out);
        
    process begin
        Bus_Sel <= '0';
        B1 <= "0000";
        B2 <= "1111";
        wait for 10 ns;
        
        B1 <= "0001";
        B2 <= "1111";
        wait for 10 ns;
        
        B1 <= "0101";
        B2 <= "1111";
        wait for 10 ns;
        
        B1 <= "1011";
        B2 <= "1111";
        wait for 10 ns;
        
        
        
        Bus_Sel <= '1';
        B2 <= "0000";
        B1 <= "1111";
        wait for 10 ns;
        
        B2 <= "0001";
        B1 <= "1111";
        wait for 10 ns;
        
        B2 <= "0101";
        B1 <= "1111";
        wait for 10 ns;
        
        B2 <= "1011";
        B1 <= "1111";
        wait for 10 ns;
        
    end process;


end Behavioral;
