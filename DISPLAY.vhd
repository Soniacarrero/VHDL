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
    Port ( reset_n : in STD_LOGIC;
           clk_display : in STD_LOGIC;
           piso_estado : in STD_LOGIC_VECTOR (2 downto 0);
           led : out STD_LOGIC_VECTOR (6 downto 0));
end display;


architecture Behavioral of display is

signal valor : std_logic_vector (6 downto 0):= "1111111";

begin

    process (reset_n, clk_display)

    begin

     if reset_n = '0' then
        valor <= "0000000";
    
     elsif rising_edge (clk_display) then
        case (piso_estado) is 
    
        when "001" =>
            valor <= "1001111";
        when "010" =>
            valor <= "0010010";
        when "011" =>
            valor <= "0000110";
        when "100" =>
            valor <= "1001100";
        when others =>
            valor <= "1111110";
        end case;
      
        end if;
    
     end process;
    
led <= valor;

end Behavioral;
