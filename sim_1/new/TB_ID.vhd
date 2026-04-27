library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TB_ID is
--  Port ( );
end TB_ID;

architecture Behavioral of TB_ID is

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

signal Instruction : STD_LOGIC_VECTOR (11 downto 0);
signal RegZero : STD_LOGIC;
signal RegA : STD_LOGIC_VECTOR (2 downto 0);
signal RegB : STD_LOGIC_VECTOR (2 downto 0);
signal ENB : STD_LOGIC;
signal AddSubSelect : STD_LOGIC;
signal LoadSelect : STD_LOGIC;
signal Value : STD_LOGIC_VECTOR (3 downto 0);
signal JumpFlag : STD_LOGIC;
signal WriteReg : STD_LOGIC;
signal JumpAddress : STD_LOGIC_VECTOR (2 downto 0);
begin
    UUT : Instruction_Decoder port map(
        Instruction => Instruction,
        RegZero => RegZero,
        RegA => RegA,
        RegB => RegB,
        ENB => ENB,
        AddSubSelect => AddSubSelect,
        LoadSelect => LoadSelect,
        Value => Value,
        JumpFlag => JumpFlag,
        WriteReg => WriteReg,
        JumpAddress => JumpAddress);
        
    process begin
        RegZero <= '0';
        Instruction <= "001100001010";
        wait for 10 ns;
        
        Instruction <= "001100100110";
        wait for 10 ns;
        
        Instruction <= "011100010000";
        wait for 10 ns;
        
        Instruction <= "101100001010";
        wait for 10 ns;
        
        Instruction <= "101100000000";
        wait for 10 ns;
        
        Instruction <= "001110100000";
        wait for 10 ns;
        
        RegZero <= '1';
        Instruction <= "001100001010";
        wait for 10 ns;
        
        Instruction <= "001100100110";
        wait for 10 ns;
        
        Instruction <= "111100000110";
        wait for 10 ns;
        
        Instruction <= "110100001010";
        wait for 10 ns;
        
        Instruction <= "101100000000";
        wait for 10 ns;
        
        Instruction <= "001110100000";
        wait for 10 ns;
    
    end process;
        


end Behavioral;
