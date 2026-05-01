----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 06:08:55 PM
-- Design Name: 
-- Module Name: Program_ROM - Behavioral
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

entity Program_ROM is
    Port ( 
        Address     : in  STD_LOGIC_VECTOR (2 downto 0); -- From the Program Counter
        Instruction : out STD_LOGIC_VECTOR (11 downto 0) -- To the Instruction Decoder
    );
end Program_ROM;

architecture Behavioral of Program_ROM is
begin

with Address select
        Instruction <= 
            "101110000111" when "000", -- Line 0: MOVI R7, 7
            "100010000010" when "001", -- Line 1: MOVI R1, 2
            "000011110000" when "010", -- Line 2: ADD R1, R7 (Triggers Overflow!)
            "100100000111" when "011", -- Line 3: MOVI R2, 7
            "010100000000" when "100", -- Line 4: NEG R2     (Prepares Subtraction)
            "001110100000" when "101", -- Line 5: ADD R7, R2 (Triggers Zero Flag!)
            "111110000111" when "110", -- Line 6: JZR R7, 7  (Tests Conditional Jump)
            "110000000000" when "111", -- Line 7: JZR R0, 7  (Halt)
            "000000000000" when others; -- Fallback safety
end Behavioral;
