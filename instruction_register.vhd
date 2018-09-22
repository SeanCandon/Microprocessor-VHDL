library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity instruction_register is
    Port (
        In0 : in std_logic_vector(15 downto 0);
        IL, Clk : in std_logic;
        DR, SA, SB : out std_logic_vector(2 downto 0);
        opcode : out std_logic_vector(6 downto 0)
     );
end instruction_register;

architecture Behavioral of instruction_register is

    COMPONENT reg16
    PORT (
        D : in std_logic_vector(15 downto 0);
        load, Clk : in std_logic;
        Q : out std_logic_vector(15 downto 0)
    );
    END COMPONENT;
    
    COMPONENT mux2_16
    PORT (
        In0, In1 : in std_logic_vector(15 downto 0);
        s : in std_logic;
        Z : out std_logic_vector(15 downto 0)
    );
    END COMPONENT;
    
   
    signal reg_out, mux_out : std_logic_vector(15 downto 0);

begin

    reg : reg16 PORT MAP (
        D => mux_out,
        load => '1',
        Clk => Clk,
        Q => reg_out
    );
    
    mux : mux2_16 PORT MAP (
        In0 => reg_out,
        In1 => In0,
        s => IL,
        Z => mux_out
    );
    
    opcode <= reg_out(15 downto 9);
    DR <= reg_out(8 downto 6);
    SA <= reg_out(5 downto 3);
    SB <= reg_out(2 downto 0);
    

    

end Behavioral;
