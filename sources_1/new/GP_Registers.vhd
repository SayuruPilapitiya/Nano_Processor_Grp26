library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity GP_Registers is Port ( 
    Clk : in STD_LOGIC;
    EN : in STD_LOGIC;
    Reset : in STD_LOGIC;
    In_Reg_Sel : in STD_LOGIC_VECTOR (7 downto 0);
    Write_Data : in STD_LOGIC_VECTOR (3 downto 0);
    Out_Reg_Sel_A : in STD_LOGIC_VECTOR (2 downto 0);
    Out_Reg_Sel_B : in STD_LOGIC_VECTOR (2 downto 0);
    Out_A : out STD_LOGIC_VECTOR (3 downto 0);
    Out_B : out STD_LOGIC_VECTOR (3 downto 0));
end GP_Registers;

architecture Behavioral of GP_Registers is

component GP_Reg Port ( 
    Clk : in STD_LOGIC;
    Reset : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR (3 downto 0);
    Enable : in STD_LOGIC;
    Val : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component MUX_4Bit_8_to_1 Port ( 
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
end component;

signal B0 : STD_LOGIC_VECTOR (3 downto 0);
signal B1 : STD_LOGIC_VECTOR (3 downto 0);
signal B2 : STD_LOGIC_VECTOR (3 downto 0);
signal B3 : STD_LOGIC_VECTOR (3 downto 0);
signal B4 : STD_LOGIC_VECTOR (3 downto 0);
signal B5 : STD_LOGIC_VECTOR (3 downto 0);
signal B6 : STD_LOGIC_VECTOR (3 downto 0);
signal B7 : STD_LOGIC_VECTOR (3 downto 0);
signal B_Out_A : STD_LOGIC_VECTOR (3 downto 0);
signal B_Out_B : STD_LOGIC_VECTOR (3 downto 0);

signal EN0 : STD_LOGIC;
signal EN1 : STD_LOGIC;
signal EN2 : STD_LOGIC;
signal EN3 : STD_LOGIC;
signal EN4 : STD_LOGIC;
signal EN5 : STD_LOGIC;
signal EN6 : STD_LOGIC;
signal EN7 : STD_LOGIC;

begin
    EN0 <= In_Reg_Sel(0) and EN;
    EN1 <= In_Reg_Sel(1) and EN;
    EN2 <= In_Reg_Sel(2) and EN;
    EN3 <= In_Reg_Sel(3) and EN;
    EN4 <= In_Reg_Sel(4) and EN;
    EN5 <= In_Reg_Sel(5) and EN;
    EN6 <= In_Reg_Sel(6) and EN;
    EN7 <= In_Reg_Sel(7) and EN;
    
    GP_Reg0 : GP_Reg port map(
        Clk => Clk,
        Reset => Reset,
        Enable => EN0,
        D => Write_Data,
        Val => B0
    );
    
    GP_Reg1 : GP_Reg port map(
        Clk => Clk,
        Reset => Reset,
        Enable => EN1,
        D => Write_Data,
        Val => B1
    );
        
    GP_Reg2 : GP_Reg port map(
        Clk => Clk,
        Reset => Reset,
        Enable => EN2,
        D => Write_Data,
        Val => B2
    );
    
    GP_Reg3 : GP_Reg port map(
        Clk => Clk,
        Reset => Reset,
        Enable => EN3,
        D => Write_Data,
        Val => B3
    );
    
    GP_Reg4 : GP_Reg port map(
        Clk => Clk,
        Reset => Reset,
        Enable => EN4,
        D => Write_Data,
        Val => B4
    );
        
    GP_Reg5 : GP_Reg port map(
        Clk => Clk,
        Reset => Reset,
        Enable => EN5,
        D => Write_Data,
        Val => B5
    );
    
    GP_Reg6 : GP_Reg port map(
        Clk => Clk,
        Reset => Reset,
        Enable => EN6,
        D => Write_Data,
        Val => B6
    );
    
    GP_Reg7 : GP_Reg port map(
        Clk => Clk,
        Reset => Reset,
        Enable => EN7,
        D => Write_Data,
        Val => B7
    );
    
    MUX_A : MUX_4Bit_8_to_1 Port map ( 
        Address => Out_Reg_Sel_A,
        B0 => B0,
        B1 => B1,
        B2 => B2,
        B3 => B3,
        B4 => B4,
        B5 => B5,
        B6 => B6,
        B7 => B7,
        B_Out => B_Out_A
    );
    
    MUX_B : MUX_4Bit_8_to_1 Port map ( 
        Address => Out_Reg_Sel_B,
        B0 => B0,
        B1 => B1,
        B2 => B2,
        B3 => B3,
        B4 => B4,
        B5 => B5,
        B6 => B6,
        B7 => B7,
        B_Out => B_Out_B
    );
    
    Out_A <= B_Out_A;
    Out_B <= B_Out_B;
    

end Behavioral;
