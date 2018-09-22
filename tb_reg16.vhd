library ieee;
use ieee.std_logic_1164.all;

entity tb_reg16 is
end tb_reg16;

architecture Behavioral of tb_reg16 is

    component reg16
        port (D    : in std_logic_vector (15 downto 0);
              load : in std_logic;
              Clk  : in std_logic;
              Q    : out std_logic_vector (15 downto 0));
    end component;

    signal D    : std_logic_vector (15 downto 0);
    signal load : std_logic;
    signal Clk  : std_logic;
    signal Q    : std_logic_vector (15 downto 0);

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : reg16
    port map (D    => D,
              load => load,
              Clk  => Clk,
              Q    => Q);

    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    Clk <= TbClock;

    stimuli : process
    begin
     
        D <= x"1111";
        load <= '1';
        wait for 100 ns; 
        D <= x"FFFF";
        wait for 100 ns;
        -- "DEAD should not go in as load is set to 0
        load <= '0';
        D <=x"DEAD";
        wait for 100 ns;
        -- Now "DEAD" should go in as load is now 1
        load <= '1';
        wait for 100 ns;
        D <= x"BEEF";
        wait for 100 * TbPeriod;

        
        TbSimEnded <= '1';
        wait;
    end process;

end Behavioral;

