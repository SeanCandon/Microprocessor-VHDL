library ieee;
use ieee.std_logic_1164.all;

entity tb_shifter is
end tb_shifter;

architecture tb of tb_shifter is

    component shifter
        port (S : in std_logic_vector (1 downto 0);
              B : in std_logic_vector (15 downto 0);
              H : out std_logic_vector (15 downto 0));
    end component;

    signal S : std_logic_vector (1 downto 0);
    signal B : std_logic_vector (15 downto 0);
    signal H : std_logic_vector (15 downto 0);

begin

    dut : shifter
    port map (S => S,
              B => B,
              H => H);

    stimuli : process
    begin

        S <= "01";
        B <= x"0002";

        wait for 100 ns;
        S <= "10";
        wait for 100 ns;


        wait;
    end process;

end tb;