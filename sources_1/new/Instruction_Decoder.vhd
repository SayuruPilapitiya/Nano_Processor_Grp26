library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Instruction_Decoder is
    Port ( Instruction : in STD_LOGIC_VECTOR (11 downto 0);
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
end Instruction_Decoder;

architecture Behavioral of Instruction_Decoder is
    signal opcode: std_logic_vector(1 downto 0);
begin
    opcode <= Instruction(11 downto 10);
    RegA<= Instruction(9 downto 7);
    RegB<= Instruction(6 downto 4);
    ENB <= not opcode(0);
    AddSubSelect <= opcode(0);
    LoadSelect <= opcode(1);
    Value <= Instruction(3 downto 0);
    JumpFlag <= opcode(0) and opcode(1) and RegZero;
    JumpAddress <= Instruction(2 downto 0);
    WriteReg <= not (opcode(0) and opcode(1));
    
--    LoadSelect <= '1' when opcode = "10" else '0';
--    AddSubSelect <= Instruction(0) when opcode = "01" else '0';
end Behavioral;
