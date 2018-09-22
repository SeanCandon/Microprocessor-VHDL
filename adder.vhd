library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity adder is
    Port (
        In0, In1, cIn : in std_logic;
        S, cOut : out std_logic
     );
end adder;

architecture Behavioral of adder is

    signal xor1_out, and1Out, and2out : std_logic;

    begin

        xor1_out <= In0 xor In1 after 1 ns;
        and1Out <= cIn and xor1_out after 1 ns;
        and2out <= In0 and In1 after 1 ns;
        cOut <= and1Out or and2Out after 1 ns;
        S <= xor1_out xor cIn after 1 ns;

end Behavioral;
