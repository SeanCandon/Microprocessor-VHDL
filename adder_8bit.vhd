library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity adder_8bit is
    Port (
            A : in std_logic_vector(7 downto 0);
            B : in std_logic_vector(7 downto 0);
            c : out std_logic;
            Z : out std_logic_vector(7 downto 0)
     );
end adder_8bit;

architecture Behavioral of adder_8bit is

    COMPONENT adder
    PORT(
        In0, In1, cIn : in std_logic;
        S, cOut : out std_logic
    );
    END COMPONENT;
    
    signal c0, c1, c2, c3, c4, c5, c6 : std_logic;  

begin

    adder0 : adder PORT MAP(
        In0 => A(0),
        In1 => B(0),
        cIn => '0',
        S => Z(0),
        cOut => c0  
    );
    
    adder1 : adder PORT MAP(
        In0 => A(1),
        In1 => B(1),
        cIn => c0,
        S => Z(1),
        cOut => c1  
    );
    
    adder2 : adder PORT MAP(
        In0 => A(2),
        In1 => B(2),
        cIn => c1,
        S => Z(2),
        cOut => c2  
    );
    
    adder3 : adder PORT MAP(
        In0 => A(3),
        In1 => B(3),
        cIn => c2,
        S => Z(3),
        cOut => c3  
    );
    
    adder4 : adder PORT MAP(
        In0 => A(4),
        In1 => B(4),
        cIn => c3,
        S => Z(4),
        cOut => c4  
    );
    
    adder5 : adder PORT MAP(
        In0 => A(5),
        In1 => B(5),
        cIn => c4,
        S => Z(5),
        cOut => c5  
    );
    
    adder6 : adder PORT MAP(
        In0 => A(6),
        In1 => B(6),
        cIn => c5,
        S => Z(6),
        cOut => c6  
    );
    
    adder7 : adder PORT MAP(
        In0 => A(7),
        In1 => B(7),
        cIn => c6,
        S => Z(7),
        cOut => c 
    );
    


end Behavioral;
