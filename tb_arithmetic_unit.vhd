library ieee;
use ieee.std_logic_1164.all;

entity tb_arithmetic_unit is
end tb_arithmetic_unit;

architecture tb of tb_arithmetic_unit is

    component arithmetic_unit
        port (In00  : in std_logic;
              In01  : in std_logic;
              S0    : in std_logic;
              S1    : in std_logic;
              c_in  : in std_logic;
              c_out : out std_logic;
              Z     : out std_logic);
    end component;

    signal In00  : std_logic;
    signal In01  : std_logic;
    signal S0    : std_logic;
    signal S1    : std_logic;
    signal c_in  : std_logic;
    signal c_out : std_logic;
    signal Z     : std_logic;

begin

    dut : arithmetic_unit
    port map (In00  => In00,
              In01  => In01,
              S0    => S0,
              S1    => S1,
              c_in  => c_in,
              c_out => c_out,
              Z     => Z);

    stimuli : process
    begin
       
        In00 <= '0';
        In01 <= '0';
        S0 <= '0';
        S1 <= '0';
        c_in <= '0';
        wait for 100 ns;
        In00 <= '1';
        wait for 100 ns;
        In00 <= '0';
        In01 <= '1';
        wait for 100 ns;
        In00 <= '1';
        wait for 100 ns;
        In00 <= '0';
        In01 <= '0';
        c_in <= '1';
        wait for 100 ns;
        In01 <= '1';
        wait for 100 ns;
        In00 <= '1';
        In01 <= '0';
        wait for 100 ns;
        In01 <= '1';
        
        In00 <= '0';
        In01 <= '0';
        S0 <= '0';
        S1 <= '1';
        c_in <= '0';
        wait for 100 ns;
        In00 <= '1';
        wait for 100 ns;
        In00 <= '0';
        In01 <= '1';
        wait for 100 ns;
        In00 <= '1';
        wait for 100 ns;
        In00 <= '0';
        In01 <= '0';
        c_in <= '1';
        wait for 100 ns;
        In01 <= '1';
        wait for 100 ns;
        In00 <= '1';
        In01 <= '0';
        wait for 100 ns;
        In01 <= '1';
        
        In00 <= '0';
        In01 <= '0';
        S0 <= '1';
        S1 <= '0';
        c_in <= '0';
        wait for 100 ns;
        In00 <= '1';
        wait for 100 ns;
        In00 <= '0';
        In01 <= '1';
        wait for 100 ns;
        In00 <= '1';
        wait for 100 ns;
        In00 <= '0';
        In01 <= '0';
        c_in <= '1';
        wait for 100 ns;
        In01 <= '1';
        wait for 100 ns;
        In00 <= '1';
        In01 <= '0';
        wait for 100 ns;
        In01 <= '1';
        
        In00 <= '0';
        In01 <= '0';
        S0 <= '1';
        S1 <= '1';
        c_in <= '0';
        wait for 100 ns;
        In00 <= '1';
        wait for 100 ns;
        In00 <= '0';
        In01 <= '1';
        wait for 100 ns;
        In00 <= '1';
        wait for 100 ns;
        In00 <= '0';
        In01 <= '0';
        c_in <= '1';
        wait for 100 ns;
        In01 <= '1';
        wait for 100 ns;
        In00 <= '1';
        In01 <= '0';
        wait for 100 ns;
        In01 <= '1';
        
        
        


        wait;
    end process;

end tb;
