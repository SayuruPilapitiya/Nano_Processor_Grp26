----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2026 12:02:39 PM
-- Design Name: 
-- Module Name: Instruction_Decoder_TB - Behavioral
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

entity Instruction_Decoder_TB is
end Instruction_Decoder_TB;

architecture Behavioral of Instruction_Decoder_TB is
    signal instruction : STD_LOGIC_VECTOR(11 downto 0);
    signal zero_flag : STD_LOGIC;
    signal reg_write, imm_sel, alu_mode, alu_a_sel, alu_b_sel, jump_en : STD_LOGIC;
    signal reg_addr, reg_addr_a, reg_addr_b : STD_LOGIC_VECTOR(2 downto 0);
    signal imm_data : STD_LOGIC_VECTOR(3 downto 0);
    signal jump_addr : STD_LOGIC_VECTOR(2 downto 0);
begin
    uut: entity work.Instruction_Decoder
        port map (Instruction => instruction, Zero_Flag => zero_flag,
                  RegWrite => reg_write, ImmSel => imm_sel, ALU_Mode => alu_mode,
                  ALU_A_Sel => alu_a_sel, ALU_B_Sel => alu_b_sel, Jump_En => jump_en,
                  Reg_Addr => reg_addr, Reg_Addr_A => reg_addr_a, Reg_Addr_B => reg_addr_b,
                  Imm_Data => imm_data, Jump_Addr => jump_addr);
    
    stim: process
    begin
        zero_flag <= '0';
        
        -- MOVI R7, 5
        instruction <= "101110000101"; wait for 10 ns;
        -- RegWrite=1, ImmSel=1, ALU_A_Sel=1, ALU_B_Sel=1, ALU_Mode=0
        
        -- MOVI R1, 10
        instruction <= "100010001010"; wait for 10 ns;
        
        -- ADD R3, R5
        instruction <= "000111010000"; wait for 10 ns;
        -- RegWrite=1, ALU_A_Sel=0, ALU_B_Sel=0, ALU_Mode=0
        
        -- NEG R2
        instruction <= "010100000000"; wait for 10 ns;
        -- RegWrite=1, ALU_A_Sel=1, ALU_B_Sel=0, ALU_Mode=1
        
        -- JZR R1, 3 (Zero=0)
        zero_flag <= '0';
        instruction <= "11001000011"; wait for 10 ns;
        -- Jump_En=0
        
        -- JZR R1, 3 (Zero=1)
        zero_flag <= '1'; wait for 10 ns;
        -- Jump_En=1, Jump_Addr=011
        
        -- JZR R0, 0 (always jump since R0=0)
        zero_flag <= '1';
        instruction <= "11000000000"; wait for 10 ns;
        -- Jump_En=1, Jump_Addr=000
        
        wait;
    end process;
end Behavioral;