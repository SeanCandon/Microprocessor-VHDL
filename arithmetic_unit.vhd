library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity arithmetic_unit is
    Port ( 
           In00, In01, S0, S1, c_in : in std_logic;
           c_out, Z : out std_logic 
    );
end arithmetic_unit;

architecture Behavioral of arithmetic_unit is

    COMPONENT mux2to1 
    PORT(
        In0 : IN std_logic;
        In1 : IN std_logic;
        s : IN std_logic;
        Z : OUT std_logic
    );
    END COMPONENT;
    
    COMPONENT adder
    PORT(
        In0 : IN std_logic;
        In1 : IN std_logic;
        cIn : IN std_logic;
        S : OUT std_logic;
        cOut : OUT std_logic
    );
    END COMPONENT;
    
    signal muxOut : std_logic;

    begin
        
        mux0 : mux2to1 PORT MAP(
                In0 => S1,
                In1 => S0,
                s => In01,
                Z => muxOut
        );
        
        adder0 : adder PORT MAP(
                In0 => In00,
                In1 => muxOut,
                cIn => c_in,
                cOut => c_out,
                S =>Z
        );
    

end Behavioral;
