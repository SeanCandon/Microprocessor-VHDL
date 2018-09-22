library ieee;
use ieee.std_logic_1164.all;

entity tb_adder is
end tb_adder;

architecture tb of tb_adder is

    component adder
        port (In0  : in std_logic;
              In1  : in std_logic;
              cIn  : in std_logic;
              S    : out std_logic;
              cOut : out std_logic);
    end component;

    signal In0  : std_logic;
    signal In1  : std_logic;
    signal cIn  : std_logic;
    signal S    : std_logic;
    signal cOut : std_logic;

begin

    dut : adder
    port map (In0  => In0,
              In1  => In1,
              cIn  => cIn,
              S    => S,
              cOut => cOut);

    stimuli : process
    begin
      
        In0 <= '0';
        In1 <= '0';
        cIn <= '0';
        wait for 100 ns;
        In0 <= '1';
        wait for 100 ns;
        In0 <= '0';
        In1 <= '1';
        wait for 100 ns;
        In0 <= '1';
        wait for 100 ns;
        In0 <= '0';
        In1 <= '0';
        cIn <= '1';
        wait for 100 ns;
        In1 <= '1';
        wait for 100 ns;
        In0 <= '1';
        In1 <= '0';
        wait for 100 ns;
        In1 <= '1';

        wait;
    end process;

end tb;