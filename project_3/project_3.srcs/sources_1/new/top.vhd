----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2023 13:30:44
-- Design Name: 
-- Module Name: top - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is

 Port ( pushbutton_star : in STD_LOGIC;
 clk_top : in STD_LOGIC;
 reset_top : in STD_LOGIC;
 updown: in STD_LOGIC;
 stop : in std_logic;
 count_enable : in STD_LOGIC;
 ALMU : in STD_LOGIC;
 tiempo:in std_logic;
 tiempo1:in std_logic;
 tiempo2:in std_logic;
 tiempo3:in std_logic;
 AN : out STD_LOGIC_VECTOR(3 downto 0);
   SEG : out STD_LOGIC_VECTOR(6 downto 0);
 led :out std_logic
 );
end top;


architecture Behavioral of top is
signal edge_start, edge_stop, edge_reset,edge_Almu,sync_out_tiempo,sync_out_tiempo1,sync_out_tiempo2,sync_out_tiempo3,sync_out_updown : STD_LOGIC;
    signal sync_start, sync_stop, sync_reset,sync_tiempo,sync_tiempo1,sync_tiempo2,sync_tiempo3,sync_ALMU,sync_updown: STD_LOGIC;
component Control_Entities is
        Port (
            CLK : in STD_LOGIC;
            ASYNC_IN_start : in STD_LOGIC;
            ASYNC_IN_stop : in STD_LOGIC;
            ASYNC_IN_reset : in STD_LOGIC;
            sync_tiempo:in STD_LOGIC;
            sync_tiempo1:in STD_LOGIC;
            sync_tiempo2:in STD_LOGIC;
            sync_tiempo3:in STD_LOGIC;
            sync_ALMU :in STD_LOGIC;
            sync_updown:in STD_LOGIC;
            EDGE_start : out STD_LOGIC;
            EDGE_stop : out STD_LOGIC;
            EDGE_reset : out STD_LOGIC;
            edge_Almu :out STD_LOGIC;
            sync_out_tiempo:out STD_LOGIC;
            sync_out_tiempo1:out STD_LOGIC;
            sync_out_tiemp2:out STD_LOGIC;
            sync_out_tiempo3:out STD_LOGIC;
            sync_out_updown:out STD_LOGIC
        );
    end component;
component maquina_estados is
Port ( 
    CLK : in STD_LOGIC;
    reset : in STD_LOGIC;
    updown : in STD_LOGIC;
    count_enable : in STD_LOGIC;
    start :in STD_LOGIC;
    stop : in STD_LOGIC;
    ALMU : in STD_LOGIC;
    tiempo:in std_logic;
 tiempo1:in std_logic;
 tiempo2:in std_logic;
 tiempo3:in std_logic;
   count_valsecuni : out STD_LOGIC_VECTOR(3 downto 0);
        count_valminuni : out STD_LOGIC_VECTOR(3 downto 0);
        count_valhor : out STD_LOGIC_VECTOR(3 downto 0);
        count_valsecdec : out STD_LOGIC_VECTOR(3 downto 0);
        count_valmindec : out STD_LOGIC_VECTOR(3 downto 0)
        );
end component;
component ControlSalidas is
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
end component;

    signal bcd_value : STD_LOGIC_VECTOR(3 downto 0);
signal seg_out_sec_units, seg_out_sec_dec : STD_LOGIC_VECTOR(6 downto 0);
signal seg_out_min_units, seg_out_min_dec ,seg_out_hour_units  : STD_LOGIC_VECTOR(6 downto 0);
signal cod_sec_units, cod_sec_dec : STD_LOGIC_VECTOR(3 downto 0);
signal cod_min_units, cod_min_dec ,cod_hour_units  : STD_LOGIC_VECTOR(3 downto 0);
begin
    control_entities_inst : Control_Entities
        port map (
            CLK => clk_top,
            ASYNC_IN_start => pushbutton_star,
            ASYNC_IN_stop => stop,
            ASYNC_IN_reset => reset_top,
             sync_tiempo => tiempo,
            sync_tiempo1 => tiempo1,
            sync_tiempo2 => tiempo2,
            sync_tiempo3 => tiempo3,
            sync_ALMU=> ALMU,
            sync_updown=>updown,
           
            EDGE_start => edge_start,
            EDGE_stop => edge_stop,
            EDGE_reset => edge_reset,
            edge_Almu =>edge_Almu,
            sync_out_tiempo=>sync_out_tiempo,
            sync_out_tiempo1=>sync_out_tiempo1,
            sync_out_tiemp2=>sync_out_tiempo2,
            sync_out_tiempo3=>sync_out_tiempo3,
            sync_out_updown=>sync_out_updown
        );
inst_count: maquina_estados
Port map ( 
    CLK =>clk_top ,
    reset => edge_reset,
    updown  => sync_out_updown,
    count_enable => count_enable,
    stop => edge_stop,
    start=>edge_start,
    ALMU  =>edge_Almu,
    tiempo=> sync_out_tiempo,
 tiempo1 => sync_out_tiempo1,
 tiempo2 => sync_out_tiempo2,
 tiempo3 => sync_out_tiempo3,
    count_valsecuni=>cod_sec_units ,
    count_valsecdec =>cod_sec_dec,
    count_valminuni =>cod_min_units,
    count_valmindec => cod_min_dec,
    count_valhor =>cod_hour_units
    
 );
 inst_control_outputs: ControlSalidas
Port map ( 
CLK  =>clk_top ,
        BCD_sec_units =>cod_sec_units,
        BCD_sec_dec =>cod_sec_dec,
        BCD_min_units =>cod_min_units,
        BCD_min_dec => cod_min_dec,
        BCD_hour_units =>cod_hour_units,
       AN => AN,
        SEG => SEG

);
 
end Behavioral;
