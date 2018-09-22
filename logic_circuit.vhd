library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity logic_circuit is
    Port (sel0, sel1, Ai, Bi : in std_logic;
            Q : out std_logic
         );
end logic_circuit;

architecture Behavioral of logic_circuit is

    COMPONENT mux4to1
    PORT(
        In0 : IN std_logic;
        In1 : IN std_logic;
        In2 : IN std_logic;
        In3 : IN std_logic;
        S0 : IN std_logic;
        S1 : IN std_logic;
        Z : OUT std_logic
    );
    END COMPONENT;
    
    signal andG, orG, xorG, notG, outP : std_logic;
    
    begin
    
    mux1: mux4to1 PORT MAP(
        In0 => andG,
        In1 => orG,
        In2 => xorG,
        In3 => notG,
        S0 => sel1,
        S1 => sel0,
        Z => Q
    );
    
    andG <= Ai and Bi after 1 ns;
    orG <= Ai or Bi after 1 ns;
    xorG <= Ai xor Bi after 1 ns;
    notG <= not Ai after 1ns;

end Behavioral;