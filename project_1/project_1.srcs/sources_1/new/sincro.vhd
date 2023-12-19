----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.12.2023 17:19:43
-- Design Name: 
-- Module Name: sincro - Behavioral
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




entity Sincro is
Port ( CLK : in STD_LOGIC;
ASYNC_IN : in STD_LOGIC;
SYNC_OUT : out STD_LOGIC);
end Sincro;
architecture Behavioral of sincro is
signal sreg : std_logic_vector(1 downto 0);
begin
process (CLK)
begin
if rising_edge(CLK) then 
sync_out <= sreg(1);
sreg <= sreg(0) & async_in;
end if; 
end process;
end Behavioral;
