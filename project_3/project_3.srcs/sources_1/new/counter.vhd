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
use IEEE.NUMERIC_STD.ALL;

entity maquina_estados is
    Port (
        CLK : in STD_LOGIC;
        reset : in STD_LOGIC;
        updown : in STD_LOGIC;
        count_enable : in STD_LOGIC;
        start : in STD_LOGIC;
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
        count_valmindec : out STD_LOGIC_VECTOR(3 downto 0);
        led_out : out STD_LOGIC
    );
end maquina_estados;

architecture Behavioral of maquina_estados is
 signal countertiempo,countertiempo1 : UNSIGNED(3 downto 0):= (others => '0');
    signal countersecuni : UNSIGNED(3 downto 0) := (others => '0');
    signal counterminuni : UNSIGNED(3 downto 0) := (others => '0');
    signal countersecdec : UNSIGNED(3 downto 0) := (others => '0');
    signal countermindec : UNSIGNED(3 downto 0) := (others => '0');
    signal counterhor : UNSIGNED(3 downto 0) := (others => '0');
    signal count_down_internal, stop_internal, reset_internal, start_internal : STD_LOGIC;
    signal counter_stopped : BOOLEAN := FALSE;
    type state_type is (S0, S1, S2);
    signal state, next_state : state_type;
    signal led_on : STD_LOGIC := '0';
    signal counter : integer := 0;
    

begin
    count_down_internal <= not updown;

    process (clk, ALMU, start, stop, reset)
    begin
        if rising_edge(clk) then
            start_internal <= start;
            reset_internal <= reset;
            stop_internal <= stop;

            if reset_internal = '1' then
                countersecuni <= (others => '0');
                counterminuni <= (others => '0');
                countersecdec <= (others => '0');
                countermindec <= (others => '0');
                counterhor <= (others => '0');
                counter_stopped <= FALSE;
                state <= S0;
                led_on <= '0';
            elsif ALMU = '1' then
                case state is
                    when S0 =>
                        state <= S1;
                    when S1 =>
                        state <= S2;
                    when S2 =>
                        state <= S0;
                    when others =>
                        state <= S0;
                end case;
            else
                state <= next_state;
            end if;
        end if;
    end process;

    process (CLK)
    begin
        case state is
            when S0 =>
                if stop_internal = '1' then
                    counter_stopped <= NOT counter_stopped;
                elsif count_enable = '1' and NOT counter_stopped then
                    if updown = '1' then
                        countersecuni <= countersecuni + 1;
                        if countersecuni = "1010" then
                            countersecdec <= countersecdec + 1;
                            countersecuni <= (others => '0');
                        end if;
                        if countersecdec = "0110" then
                            counterminuni <= counterminuni + 1;
                            countersecdec <= (others => '0');
                        end if;
                        if counterminuni = "1010" then
                            countermindec <= countermindec + 1;
                            counterminuni <= (others => '0');
                        end if;
                        if countermindec = "0110" then
                            counterhor <= counterhor + 1;
                            countermindec <= (others => '0');
                        end if;
                    elsif count_down_internal = '1' then
                        countersecuni <= countersecuni - 1;
                        if countersecuni = "0000" then
                            countersecdec <= countersecdec - 1;
                            countersecuni <= "1010";
                        end if;
                        if countersecdec = "0000" then
                            counterminuni <= counterminuni - 1;
                            countersecdec <= "0110";
                        end if;
                        if counterminuni = "0000" then
                            countermindec <= countermindec - 1;
                            counterminuni <= "1010";
                        end if;
                        if countermindec = "0000" then
                            counterhor <= counterhor - 1;
                            countermindec <= "0110";
                        end if;
                    end if;
                end if;
                when S1 =>
                 if stop_internal = '1' then
                    counter_stopped <= NOT counter_stopped;
                    elsif count_enable = '1' and NOT counter_stopped then
                    countertiempo <= tiempo3 & tiempo2 & tiempo1 & tiempo;
                    if countertiempo > "1001" then
                    countermindec <="0001";
                    counterminuni<=countertiempo-"1010";
                    elsif countertiempo < "1001" then
                     counterminuni<=countertiempo;
                    end if;
                    countersecuni <= countersecuni - 1;
                    if countersecuni = "0000" then
                            countersecdec <= countersecdec - 1;
                            countersecuni <= "1010";
                        end if;
                        if countersecdec = "0000" then
                            counterminuni <= counterminuni - 1;
                            countersecdec <= "0110";
                            end if;
                            if countersecuni = "0000" and countersecdec = "0000" then
                             led_on<='1';
                             end if;
                    
                    
                    end if;
                when S2 =>
                 if stop_internal = '1' then
                    counter_stopped <= NOT counter_stopped;
                    elsif count_enable = '1' and NOT counter_stopped then
                    countertiempo <= tiempo3 & tiempo2 & tiempo1 & tiempo;
                     countersecuni <= countersecuni + 1;
                     countertiempo1<= countermindec+counterminuni;
                     if countertiempo > countertiempo1 then
                        if countersecuni = "1010" then
                            countersecdec <= countersecdec + 1;
                            countersecuni <= (others => '0');
                        end if;
                        if countersecdec = "0110" then
                            counterminuni <= counterminuni + 1;
                            countersecdec <= (others => '0');
                        end if;
                        if counterminuni = "1010" then
                            countermindec <= countermindec + 1;
                            counterminuni <= (others => '0');
                            end if;
                            
                     elsif countertiempo = countertiempo1 then
                     for i in 0 to 9 loop
                if counter = i then
                    led_on <= '1';
                else
                    led_on <= '0';
                end if;
            end loop;

            
            if counter = 10 then
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
                    end if;
                    end if;
            when others =>
                null;
        end case;
    end process;

    count_valsecuni <= STD_LOGIC_VECTOR(countersecuni);
    count_valminuni <= STD_LOGIC_VECTOR(counterminuni);
    count_valsecdec <= STD_LOGIC_VECTOR(countersecdec);
    count_valmindec <= STD_LOGIC_VECTOR(countermindec);
    count_valhor <= STD_LOGIC_VECTOR(counterhor);
    led_out <=led_on;

end Behavioral;
