----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2026 05:22:19 PM
-- Design Name: 
-- Module Name: NanoProcessor_Top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 4-bit Nanoprocessor - Top Level
--              Integrates: Slow_Clock, PC, ROM, Decoder, Register Bank,
--              Muxes, ALU (with overflow detection), 7-Seg Display
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

entity NanoProcessor_Top is
    Port (
        Clk_100MHz   : in  STD_LOGIC;
        Reset_Btn    : in  STD_LOGIC;
        LED_Output   : out STD_LOGIC_VECTOR (3 downto 0);  -- R7 value
        Zero_LED     : out STD_LOGIC;  -- LD15: Zero Flag
        Carry_LED    : out STD_LOGIC;  -- LD14: Carry Flag
        Overflow_LED : out STD_LOGIC;  -- LD13: Overflow Flag
        Seg_Out      : out STD_LOGIC_VECTOR (6 downto 0);
        Anode_Out    : out STD_LOGIC_VECTOR (3 downto 0)
    );
end NanoProcessor_Top;

architecture Behavioral of NanoProcessor_Top is

    -- ==================== COMPONENT DECLARATIONS ====================
    
    component Slow_Clock is
        Generic (SIM_MODE : boolean := true);
        Port (Clk_in : in STD_LOGIC; Reset : in STD_LOGIC; Clk_out : out STD_LOGIC);
    end component;
    
    component Adder_3bit is
        Port (A : in STD_LOGIC_VECTOR(2 downto 0); Sum : out STD_LOGIC_VECTOR(2 downto 0));
    end component;
    
    component Mux_2way_3bit is
        Port (A, B : in STD_LOGIC_VECTOR(2 downto 0); Sel : in STD_LOGIC; Y : out STD_LOGIC_VECTOR(2 downto 0));
    end component;
    
    component Program_Counter is
        Port (Clk, Reset : in STD_LOGIC; Next_Addr : in STD_LOGIC_VECTOR(2 downto 0); PC_out : out STD_LOGIC_VECTOR(2 downto 0));
    end component;
    
    component ROM_Program is
        Port (Address : in STD_LOGIC_VECTOR(2 downto 0); Instruction : out STD_LOGIC_VECTOR(11 downto 0));
    end component;
    
    component Instruction_Decoder is
        Port (Instruction : in STD_LOGIC_VECTOR(11 downto 0); Zero_Flag : in STD_LOGIC;
              RegWrite, ImmSel, ALU_Mode, ALU_A_Sel, ALU_B_Sel, Jump_En : out STD_LOGIC;
              Reg_Addr, Reg_Addr_A, Reg_Addr_B : out STD_LOGIC_VECTOR(2 downto 0);
              Imm_Data : out STD_LOGIC_VECTOR(3 downto 0); Jump_Addr : out STD_LOGIC_VECTOR(2 downto 0));
    end component;
    
    component Decoder_3_to_8 is
        Port (Sel : in STD_LOGIC_VECTOR(2 downto 0); En : in STD_LOGIC; Output : out STD_LOGIC_VECTOR(7 downto 0));
    end component;
    
    component Register_Bank is
        Port (Clk, Reset : in STD_LOGIC; Write_En : in STD_LOGIC_VECTOR(7 downto 0);
              Data_In : in STD_LOGIC_VECTOR(3 downto 0); Reg_Sel_A, Reg_Sel_B : in STD_LOGIC_VECTOR(2 downto 0);
              Reg_Out_A, Reg_Out_B, R7_Output : out STD_LOGIC_VECTOR(3 downto 0);
              R0_Out, R1_Out, R2_Out, R3_Out, R4_Out, R5_Out, R6_Out : out STD_LOGIC_VECTOR(3 downto 0));
    end component;
    
    component Mux_8way_4bit is
        Port (Input0, Input1, Input2, Input3, Input4, Input5, Input6, Input7 : in STD_LOGIC_VECTOR(3 downto 0);
              Sel : in STD_LOGIC_VECTOR(2 downto 0); Y : out STD_LOGIC_VECTOR(3 downto 0));
    end component;
    
    component Mux_2way_4bit is
        Port (A, B : in STD_LOGIC_VECTOR(3 downto 0); Sel : in STD_LOGIC; Y : out STD_LOGIC_VECTOR(3 downto 0));
    end component;
    
    component Adder_Subtractor_4bit is
        Port (A, B : in STD_LOGIC_VECTOR(3 downto 0); Mode : in STD_LOGIC;
              Result : out STD_LOGIC_VECTOR(3 downto 0); 
              Zero_Flag, Carry_Flag, Overflow_Flag : out STD_LOGIC);
    end component;
    
    component SevenSeg_Display is
        Port (Data_In : in STD_LOGIC_VECTOR(3 downto 0); 
              Seg_Out : out STD_LOGIC_VECTOR(6 downto 0); Anode_Out : out STD_LOGIC_VECTOR(3 downto 0));
    end component;

    -- ==================== INTERNAL SIGNALS ====================
    
    -- Clock
    signal slow_clk : STD_LOGIC;
    
    -- PC signals
    signal pc_out, pc_next, pc_mux_out, jump_addr : STD_LOGIC_VECTOR(2 downto 0);
    
    -- Instruction
    signal instruction : STD_LOGIC_VECTOR(11 downto 0);
    
    -- Control signals
    signal reg_write_en, imm_sel, alu_mode, alu_a_sel, alu_b_sel, jump_en : STD_LOGIC;
    
    -- Address signals
    signal reg_addr, reg_addr_a, reg_addr_b : STD_LOGIC_VECTOR(2 downto 0);
    
    -- Data signals
    signal imm_data : STD_LOGIC_VECTOR(3 downto 0);
    signal write_en_vector : STD_LOGIC_VECTOR(7 downto 0);
    
    -- Register outputs
    signal r7_val : STD_LOGIC_VECTOR(3 downto 0);
    signal r0_o, r1_o, r2_o, r3_o, r4_o, r5_o, r6_o : STD_LOGIC_VECTOR(3 downto 0);
    
    -- Muxed register outputs (from 8-way mux)
    signal mux_reg_out_a, mux_reg_out_b : STD_LOGIC_VECTOR(3 downto 0);
    
    -- ALU signals
    signal alu_a, alu_b, alu_result : STD_LOGIC_VECTOR(3 downto 0);
    signal alu_zero_f, alu_carry_f, alu_overflow_f : STD_LOGIC;
    
    -- JZR zero detection
    signal reg_zero_check : STD_LOGIC;

begin
    -- ==================== ZERO DETECTION FOR JZR ====================
    -- Checks if the register selected by Reg_Addr_A is zero
    -- This is the CORRECT way per lab spec: "If value in register R is 0"
    reg_zero_check <= '1' when mux_reg_out_a = "0000" else '0';

    -- ==================== INSTANTIATIONS ====================
    
    -- Slow Clock (change SIM_MODE to true for simulation)
    SC: Slow_Clock 
        generic map (SIM_MODE => true)
        port map (Clk_in => Clk_100MHz, Reset => Reset_Btn, Clk_out => slow_clk);
    
    -- PC Adder (+1)
    PC_Adder: Adder_3bit 
        port map (A => pc_out, Sum => pc_next);
    
    -- 2-way 3-bit Mux for PC input
    PC_Mux: Mux_2way_3bit 
        port map (A => pc_next, B => jump_addr, Sel => jump_en, Y => pc_mux_out);
    
    -- Program Counter
    PC: Program_Counter 
        port map (Clk => slow_clk, Reset => Reset_Btn, Next_Addr => pc_mux_out, PC_out => pc_out);
    
    -- Program ROM
    ROM: ROM_Program 
        port map (Address => pc_out, Instruction => instruction);
    
    -- Instruction Decoder
    Decoder_Inst: Instruction_Decoder 
        port map (
            Instruction => instruction,
            Zero_Flag   => reg_zero_check,
            RegWrite    => reg_write_en,
            ImmSel      => imm_sel,
            ALU_Mode    => alu_mode,
            ALU_A_Sel   => alu_a_sel,
            ALU_B_Sel   => alu_b_sel,
            Jump_En     => jump_en,
            Reg_Addr    => reg_addr,
            Reg_Addr_A  => reg_addr_a,
            Reg_Addr_B  => reg_addr_b,
            Imm_Data    => imm_data,
            Jump_Addr   => jump_addr
        );
    
    -- 3-to-8 Decoder for Register Write
    RegDec: Decoder_3_to_8 
        port map (Sel => reg_addr, En => reg_write_en, Output => write_en_vector);
    
    -- Register Bank
    RegBank: Register_Bank 
        port map (
            Clk => slow_clk, Reset => Reset_Btn,
            Write_En => write_en_vector, Data_In => alu_result,
            Reg_Sel_A => reg_addr_a, Reg_Sel_B => reg_addr_b,
            Reg_Out_A => open, Reg_Out_B => open,
            R7_Output => r7_val,
            R0_Out => r0_o, R1_Out => r1_o, R2_Out => r2_o, R3_Out => r3_o,
            R4_Out => r4_o, R5_Out => r5_o, R6_Out => r6_o
        );
    
    -- 8-way 4-bit Mux for Register Output A
    Reg_Mux_A: Mux_8way_4bit 
        port map (
            Input0 => r0_o, Input1 => r1_o, Input2 => r2_o, Input3 => r3_o,
            Input4 => r4_o, Input5 => r5_o, Input6 => r6_o, Input7 => r7_val,
            Sel => reg_addr_a, Y => mux_reg_out_a
        );
    
    -- 8-way 4-bit Mux for Register Output B
    Reg_Mux_B: Mux_8way_4bit 
        port map (
            Input0 => r0_o, Input1 => r1_o, Input2 => r2_o, Input3 => r3_o,
            Input4 => r4_o, Input5 => r5_o, Input6 => r6_o, Input7 => r7_val,
            Sel => reg_addr_b, Y => mux_reg_out_b
        );
    
    -- 2-way 4-bit Mux for ALU Input A (Register A or R0/Zero)
    Mux_ALU_A: Mux_2way_4bit 
        port map (A => mux_reg_out_a, B => "0000", Sel => alu_a_sel, Y => alu_a);
    
    -- 2-way 4-bit Mux for ALU Input B (Register B or Immediate)
    Mux_ALU_B: Mux_2way_4bit 
        port map (A => mux_reg_out_b, B => imm_data, Sel => alu_b_sel, Y => alu_b);
    
    -- ALU (4-bit Adder/Subtractor with overflow detection)
    ALU: Adder_Subtractor_4bit 
        port map (
            A => alu_a, B => alu_b, Mode => alu_mode,
            Result => alu_result, 
            Zero_Flag => alu_zero_f, 
            Carry_Flag => alu_carry_f,
            Overflow_Flag => alu_overflow_f
        );
    
    -- Seven Segment Display
    SevSeg: SevenSeg_Display 
        port map (
            Data_In => r7_val, 
            Seg_Out => Seg_Out, 
            Anode_Out => Anode_Out
        );
    
    -- ==================== OUTPUTS ====================
    LED_Output   <= r7_val;
    Zero_LED     <= alu_zero_f;
    Carry_LED    <= alu_carry_f;
    Overflow_LED <= alu_overflow_f;

end Behavioral;