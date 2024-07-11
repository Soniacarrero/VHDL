----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.06.2024 11:25:18
-- Design Name: 
-- Module Name: display - Behavioral
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
use ieee.std_logic_arith.ALL;
use ieee.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity display is
    Port ( reset_n : in STD_LOGIC; --reset negado
           clk_display : in STD_LOGIC; --CLK del display (coincide con el del tratamiento de pisos)
           piso_estado : in STD_LOGIC_VECTOR (2 downto 0); -- piso en el que está (el que tiene que verse refrejado en el display)
           led : out STD_LOGIC_VECTOR (6 downto 0)); --leds del display
end display;


architecture Behavioral of display is

signal valor : std_logic_vector (6 downto 0):= "1111111";

begin

    process (reset_n, clk_display)

    begin

     if reset_n = '0' then
        valor <= "0000000"; --todos encendidos
    
     elsif rising_edge (clk_display) then
        case (piso_estado) is 
    
        when "001" =>
            valor <= "0000001"; -- 0
        when "010" =>
            valor <= "1001111"; -- 1
        when "011" =>
            valor <= "0010010"; -- 2
        when "100" =>
            valor <= "0000110"; -- 3
        when others =>
            valor <= "1001100";
        end case;
      
        end if;
    
     end process;
    
led <= valor;

end Behavioral;
