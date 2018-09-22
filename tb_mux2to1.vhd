library ieee;
use ieee.std_logic_1164.all;

entity tb_mux2to1 is
end tb_mux2to1;

architecture tb of tb_mux2to1 is

    component mux2to1
        port (In0 : in std_logic;
              In1 : in std_logic;
              s   : in std_logic;
              Z   : out std_logic);
    end component;

    signal In0 : std_logic;
    signal In1 : std_logic;
    signal s   : std_logic;
    signal Z   : std_logic;

begin

    dut : mux2to1
    port map (In0 => In0,
              In1 => In1,
              s   => s,
              Z   => Z);

    stimuli : process
    begin
     
        In0 <= '1';
        In1 <= '0';
        s <= '0';

        wait for 100 ns;
        s <= '1';
        wait for 100 ns;

        wait;
    end process;

end tb;
