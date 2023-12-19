----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.12.2023 19:12:19
-- Design Name: 
-- Module Name: counter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
 Port (
 CLK : in STD_LOGIC;
        reset : in STD_LOGIC;
        updown : in STD_LOGIC;
        count_enable : in STD_LOGIC;
        stop : in STD_LOGIC;
        start: in STD_LOGIC;
        count_valsecuni : out STD_LOGIC_VECTOR(3 downto 0);
        count_valminuni : out STD_LOGIC_VECTOR(3 downto 0);
        count_valhor : out STD_LOGIC_VECTOR(3 downto 0);
        count_valsecdec : out STD_LOGIC_VECTOR(3 downto 0);
        count_valmindec : out STD_LOGIC_VECTOR(3 downto 0)
       
        );
end counter;

architecture Behavioral of counter is
      signal countersecuni : UNSIGNED(3 downto 0) := (others => '0');
      signal counterminuni : UNSIGNED( 3 downto 0) := (others => '0');
       signal countersecdec : UNSIGNED(3 downto 0) := (others => '0');
      signal countermindec : UNSIGNED( 3 downto 0) := (others => '0');
      signal counterhor : UNSIGNED(3 downto 0) := (others => '0');
    signal count_down_internal, stop_internal, reset_internal, start_internal : STD_LOGIC;
    signal counter_stopped : BOOLEAN := FALSE;

begin
    count_down_internal <= not updown;

    process(CLK)
    begin
        if rising_edge(CLK) then
            -- Sincronización y detección de flancos para cada señal de botón
            start_internal <= start;
            reset_internal <= reset;
            stop_internal <= stop;

            -- Control del contador
            if reset_internal = '1' then
                countersecuni <= "0000";
                counterminuni <= "0000";
                countersecdec <= "0000";
                countermindec <= "0000";
                counterhor <= "0000";
                counter_stopped <= FALSE;
            elsif stop_internal = '1' then
                counter_stopped <= NOT counter_stopped;
            elsif count_enable = '1' and NOT counter_stopped then
                if updown= '1' then
                    countersecuni <= countersecuni + 1;
                    if countersecuni="1010" then
                    countersecdec<=countersecdec +1;
                    countersecuni <=(others => '0');
                    end if;
                    if countersecdec="0110" then
                    counterminuni<=counterminuni +1;
                    countersecdec <=(others => '0');
                    end if;
                     if counterminuni="1010" then
                    countermindec<=countermindec +1;
                    counterminuni <=(others => '0');
                    end if;
                    if countermindec="0110" then
                    counterhor<=counterhor +1;
                    countermindec <=(others => '0');
                    end if;
                    
                elsif count_down_internal = '1' then
                     countersecuni <= countersecuni - 1;
                    if countersecuni="0000" then
                    countersecdec<=countersecdec -1;
                    countersecuni <= "1010";
                    end if;
                    if countersecdec="0000" then
                    counterminuni<=counterminuni -1;
                    countersecdec <= "0110";
                    end if;
                     if counterminuni="0000" then
                    countermindec<=countermindec -1;
                    counterminuni <= "1010";
                    end if;
                    if countermindec="0000" then
                    counterhor<=counterhor -1;
                    countermindec <= "0110";
                    end if;
                end if;
            end if;
        end if;
    end process;

    count_valsecuni <=STD_LOGIC_VECTOR( countersecuni);
    count_valminuni <=STD_LOGIC_VECTOR( counterminuni);
    count_valsecdec <=STD_LOGIC_VECTOR( countersecdec);
    count_valmindec <=STD_LOGIC_VECTOR( countermindec);
    count_valhor <=STD_LOGIC_VECTOR( counterhor);

end Behavioral;

