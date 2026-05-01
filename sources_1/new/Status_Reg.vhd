----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2026 01:20:55 PM
-- Design Name: 
-- Module Name: Status_Reg - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Status_Reg is
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           D_in : in STD_LOGIC_VECTOR (7 downto 0);
           Flag_Slc : in STD_LOGIC_VECTOR (2 downto 0);
           Flag_Out : out STD_LOGIC;
           D_out : out STD_LOGIC_VECTOR (7 downto 0));
end Status_Reg;


architecture Behavioral of Status_Reg is


    COMPONENT Decoder_3_to_8
        PORT(
            I : IN std_logic_vector(2 downto 0);
            Y : OUT std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    
    COMPONENT D_FF_Fall
        PORT(
            D    : IN std_logic;
            Res  : IN std_logic;
            Clk  : IN std_logic;
            Q    : OUT std_logic;
            Qbar : OUT std_logic
        );
    END COMPONENT;
signal Dec_Out : STD_LOGIC_VECTOR (7 downto 0);
signal D_FF_Out : STD_LOGIC_VECTOR (7 downto 0);

begin
    Dec: Decoder_3_to_8 PORT MAP (
            I => Flag_Slc,
            Y => Dec_Out
    );
    
    Zero: D_FF_Fall port map (D => D_in(0), Res => Reset, Clk => Clk, Q => D_FF_Out(0));
    NotZero : D_FF_Fall port map (D => D_in(1), Res => Reset, Clk => Clk, Q => D_FF_Out(1));
    Overflow : D_FF_Fall port map (D => D_in(2), Res => Reset, Clk => Clk, Q => D_FF_Out(2));
    Equal: D_FF_Fall port map (D => D_in(3), Res => Reset, Clk => Clk, Q => D_FF_Out(3));
    Less: D_FF_Fall port map (D => D_in(4), Res => Reset, Clk => Clk, Q => D_FF_Out(4));
    Greater: D_FF_Fall port map (D => D_in(5), Res => Reset, Clk => Clk, Q => D_FF_Out(5));
    T1: D_FF_Fall port map (D => D_in(6), Res => Reset, Clk => Clk, Q => D_FF_Out(6));
    T2: D_FF_Fall port map (D => D_in(7), Res => Reset, Clk => Clk, Q => D_FF_Out(7));
    
    Flag_Out <= (Dec_Out(0) and D_FF_Out(0)) or
                (Dec_Out(1) and D_FF_Out(1)) or
                (Dec_Out(2) and D_FF_Out(2)) or
                (Dec_Out(3) and D_FF_Out(3)) or
                (Dec_Out(4) and D_FF_Out(4)) or
                (Dec_Out(5) and D_FF_Out(5)) or
                (Dec_Out(6) and D_FF_Out(6)) or
                (Dec_Out(7) and D_FF_Out(7)) ;
    
    
    D_out <= D_FF_Out;
    
    


end Behavioral;
