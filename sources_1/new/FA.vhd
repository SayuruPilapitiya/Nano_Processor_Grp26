----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 05:31:12 PM
-- Design Name: 
-- Module Name: FA - Behavioral
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

entity FA is
    Port ( 
        A     : in  STD_LOGIC;
        B     : in  STD_LOGIC;
        C_in  : in  STD_LOGIC;
        S     : out STD_LOGIC;
        C_out : out STD_LOGIC
    );
end FA;

architecture Behavioral of FA is
begin
    S <= A xor B xor C_in;
    C_out <= (A and B) or (C_in and (A xor B));
end Behavioral;
