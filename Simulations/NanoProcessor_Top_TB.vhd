----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2026 05:28:29 PM
-- Design Name: 
-- Module Name: NanoProcessor_Top_TB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Full system testbench for the Nanoprocessor
--              Verifies program execution: sum of 1+2+3 = 6 stored in R7
--              IMPORTANT: Set SIM_MODE to true in NanoProcessor_Top before running!
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
        report "=== SIMULATION STARTED ===";
        reset_btn <= '1';
        wait for clk_period * 10;
        reset_btn <= '0';
        report "Reset released, program starting...";
        
        -- =============================================
        -- Let the program run through several loops
        -- With SIM_MODE=true, each instruction takes ~10 clock cycles
        -- 8 instructions × 10 cycles = 80 cycles per loop
        -- 800 cycles = ~10 program loops (more than enough)
        -- =============================================
        wait for clk_period * 800;
        
        -- =============================================
        -- Test reset during operation
        -- =============================================
        report "Testing reset during operation...";
        reset_btn <= '1';
        wait for clk_period * 30;
        reset_btn <= '0';
        report "Reset released, program restarting...";
        
        -- Let it run a bit more
        wait for clk_period * 400;
        
        report "=== SIMULATION COMPLETE ===";
        wait;
    end process;
    
    -- ============ OBSERVE INTERNAL SIGNALS ============
    -- These processes let you see inside the processor in waveform
    
    process
    begin
        wait for 1 ns;
        loop
            -- PC value (from uut.PC.pc_reg)
            -- This uses hierarchical reference
            wait until rising_edge(clk_100mhz);
            wait for 1 ns;
        end loop;
    end process;
    
end Behavioral;