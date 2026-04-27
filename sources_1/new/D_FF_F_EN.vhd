library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_FF_F_EN is
    Port (
        Clk : in STD_LOGIC;
        Reset : in STD_LOGIC;
        EN  : in STD_LOGIC;
        D   : in STD_LOGIC;
        Q   : out STD_LOGIC;
        Q_bar : out STD_LOGIC
    );
end D_FF_F_EN;

architecture Behavioral of D_FF_F_EN is
    signal Q_int : STD_LOGIC;
    
    
begin
    process(Clk, Reset)
    begin
        if Reset = '1' then
            Q_int <= '0';
        elsif falling_edge(Clk) then
            if EN = '1' then
                Q_int <= D;
            end if;
        end if;
    end process;

    Q <= Q_int;
    Q_bar <= not Q_int;
end Behavioral;