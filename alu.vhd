library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- This is the alu for 1 bit slice

entity alu is
    Port (
        In0, In1, S0, S1, S2, cIn : in std_logic;
        Z, cOut : out std_logic 
    );
end alu;

architecture Behavioral of alu is

    COMPONENT mux2to1
    PORT(
            In0, In1, s : IN std_logic;
            Z : OUT std_logic
    );
    END COMPONENT;
    
    COMPONENT arithmetic_unit
    PORT(
            In00, In01, S0, S1, c_in : IN std_logic;
            c_out, Z : OUT std_logic
    );
    END COMPONENT;
    
    COMPONENT logic_circuit
    PORT(
            sel0, sel1, Ai, Bi : IN std_logic;
            Q : OUT std_logic
    );
    END COMPONENT;
    
    signal arith_out, logic_out : std_logic;

begin

    logic : logic_circuit PORT MAP(
        sel0 => S0,
        sel1 => S1,
        Ai => In0,
        Bi => In1,
        Q => logic_out
    );
    
    arith : arithmetic_unit PORT MAP(
        c_in => cIn,
        In00 => In0,
        In01 => In1,
        S0 => S0,
        S1 => S1,
        c_out => cOut,
        Z => arith_out
    );
    
    mux0 : mux2to1 PORT MAP(
        In0 => arith_out,
        In1 => logic_out,
        s => S2,
        Z => Z
    );


end Behavioral;
