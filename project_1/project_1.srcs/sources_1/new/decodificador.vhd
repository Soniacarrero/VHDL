----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10.12.2023 17:55:16
-- Design Name: 
-- Module Name: decodificador - Behavioral
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
-----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decodificador is
   Port (
        BCD : in STD_LOGIC_VECTOR(3 downto 0);
        SEG : out STD_LOGIC_VECTOR(6 downto 0)
    );
end decodificador;

architecture Behavioral of decodificador is
begin
 process(BCD)
    begin
        case BCD is
            when "0000" =>
                SEG <= "0000001"; -- 0
            when "0001" =>
                SEG <= "1001111"; -- 1
            when "0010" =>
                SEG <= "0010010"; -- 2
            when "0011" =>
                SEG <= "0000110"; -- 3
            when "0100" =>
                SEG <= "1001100"; -- 4
            when "0101" =>
                SEG <= "0100100"; -- 5
            when "0110" =>
                SEG <= "0100000"; -- 6
            when "0111" =>
                SEG <= "0001111"; -- 7
            when "1000" =>
                SEG <= "0000000"; -- 8
            when others =>
                SEG <= "0000100"; -- 9 
        end case;
        end process;
end Behavioral;
