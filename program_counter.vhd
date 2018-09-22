library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity program_counter is
    Port (
        In0 : in std_logic_vector(15 downto 0);
        pi, pl, Clk, reset : in std_logic;
        Q : out std_logic_vector(15 downto 0)
     );
end program_counter;

architecture Behavioral of program_counter is

    
    COMPONENT adder_16bit
    PORT(
        A, B : in std_logic_vector(15 downto 0);
        c : out std_logic;
        Z : out std_logic_vector(15 downto 0)
    );
    END COMPONENT;
    
    COMPONENT reg16
    PORT(
        D : in std_logic_vector(15 downto 0);
        load, Clk : in std_logic;
        Q : out std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    
    
    signal newPC, reg_out, adder0_out, adder1_out : std_logic_vector(15 downto 0);
    signal adder0_c, adder1_c, control : std_logic;


begin

    reg : reg16 PORT MAP(
        D => newPC,
        load => control,
        Clk => Clk,
        Q => reg_out      
    );
    
    adder0 : adder_16bit PORT MAP(
        A => reg_out,
        B => x"0001",
        c => adder0_c,
        Z => adder0_out
    );
    
    adder1 : adder_16bit PORT MAP(
        A => reg_out,
        B => In0,
        c => adder1_c,
        Z => adder1_out
    );
    
newPC <= x"0000" when reset='1' else
         adder1_out when pl='1' else
         adder0_out when pi='1' else
         reg_out;
         
Q <= reg_out;

control <= (pl or pi or reset);    
    



end Behavioral;
