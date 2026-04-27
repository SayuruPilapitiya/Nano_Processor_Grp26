library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity GP_Reg is
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (3 downto 0);
           Enable : in STD_LOGIC;
           Val : out STD_LOGIC_VECTOR (3 downto 0));
end GP_Reg;

architecture Behavioral of GP_Reg is

component D_FF_F_EN port(
    Clk : in STD_LOGIC;
    Reset : in STD_LOGIC;
    EN : in STD_LOGIC;
    D : in STD_LOGIC;
    Q : out STD_LOGIC);
 end component;    

signal D0, D1, D2, D3 : STD_LOGIC := '0';
signal Q0, Q1, Q2, Q3 : STD_LOGIC := '0';

begin
    
    FF0 : D_FF_F_EN Port Map(
        Clk => Clk,
        Reset => Reset,
        EN => Enable,
        D => D0,
        Q => Q0
    );
        
    FF1 : D_FF_F_EN Port Map(
        Clk => Clk,
        Reset => Reset,
        EN => Enable,
        D => D1,
        Q => Q1
    );
        
    FF2 : D_FF_F_EN Port Map(
        Clk => Clk,
        Reset => Reset,
        EN => Enable,
        D => D2,
        Q => Q2
    );
        
    FF3 : D_FF_F_EN Port Map(
        Clk => Clk,
        Reset => Reset,
        EN => Enable,
        D => D3,
        Q => Q3
    );
        
    D0 <= D(0);
    D1 <= D(1);
    D2 <= D(2);
    D3 <= D(3);
       
    Val(0) <= Q0;
    Val(1) <= Q1;
    Val(2) <= Q2;
    Val(3) <= Q3;

end Behavioral;
