library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity PC is
    Port ( D : in STD_LOGIC_VECTOR (2 downto 0);
           Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (2 downto 0));
end PC;

architecture Behavioral of PC is

component D_FF_F port(
    D : in STD_LOGIC;
    Res : in STD_LOGIC;
    Clk : in STD_LOGIC;
    Q : out STD_LOGIC;
    Q_bar : out STD_LOGIC);
 end component;
 
 signal D0, D1, D2 : STD_LOGIC := '0';
 signal Q0, Q1, Q2 : STD_LOGIC := '0';
    
begin
    FF0 : D_FF_F Port Map(
        D => D0,
        Res => Reset,
        Clk => Clk,
        Q => Q0);
       
    FF1 : D_FF_F Port Map(
       D => D1,
       Res => Reset,
       Clk => Clk,
       Q => Q1);
   
    FF2 : D_FF_F Port Map(
       D => D2,
       Res => Reset,
       Clk => Clk,
       Q => Q2);
       
    D0 <= D(0);
    D1 <= D(1);
    D2 <= D(2);
       
    Q(0) <= Q0;
    Q(1) <= Q1;
    Q(2) <= Q2;


end Behavioral;