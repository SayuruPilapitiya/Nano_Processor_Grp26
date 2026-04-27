library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_RCA_4 is
--  Port ( );
end TB_RCA_4;

architecture Behavioral of TB_RCA_4 is

component RCA_4 is Port ( 
    A : in STD_LOGIC_VECTOR (3 downto 0);
    B : in STD_LOGIC_VECTOR (3 downto 0);
    C_in : in STD_LOGIC;
    S : out STD_LOGIC_VECTOR (3 downto 0);
    C_out : out STD_LOGIC);
end component;

signal A : STD_LOGIC_VECTOR (3 downto 0);
signal B : STD_LOGIC_VECTOR (3 downto 0);
signal C_in : STD_LOGIC;
signal S : STD_LOGIC_VECTOR (3 downto 0);
signal C_out : STD_LOGIC;


begin
    UUT : RCA_4 port map(
        A => A,
        B => B,
        C_in => C_in,
        S => S,
        C_out => C_out);
        
    process begin
        C_in <= '0';
        A <= "0000";
        B <= "0000";
        wait for 10 ns;
        
        B <= "0001";
        wait for 10 ns;
        
        B <= "0011";
        wait for 10 ns;
        
        B <= "0101";
        wait for 10 ns;
        
        B <= "1000";
        wait for 10 ns;
        
        B <= "1001";
        wait for 10 ns;
        
        B <= "1011";
        wait for 10 ns;
        
        B <= "1101";
        wait for 10 ns;
        
        
        A <= "0010";
        B <= "0000";
        wait for 10 ns;
        
        B <= "0001";
        wait for 10 ns;
        
        B <= "0011";
        wait for 10 ns;
        
        B <= "0101";
        wait for 10 ns;
        
        B <= "1000";
        wait for 10 ns;
        
        B <= "1001";
        wait for 10 ns;
        
        B <= "1011";
        wait for 10 ns;
        
        B <= "1101";
        wait for 10 ns;
        
        
        A <= "0101";
        B <= "0000";
        wait for 10 ns;
        
        B <= "0001";
        wait for 10 ns;
        
        B <= "0011";
        wait for 10 ns;
        
        B <= "0101";
        wait for 10 ns;
        
        B <= "1000";
        wait for 10 ns;
        
        B <= "1001";
        wait for 10 ns;
        
        B <= "1011";
        wait for 10 ns;
        
        B <= "1101";
        wait for 10 ns;
        
        
        A <= "1111";
        B <= "0000";
        wait for 10 ns;
        
        B <= "0001";
        wait for 10 ns;
        
        B <= "0011";
        wait for 10 ns;
        
        B <= "0101";
        wait for 10 ns;
        
        B <= "1000";
        wait for 10 ns;
        
        B <= "1001";
        wait for 10 ns;
        
        B <= "1011";
        wait for 10 ns;
        
        B <= "1101";
        wait for 10 ns;
        
        wait;
        
    end process;

end Behavioral;
