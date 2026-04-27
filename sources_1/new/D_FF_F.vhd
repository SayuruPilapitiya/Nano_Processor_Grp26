library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_FF_F is Port ( 
    D : in STD_LOGIC;
    Res : in STD_LOGIC;
    Clk : in STD_LOGIC; 
    Q : out STD_LOGIC;
    Q_bar : out STD_LOGIC); 
end D_FF_F;

architecture Behavioral of D_FF_F is
    signal Q_int : STD_LOGIC;

begin

    process(Clk, Res) 
    begin
        if Res = '1' then
            Q_int <= '0';
        elsif (falling_edge(Clk)) then 
            Q_int <= D;
        end if;
    end process;
    
    Q <= Q_int;
    Q_bar <= not Q_int;


end Behavioral;
