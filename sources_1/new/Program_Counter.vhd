----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2026 05:28:38 PM
-- Design Name: 
-- Module Name: Program_Counter - Behavioral
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

entity Program_Counter is
    Port ( 
        D     : in  STD_LOGIC_VECTOR (2 downto 0); -- Next address to load
        Reset : in  STD_LOGIC;                     -- Connected to pushbutton
        Clk   : in  STD_LOGIC;                     -- Slow clock
        Q     : out STD_LOGIC_VECTOR (2 downto 0)  -- Current execution address
    );
end Program_Counter;

architecture Structural of Program_Counter is

    COMPONENT D_FF
        PORT(
            D    : IN std_logic;
            Res  : IN std_logic;
            Clk  : IN std_logic;
            Q    : OUT std_logic;
            Qbar : OUT std_logic
        );
    END COMPONENT;

begin
    -- Instantiating 3 D Flip-Flops for the 3-bit counter
    DFF0: D_FF port map (D => D(0), Res => Reset, Clk => Clk, Q => Q(0));
    DFF1: D_FF port map (D => D(1), Res => Reset, Clk => Clk, Q => Q(1));
    DFF2: D_FF port map (D => D(2), Res => Reset, Clk => Clk, Q => Q(2));

end Structural;