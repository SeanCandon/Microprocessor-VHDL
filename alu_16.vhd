library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity alu_16 is
        Port (
            A, B : in std_logic_vector(15 downto 0);
            fs4 : in std_logic_vector(3 downto 0);
            c_final : out std_logic;
            overflow : out std_logic;
            Q : out std_logic_vector(15 downto 0)
         );
end alu_16;

architecture Behavioral of alu_16 is

    COMPONENT alu
    PORT(
        In0, In1, S0, S1, S2, cIn : in std_logic;
        Z, cOut : out std_logic
    );
    END COMPONENT;
    
    signal c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11,
            c12, c13, c14, c15, c16, z1, z2, z3, z4, z5, z6,
            z7, z8, z9, z10, z11, z12, z13, z14, z15, z16, v : std_logic;

    begin
    
    alu_1 : alu PORT MAP(
        In0 => A(0),
        In1 => B(0),
        S0 => fs4(1),
        S1 => fs4(2),
        S2 => fs4(3),
        cIn => fs4(0),
        cOut => c1,
        Z => Q(0)
    );
    
    alu_2 : alu PORT MAP(
        In0 => A(1),
        In1 => B(1),
        S0 => fs4(1),
        S1 => fs4(2),
        S2 => fs4(3),
        cIn => c1,
        cOut => c2,
        Z => Q(1)
    );
    
    alu_3 : alu PORT MAP(
        In0 => A(2),
        In1 => B(2),
        S0 => fs4(1),
        S1 => fs4(2),
        S2 => fs4(3),
        cIn => c2,
        cOut => c3,
        Z => Q(2)
    );
    
    alu_4 : alu PORT MAP(
        In0 => A(3),
        In1 => B(3),
        S0 => fs4(1),
        S1 => fs4(2),
        S2 => fs4(3),
        cIn => c3,
        cOut => c4,
        Z => Q(3)
    );
    
    alu_5 : alu PORT MAP(
        In0 => A(4),
        In1 => B(4),
        S0 => fs4(1),
        S1 => fs4(2),
        S2 => fs4(3),
        cIn => c4,
        cOut => c5,
        Z => Q(4)
    );
    
    alu_6 : alu PORT MAP(
        In0 => A(5),
        In1 => B(5),
        S0 => fs4(1),
        S1 => fs4(2),
        S2 => fs4(3),
        cIn => c5,
        cOut => c6,
        Z => Q(5)
    );
    
    alu_7 : alu PORT MAP(
        In0 => A(6),
        In1 => B(6),
        S0 => fs4(1),
        S1 => fs4(2),
        S2 => fs4(3),
        cIn => c6,
        cOut => c7,
        Z => Q(6)
    );
    
    alu_8 : alu PORT MAP(
        In0 => A(7),
        In1 => B(7),
        S0 => fs4(1),
        S1 => fs4(2),
        S2 => fs4(3),
        cIn => c7,
        cOut => c8,
        Z => Q(7)
    );
    
    alu_9 : alu PORT MAP(
        In0 => A(8),
        In1 => B(8),
        S0 => fs4(1),
        S1 => fs4(2),
        S2 => fs4(3),
        cIn => c8,
        cOut => c9,
        Z => Q(8)
    );
    
    alu_10 : alu PORT MAP(
        In0 => A(9),
        In1 => B(9),
        S0 => fs4(1),
        S1 => fs4(2),
        S2 => fs4(3),
        cIn => c9,
        cOut => c10,
        Z => Q(9)
    );
    
    alu_11 : alu PORT MAP(
        In0 => A(10),
        In1 => B(10),
        S0 => fs4(1),
        S1 => fs4(2),
        S2 => fs4(3),
        cIn => c10,
        cOut => c11,
        Z => Q(10)
    );
    
    alu_12 : alu PORT MAP(
        In0 => A(11),
        In1 => B(11),
        S0 => fs4(1),
        S1 => fs4(2),
        S2 => fs4(3),
        cIn => c11,
        cOut => c12,
        Z => Q(11)
    );
    
    alu_13 : alu PORT MAP(
        In0 => A(12),
        In1 => B(12),
        S0 => fs4(1),
        S1 => fs4(2),
        S2 => fs4(3),
        cIn => c12,
        cOut => c13,
        Z => Q(12)
    );
    
    alu_14 : alu PORT MAP(
        In0 => A(13),
        In1 => B(13),
        S0 => fs4(1),
        S1 => fs4(2),
        S2 => fs4(3),
        cIn => c13,
        cOut => c14,
        Z => Q(13)
    );
    
    alu_15 : alu PORT MAP(
        In0 => A(14),
        In1 => B(14),
        S0 => fs4(1),
        S1 => fs4(2),
        S2 => fs4(3),
        cIn => c14,
        cOut => c15,
        Z => Q(14)
    );
    
    alu_16 : alu PORT MAP(
        In0 => A(15),
        In1 => B(15),
        S0 => fs4(1),
        S1 => fs4(2),
        S2 => fs4(3),
        cIn => c15,
        cOut => c16,
        Z => Q(15)
    );
    
    c_final <= c16;
    overflow <= c16 xor c15;


end Behavioral;
