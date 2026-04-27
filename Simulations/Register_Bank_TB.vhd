----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2026 12:01:27 PM
-- Design Name: 
-- Module Name: Register_Bank_TB - Behavioral
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

entity Register_Bank_TB is
end Register_Bank_TB;

architecture Behavioral of Register_Bank_TB is

    -- All signals initialized to avoid 'U' (uninitialized) values
    signal clk       : STD_LOGIC := '0';
    signal reset     : STD_LOGIC := '1';  -- Start in reset
    signal write_en  : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal data_in   : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal reg_sel_a : STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal reg_sel_b : STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal reg_out_a : STD_LOGIC_VECTOR(3 downto 0);
    signal reg_out_b : STD_LOGIC_VECTOR(3 downto 0);
    signal r7_out    : STD_LOGIC_VECTOR(3 downto 0);
    signal r0_o, r1_o, r2_o, r3_o, r4_o, r5_o, r6_o : STD_LOGIC_VECTOR(3 downto 0);
    
    constant clk_period : time := 10 ns;
    
begin

    -- Unit Under Test
    uut: entity work.Register_Bank
        port map (
            Clk       => clk,
            Reset     => reset,
            Write_En  => write_en,
            Data_In   => data_in,
            Reg_Sel_A => reg_sel_a,
            Reg_Sel_B => reg_sel_b,
            Reg_Out_A => reg_out_a,
            Reg_Out_B => reg_out_b,
            R7_Output => r7_out,
            R0_Out    => r0_o,
            R1_Out    => r1_o,
            R2_Out    => r2_o,
            R3_Out    => r3_o,
            R4_Out    => r4_o,
            R5_Out    => r5_o,
            R6_Out    => r6_o
        );
    
    -- Clock process
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
    -- Stimulus process
    stim: process
    begin
        -- =============================================
        -- Hold reset for 2 clock cycles
        -- This clears all registers to 0
        -- =============================================
        reset <= '1';
        wait for clk_period * 2;
        reset <= '0';
        wait for clk_period;  -- Extra cycle to settle
        
        -- =============================================
        -- Verify reset: all registers should be 0
        -- =============================================
        reg_sel_a <= "001"; wait for 5 ns;  -- R1 = 0000
        reg_sel_a <= "010"; wait for 5 ns;  -- R2 = 0000
        reg_sel_a <= "111"; wait for 5 ns;  -- R7 = 0000
        
        -- =============================================
        -- Write 5 to R1
        -- =============================================
        write_en <= "00000010";  -- One-hot: bit 1 = R1
        data_in  <= "0101";      -- Value = 5
        wait for clk_period;     -- Write happens on rising edge
        
        write_en <= (others => '0');  -- Disable write
        wait for 1 ns;                -- Tiny delay for signals to settle
        
        reg_sel_a <= "001"; wait for 5 ns;  -- Read R1
        -- Expected: reg_out_a = 0101
        
        -- =============================================
        -- Write 10 (1010) to R5
        -- =============================================
        write_en <= "00100000";  -- One-hot: bit 5 = R5
        data_in  <= "1010";      -- Value = 10
        wait for clk_period;
        
        write_en <= (others => '0');
        wait for 1 ns;
        
        reg_sel_a <= "101"; wait for 5 ns;  -- Read R5
        -- Expected: reg_out_a = 1010
        
        -- =============================================
        -- Try to write 15 (1111) to R0 ? Should be IGNORED
        -- =============================================
        write_en <= "00000001";  -- One-hot: bit 0 = R0
        data_in  <= "1111";      -- Try to write 15
        wait for clk_period;
        
        write_en <= (others => '0');
        wait for 1 ns;
        
        reg_sel_a <= "000"; wait for 5 ns;  -- Read R0
        -- Expected: reg_out_a = 0000 (hardwired, write ignored)
        
        -- =============================================
        -- Dual-port read: R1 and R5 at the SAME TIME
        -- =============================================
        reg_sel_a <= "001";  -- Port A ? R1 (should be 5)
        reg_sel_b <= "101";  -- Port B ? R5 (should be 10)
        wait for 5 ns;
        -- Expected: reg_out_a = 0101, reg_out_b = 1010
        
        -- =============================================
        -- Write 6 to R7 (final answer for our program)
        -- =============================================
        write_en <= "10000000";  -- One-hot: bit 7 = R7
        data_in  <= "0110";      -- Value = 6
        wait for clk_period;
        
        write_en <= (others => '0');
        wait for 1 ns;
        -- Expected: r7_out = 0110
        
        -- =============================================
        -- Verify individual register output pins
        -- =============================================
        wait for 5 ns;
        -- Expected: r0_o=0000, r1_o=0101, r2_o=0000, r3_o=0000
        --           r4_o=0000, r5_o=1010, r6_o=0000, r7_out=0110
        
        -- =============================================
        -- Reset: Everything should go back to 0
        -- =============================================
        reset <= '1';
        wait for clk_period * 2;
        reset <= '0';
        wait for clk_period;
        
        -- Verify all cleared
        reg_sel_a <= "001"; wait for 5 ns;  -- R1 = 0000
        reg_sel_a <= "101"; wait for 5 ns;  -- R5 = 0000
        reg_sel_a <= "111"; wait for 5 ns;  -- R7 = 0000
        
        -- =============================================
        -- Sequential writes to R2, R3, R4
        -- =============================================
        write_en <= "00000100"; data_in <= "0011"; wait for clk_period;  -- R2 = 3
        write_en <= "00001000"; data_in <= "0100"; wait for clk_period;  -- R3 = 4
        write_en <= "00010000"; data_in <= "0101"; wait for clk_period;  -- R4 = 5
        
        write_en <= (others => '0');
        wait for 1 ns;
        
        -- Read all three
        reg_sel_a <= "010"; wait for 5 ns;  -- R2 = 0011 (3)
        reg_sel_a <= "011"; wait for 5 ns;  -- R3 = 0100 (4)
        reg_sel_a <= "100"; wait for 5 ns;  -- R4 = 0101 (5)
        
        wait;
    end process;
end Behavioral;