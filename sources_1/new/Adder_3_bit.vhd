----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 05:32:41 PM
-- Design Name: 
-- Module Name: Adder_3_bit - Behavioral
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Adder_3_bit is
    Port ( 
        A     : in  STD_LOGIC_VECTOR (2 downto 0);
        B     : in  STD_LOGIC_VECTOR (2 downto 0);
        C_in  : in  STD_LOGIC;
        S     : out STD_LOGIC_VECTOR (2 downto 0);
        C_out : out STD_LOGIC
    );
end Adder_3_bit;

architecture Structural of Adder_3_bit is

    COMPONENT FA
        PORT(
            A     : IN std_logic;
            B     : IN std_logic;
            C_in  : IN std_logic;
            S     : OUT std_logic;
            C_out : OUT std_logic
        );
    END COMPONENT;

    -- Internal carry signals to chain the Full Adders
    signal FA0_C, FA1_C : std_logic;

begin
    -- Chaining 3 Full Adders together
    FA_0: FA port map (A => A(0), B => B(0), C_in => C_in,  S => S(0), C_out => FA0_C);
    FA_1: FA port map (A => A(1), B => B(1), C_in => FA0_C, S => S(1), C_out => FA1_C);
    FA_2: FA port map (A => A(2), B => B(2), C_in => FA1_C, S => S(2), C_out => C_out);

end Structural;
