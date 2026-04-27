library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_D_FF_F_EN is
--  Port ( );
end TB_D_FF_F_EN;

architecture Behavioral of TB_D_FF_F_EN is

component D_FF_F_EN port(
    Clk : in STD_LOGIC;
    EN : in STD_LOGIC;
    D : in STD_LOGIC;
    Q : out STD_LOGIC);
end component;

signal Clk : STD_LOGIC;
signal EN : STD_LOGIC;
signal D : STD_LOGIC;
signal Q : STD_LOGIC;

begin

    UUT : D_FF_F_EN port map(
        Clk => Clk,
        EN => EN,
        D => D,
        Q => Q);
        
        
    clk_gen : process
    begin
        Clk <= '0';
        wait for 5 ns;
        loop
            wait for 10 ns;
            Clk <= not Clk;
        end loop;
        
    end process;
    
    process begin
        EN <= '0';
        D <= '1';
        wait for 10 ns;
        
        EN <= '0';
        D <= '0';
        wait for 10 ns;
        
        D <= '1';
        wait for 10 ns;
        
        EN <= '1';
        D <= '0';
        wait for 10 ns;
        
        EN <= '0';
        D <= '0';
        wait for 10 ns;
        
        D <= '1';
        wait for 10 ns;
    end process;


end Behavioral;
