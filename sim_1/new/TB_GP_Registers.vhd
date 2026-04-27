library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_GP_Registers is
--  Port ( );
end TB_GP_Registers;

architecture Behavioral of TB_GP_Registers is

component GP_Registers Port (
    Clk : in STD_LOGIC;
    EN : in STD_LOGIC;
    Reset : in STD_LOGIC;
    In_Reg_Sel : in STD_LOGIC_VECTOR (7 downto 0);
    Write_Data : in STD_LOGIC_VECTOR (3 downto 0);
    Out_Reg_Sel_A : in STD_LOGIC_VECTOR (2 downto 0);
    Out_Reg_Sel_B : in STD_LOGIC_VECTOR (2 downto 0);
    Out_A : out STD_LOGIC_VECTOR (3 downto 0);
    Out_B : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal Clk : STD_LOGIC;
signal EN : STD_LOGIC;
signal Reset : STD_LOGIC := '0';
signal In_Reg_Sel : STD_LOGIC_VECTOR (7 downto 0);
signal Write_Data : STD_LOGIC_VECTOR (3 downto 0);
signal Out_Reg_Sel_A : STD_LOGIC_VECTOR (2 downto 0);
signal Out_Reg_Sel_B : STD_LOGIC_VECTOR (2 downto 0);
signal Out_A : STD_LOGIC_VECTOR (3 downto 0);
signal Out_B : STD_LOGIC_VECTOR (3 downto 0);

begin
    UUT : GP_Registers port map(
        Clk => Clk,
        EN => EN,
        Reset => Reset,
        In_Reg_Sel => In_Reg_Sel,
        Write_Data => Write_Data,
        Out_Reg_Sel_A => Out_Reg_Sel_A,
        Out_Reg_Sel_B => Out_Reg_Sel_B,
        Out_A => Out_A,
        Out_B => Out_B);
        
    clk_gen : process
    begin
        wait for 5 ns;
        Clk <= '0';
        loop
            wait for 10 ns;
            Clk <= not Clk;
        end loop;
        
    end process;
    
    process begin
        EN <= '1';
        wait for 10 ns;
        
        In_Reg_Sel <="00000001";
        Write_Data <="0011";
        Out_Reg_Sel_A <= "000";
        Out_Reg_Sel_B <= "111";
        wait for 10 ns;
        
        In_Reg_Sel<="00000010";
        Write_Data<="1011";
        Out_Reg_Sel_A <= "001";
        Out_Reg_Sel_B <= "110";
        wait for 10 ns;
        
        In_Reg_Sel<="00000100";
        Write_Data<="0010";
        Out_Reg_Sel_A <= "010";
        Out_Reg_Sel_B <= "101";
        wait for 10 ns;
        
        In_Reg_Sel<="00001000";
        Write_Data<="0111";
        Out_Reg_Sel_A <= "011";
        Out_Reg_Sel_B <= "100";
        wait for 10 ns;
        
        In_Reg_Sel<="00010000";
        Write_Data<="1011";
        Out_Reg_Sel_A <= "100";
        Out_Reg_Sel_B <= "011";
        wait for 10 ns;
        
        In_Reg_Sel<="00100000";
        Write_Data<="0000";
        Out_Reg_Sel_A <= "101";
        Out_Reg_Sel_B <= "010";
        wait for 10 ns;
        
        In_Reg_Sel<="01000000";
        Write_Data<="0010";
        Out_Reg_Sel_A <= "110";
        Out_Reg_Sel_B <= "001";
        wait for 10 ns;
        
        In_Reg_Sel<="10000000";
        Write_Data<="0100";
        Out_Reg_Sel_A <= "111";
        Out_Reg_Sel_B <= "000";
        wait for 10 ns;
        
        
    end process;
        


end Behavioral;
