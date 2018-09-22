library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity mux3to1 is
    Port (
            sel : in std_logic_vector(1 downto 0);
            In0, In1, In2 : in std_logic;
            Q : out std_logic
     );
end mux3to1;

architecture Behavioral of mux3to1 is

begin

Q <= In0 when sel(0)='0' and sel(1) = '0' else
        In1 when sel(0) = '1' and sel(1) = '0' else
        In2 when sel(0) = '0' and sel(1) = '1';

end Behavioral;
