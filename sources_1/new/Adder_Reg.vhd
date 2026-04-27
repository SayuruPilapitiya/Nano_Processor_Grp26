library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adder_Reg is
    Port ( Clk : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR(3 downto 0);
           Q : out STD_LOGIC_VECTOR(3 downto 0);
           Q_bar : out STD_LOGIC_VECTOR(3 downto 0));
end Adder_Reg;

architecture Behavioral of Adder_Reg is

component D_FF_R port(
    D : in STD_LOGIC;
    Clk : in STD_LOGIC;
    res : in STD_LOGIC;
    Q : out STD_LOGIC;
    Q_bar : out STD_LOGIC);
end component;
 
signal D0, D1, D2, D3 : STD_LOGIC := '0';
signal Q0, Q1, Q2, Q3: STD_LOGIC := '0';

begin
    FF0 : D_FF_R Port Map(
        D => D0,
        Clk => Clk,
        res =>'0',
        Q => Q0);
        
    FF1 : D_FF_R Port Map(
        D => D1,
        Clk => Clk,
        res =>'0',
        Q => Q1);
    FF2 : D_FF_R Port Map(
        D => D2,
        Clk => Clk,
        res =>'0',
        Q => Q2);
        
    FF3 : D_FF_R Port Map(
        D => D3,
        Clk => Clk,
        res =>'0',
        Q => Q3);
        
   
        
    D0 <= D(0);
    D1 <= D(1);
    D2 <= D(2);
    D3 <= D(3);

       
    Q(0) <= Q0;
    Q(1) <= Q1;
    Q(2) <= Q2;
    Q(3) <= Q3;


end Behavioral;
