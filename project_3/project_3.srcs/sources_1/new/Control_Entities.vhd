----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2023 16:23:40
-- Design Name: 
-- Module Name: Control_Entities - Behavioral
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

entity Control_Entities is
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
end Control_Entities;

architecture Behavioral of Control_Entities is
    component Sincro is
        Port (
            CLK : in STD_LOGIC;
            ASYNC_IN : in STD_LOGIC;
            SYNC_OUT : out STD_LOGIC
        );
    end component;

    component EDGEDCTR is
        Port (
            CLK : in STD_LOGIC;
            SYNC_IN : in STD_LOGIC;
            EDGE : out STD_LOGIC
        );
    end component;

    signal sync_start, sync_stop, sync_reset ,ssync_almu: STD_LOGIC;
    signal edge_start1, edge_stop1, edge_reset1 : STD_LOGIC;
begin
    sync_start_inst : Sincro
        port map (
            CLK => CLK,
            ASYNC_IN => ASYNC_IN_start,
            SYNC_OUT => sync_start
        );

    sync_stop_inst : Sincro
        port map (
            CLK => CLK,
            ASYNC_IN => ASYNC_IN_stop,
            SYNC_OUT => sync_stop
        );

    sync_reset_inst : Sincro
        port map (
            CLK => CLK,
            ASYNC_IN => ASYNC_IN_reset,
            SYNC_OUT => sync_reset
        );
        sync_start_tiempo : Sincro
        port map (
            CLK => CLK,
            ASYNC_IN => sync_tiempo,
            SYNC_OUT => sync_out_tiempo
        );
         sync_start_tiempo1 : Sincro
        port map (
            CLK => CLK,
            ASYNC_IN => sync_tiempo1,
            SYNC_OUT => sync_out_tiempo1
        );
           sync_start_tiempo2 : Sincro
        port map (
            CLK => CLK,
            ASYNC_IN => sync_tiempo2,
            SYNC_OUT => sync_out_tiemp2
        );
             sync_start_tiempo3 : Sincro
        port map (
            CLK => CLK,
            ASYNC_IN => sync_tiempo3,
            SYNC_OUT => sync_out_tiempo3
        );
        sync_start_updown : Sincro
         port map (
            CLK => CLK,
            ASYNC_IN => sync_updown,
            SYNC_OUT => sync_out_updown
        );
         sync_start_almu : Sincro
        port map (
            CLK => CLK,
            ASYNC_IN => sync_ALMU ,
            SYNC_OUT => ssync_almu
        );

    edge_start_inst : EDGEDCTR
        port map (
            CLK => CLK,
            SYNC_IN => sync_start,
            EDGE =>EDGE_start
        );

    edge_stop_inst : EDGEDCTR
        port map (
            CLK => CLK,
            SYNC_IN => sync_stop,
            EDGE => EDGE_stop 
        );

    edge_reset_inst : EDGEDCTR
        port map (
            CLK => CLK,
            SYNC_IN => sync_reset,
            EDGE => EDGE_reset
        );
         edge_almu_inst : EDGEDCTR
        port map (
            CLK => CLK,
            SYNC_IN => ssync_almu,
            EDGE =>  edge_Almu
        );
end Behavioral;
