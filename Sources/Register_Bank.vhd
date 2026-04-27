----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2026 11:12:56 AM
-- Design Name: 
-- Module Name: Register_Bank - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 8 x 4-bit Register Bank
--              R0 hardwired to "0000" (read-only zero)
--              Synchronous write, asynchronous read
--              All registers reset to 0
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

entity Register_Bank is
    Port (
        Clk        : in  STD_LOGIC;
        Reset      : in  STD_LOGIC;
        Write_En   : in  STD_LOGIC_VECTOR (7 downto 0);  -- One-hot from decoder
        Data_In    : in  STD_LOGIC_VECTOR (3 downto 0);
        Reg_Sel_A  : in  STD_LOGIC_VECTOR (2 downto 0);  -- Read port A
        Reg_Sel_B  : in  STD_LOGIC_VECTOR (2 downto 0);  -- Read port B
        Reg_Out_A  : out STD_LOGIC_VECTOR (3 downto 0);
        Reg_Out_B  : out STD_LOGIC_VECTOR (3 downto 0);
        R7_Output  : out STD_LOGIC_VECTOR (3 downto 0);  -- Direct R7 for display
        -- Individual register outputs for external 8-way mux connection
        R0_Out     : out STD_LOGIC_VECTOR (3 downto 0);
        R1_Out     : out STD_LOGIC_VECTOR (3 downto 0);
        R2_Out     : out STD_LOGIC_VECTOR (3 downto 0);
        R3_Out     : out STD_LOGIC_VECTOR (3 downto 0);
        R4_Out     : out STD_LOGIC_VECTOR (3 downto 0);
        R5_Out     : out STD_LOGIC_VECTOR (3 downto 0);
        R6_Out     : out STD_LOGIC_VECTOR (3 downto 0)
    );
end Register_Bank;
    
architecture Behavioral of Register_Bank is
    type reg_array is array (0 to 7) of STD_LOGIC_VECTOR(3 downto 0);
    signal registers : reg_array := (others => (others => '0'));
begin
    -- Synchronous write process (skip R0 - always stays 0)
    process(Clk, Reset)
    begin
        if Reset = '1' then
            registers <= (others => (others => '0'));
        elsif rising_edge(Clk) then
            for i in 1 to 7 loop
                if Write_En(i) = '1' then
                    registers(i) <= Data_In;
                end if;
            end loop;
            -- R0 (index 0) never written - hardwired to 0
        end if;
    end process;
    
    -- Asynchronous reads - R0 always returns "0000"
    Reg_Out_A <= (others => '0') when Reg_Sel_A = "000" 
                 else registers(to_integer(unsigned(Reg_Sel_A)));
    Reg_Out_B <= (others => '0') when Reg_Sel_B = "000" 
                 else registers(to_integer(unsigned(Reg_Sel_B)));
    
    -- Direct register outputs for 7-segment display
    R7_Output <= registers(7);
    
    -- Individual register outputs for external 8-way mux
    R0_Out <= (others => '0');  -- R0 always 0
    R1_Out <= registers(1);
    R2_Out <= registers(2);
    R3_Out <= registers(3);
    R4_Out <= registers(4);
    R5_Out <= registers(5);
    R6_Out <= registers(6);
end Behavioral;