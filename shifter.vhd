library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity shifter is
    Port (
        S : in std_logic_vector(1 downto 0);
        B : in std_logic_vector(15 downto 0);
        H : out std_logic_vector(15 downto 0)
     );
end shifter;

architecture Behavioral of shifter is

    COMPONENT mux3to1
    PORT(
            sel : in std_logic_vector(1 downto 0);
            In0, In1, In2 : in std_logic;
            Q : out std_logic
    );
    END COMPONENT;  
    
    signal IR, IL : std_logic;    

begin

    mux0 : mux3to1 PORT MAP(
        sel => S,
        In0 => B(0),
        In1 => B(1),
        In2 => IL,
        Q => H(0)
    );
    
    mux1 : mux3to1 PORT MAP(
        sel => S,
        In0 => B(1),
        In1 => B(2),
        In2 => B(0),
        Q => H(1)
    );
    
    mux2 : mux3to1 PORT MAP(
        sel => S,
        In0 => B(2),
        In1 => B(3),
        In2 => B(1),
        Q => H(2)
    );
    
    mux3 : mux3to1 PORT MAP(
        sel => S,
        In0 => B(3),
        In1 => B(4),
        In2 => B(2),
        Q => H(3)
    );
    
    mux4 : mux3to1 PORT MAP(
        sel => S,
        In0 => B(4),
        In1 => B(5),
        In2 => B(3),
        Q => H(4)
    );
    
    mux5 : mux3to1 PORT MAP(
        sel => S,
        In0 => B(5),
        In1 => B(6),
        In2 => B(4),
        Q => H(5)
    );
    
    mux6 : mux3to1 PORT MAP(
        sel => S,
        In0 => B(6),
        In1 => B(7),
        In2 => B(5),
        Q => H(6)
    );
    
    mux7 : mux3to1 PORT MAP(
        sel => S,
        In0 => B(7),
        In1 => B(8),
        In2 => B(6),
        Q => H(7)
    );
    
    mux8 : mux3to1 PORT MAP(
        sel => S,
        In0 => B(8),
        In1 => B(9),
        In2 => B(7),
        Q => H(8)
    );
    
    mux9 : mux3to1 PORT MAP(
        sel => S,
        In0 => B(9),
        In1 => B(10),
        In2 => B(8),
        Q => H(9)
    );
    
    mux10 : mux3to1 PORT MAP(
        sel => S,
        In0 => B(10),
        In1 => B(11),
        In2 => B(9),
        Q => H(10)
    );
    
    mux11 : mux3to1 PORT MAP(
        sel => S,
        In0 => B(11),
        In1 => B(12),
        In2 => B(10),
        Q => H(11)
    );
    
    mux12 : mux3to1 PORT MAP(
        sel => S,
        In0 => B(12),
        In1 => B(13),
        In2 => B(11),
        Q => H(12)
    );
    
    mux13 : mux3to1 PORT MAP(
        sel => S,
        In0 => B(13),
        In1 => B(14),
        In2 => B(12),
        Q => H(13)
    );
    
    mux14 : mux3to1 PORT MAP(
        sel => S,
        In0 => B(14),
        In1 => B(15),
        In2 => B(13),
        Q => H(14)
    );
    
    mux15 : mux3to1 PORT MAP(
        sel => S,
        In0 => B(15),
        In1 => IR,
        In2 => B(14),
        Q => H(15)
    );
    
    IR <= '0';
    IL <= '0';
    


end Behavioral;
