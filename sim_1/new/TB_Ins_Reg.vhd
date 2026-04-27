library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Ins_Reg is
--  Port ( );
end TB_Ins_Reg;

architecture Behavioral of TB_Ins_Reg is

component Instruction_Reg Port (
    Clk : in STD_LOGIC;
    Reset : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR (11 downto 0);
    Q : out STD_LOGIC_VECTOR (11 downto 0));
end component;

signal Clk : STD_LOGIC;
signal Reset : STD_LOGIC;
signal D : STD_LOGIC_VECTOR (11 downto 0);
signal Q : STD_LOGIC_VECTOR (11 downto 0);

begin
    UUT : Instruction_Reg port map (
        Clk => Clk,
        Reset => Reset,
        D => D,
        Q => Q);
    
    clk_gen : process
    begin
        Clk <= '0';
        loop
            wait for 10 ns;
            Clk <= not Clk;
        end loop;
        
    end process;
    
    process begin
        Reset <= '1';
        D <= "010101010101";
        wait for 15 ns;
        
        Reset <= '0';
        D <= "010101010101";
        wait for 10 ns;
        
        D <= "010111010101";
        wait for 10 ns;
        
        D <= "010101101101";
        wait for 10 ns;
        
        D <= "100001010101";
        wait for 10 ns;
        
        D <= "110101101111";
        wait for 10 ns;
    end process;
        
end Behavioral;