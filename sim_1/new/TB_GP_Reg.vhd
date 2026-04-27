library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_GP_Reg is
--  Port ( );
end TB_GP_Reg;

architecture Behavioral of TB_GP_Reg is

component GP_Reg Port ( 
    Clk : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR (3 downto 0);
    Enable : in STD_LOGIC;
    Val : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal Clk : STD_LOGIC;
signal Enable : STD_LOGIC;
signal D : STD_LOGIC_VECTOR(3 downto 0);
signal Val : STD_LOGIC_VECTOR(3 downto 0);

begin
    UUT : GP_Reg port map (
        Clk => Clk,
        D => D,
        Enable => Enable,
        Val => Val);
    
    clk_gen : process
    begin
        Clk <= '1';
        wait for 5 ns;
--        Clk <= '0';
--        wait for 10 ns;
        loop
            wait for 10 ns;
            Clk <= not Clk;
        end loop;
        
    end process;    
    
    process begin
        Enable <= '1';
        D <= "1010";
        wait for 10 ns;
        
        Enable <= '0';
        D <= "0010";
        wait for 10 ns;
        
        D <= "1110";
        wait for 10 ns;
        
        Enable <= '1';
        D <= "0100";
        wait for 10 ns;
        
        Enable <= '0';
        D <= "1010";
        wait for 10 ns;
        
        D <= "1110";
        wait for 10 ns;
        
        Enable <= '1';
        D <= "1111";
        wait for 10 ns;
        
    end process;


end Behavioral;
