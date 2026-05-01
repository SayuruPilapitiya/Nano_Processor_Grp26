----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 01:40:13 PM
-- Design Name: 
-- Module Name: Instruction_Decoder - Behavioral
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

entity Instruction_Decoder is
    Port ( 
        Instruction  : in  STD_LOGIC_VECTOR (11 downto 0);
        Reg_Check    : in  STD_LOGIC; -- From the target register for JZR
        
        -- Control Signals Output
        Reg_En       : out STD_LOGIC_VECTOR (2 downto 0);
        Load_Sel     : out STD_LOGIC;
        Imm_Val      : out STD_LOGIC_VECTOR (3 downto 0);
        Reg_Sel_A    : out STD_LOGIC_VECTOR (2 downto 0);
        Reg_Sel_B    : out STD_LOGIC_VECTOR (2 downto 0);
        Add_Sub_Sel  : out STD_LOGIC;
        Jump_Flag    : out STD_LOGIC;
        Jump_Addr    : out STD_LOGIC_VECTOR (2 downto 0)
    );
end Instruction_Decoder;

architecture Behavioral of Instruction_Decoder is

begin

    process(Instruction, Reg_Check)
        variable Opcode : STD_LOGIC_VECTOR(1 downto 0);
    begin
        -- Extract the 2-bit Opcode
        Opcode := Instruction(11 downto 10);
        
        -- Default all outputs to 0 to prevent accidental latches
        Reg_En       <= "000";
        Load_Sel     <= '0';
        Imm_Val      <= "0000";
        Reg_Sel_A    <= "000";
        Reg_Sel_B    <= "000";
        Add_Sub_Sel  <= '0';
        Jump_Flag    <= '0';
        Jump_Addr    <= "000";

        case Opcode is
            when "10" => -- MOVI
                Reg_En       <= Instruction(9 downto 7);
                Load_Sel     <= '1'; -- Select immediate value
                Imm_Val      <= Instruction(3 downto 0);
                
            when "00" => -- ADD
                Reg_En       <= Instruction(9 downto 7);
                Load_Sel     <= '0'; -- Select Add/Sub output
                Reg_Sel_A    <= Instruction(9 downto 7);
                Reg_Sel_B    <= Instruction(6 downto 4);
                Add_Sub_Sel  <= '0'; -- 0 for Add
                
            when "01" => -- NEG
                Reg_En       <= Instruction(9 downto 7);
                Load_Sel     <= '0'; -- Select Add/Sub output
                Reg_Sel_A    <= "000"; -- Hardcoded to R0 (which is 0)
                Reg_Sel_B    <= Instruction(9 downto 7);
                Add_Sub_Sel  <= '1'; -- 1 for Subtract
                
            when "11" => -- JZR
                -- Reg_En remains "000" (default) to protect registers
                Reg_Sel_A    <= Instruction(9 downto 7); -- Route register to check
                Jump_Addr    <= Instruction(2 downto 0);
                
                -- Conditional Jump Logic
                if Reg_Check = '1' then
                    Jump_Flag <= '1';
                else
                    Jump_Flag <= '0';
                end if;
                
            when others =>
                -- Catch-all for safety (already handled by defaults, but good practice)
                null;
        end case;
        
    end process;

end Behavioral;
