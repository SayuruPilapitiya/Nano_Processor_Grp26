----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2026 11:47:00 AM
-- Design Name: 
-- Module Name: Adder_Subtractor_4bit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 4-bit Adder/Subtractor using RCA_4 from Lab 3
--              Mode=0: Addition (A + B)
--              Mode=1: Subtraction (A - B, using 2's complement)
--              Incorporates XOR gates on B inputs for inversion
--              Outputs Zero Flag and Carry Flag
--              Overflow detection using Cin(MSB) XOR Cout(MSB)
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

entity Adder_Subtractor_4bit is
    Port (
        A             : in  STD_LOGIC_VECTOR (3 downto 0);
        B             : in  STD_LOGIC_VECTOR (3 downto 0);
        Mode          : in  STD_LOGIC;
        Result        : out STD_LOGIC_VECTOR (3 downto 0);
        Zero_Flag     : out STD_LOGIC;
        Carry_Flag    : out STD_LOGIC;
        Overflow_Flag : out STD_LOGIC
    );
end Adder_Subtractor_4bit;

architecture Behavioral of Adder_Subtractor_4bit is

    component RCA_4 is
        Port (
            A0, A1, A2, A3 : in  STD_LOGIC;
            B0, B1, B2, B3 : in  STD_LOGIC;
            C_in           : in  STD_LOGIC;
            S0, S1, S2, S3 : out STD_LOGIC;
            C_out          : out STD_LOGIC;
            C_MSB_in       : out STD_LOGIC
        );
    end component;

    signal b_xor        : STD_LOGIC_VECTOR (3 downto 0);
    signal sum_internal : STD_LOGIC_VECTOR (3 downto 0);
    signal carry_in     : STD_LOGIC;
    signal carry_out    : STD_LOGIC;
    signal carry_msb_in : STD_LOGIC;

begin
    -- Two's complement: XOR B with Mode
    -- Mode=0 ? B unchanged, Mode=1 ? B inverted
    b_xor(0) <= B(0) xor Mode;
    b_xor(1) <= B(1) xor Mode;
    b_xor(2) <= B(2) xor Mode;
    b_xor(3) <= B(3) xor Mode;
    
    -- Mode=0 ? Cin=0 (add), Mode=1 ? Cin=1 (subtract)
    carry_in <= Mode;

    -- Your RCA_4 from Lab 3
    RCA_Instance: RCA_4
        port map (
            A0 => A(0), A1 => A(1), A2 => A(2), A3 => A(3),
            B0 => b_xor(0), B1 => b_xor(1), B2 => b_xor(2), B3 => b_xor(3),
            C_in     => carry_in,
            S0 => sum_internal(0), S1 => sum_internal(1),
            S2 => sum_internal(2), S3 => sum_internal(3),
            C_out    => carry_out,
            C_MSB_in => carry_msb_in
        );

    -- Outputs
    Result        <= sum_internal;
    Carry_Flag    <= carry_out;
    Zero_Flag     <= '1' when sum_internal = "0000" else '0';
    
    -- Overflow = Cin(MSB) XOR Cout(MSB)
    -- carry_msb_in = FA2_C (carry going INTO bit 3)
    -- carry_out = C_out (carry coming OUT of bit 3)
    Overflow_Flag <= carry_msb_in xor carry_out;

end Behavioral;