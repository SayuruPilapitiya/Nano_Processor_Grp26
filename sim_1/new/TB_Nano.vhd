library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TB_Nano is
--  Port ( );
end TB_Nano;

architecture Behavioral of TB_Nano is

component Nano Port (   
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
end component;

signal Clk : std_logic;
signal Reset : std_logic;
signal Addres : STD_LOGIC_VECTOR (2 downto 0);
signal I1 : STD_LOGIC_VECTOR (11 downto 0);
signal I2 : STD_LOGIC_VECTOR (11 downto 0);
signal Debug_1 : STD_LOGIC;
signal Debug_3 : STD_LOGIC_VECTOR (2 downto 0);
signal Debug_4 : STD_LOGIC_VECTOR (3 downto 0);
signal IN1 : STD_LOGIC_VECTOR (3 downto 0);
signal IN2 : STD_LOGIC_VECTOR (3 downto 0);
signal Debug_4B : STD_LOGIC_VECTOR (3 downto 0);
signal Debug_8 : STD_LOGIC_VECTOR (7 downto 0);
signal Flag : STD_LOGIC;

begin
    UUT : Nano port map(
        Clk => Clk,
        Reset => Reset,
        Addres => Addres,
        I1 => I1,
        I2 => I2,
        Debug_1 => Debug_1,
        Debug_3 => Debug_3,
        Debug_4 => Debug_4,
        IN1 => IN1,
        IN2 => IN2,
        Debug_4B => Debug_4B,
        Debug_8 => Debug_8,
        Flag => Flag
    );
    
    process begin
        Reset <= '1';
        Clk <= '0';
        wait for 5 ns;
        Reset <= '0';
        wait for 5 ns;
        while true loop
            Clk <= '1';
            wait for 10 ns;
    
            Clk <= '0';
            wait for 10 ns;          
                      
        end loop;
    end process;

end Behavioral;
