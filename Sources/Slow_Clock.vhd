----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 04:12:56 PM
-- Design Name: 
-- Module Name: Slow_Clock - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity Slow_Clock is
    Generic (
        SIM_MODE : boolean := true  -- TRUE for simulation, FALSE for board
    );
    Port (
        Clk_in  : in  STD_LOGIC;
        Reset   : in  STD_LOGIC;
        Clk_out : out STD_LOGIC
    );
end Slow_Clock;

architecture Behavioral of Slow_Clock is
    signal count : unsigned(27 downto 0) := (others => '0');
    signal clk_reg : STD_LOGIC := '0';
    
    -- Board: 100MHz / 2Hz = 50,000,000 cycles ? 0x2FAF080 (26 bits)
    -- Simulation: small count for quick results
    constant BOARD_LIMIT_2HZ : unsigned(27 downto 0) := x"17D7840"; -- 25,000,000 for 2 Hz
    constant BOARD_LIMIT_1HZ : unsigned(27 downto 0) := x"2FAF080"; -- 50,000,000 for 1 Hz
    constant SIM_LIMIT       : unsigned(27 downto 0) := x"000000A"; -- 10 for simulation
begin
    process(Clk_in, Reset)
    begin
        if Reset = '1' then
            count <= (others => '0');
            clk_reg <= '0';
        elsif rising_edge(Clk_in) then
            if SIM_MODE then
                if count = SIM_LIMIT then
                    count <= (others => '0');
                    clk_reg <= not clk_reg;
                else
                    count <= count + 1;
                end if;
            else
                if count = BOARD_LIMIT_2HZ then -- Use 2 Hz for board
                    count <= (others => '0');
                    clk_reg <= not clk_reg;
                else
                    count <= count + 1;
                end if;
            end if;
        end if;
    end process;
    
    Clk_out <= clk_reg;
end Behavioral;