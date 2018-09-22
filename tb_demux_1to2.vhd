library ieee;
use ieee.std_logic_1164.all;

entity tb_demux_1to2 is
end tb_demux_1to2;

architecture tb of tb_demux_1to2 is

    component demux_1to2
        port (In0 : in std_logic_vector (15 downto 0);
              sel : in std_logic;
              Z0  : out std_logic_vector (15 downto 0);
              Z1  : out std_logic_vector (15 downto 0));
    end component;

    signal In0 : std_logic_vector (15 downto 0);
    signal sel : std_logic;
    signal Z0  : std_logic_vector (15 downto 0);
    signal Z1  : std_logic_vector (15 downto 0);

begin

    dut : demux_1to2
    port map (In0 => In0,
              sel => sel,
              Z0  => Z0,
              Z1  => Z1);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        In0 <= x"abcd";
        sel <= '0';
        wait for 100 ns;
        In0 <= x"ffff";
        sel <= '1';

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;
