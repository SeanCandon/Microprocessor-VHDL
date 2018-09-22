library ieee;
use ieee.std_logic_1164.all;

entity tb_adder_8bit is
end tb_adder_8bit;

architecture tb of tb_adder_8bit is

    component adder_8bit
        port (A : in std_logic_vector (7 downto 0);
              B : in std_logic_vector (7 downto 0);
              c : out std_logic;
              Z : out std_logic_vector (7 downto 0));
    end component;

    signal A : std_logic_vector (7 downto 0);
    signal B : std_logic_vector (7 downto 0);
    signal c : std_logic;
    signal Z : std_logic_vector (7 downto 0);

begin

    dut : adder_8bit
    port map (A => A,
              B => B,
              c => c,
              Z => Z);

    stimuli : process
    begin
        
        A <= x"03";
        B <= x"04";
        wait for 100 ns;
        
        A <= x"07";
        B <= x"fe";
        wait for 100 ns;

        wait;
    end process;

end tb;
