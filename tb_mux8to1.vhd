library ieee;
use ieee.std_logic_1164.all;

entity tb_mux8_16bit is
end tb_mux8_16bit;

architecture tb of tb_mux8_16bit is

    component mux8_16bit
        port (In0 : in std_logic_vector (15 downto 0);
              In1 : in std_logic_vector (15 downto 0);
              In2 : in std_logic_vector (15 downto 0);
              In3 : in std_logic_vector (15 downto 0);
              In4 : in std_logic_vector (15 downto 0);
              In5 : in std_logic_vector (15 downto 0);
              In6 : in std_logic_vector (15 downto 0);
              In7 : in std_logic_vector (15 downto 0);
              S0  : in std_logic_vector (2 downto 0);
              Z   : out std_logic_vector (15 downto 0));
    end component;

    signal In0 : std_logic_vector (15 downto 0);
    signal In1 : std_logic_vector (15 downto 0);
    signal In2 : std_logic_vector (15 downto 0);
    signal In3 : std_logic_vector (15 downto 0);
    signal In4 : std_logic_vector (15 downto 0);
    signal In5 : std_logic_vector (15 downto 0);
    signal In6 : std_logic_vector (15 downto 0);
    signal In7 : std_logic_vector (15 downto 0);
    signal S0  : std_logic_vector (2 downto 0);
    signal Z   : std_logic_vector (15 downto 0);

begin

    dut : mux8_16bit
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
    
        In0 <= x"0123";
        In1 <= x"4567";
        In2 <= x"89ab";
        In3 <= x"cdef";
        In4 <= x"0000";
        In5 <= x"ffff";
        In6 <= x"dead";
        In7 <= x"beef";
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

    end process;

end tb;