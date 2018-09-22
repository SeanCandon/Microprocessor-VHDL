library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity demux_1to2 is
    Port (
            In0 : in std_logic_vector(15 downto 0);
            sel : in std_logic;
            Z0, Z1 : out std_logic_vector(15 downto 0)     
     );
end demux_1to2;

architecture Behavioral of demux_1to2 is

begin

Z0 <= In0 when sel='0';
Z1 <= In0 when sel='1';

end Behavioral;
