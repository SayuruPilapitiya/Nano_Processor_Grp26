----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 05:47:43 PM
-- Design Name: 
-- Module Name: Register_Bank - Behavioral
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

entity Register_Bank is
    Port ( 
        Data_In : in  STD_LOGIC_VECTOR (3 downto 0); -- From the Load Mux
        Reg_En  : in  STD_LOGIC_VECTOR (2 downto 0); -- From Instruction Decoder
        Clk     : in  STD_LOGIC;
        Reset   : in  STD_LOGIC;
        
        -- Outputs of all 8 registers
        R0 : out STD_LOGIC_VECTOR (3 downto 0);
        R1 : out STD_LOGIC_VECTOR (3 downto 0);
        R2 : out STD_LOGIC_VECTOR (3 downto 0);
        R3 : out STD_LOGIC_VECTOR (3 downto 0);
        R4 : out STD_LOGIC_VECTOR (3 downto 0);
        R5 : out STD_LOGIC_VECTOR (3 downto 0);
        R6 : out STD_LOGIC_VECTOR (3 downto 0);
        R7 : out STD_LOGIC_VECTOR (3 downto 0);
        R7_prev : out STD_LOGIC_VECTOR (3 downto 0)
     
    );
end Register_Bank;

architecture Structural of Register_Bank is


    COMPONENT Reg_4bit_Fall
        PORT(
            D     : IN std_logic_vector(3 downto 0);
            En    : IN std_logic;
            Clk   : IN std_logic;
            Reset : IN std_logic;
            Q     : OUT std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    COMPONENT Reg_4bit
        PORT(
            D     : IN std_logic_vector(3 downto 0);
            En    : IN std_logic;
            Clk   : IN std_logic;
            Reset : IN std_logic;
            Q     : OUT std_logic_vector(3 downto 0)
        );
    END COMPONENT;

    COMPONENT Decoder_3_to_8
        PORT(
            I : IN std_logic_vector(2 downto 0);
            Y : OUT std_logic_vector(7 downto 0)
        );
    END COMPONENT;

    -- Internal signal to carry the enable bits from the decoder to the registers
    signal Decode_Y : std_logic_vector(7 downto 0);

begin

    -- Hardcode R0 to all 0s (Saves logic gates!)
    R0 <= "0000";

    -- Instantiate the Decoder
    Dec: Decoder_3_to_8 PORT MAP (
        I => Reg_En,
        Y => Decode_Y
    );

    -- Instantiate Registers 1 through 7
    Reg1: Reg_4bit PORT MAP (D => Data_In, En => Decode_Y(1), Clk => Clk, Reset => Reset, Q => R1);
    Reg2: Reg_4bit PORT MAP (D => Data_In, En => Decode_Y(2), Clk => Clk, Reset => Reset, Q => R2);
    Reg3: Reg_4bit PORT MAP (D => Data_In, En => Decode_Y(3), Clk => Clk, Reset => Reset, Q => R3);
    Reg4: Reg_4bit PORT MAP (D => Data_In, En => Decode_Y(4), Clk => Clk, Reset => Reset, Q => R4);
    Reg5: Reg_4bit PORT MAP (D => Data_In, En => Decode_Y(5), Clk => Clk, Reset => Reset, Q => R5);
    Reg6: Reg_4bit PORT MAP (D => Data_In, En => Decode_Y(6), Clk => Clk, Reset => Reset, Q => R6);
    Reg7: Reg_4bit PORT MAP (D => Data_In, En => Decode_Y(7), Clk => Clk, Reset => Reset, Q => R7);
    Reg7_prev: Reg_4bit_Fall PORT MAP (D => Data_In, En => Decode_Y(7), Clk => Clk, Reset => Reset, Q => R7_prev);

end Structural;
