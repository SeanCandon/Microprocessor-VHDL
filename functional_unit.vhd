library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity functional_unit is
    Port (
        A, B : in std_logic_vector(15 downto 0);
        fs : in std_logic_vector (4 downto 0);
        C, V, N, Z : out std_logic;
        F : out std_logic_vector(15 downto 0)
     );
end functional_unit;

architecture Behavioral of functional_unit is

    COMPONENT alu_16
    PORT(
        A, B : in std_logic_vector(15 downto 0);
        fs4 : in std_logic_vector(3 downto 0);
        c_final : out std_logic;
        overflow : out std_logic;
        Q : out std_logic_vector(15 downto 0)
     );
     END COMPONENT;
     
    COMPONENT shifter
    PORT(
         S : in std_logic_vector(1 downto 0);
         B : in std_logic_vector(15 downto 0);
         H : out std_logic_vector(15 downto 0)
    );
    END COMPONENT;
    
    COMPONENT mux2_16
    PORT(
        In0 : in std_logic_vector(15 downto 0);
        In1 : in std_logic_vector(15 downto 0);
        s : in std_logic;
        Z : out std_logic_vector(15 downto 0)
    );
    END COMPONENT;
    
    signal g_select : std_logic_vector(3 downto 0);
    signal h_select : std_logic_vector(1 downto 0);
    signal alu_out, shift_out : std_logic_vector(15 downto 0);
    signal zero : std_logic;
    
begin

    alu : alu_16 PORT MAP(
        A => A,
        B => B,
        fs4(0) => fs(0),
        fs4(1) => fs(1),
        fs4(2) => fs(2),
        fs4(3) => fs(3),
        c_final => C,
        overflow => V,
        Q => alu_out    
    );
    
    shifter0 : shifter PORT MAP(
        S(0) => fs(2),
        S(1) => fs(3),
        B => B,
        H => shift_out
    );
    
    mux0 : mux2_16 PORT MAP(
        In0 => alu_out,
        In1 => shift_out,
        s => fs(4),
        Z => F
    );
    
    N <= alu_out(15);
        
    zero <= alu_out(15) or alu_out(14) or alu_out(13) or alu_out(12) or alu_out(11) or alu_out(10) or alu_out(9) or alu_out(8) or alu_out(7) or
        alu_out(6) or alu_out(5) or alu_out(4) or alu_out(3) or alu_out(2) or alu_out(1) or alu_out(0);
        
    Z <= not zero;


end Behavioral;
