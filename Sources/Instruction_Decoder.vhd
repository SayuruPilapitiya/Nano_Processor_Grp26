----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2026 11:17:54 AM
-- Design Name: 
-- Module Name: Instruction_Decoder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Decodes 12-bit instructions into control signals
--              Supports: MOVI, ADD, NEG, JZR
--              JZR checks Zero_Flag from register zero detection
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

entity Instruction_Decoder is
    Port (
        Instruction : in  STD_LOGIC_VECTOR (11 downto 0);
        Zero_Flag   : in  STD_LOGIC;  -- From register zero detection logic
        -- Control Signals
        RegWrite    : out STD_LOGIC;
        ImmSel      : out STD_LOGIC;
        ALU_Mode    : out STD_LOGIC;
        ALU_A_Sel   : out STD_LOGIC;
        ALU_B_Sel   : out STD_LOGIC;
        Jump_En     : out STD_LOGIC;
        -- Extracted fields
        Reg_Addr    : out STD_LOGIC_VECTOR (2 downto 0);
        Reg_Addr_A  : out STD_LOGIC_VECTOR (2 downto 0);
        Reg_Addr_B  : out STD_LOGIC_VECTOR (2 downto 0);
        Imm_Data    : out STD_LOGIC_VECTOR (3 downto 0);
        Jump_Addr   : out STD_LOGIC_VECTOR (2 downto 0)
    );
end Instruction_Decoder;

architecture Behavioral of Instruction_Decoder is
    signal opcode : STD_LOGIC_VECTOR(1 downto 0);
begin
    opcode <= Instruction(11 downto 10);
    
    process(Instruction, opcode, Zero_Flag)
    begin
        -- Default values (safe state)
        RegWrite  <= '0';
        ImmSel    <= '0';
        ALU_Mode  <= '0';
        ALU_A_Sel <= '0';
        ALU_B_Sel <= '0';
        Jump_En   <= '0';
        Reg_Addr  <= Instruction(9 downto 7);
        Reg_Addr_A <= Instruction(9 downto 7);
        Reg_Addr_B <= Instruction(6 downto 4);
        Imm_Data  <= Instruction(3 downto 0);
        Jump_Addr <= Instruction(2 downto 0);
        
        case opcode is
            -- MOVI R, d : 10 RRR 000 dddd
            when "10" =>
                RegWrite  <= '1';
                ImmSel    <= '1';
                ALU_A_Sel <= '1';    -- Select R0 (0) for ALU A
                ALU_B_Sel <= '1';    -- Select immediate for ALU B
                ALU_Mode  <= '0';    -- Add: 0 + d = d
                
            -- ADD Ra, Rb : 00 RaRaRa RbRbRb 0000
            when "00" =>
                RegWrite  <= '1';
                ALU_A_Sel <= '0';    -- Select Reg_A (Ra)
                ALU_B_Sel <= '0';    -- Select Reg_B (Rb)
                ALU_Mode  <= '0';    -- Add: Ra + Rb
                Reg_Addr  <= Instruction(9 downto 7);
                
            -- NEG R : 01 RRR 000 00000
            when "01" =>
                RegWrite  <= '1';
                ALU_A_Sel <= '1';    -- Select R0 (0)
                ALU_B_Sel <= '0';    -- Select Reg_A (R)
                ALU_Mode  <= '1';    -- Subtract: 0 - R = -R
                
            -- JZR R, d : 11 RRR 000 ddd
            when "11" =>
                if Zero_Flag = '1' then
                    Jump_En <= '1';
                else
                    Jump_En <= '0';
                end if;
                Reg_Addr_A <= Instruction(9 downto 7);  -- Register to check
                Jump_Addr  <= Instruction(2 downto 0);
                
            when others =>
                null;  -- Defaults already set
        end case;
    end process;
end Behavioral;