library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Instruction_Decoder is
end TB_Instruction_Decoder;

architecture Behavioral of TB_Instruction_Decoder is
    component Instruction_Decoder is
        Port (
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
            JumpAddress : out STD_LOGIC_VECTOR (2 downto 0)
        );
    end component;

    -- Inputs
    signal Instruction : STD_LOGIC_VECTOR (11 downto 0) := (others => '0');
    signal RegZero : STD_LOGIC := '0';

    -- Outputs
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
    uut: Instruction_Decoder port map (
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
        JumpAddress => JumpAddress
    );

    stim_proc: process
    begin
        -- Test case 1: ADD R1, R2
        Instruction <= "01" & "001" & "010" & "0000";
        wait for 10 ns;
        assert (RegA = "001") report "Test Case 1 Failed: RegA" severity error;
        assert (RegB = "010") report "Test Case 1 Failed: RegB" severity error;
        assert (AddSubSelect = '1') report "Test Case 1 Failed: AddSubSelect" severity error;
        assert (WriteReg = '1') report "Test Case 1 Failed: WriteReg" severity error;

        -- Test case 2: SUB R3, R4
        Instruction <= "01" & "011" & "100" & "0001";
        wait for 10 ns;
        assert (RegA = "011") report "Test Case 2 Failed: RegA" severity error;
        assert (RegB = "100") report "Test Case 2 Failed: RegB" severity error;
        assert (AddSubSelect = '1') report "Test Case 2 Failed: AddSubSelect" severity error;
        assert (WriteReg = '1') report "Test Case 2 Failed: WriteReg" severity error;

        -- Test case 3: LOAD R5, 10
        Instruction <= "10" & "101" & "000" & "1010";
        wait for 10 ns;
        assert (RegA = "101") report "Test Case 3 Failed: RegA" severity error;
        assert (LoadSelect = '1') report "Test Case 3 Failed: LoadSelect" severity error;
        assert (Value = "1010") report "Test Case 3 Failed: Value" severity error;
        assert (WriteReg = '1') report "Test Case 3 Failed: WriteReg" severity error;

        -- Test case 4: JUMPZ 5
        Instruction <= "11" & "000" & "000" & "101";
        RegZero <= '1';
        wait for 10 ns;
        assert (JumpFlag = '1') report "Test Case 4 Failed: JumpFlag" severity error;
        assert (JumpAddress = "101") report "Test Case 4 Failed: JumpAddress" severity error;
        assert (WriteReg = '0') report "Test Case 4 Failed: WriteReg" severity error;
        
        RegZero <= '0';
        wait for 10 ns;
        assert (JumpFlag = '0') report "Test Case 4 Failed: JumpFlag not reset" severity error;


        wait;
    end process;
end Behavioral;
