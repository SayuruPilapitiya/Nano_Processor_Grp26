----------------------------------------------------------------------------------
-- Company: UOM CSE
-- Engineer: Lahiru Januka
-- Create Date: 02/24/2026 02:34:31 PM
-- Design Name: 3_to_8_decoder
-- Module Name: Decoder_3_to_8 - Behavioral
-- Project Name: Lab 4
--
-- Updated: Port names standardized for NanoProcessor integration
--          I ? Sel, EN ? En, Y ? Output
--          Internal Decoder_2_to_4 port names also updated to match
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder_3_to_8 is
    Port ( Sel    : in  STD_LOGIC_VECTOR (2 downto 0);
           En     : in  STD_LOGIC;
           Output : out STD_LOGIC_VECTOR (7 downto 0));
end Decoder_3_to_8;

architecture Behavioral of Decoder_3_to_8 is

    component Decoder_2_to_4
        port (
            Sel    : in  std_logic_vector(1 downto 0);
            En     : in  std_logic;
            Output : out std_logic_vector(3 downto 0)
        );
    end component;
    
    signal Sel_Lower    : std_logic_vector(1 downto 0);  -- Sel(1:0) for both 2-to-4 decoders
    signal Output_Lower : std_logic_vector(3 downto 0);  -- Output from decoder 0 (bits 3-0)
    signal Output_Upper : std_logic_vector(3 downto 0);  -- Output from decoder 1 (bits 7-4)
    signal En_Lower     : std_logic;                     -- Enable for lower decoder
    signal En_Upper     : std_logic;                     -- Enable for upper decoder
    
begin

    En_Lower <= (not Sel(2)) and En;
    En_Upper <= Sel(2) and En;
    
    Sel_Lower <= Sel(1 downto 0);

    Decoder_Lower: Decoder_2_to_4
        port map (
            Sel    => Sel_Lower,
            En     => En_Lower,
            Output => Output_Lower
        );
    
    Decoder_Upper: Decoder_2_to_4
        port map (
            Sel    => Sel_Lower,
            En     => En_Upper,
            Output => Output_Upper
        );
    
    Output(3 downto 0) <= Output_Lower;
    Output(7 downto 4) <= Output_Upper;
    
end Behavioral;