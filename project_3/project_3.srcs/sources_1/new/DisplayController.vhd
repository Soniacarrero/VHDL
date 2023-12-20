----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2023 18:17:11
-- Design Name: 
-- Module Name: DisplayController - Behavioral
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
entity DisplayController is
    Port (
        CLK : in STD_LOGIC;
        count_value_1 : in STD_LOGIC_VECTOR(6 downto 0);
        count_value_2 : in STD_LOGIC_VECTOR(6 downto 0);
        count_value_3 : in STD_LOGIC_VECTOR(6 downto 0);
        count_value_4 : in STD_LOGIC_VECTOR(6 downto 0);
        count_value_5 : in STD_LOGIC_VECTOR(6 downto 0);
        AN : out STD_LOGIC_VECTOR(3 downto 0);
        SEG : out STD_LOGIC_VECTOR(6 downto 0)
    );
end DisplayController;

architecture Behavioral of DisplayController is
    signal contador : INTEGER := 0;
    signal seleccion: std_logic_vector(1 downto 0):="00";
begin
    process(CLK)
    begin

        if rising_edge(CLK) then
            contador <= contador + 1;
            if contador= 4 then
                contador <= 0;
            end if;
        end if;
    end process;

    AN <= "1110" when (contador = 0) else
          "1101" when (contador = 1) else
          "1011" when (contador = 2) else
          "0111";

    SEG <= count_value_1 when (contador= 0) else
           count_value_2 when (contador = 1) else
           count_value_3 when (contador = 2) else
           count_value_4;

   
end Behavioral;


