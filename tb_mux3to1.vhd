library ieee;
use ieee.std_logic_1164.all;

entity tb_mux3to1 is
end tb_mux3to1;

architecture tb of tb_mux3to1 is

    component mux3to1
        port (sel : in std_logic_vector (1 downto 0);
              In0 : in std_logic;
              In1 : in std_logic;
              In2 : in std_logic;
              Q   : out std_logic);
    end component;

    signal sel : std_logic_vector (1 downto 0);
    signal In0 : std_logic;
    signal In1 : std_logic;
    signal In2 : std_logic;
    signal Q   : std_logic;

begin

    dut : mux3to1
    port map (sel => sel,
              In0 => In0,
              In1 => In1,
              In2 => In2,
              Q   => Q);

    stimuli : process
    begin
        
        
        sel <= "00";
        In0 <= '0';
        In1 <= '1';
        In2 <= '0';
        wait for 100 ns;
        sel <= "01";
        wait for 100 ns;
        sel <= "10";


        wait;
    end process;

end tb;
