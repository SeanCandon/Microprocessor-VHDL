library ieee;
use ieee.std_logic_1164.all;

entity tb_mux4to1 is
end tb_mux4to1;

architecture tb of tb_mux4to1 is

    component mux4to1
        port (In0 : in std_logic;
              In1 : in std_logic;
              In2 : in std_logic;
              In3 : in std_logic;
              S0  : in std_logic;
              S1  : in std_logic;
              Z   : out std_logic);
    end component;

    signal In0 : std_logic;
    signal In1 : std_logic;
    signal In2 : std_logic;
    signal In3 : std_logic;
    signal S0  : std_logic;
    signal S1  : std_logic;
    signal Z   : std_logic;

begin

    dut : mux4to1
    port map (In0 => In0,
              In1 => In1,
              In2 => In2,
              In3 => In3,
              S0  => S0,
              S1  => S1,
              Z   => Z);

    stimuli : process
    begin
        
        In0 <= '0';
        In1 <= '1';
        In2 <= '0';
        In3 <= '1';
        S0 <= '0';
        S1 <= '0';
        wait for 100 ns; 
        S1 <= '1'; 
        wait for 100 ns;
        S0 <= '1';
        S1 <= '0';
        wait for 100 ns;
        S1 <= '1';
        wait for 200 ns;


        wait;
    end process;

end tb;