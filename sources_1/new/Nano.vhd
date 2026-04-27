library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Nano is Port ( 
    Clk : in STD_LOGIC;
    Reset : in STD_LOGIC;
    Addres : out STD_LOGIC_VECTOR (2 downto 0);
    I1 : out STD_LOGIC_VECTOR (11 downto 0);
    I2 : out STD_LOGIC_VECTOR (11 downto 0);
    Debug_1 : out STD_LOGIC;
    Debug_3 : out STD_LOGIC_VECTOR (2 downto 0);
    Debug_4 : out STD_LOGIC_VECTOR (3 downto 0);
    IN1 : out STD_LOGIC_VECTOR (3 downto 0);
    IN2 : out STD_LOGIC_VECTOR (3 downto 0);
    Debug_4B : out STD_LOGIC_VECTOR (3 downto 0);
    Debug_8 : out STD_LOGIC_VECTOR (7 downto 0);
    Flag : out STD_LOGIC);
end Nano;

architecture Behavioral of Nano is

component PC Port ( 
    D : in STD_LOGIC_VECTOR (2 downto 0);
    Clk : in STD_LOGIC;
    Reset : in STD_LOGIC;
    Q : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component Program_ROM Port ( 
    Address : in STD_LOGIC_VECTOR (2 downto 0);
    Instruction : out STD_LOGIC_VECTOR (11 downto 0));
end component;

component Instruction_Reg is Port ( 
    Clk : in STD_LOGIC;
    Reset : in STD_LOGIC;
    D : in STD_LOGIC_VECTOR (11 downto 0);
    Q : out STD_LOGIC_VECTOR (11 downto 0));
end component;


component Instruction_Decoder Port ( 
    Instruction : in STD_LOGIC_VECTOR (11 downto 0);
    RegZero : in STD_LOGIC;
    RegA : out STD_LOGIC_VECTOR (2 downto 0);
    RegB : out STD_LOGIC_VECTOR (2 downto 0);
    ENB : out STD_LOGIC;
    AddSubSelect : out STD_LOGIC;
    LoadSelect : out STD_LOGIC;
    Value : out STD_LOGIC_VECTOR (3 downto 0);
    JumpFlag : out STD_LOGIC;
    WriteReg : out STD_LOGIC;
    JumpAddress : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component RCA_4 Port ( 
    A : IN STD_LOGIC_VECTOR (3 downto 0);
    B : IN STD_LOGIC_VECTOR (3 downto 0);
    C_in : IN STD_LOGIC;
    S : OUT STD_LOGIC_VECTOR (3 downto 0);
    C_out : OUT STD_LOGIC);
end component;

component MUX_2_to_1 Port ( 
    B1 : in STD_LOGIC_VECTOR (2 downto 0);
    B2 : in STD_LOGIC_VECTOR (2 downto 0);
    Bus_Sel : in STD_LOGIC;
    BOut : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component MUX_4Bit_2_to1 Port (
    B1 : in STD_LOGIC_VECTOR (3 downto 0);
    B2 : in STD_LOGIC_VECTOR (3 downto 0);
    Bus_Sel : in STD_LOGIC;
    B_Out : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component Decoder_3_to_8 Port ( 
    I : in STD_LOGIC_VECTOR (2 downto 0);
    EN : in STD_LOGIC;
    Y : out STD_LOGIC_VECTOR (7 downto 0));
end component;



component GP_Registers Port ( 
    Clk : in STD_LOGIC;
    EN : in STD_LOGIC;
    Reset : in STD_LOGIC;
    In_Reg_Sel : in STD_LOGIC_VECTOR (7 downto 0);
    Write_Data : in STD_LOGIC_VECTOR (3 downto 0);
    Out_Reg_Sel_A : in STD_LOGIC_VECTOR (2 downto 0);
    Out_Reg_Sel_B : in STD_LOGIC_VECTOR (2 downto 0);
    Out_A : out STD_LOGIC_VECTOR (3 downto 0);
    Out_B : out STD_LOGIC_VECTOR (3 downto 0));
end component;


component Adder_Reg is
    Port ( Clk : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (3 downto 0);
           Q : out STD_LOGIC_VECTOR (3 downto 0));
end component;


signal D : STD_LOGIC_VECTOR (2 downto 0);-- := "000";
signal Address : STD_LOGIC_VECTOR (2 downto 0);
signal Instruction : STD_LOGIC_VECTOR (11 downto 0);
signal Reg_Instruction : STD_LOGIC_VECTOR (11 downto 0);
signal RegZero : STD_LOGIC;
signal RegA : STD_LOGIC_VECTOR (2 downto 0);
signal RegB : STD_LOGIC_VECTOR (2 downto 0);
signal ENB : STD_LOGIC;
signal AddSubSelect : STD_LOGIC; -- 0 = Add
signal LoadSelect : STD_LOGIC;
signal Value : STD_LOGIC_VECTOR (3 downto 0);
signal JumpFlag : STD_LOGIC;
signal WriteEn : STD_LOGIC;
--signal Jmp : STD_LOGIC;
signal JumpAddress : STD_LOGIC_VECTOR (2 downto 0) := "000";
signal PC_next : STD_LOGIC_VECTOR(2 downto 0);
signal C_out : STD_LOGIC;
signal C_out2 : STD_LOGIC;
signal S : STD_LOGIC_VECTOR (3 downto 0) := "0000";
signal S2 : STD_LOGIC_VECTOR (3 downto 0):= "0000";
signal Store_Val : STD_LOGIC_VECTOR (3 downto 0);
signal Reg_EN : STD_LOGIC_VECTOR (7 downto 0) := "00000000";

signal GP0 : STD_LOGIC_VECTOR (3 downto 0);
signal GP1 : STD_LOGIC_VECTOR (3 downto 0);
signal GP2 : STD_LOGIC_VECTOR (3 downto 0);
signal GP3 : STD_LOGIC_VECTOR (3 downto 0);
signal GP4 : STD_LOGIC_VECTOR (3 downto 0);
signal GP5 : STD_LOGIC_VECTOR (3 downto 0);
signal GP6 : STD_LOGIC_VECTOR (3 downto 0);
signal GP7 : STD_LOGIC_VECTOR (3 downto 0);
signal AdderIn1 : STD_LOGIC_VECTOR (3 downto 0);
signal AdderIn2 : STD_LOGIC_VECTOR (3 downto 0);
signal MUXOut1 : STD_LOGIC_VECTOR (3 downto 0);
signal MUXOut2 : STD_LOGIC_VECTOR (3 downto 0);



signal Address_4 : STD_LOGIC_VECTOR (3 downto 0);



begin
    PC1 : PC port map(
        D=>D,
        Reset => Reset,
        Clk => Clk,
        Q => Address
    );
    
    Program_ROM1 : Program_ROM port map(
        Address => Address,
        Instruction => Instruction
    );
    
    Instruction_Reg1 : Instruction_Reg port map(
        Clk => Clk,
        Reset => Reset,
        D => Instruction,
        Q => Reg_Instruction
    );
    
    Instruction_Decoder1 : Instruction_Decoder port map(
        Instruction => Reg_Instruction,
        RegZero => RegZero,
        RegA => RegA,
        RegB => RegB,
        ENB => ENB,
        AddSubSelect => AddSubSelect,
        LoadSelect => LoadSelect,
        Value => Value,
        JumpFlag => JumpFlag,
        WriteReg => WriteEn,
        JumpAddress => JumpAddress
    );
    
    PC_Adder : RCA_4 port map(
        A => Address_4,
        B => "0001",
        C_in => '0',
        S => S,
        C_out => C_out
    );
    
    PC_MUX : MUX_2_to_1 port map(
        B1 => S(2 downto 0),
        B2 => JumpAddress,
        Bus_Sel => JumpFlag,
        BOut => PC_next
    );
    

    
    
    -------------------------------------------------------------------------------------------
    GP_Registers1 : GP_Registers Port map( 
    Clk => Clk,
    Reset => Reset,
    EN => WriteEn,
    In_Reg_Sel => Reg_EN,
    Write_Data => Store_Val,
    Out_Reg_Sel_A => RegA,
    Out_Reg_Sel_B => RegB,
--    Out_A => AdderIn1,
--    Out_B =>AdderIn2
    Out_A => MUXOut1,
    Out_B => MUXOut2
    );
    Adder_Reg1 : Adder_Reg port map(
        Clk => Clk,
        D => MUXOut1,
        Q => AdderIn1
    );
    Adder_Reg2 : Adder_Reg port map(
        Clk => Clk,
        D => MUXOut2,
        Q => AdderIn2
    );
    
    Adder : RCA_4 port map(
        A => AdderIn1,
        B => AdderIn2,
        C_in => '0',
        S => S2,
        C_out => C_out2
    );
    
    Data_MUX : MUX_4Bit_2_to1 port map(
        B1=> S2,
        B2 => Value,
        Bus_Sel => LoadSelect,
        B_Out =>Store_Val
    );
    
    GP_Reg_Decoder : Decoder_3_to_8 port map(
        I => RegA,
        EN => WriteEn,
        Y => Reg_EN
    );
    

    
    -------------------------------------------------------------------------------------------------------
    
    
     
    
    
    
    RegZero <= (not AdderIn1(0)) and (not AdderIn1(1)) and (not AdderIn1(2)) and (not AdderIn1(3));   
    
    Address_4 <= std_logic_vector(unsigned('0' & Address));
    D <= PC_next;
    Addres <= Address;
--    Flag <= Reg_EN(0);
    Flag <= LoadSelect;
    I1<= Instruction;
    I2<= Reg_Instruction;
    Debug_8 <= Reg_EN;
    IN1 <= AdderIn1;
    IN2 <= AdderIn2;
    Debug_4B <= Store_Val;
    Debug_4 <= Value;
    Debug_3 <= RegB;
    Debug_1 <= WriteEn;

end Behavioral;
