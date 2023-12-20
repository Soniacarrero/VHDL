----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.12.2023 12:32:08
-- Design Name: 
-- Module Name: ControlSalidas - Behavioral
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

entity ControlSalidas is
  Port (
        CLK : in STD_LOGIC;
        BCD_sec_units : in STD_LOGIC_VECTOR(3 downto 0);
        BCD_sec_dec : in STD_LOGIC_VECTOR(3 downto 0);
        BCD_min_units : in STD_LOGIC_VECTOR(3 downto 0);
        BCD_min_dec : in STD_LOGIC_VECTOR(3 downto 0);
        BCD_hour_units : in STD_LOGIC_VECTOR(3 downto 0);
        AN : out STD_LOGIC_VECTOR(3 downto 0);
        SEG : out STD_LOGIC_VECTOR(6 downto 0)
    );
end ControlSalidas;

architecture Behavioral of ControlSalidas is
 component decodificador
        Port (
            BCD7 : in STD_LOGIC_VECTOR(3 downto 0);
            SEG : out STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;

 component clk_divisor is
    Port (
        CLK : in STD_LOGIC;
        CLK_OUT : out STD_LOGIC
    );
end component;

component DisplayController
    Port (
        CLK  : in STD_LOGIC;
        count_value_1 : in STD_LOGIC_VECTOR(6 downto 0);
        count_value_2 : in STD_LOGIC_VECTOR(6 downto 0);
        count_value_3 : in STD_LOGIC_VECTOR(6 downto 0);
        count_value_4 : in STD_LOGIC_VECTOR(6 downto 0);
        count_value_5 : in STD_LOGIC_VECTOR(6 downto 0);
        AN : out STD_LOGIC_VECTOR(3 downto 0);
        SEG : out STD_LOGIC_VECTOR(6 downto 0)
    );
end component;

signal seg_out_sec_units, seg_out_sec_dec, seg_out_min_units, seg_out_min_dec, seg_out_hour_units : STD_LOGIC_VECTOR(6 downto 0);
signal clk_multi: STD_LOGIC;
begin
    bcd_inst_sec_units: decodificador
    port map (
        BCD7 => BCD_sec_units, 
        SEG => seg_out_sec_units
    );

    bcd_inst_sec_dec: decodificador
    port map (
        BCD7 => BCD_sec_dec, 
        SEG => seg_out_sec_dec
    );

    bcd_inst_min_units: decodificador
    port map (
        BCD7 => BCD_min_units, 
        SEG => seg_out_min_units
    );

    bcd_inst_min_dec: decodificador
    port map (
        BCD7 => BCD_min_dec, 
        SEG => seg_out_min_dec
    );

    bcd_inst_hour_units: decodificador
    port map (
        BCD7 => BCD_hour_units, 
        SEG => seg_out_hour_units
    );

    reloj: clk_divisor
    port map (
       CLK => CLK,
       CLK_OUT => clk_multi
    );

    display_controller_inst: DisplayController
    port map (
        CLK => clk_multi,
        count_value_1 => seg_out_sec_units,
        count_value_2 => seg_out_sec_dec,
        count_value_3 => seg_out_min_units,
        count_value_4 => seg_out_min_dec,
        count_value_5 => seg_out_hour_units,
        AN => AN,
        SEG => SEG
    );

end Behavioral;

