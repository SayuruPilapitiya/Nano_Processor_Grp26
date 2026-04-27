----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 09:53:59 PM
-- Design Name: 
-- Module Name: ROM_Program - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 12-bit wide Program ROM (8 locations for 3-bit PC)
--              Stores machine code for sum of integers 1 to 3
--              Result stored in R7 = 6
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- Engineer: [Your Name]
-- Module Name: ROM_Program
-- Description: 12-bit wide Program ROM (8 locations for 3-bit PC)
--              Stores machine code for sum of integers 1 to 3
--              Result stored in R7 = 6
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ROM_Program is
    Port (
        Address     : in  STD_LOGIC_VECTOR (2 downto 0);
        Instruction : out STD_LOGIC_VECTOR (11 downto 0)
    );
end ROM_Program;

architecture Behavioral of ROM_Program is
    type rom_array is array (0 to 7) of STD_LOGIC_VECTOR(11 downto 0);
    
    -- Program: Calculate sum of all integers from 1 to 3
    -- Result: R7 = 1 + 2 + 3 = 6
    --
    -- Address 0: MOVI R7, 0    ; R7 = 0 (accumulator)
    -- Address 1: MOVI R1, 1    ; R1 = 1
    -- Address 2: ADD R7, R1    ; R7 = 0 + 1 = 1
    -- Address 3: MOVI R1, 2    ; R1 = 2
    -- Address 4: ADD R7, R1    ; R7 = 1 + 2 = 3
    -- Address 5: MOVI R1, 3    ; R1 = 3
    -- Address 6: ADD R7, R1    ; R7 = 3 + 3 = 6
    -- Address 7: JZR R0, 0     ; Infinite loop (R0 always 0 ? always jump to 0)
    --
    -- Instruction Formats:
    -- MOVI R, d : 10 RRR 000 dddd
    -- ADD Ra, Rb : 00 RaRaRa RbRbRb 0000
    -- JZR R, d  : 11 RRR 000 ddd
    
    constant program : rom_array := (
        0 => "101110000000",  -- MOVI R7, 0   : 10 111 000 0000
        1 => "100010000001",  -- MOVI R1, 1   : 10 001 000 0001
        2 => "001110010000",  -- ADD R7, R1   : 00 111 001 0000
        3 => "100010000010",  -- MOVI R1, 2   : 10 001 000 0010
        4 => "001110010000",  -- ADD R7, R1   : 00 111 001 0000
        5 => "100010000011",  -- MOVI R1, 3   : 10 001 000 0011
        6 => "001110010000",  -- ADD R7, R1   : 00 111 001 0000
        7 => "110000000000"   -- JZR R0, 0    : 11 000 000 0000
    );
    
begin
    Instruction <= program(to_integer(unsigned(Address)));
end Behavioral;