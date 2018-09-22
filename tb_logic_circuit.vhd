library ieee;
use ieee.std_logic_1164.all;

entity tb_logic_circuit is
end tb_logic_circuit;

architecture tb of tb_logic_circuit is

    component logic_circuit
        port (sel0 : in std_logic;
              sel1 : in std_logic;
              Ai   : in std_logic;
              Bi   : in std_logic;
              Q    : out std_logic);
    end component;

    signal sel0 : std_logic;
    signal sel1 : std_logic;
    signal Ai   : std_logic;
    signal Bi   : std_logic;
    signal Q    : std_logic;

begin

    dut : logic_circuit
    port map (sel0 => sel0,
              sel1 => sel1,
              Ai   => Ai,
              Bi   => Bi,
              Q    => Q);

    stimuli : process
    begin
      
        sel0 <= '0';
        sel1 <= '0';
        Ai <= '0';
        Bi <= '1';
        wait for 100 ns;
        sel1 <= '1';
        wait for 100 ns;
        sel0 <= '1';
        sel1 <= '0';
        wait for 100 ns;
        sel1 <= '1';
        wait for 100 ns;
        
    end process;

end tb;