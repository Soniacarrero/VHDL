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
generic (
WIDTH: positive := 4
);
 Port ( pushbutton_star : in STD_LOGIC;
 clk_top : in STD_LOGIC;
 reset_top : in STD_LOGIC;
 updown: in STD_LOGIC;
 stop : in std_logic;
  count_enable : in STD_LOGIC;
  count_value : out STD_LOGIC_VECTOR(3 downto 0);
    seg_out : out STD_LOGIC_VECTOR(6 downto 0)
 );
end top;


architecture Behavioral of top is
component Sincro is
Port ( CLK : in STD_LOGIC;
ASYNC_IN : in STD_LOGIC;
SYNC_OUT : out STD_LOGIC);
end component;
component EDGEDCTR is
Port ( CLK : in STD_LOGIC;
SYNC_IN : in STD_LOGIC;
EDGE : out STD_LOGIC);
end component;
component counter is
Port ( 
    CLK : in STD_LOGIC;
    reset : in STD_LOGIC;
    updown : in STD_LOGIC;
    count_enable : in STD_LOGIC;
    stop : in STD_LOGIC;
   count_valsecuni : out STD_LOGIC_VECTOR(3 downto 0);
        count_valminuni : out STD_LOGIC_VECTOR(3 downto 0);
        count_valhor : out STD_LOGIC_VECTOR(3 downto 0);
        count_valsecdec : out STD_LOGIC_VECTOR(3 downto 0);
        count_valmindec : out STD_LOGIC_VECTOR(3 downto 0)
        );
end component;
 component decodificador
        Port (
            BCD7 : in STD_LOGIC_VECTOR(3 downto 0);
            SEG : out STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;

 signal sync_start, sync_stop, sync_reset : STD_LOGIC;
    signal edge_start, edge_stop, edge_reset : STD_LOGIC;
    signal bcd_value : STD_LOGIC_VECTOR(3 downto 0);
signal seg_out_sec_units, seg_out_sec_dec : STD_LOGIC_VECTOR(6 downto 0);
signal seg_out_min_units, seg_out_min_dec ,seg_out_hour_units  : STD_LOGIC_VECTOR(6 downto 0);
signal cod_sec_units, cod_sec_dec : STD_LOGIC_VECTOR(4 downto 0);
signal cod_min_units, cod_min_dec ,cod_hour_units  : STD_LOGIC_VECTOR(4 downto 0);
begin
   sync_start_inst : sincro
    port map (
        CLK => clk_top ,
        ASYNC_IN => pushbutton_star,
        SYNC_OUT => sync_start
    );
      sync_stop_inst : sincro
    port map (
        CLK => clk_top,
        ASYNC_IN => stop,
        SYNC_OUT => sync_stop
    );
      sync_reset_inst : sincro
    port map (
        CLK => clk_top,
        ASYNC_IN => reset_top,
        SYNC_OUT => sync_reset
        );
 edge_start_inst : EDGEDCTR
    port map (
        CLK => clk_top,
        SYNC_IN => sync_start,
        EDGE => edge_start
);
edge_stop_inst : edgedctr
    port map (
        CLK =>clk_top,
        SYNC_IN => sync_stop,
        EDGE => edge_stop
    );
       edge_reset_inst : edgedctr
    port map (
        CLK =>clk_top,
        SYNC_IN => sync_reset,
        EDGE => edge_reset
    );
inst_count: counter
Port map ( 
    CLK =>clk_top ,
    reset => edge_reset,
    updown  => updown,
    count_enable => count_enable,
    stop => edge_stop,
    count_valsecuni=>cod_sec_units ,
    count_valsecdec =>cod_sec_dec,
    count_valminuni =>cod_min_units,
    count_valmindec => cod_min_dec,
    count_valhor =>cod_hour_units
    
 );
   bcd_inst : decodificador
    port map (
        BCD7 => bcd_value,
        SEG => seg_out
    );
    bcd_inst_sec_units: decodificador
port map (
    BCD7 => cod_sec_units(4 downto 0), 
    SEG => seg_out_sec_units
);

bcd_inst_sec_dec: decodificador
port map (
    BCD7 => cod_sec_dec(4 downto 0), 
    SEG => seg_out_sec_dec
);
bcd_inst_min_units: decodificador
port map (
    BCD7 => cod_min_units(4 downto 0), 
    SEG => seg_out_min_units
);

bcd_inst_min_dec: decodificador
port map (
    BCD7 =>  cod_min_dec(7 downto 4), 
    SEG => seg_out_min_dec
);

-- Decodificadores BCD a 7 segmentos para horas
bcd_inst_hour_units: decodificador
port map (
    BCD7 => cod_hour_units(4 downto 0), 
    SEG => seg_out_hour_units
);

 
end Behavioral;
