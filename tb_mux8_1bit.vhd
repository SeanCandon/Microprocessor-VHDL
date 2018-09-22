library ieee;
use ieee.std_logic_1164.all;

entity tb_mux8to1 is
end tb_mux8to1;

architecture tb of tb_mux8to1 is

    component mux8to1
        port (In0 : in std_logic;
              In1 : in std_logic;
              In2 : in std_logic;
              In3 : in std_logic;
              In4 : in std_logic;
              In5 : in std_logic;
              In6 : in std_logic;
              In7 : in std_logic;
              S0  : in std_logic_vector (2 downto 0);
              Z   : out std_logic);
    end component;

    signal In0 : std_logic;
    signal In1 : std_logic;
    signal In2 : std_logic;
    signal In3 : std_logic;
    signal In4 : std_logic;
    signal In5 : std_logic;
    signal In6 : std_logic;
    signal In7 : std_logic;
    signal S0  : std_logic_vector (2 downto 0);
    signal Z   : std_logic;

begin

    dut : mux8to1
    port map (In0 => In0,
              In1 => In1,
              In2 => In2,
              In3 => In3,
              In4 => In4,
              In5 => In5,
              In6 => In6,
              In7 => In7,
              S0  => S0,
              Z   => Z);

    stimuli : process
    begin
        
        In0 <= '0';
        In1 <= '1';
        In2 <= '0';
        In3 <= '1';
        In4 <= '0';
        In5 <= '1';
        In6 <= '0';
        In7 <= '1';
        S0 <= "000";
        wait for 100 ns;
        S0 <= "001";
        wait for 100 ns;
        S0 <= "010";
        wait for 100 ns;
        S0 <= "011";
        wait for 100 ns;
        S0 <= "100";
        wait for 100 ns;
        S0 <= "101";
        wait for 100 ns;
        S0 <= "110";
        wait for 100 ns;
        S0 <= "111";
        wait for 100 ns;

        wait;
    end process;

end tb;