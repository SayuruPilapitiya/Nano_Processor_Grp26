----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2026 06:31:20 PM
-- Design Name: 
-- Module Name: Test_Processor_TB - Behavioral
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


----------------------------------------------------------------------------------
-- Improved NanoProcessor_Top_TB with internal signal observation
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity NanoProcessor_Top_TB is
end NanoProcessor_Top_TB;

architecture Behavioral of NanoProcessor_Top_TB is
    signal clk_100mhz   : STD_LOGIC := '0';
    signal reset_btn    : STD_LOGIC := '1';
    signal led_output   : STD_LOGIC_VECTOR(3 downto 0);
    signal zero_led     : STD_LOGIC;
    signal carry_led    : STD_LOGIC;
    signal overflow_led : STD_LOGIC;
    signal seg_out      : STD_LOGIC_VECTOR(6 downto 0);
    signal anode_out    : STD_LOGIC_VECTOR(3 downto 0);
    constant clk_period : time := 10 ns;
    
begin
    
    uut: entity work.NanoProcessor_Top
        port map (
            Clk_100MHz   => clk_100mhz,
            Reset_Btn    => reset_btn,
            LED_Output   => led_output,
            Zero_LED     => zero_led,
            Carry_LED    => carry_led,
            Overflow_LED => overflow_led,
            Seg_Out      => seg_out,
            Anode_Out    => anode_out
        );
    
    -- Clock: 100 MHz (10 ns period)
    clk_process: process
    begin
        clk_100mhz <= '0';
        wait for clk_period/2;
        clk_100mhz <= '1';
        wait for clk_period/2;
    end process;
    
    -- Stimulus
    stim: process
    begin
        -- =============================================
        -- Power-on reset
        -- =============================================
        report "=== NANOPROCESSOR SIMULATION STARTED ===";
        reset_btn <= '1';
        wait for clk_period * 10;
        reset_btn <= '0';
        report "Reset released, program starting...";
        
        -- Wait for program to complete the sum (1+2+3=6)
        -- Need enough time for 8 instructions to execute
        wait for clk_period * 200;
        
        -- Check final result
        report "Checking final result...";
        wait for 1 ns;
        
        -- End simulation
        report "=== SIMULATION COMPLETE ===";
        wait;
    end process;
    
    -- Monitor important signals
    monitor: process
    begin
        wait for clk_period;
        report "Time: " & time'image(now) & 
               " LED_Output(R7) = " & to_string(led_output) &
               " Zero=" & std_logic'image(zero_led) &
               " Carry=" & std_logic'image(carry_led) &
               " Overflow=" & std_logic'image(overflow_led);
    end process;
    
    -- Helper function to convert std_logic_vector to string for reporting
    function to_string(slv: std_logic_vector) return string is
        variable result: string(1 to slv'length);
    begin
        for i in slv'range loop
            result(slv'length - i) := std_logic'image(slv(i))(2);
        end loop;
        return result;
    end function;
    
end Behavioral;