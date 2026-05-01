----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 06:34:30 PM
-- Design Name: 
-- Module Name: TB_Nanoprocessor - Behavioral
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

entity TB_Nanoprocessor is
-- Testbench has no ports
end TB_Nanoprocessor;

architecture Behavior of TB_Nanoprocessor is

    -- Component Declaration for the UUT (Unit Under Test)
    COMPONENT Nanoprocessor
    PORT(
         Clk           : IN  std_logic;
         Reset         : IN  std_logic;
         Zero_Flag     : OUT std_logic;
         Overflow_Flag : OUT std_logic;
         Reg_7_Out     : OUT std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    
    -- Inputs
    signal Clk   : std_logic := '0';
    signal Reset : std_logic := '0';

    -- Outputs
    signal Zero_Flag     : std_logic;
    signal Overflow_Flag : std_logic;
    signal Reg_7_Out     : std_logic_vector(3 downto 0);

    -- Clock period definition (Simulating a fast clock for the testbench)
    constant Clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Nanoprocessor PORT MAP (
          Clk => Clk,
          Reset => Reset,
          Zero_Flag => Zero_Flag,
          Overflow_Flag => Overflow_Flag,
          Reg_7_Out => Reg_7_Out
        );

    -- Clock process definitions
    Clk_process :process
    begin
        Clk <= '0';
        wait for Clk_period/2;
        Clk <= '1';
        wait for Clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin		
        -- 1. Hold reset state initially to clear the PC and Registers
        Reset <= '1';
        wait for 20 ns;	
        
        -- 2. Release reset and let the processor run the ROM program
        Reset <= '0';
        
        -- The program has 8 lines. We wait enough clock cycles for it to finish.
        -- Watch the waveform for Reg_7_Out. 
        -- It should change: 0000 -> 0001 -> 0011 -> 0110 (which is 6 in decimal!)
        wait for Clk_period * 10;
        
        -- 3. Test the manual reset button mid-execution (Optional safety check)
        Reset <= '1';
        wait for Clk_period * 2;
        Reset <= '0';

        wait; -- Suspend simulation
    end process;

end Behavior;
