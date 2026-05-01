----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 06:14:36 PM
-- Design Name: 
-- Module Name: Nanoprocessor - Behavioral
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

entity Nanoprocessor is
    Port ( 
        Clk           : in  STD_LOGIC;
        Reset         : in  STD_LOGIC; -- The pushbutton to reset the PC and Registers
        C : out STD_LOGIC;
        
        -- Outputs to the physical board
        Zero_Flag     : out STD_LOGIC;
        Not_Zero_Flag     : out STD_LOGIC;
        Overflow_Flag : out STD_LOGIC;
        Equal_Flag : out STD_LOGIC;
        Greater_Flag : out STD_LOGIC;
        Less_Flag : out STD_LOGIC;
        Reg_7_Out     : out STD_LOGIC_VECTOR (3 downto 0);
        
        
        Anode_Out     : out STD_LOGIC_VECTOR (3 downto 0);
        -- New 7-Segment Pins
        Seg_Out       : out STD_LOGIC_VECTOR (6 downto 0)
    );
end Nanoprocessor;

architecture Structural of Nanoprocessor is

    -- ==========================================
    -- 1. COMPONENT DECLARATIONS
    -- ==========================================

    COMPONENT Program_Counter
        PORT(
            D     : IN std_logic_vector(2 downto 0);
            Reset : IN std_logic;
            Clk   : IN std_logic;
            Q     : OUT std_logic_vector(2 downto 0)
        );
    END COMPONENT;

    COMPONENT Adder_3_bit
        PORT(
            A     : IN std_logic_vector(2 downto 0);
            B     : IN std_logic_vector(2 downto 0);
            C_in  : IN std_logic;
            S     : OUT std_logic_vector(2 downto 0);
            C_out : OUT std_logic
        );
    END COMPONENT;

    COMPONENT Mux_2_to_1_3bit
        PORT(
            D0  : IN std_logic_vector(2 downto 0);
            D1  : IN std_logic_vector(2 downto 0);
            Sel : IN std_logic;
            Y   : OUT std_logic_vector(2 downto 0)
        );
    END COMPONENT;

    COMPONENT Program_ROM
        PORT(
            Address     : IN std_logic_vector(2 downto 0);
            Instruction : OUT std_logic_vector(11 downto 0)
        );
    END COMPONENT;

    COMPONENT Instruction_Decoder
        PORT(
            Instruction : IN std_logic_vector(11 downto 0);
            Reg_Check   : IN std_logic;
            Reg_En      : OUT std_logic_vector(2 downto 0);
            Load_Sel    : OUT std_logic;
            Imm_Val     : OUT std_logic_vector(3 downto 0);
            Reg_Sel_A   : OUT std_logic_vector(2 downto 0);
            Reg_Sel_B   : OUT std_logic_vector(2 downto 0);
            Add_Sub_Sel : OUT std_logic;
            Jump_Flag   : OUT std_logic;
            Jump_Addr   : OUT std_logic_vector(2 downto 0)
        );
    END COMPONENT;

    COMPONENT Register_Bank
        PORT(
            Data_In : IN std_logic_vector(3 downto 0);
            Reg_En  : IN std_logic_vector(2 downto 0);
            Clk     : IN std_logic;
            Reset   : IN std_logic;
            R0      : OUT std_logic_vector(3 downto 0);
            R1      : OUT std_logic_vector(3 downto 0);
            R2      : OUT std_logic_vector(3 downto 0);
            R3      : OUT std_logic_vector(3 downto 0);
            R4      : OUT std_logic_vector(3 downto 0);
            R5      : OUT std_logic_vector(3 downto 0);
            R6      : OUT std_logic_vector(3 downto 0);
            R7      : OUT std_logic_vector(3 downto 0);
            R7_prev : OUT std_logic_vector(3 downto 0)
        );
    END COMPONENT;

    COMPONENT Mux_8_to_1_4bit
        PORT(
            D0, D1, D2, D3, D4, D5, D6, D7 : IN std_logic_vector(3 downto 0);
            Sel : IN std_logic_vector(2 downto 0);
            Y   : OUT std_logic_vector(3 downto 0)
        );
    END COMPONENT;

    COMPONENT Mux_2_to_1_4bit
        PORT(
            D0  : IN std_logic_vector(3 downto 0);
            D1  : IN std_logic_vector(3 downto 0);
            Sel : IN std_logic;
            Y   : OUT std_logic_vector(3 downto 0)
        );
    END COMPONENT;

    COMPONENT Add_Sub_4bit
        PORT(
            A        : IN std_logic_vector(3 downto 0);
            B        : IN std_logic_vector(3 downto 0);
            Ctrl     : IN std_logic;
            S        : OUT std_logic_vector(3 downto 0);
            Overflow : OUT std_logic;
            Zero     : OUT std_logic
        );
    END COMPONENT;
    
    COMPONENT Slow_Clock
            PORT(
                Clk_in  : IN std_logic;
                Clk_out : OUT std_logic
            );
        END COMPONENT;
        
    COMPONENT LUT_16_7
                PORT(
                    address : IN std_logic_vector(3 downto 0);
                    data    : OUT std_logic_vector(6 downto 0)
                );
            END COMPONENT;
            
    COMPONENT Status_Reg
                PORT(
                   Clk : in STD_LOGIC;
                   Reset : in STD_LOGIC;
                   D_in : in STD_LOGIC_VECTOR (7 downto 0);
                   Flag_Slc : in STD_LOGIC_VECTOR (2 downto 0);
                   Flag_Out : out STD_LOGIC;
                   D_out : out STD_LOGIC_VECTOR (7 downto 0)
                );
            END COMPONENT;
                        


    -- ==========================================
    -- 2. INTERNAL SIGNALS (The "Wires")
    -- ==========================================

    -- PC and Execution signals
    signal PC_Output      : std_logic_vector(2 downto 0);
    signal Next_PC        : std_logic_vector(2 downto 0);
    signal PC_Plus_One    : std_logic_vector(2 downto 0);
    signal ROM_Data       : std_logic_vector(11 downto 0);
    signal Dummy_Carry    : std_logic; -- Captures unused carry out from 3-bit adder

    -- Decoder Control Signals
    signal Dec_Reg_En     : std_logic_vector(2 downto 0);
    signal Dec_Load_Sel   : std_logic;
    signal Dec_Imm_Val    : std_logic_vector(3 downto 0);
    signal Dec_Reg_Sel_A  : std_logic_vector(2 downto 0);
    signal Dec_Reg_Sel_B  : std_logic_vector(2 downto 0);
    signal Dec_Add_Sub_Sel: std_logic;
    signal Jump  : std_logic;
    signal Dec_Jump_Flag  : std_logic;
    signal Dec_Jump_Addr  : std_logic_vector(2 downto 0);
    signal Zero_F : std_logic;
    
    --
    signal Flag_Slc : std_logic_vector(2 downto 0);
    signal Status_Data_in : std_logic_vector(7 downto 0);
    signal Flag_Out : std_logic;
    signal Status_Data_out : std_logic_vector(7 downto 0);

    -- Data Path Signals
    signal R0_Out, R1_Out, R2_Out, R3_Out : std_logic_vector(3 downto 0);
    signal R4_Out, R5_Out, R6_Out, R7_Out : std_logic_vector(3 downto 0);
    signal R7_prev_Out : std_logic_vector(3 downto 0);
    
    signal Mux_A_Out      : std_logic_vector(3 downto 0);
    signal Mux_B_Out      : std_logic_vector(3 downto 0);
    signal Add_Sub_Result : std_logic_vector(3 downto 0);
    signal Data_Bus       : std_logic_vector(3 downto 0);
    
    
    
    --Slow Clock
    signal Clk_Slow : std_logic;

begin

    -- ==========================================
    -- 3. PORT MAPPING (Wiring it all together)
    -- ==========================================

    -- 0. The Clock Divider (Creates the 2-second tick)
    Slow_Clock_Inst: Slow_Clock PORT MAP (
        Clk_in  => Clk,      
        Clk_out => Clk_Slow  
    );

    -- 1. Program Counter Loop
    PC_Inst: Program_Counter PORT MAP(
        D     => Next_PC,
        Reset => Reset,
        Clk   => Clk_Slow,   -- Using the slow clock
        Q     => PC_Output
    );

    Adder_3_Inst: Adder_3_bit PORT MAP(
        A     => PC_Output,
        B     => "001", -- Hardcoded to add 1
        C_in  => '0',
        S     => PC_Plus_One,
        C_out => Dummy_Carry
    );

    Mux_PC_Jump: Mux_2_to_1_3bit PORT MAP(
        D0  => PC_Plus_One,
        D1  => Dec_Jump_Addr,
        Sel => Dec_Jump_Flag,
        Y   => Next_PC
    );

    -- 2. ROM
    ROM_Inst: Program_ROM PORT MAP(
        Address     => PC_Output,
        Instruction => ROM_Data
    );

    -- 3. Instruction Decoder
    Decoder_Inst: Instruction_Decoder PORT MAP(
        Instruction => ROM_Data,
        Reg_Check   => Flag_Out,
        Reg_En      => Dec_Reg_En,
        Load_Sel    => Dec_Load_Sel,
        Imm_Val     => Dec_Imm_Val,
        Reg_Sel_A   => Dec_Reg_Sel_A,
        Reg_Sel_B   => Dec_Reg_Sel_B,
        Add_Sub_Sel => Dec_Add_Sub_Sel,
        Jump_Flag   => Jump,
        Jump_Addr   => Dec_Jump_Addr
    );

    -- 4. Register Bank (Correctly mapped!)
    Reg_Bank_Inst: Register_Bank PORT MAP(
        Data_In => Data_Bus,
        Reg_En  => Dec_Reg_En,
        Clk     => Clk_Slow,   -- Using the slow clock
        Reset   => Reset,
        R0      => R0_Out,
        R1      => R1_Out,
        R2      => R2_Out,
        R3      => R3_Out,
        R4      => R4_Out,
        R5      => R5_Out,
        R6      => R6_Out,
        R7      => R7_Out,
        R7_prev => R7_prev_Out
    );

    -- 5. Data Multiplexers (A and B)
    Mux_A_Inst: Mux_8_to_1_4bit PORT MAP(
        D0 => R0_Out, D1 => R1_Out, D2 => R2_Out, D3 => R3_Out,
        D4 => R4_Out, D5 => R5_Out, D6 => R6_Out, D7 => R7_Out,
        Sel => Dec_Reg_Sel_A,
        Y   => Mux_A_Out
    );

    Mux_B_Inst: Mux_8_to_1_4bit PORT MAP(
        D0 => R0_Out, D1 => R1_Out, D2 => R2_Out, D3 => R3_Out,
        D4 => R4_Out, D5 => R5_Out, D6 => R6_Out, D7 => R7_Out,
        Sel => Dec_Reg_Sel_B,
        Y   => Mux_B_Out
    );

    -- 6. Add/Subtract Unit
    Add_Sub_Inst: Add_Sub_4bit PORT MAP(
        A        => Mux_A_Out,
        B        => Mux_B_Out,
        Ctrl     => Dec_Add_Sub_Sel,
        S        => Add_Sub_Result,
        Overflow => Overflow_Flag,
        Zero     => Zero_F
    );

    -- 7. Load Selection Multiplexer (Back to Registers)
    Mux_Load_Inst: Mux_2_to_1_4bit PORT MAP(
        D0  => Add_Sub_Result,
        D1  => Dec_Imm_Val,
        Sel => Dec_Load_Sel,
        Y   => Data_Bus
    );
    
    Status_Reg_Inst: Status_Reg PORT MAP(
        Clk => Clk_Slow,
        Reset => Reset,
        D_in => Status_Data_in,
        Flag_Slc => Flag_Slc,-----------------
        Flag_Out => Flag_Out,
        D_out => Status_Data_out);
        
        

-- ==========================================
    -- 4. FINAL OUTPUT ROUTING
    -- ==========================================
    -- Route Register 7's output to the physical LEDs
    Reg_7_Out <= R7_prev_Out;
    
    Zero_Flag <= Status_Data_out(0);
    Not_Zero_Flag <= Status_Data_out(1);
    Overflow_Flag <= Status_Data_out(2);
    Equal_Flag <= Status_Data_out(3);
    Greater_Flag <= Status_Data_out(4);
    Less_Flag <= Status_Data_out(5);
    
    C <= Clk_Slow;
    
    Status_Data_in(0) <= Zero_F;
    Status_Data_in (7 downto 1) <= "0110100";
    
    -- Turn ON only the right-most 7-segment digit (Active Low: 0 means ON)
    Anode_Out <= "0000"; 
    Dec_Jump_Flag <= Jump and Flag_Out;

    -- Connect the 7-Segment Decoder
    Seven_Seg_Inst: LUT_16_7 PORT MAP(
        address => R7_prev_Out,  -- Read the value from Register 7
        data    => Seg_Out  -- Send the decoded segments to the physical pins
    );

end Structural;
