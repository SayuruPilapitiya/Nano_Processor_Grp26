----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/01/2026 01:47:03 PM
-- Design Name: 
-- Module Name: D_FF_Fall - Behavioral
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

entity D_FF_Fall is
    Port ( D : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Res : in STD_LOGIC;
           Q : out STD_LOGIC;
           Qbar : out STD_LOGIC);
end D_FF_Fall;

architecture Behavioral of D_FF_Fall is

begin
    process (Clk, Res)
    begin
        -- Asynchronous Reset: instantly clears the PC to 0 when the button is pushed
        if Res = '1' then
            Q <= '0';
            Qbar <= '1';
        elsif rising_edge(Clk) then
            Q <= D;
            Qbar <= not D;
        end if;
    end process;
end Behavioral;
