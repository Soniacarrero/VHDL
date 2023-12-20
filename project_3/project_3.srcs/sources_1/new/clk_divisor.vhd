----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.12.2023 11:02:26
-- Design Name: 
-- Module Name: clk_divisor - Behavioral
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

entity clk_divisor is
    Port ( CLK : in STD_LOGIC;
           CLK_OUT : out STD_LOGIC);
end clk_divisor;

architecture Behavioral of clk_divisor is
    constant MULTIPLIER_RATIO : integer := 60;  
    signal counter : integer range 0 to MULTIPLIER_RATIO - 1 := 0;
    signal CLK_OUT_temp : STD_LOGIC := '0';
begin
    process (CLK)
    begin
        if rising_edge(CLK) then
            if counter = MULTIPLIER_RATIO - 1 then
                counter <= 0;  
                CLK_OUT_temp <= not CLK_OUT_temp;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    CLK_OUT <= CLK_OUT_temp;

end Behavioral;
