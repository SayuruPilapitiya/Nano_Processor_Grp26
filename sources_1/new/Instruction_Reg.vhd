library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Instruction_Reg is
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (11 downto 0);
           Q : out STD_LOGIC_VECTOR (11 downto 0));
end Instruction_Reg;

architecture Behavioral of Instruction_Reg is

component D_FF_R port(
    D : in STD_LOGIC;
    Res : in STD_LOGIC;
    Clk : in STD_LOGIC;
    Q : out STD_LOGIC;
    Q_bar : out STD_LOGIC);
end component;
 
signal D0, D1, D2, D3, D4, D5, D6, D7, D8, D9, D10, D11 : STD_LOGIC := '0';
signal Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7, Q8, Q9, Q10, Q11 : STD_LOGIC := '0';

begin
    FF0 : D_FF_R Port Map(
        D => D0,
        Res => Reset,
        Clk => Clk,
        Q => Q0);
        
    FF1 : D_FF_R Port Map(
        D => D1,
        Res => Reset,
        Clk => Clk,
        Q => Q1);
    FF2 : D_FF_R Port Map(
        D => D2,
        Res => Reset,
        Clk => Clk,
        Q => Q2);
        
    FF3 : D_FF_R Port Map(
        D => D3,
        Res => Reset,
        Clk => Clk,
        Q => Q3);
        
    FF4 : D_FF_R Port Map(
        D => D4,
        Res => Reset,
        Clk => Clk,
        Q => Q4);
    FF5 : D_FF_R Port Map(
        D => D5,
        Res => Reset,
        Clk => Clk,
        Q => Q5);
    FF6 : D_FF_R Port Map(
        D => D6,
        Res => Reset,
        Clk => Clk,
        Q => Q6);
        
    FF7 : D_FF_R Port Map(
        D => D7,
        Res => Reset,
        Clk => Clk,
        Q => Q7);
    FF8 : D_FF_R Port Map(
        D => D8,
        Res => Reset,
        Clk => Clk,
        Q => Q8);
        
    FF9 : D_FF_R Port Map(
        D => D9,
        Res => Reset,
        Clk => Clk,
        Q => Q9);
        
    FF10 : D_FF_R Port Map(
        D => D10,
        Res => Reset,
        Clk => Clk,
        Q => Q10);
        
    FF11 : D_FF_R Port Map(
        D => D11,
        Res => Reset,
        Clk => Clk,
        Q => Q11);
        
    D0 <= D(0);
    D1 <= D(1);
    D2 <= D(2);
    D3 <= D(3);
    D4 <= D(4);
    D5 <= D(5);
    D6 <= D(6);
    D7 <= D(7);
    D8 <= D(8);
    D9 <= D(9);
    D10 <= D(10);
    D11 <= D(11);
       
    Q(0) <= Q0;
    Q(1) <= Q1;
    Q(2) <= Q2;
    Q(3) <= Q3;
    Q(4) <= Q4;
    Q(5) <= Q5;
    Q(6) <= Q6;
    Q(7) <= Q7;
    Q(8) <= Q8;
    Q(9) <= Q9;
    Q(10) <= Q10;
    Q(11) <= Q11;


end Behavioral;
