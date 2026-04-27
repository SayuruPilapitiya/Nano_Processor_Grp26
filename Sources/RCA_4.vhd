----------------------------------------------------------------------------------
-- Company: UOM CSE
-- Engineer: Lahiru Januka
-- 
-- Create Date: 02/17/2026 04:13:47 PM
-- Design Name: RCA_4
-- Module Name: RCA_4 - Behavioral
-- Project Name: Lab 3
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RCA_4 is
    Port ( 
        A0, A1, A2, A3 : in  STD_LOGIC;
        B0, B1, B2, B3 : in  STD_LOGIC;
        C_in           : in  STD_LOGIC;
        S0, S1, S2, S3 : out STD_LOGIC;
        C_out          : out STD_LOGIC;
        C_MSB_in       : out STD_LOGIC 
    );
end RCA_4;

architecture Behavioral of RCA_4 is
    component FA
        port (
            A     : in  std_logic;
            B     : in  std_logic;
            C_in  : in  std_logic;
            S     : out std_logic;
            C_out : out std_logic
        );
    end component;

    SIGNAL FA0_C, FA1_C, FA2_C : std_logic;

begin
        FA_0 : FA
            port map (
                A     => A0,
                B     => B0,
                C_in  => C_in,
                S     => S0,
                C_Out => FA0_C
            );
        
        FA_1 : FA
            port map (
                A     => A1,
                B     => B1,
                C_in  => FA0_C,
                S     => S1,
                C_Out => FA1_C
            );
        
        FA_2 : FA
            port map (
                A     => A2,
                B     => B2,
                C_in  => FA1_C,
                S     => S2,
                C_Out => FA2_C   -- ? This is the carry INTO bit 3 (MSB)!
            );
        
        FA_3 : FA
            port map (
                A     => A3,
                B     => B3,
                C_in  => FA2_C,  -- ? Carry into MSB
                S     => S3,
                C_Out => C_out   -- ? Carry out of MSB
            );
    
        -- Expose the carry into MSB for overflow detection
        C_MSB_in <= FA2_C;
end Behavioral;