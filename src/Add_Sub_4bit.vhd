----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 05:52:57 PM
-- Design Name: 
-- Module Name: Add_Sub_4bit - Behavioral
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

entity Add_Sub_4bit is
    Port ( 
        A        : in  STD_LOGIC_VECTOR (3 downto 0);
        B        : in  STD_LOGIC_VECTOR (3 downto 0);
        Ctrl     : in  STD_LOGIC; -- 0 for Add, 1 for Subtract
        S        : out STD_LOGIC_VECTOR (3 downto 0);
        Overflow : out STD_LOGIC;
        Zero     : out STD_LOGIC
    );
end Add_Sub_4bit;

architecture Structural of Add_Sub_4bit is

    COMPONENT FA
        PORT(
            A     : IN std_logic;
            B     : IN std_logic;
            C_in  : IN std_logic;
            S     : OUT std_logic;
            C_out : OUT std_logic
        );
    END COMPONENT;

    signal B_XOR : std_logic_vector(3 downto 0);
    signal C     : std_logic_vector(3 downto 0); -- Internal carries
    signal Sum   : std_logic_vector(3 downto 0);

begin
    -- The XOR trick for 2's complement subtraction
    B_XOR(0) <= B(0) xor Ctrl;
    B_XOR(1) <= B(1) xor Ctrl;
    B_XOR(2) <= B(2) xor Ctrl;
    B_XOR(3) <= B(3) xor Ctrl;

    -- Chain the Full Adders (Ctrl goes into the first C_in!)
    FA0: FA port map (A => A(0), B => B_XOR(0), C_in => Ctrl, S => Sum(0), C_out => C(0));
    FA1: FA port map (A => A(1), B => B_XOR(1), C_in => C(0), S => Sum(1), C_out => C(1));
    FA2: FA port map (A => A(2), B => B_XOR(2), C_in => C(1), S => Sum(2), C_out => C(2));
    FA3: FA port map (A => A(3), B => B_XOR(3), C_in => C(2), S => Sum(3), C_out => C(3));

    -- Output routing
    S <= Sum;
    
    -- Overflow logic for signed 2's complement numbers
    Overflow <= C(3) xor C(2); 
    
    -- Zero flag logic (NOR gate over all sum bits)
    Zero <= not (Sum(0) or Sum(1) or Sum(2) or Sum(3));

end Structural;
