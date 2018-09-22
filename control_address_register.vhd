library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity control_address_register is
    Port (
        In0 : in std_logic_vector(7 downto 0);
        sel, Clk, reset : in std_logic;
        Z : out std_logic_vector(7 downto 0)
     );
end control_address_register;

architecture Behavioral of control_address_register is

    COMPONENT reg8
    PORT (
        D : in std_logic_vector(7 downto 0);
        load, Clk : in std_logic;
        Q : out std_logic_vector(7 downto 0)
    );
    END COMPONENT;
    
    COMPONENT mux2_8bit
    PORT (
        In0, In1 : in std_logic_vector(7 downto 0);
        s : in std_logic;
        Z : out std_logic_vector(7 downto 0)
    );
    END COMPONENT;
    
    COMPONENT adder_8bit
    PORT(
        A, B : in std_logic_vector(7 downto 0);
        c : out std_logic;
        Z : out std_logic_vector(7 downto 0)
    );
    END COMPONENT;
    
    signal reg_out, mux_out, adder_out, reg_in : std_logic_vector(7 downto 0);
    signal adder_c : std_logic;
    
begin

    adder : adder_8bit PORT MAP(
        A => reg_out,
        B => x"01",
        c => adder_c,
        Z => adder_out   
    );
    
    reg : reg8 PORT MAP(
        D => reg_in,
        load => '1',
        Clk => Clk,
        Q => reg_out
    );
    
    mux0 : mux2_8bit PORT MAP(
        In0 => In0,
        In1 => adder_out,
        s => sel,
        Z => mux_out
    );
    
    mux1 : mux2_8bit PORT MAP(
        In0 => mux_out,
        In1 => x"08",
        s => reset,
        Z => reg_in
    );
    
    Z <= reg_out;
    
--    reg_in <= mux_out when reset='0' else
--              "00000000";


end Behavioral;
