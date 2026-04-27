----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 09:50:32 AM
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
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C_in : in STD_LOGIC;
           S : out STD_LOGIC;
           C_out : out STD_LOGIC);
end FA;

architecture Behavioral of FA is

component HA port (
    A: IN STD_LOGIC;
    B: IN STD_LOGIC;
    S: OUT STD_LOGIC;
    C: OUT STD_LOGIC);
end component;

signal HA0_S : STD_LOGIC;
signal HA1_S : STD_LOGIC;
signal HA0_C : STD_LOGIC;
signal HA1_C : STD_LOGIC;

begin

    HA_0 : HA port map(
        A => A,
        B => B,
        S => HA0_S,
        C => HA0_C);
        
    HA_1 : HA port map(
        A => HA0_S,
        B => C_in,
        S => HA1_S,
        C => HA1_C);
        
    S <= HA1_S;
    C_out <= HA0_C OR HA1_C;


end Behavioral;
