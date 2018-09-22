library ieee;
use ieee.std_logic_1164.all;

entity tb_program_counter is
end tb_program_counter;

architecture tb of tb_program_counter is

    component program_counter
        port (In0 : in std_logic_vector (15 downto 0);
              pi  : in std_logic;
              pl  : in std_logic;
              reset : in std_logic;
              Clk : in std_logic;
              Q   : out std_logic_vector (15 downto 0));
    end component;

    signal In0 : std_logic_vector (15 downto 0);
    signal pi  : std_logic;
    signal pl  : std_logic;
    signal reset : std_logic;
    signal Clk : std_logic;
    signal Q   : std_logic_vector (15 downto 0);

    constant TbPeriod : time := 100 ns; 
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : program_counter
    port map (In0 => In0,
              pi  => pi,
              pl  => pl,
              reset => reset,
              Clk => Clk,
              Q   => Q);


    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    Clk <= TbClock;

    stimuli : process
    begin
  
        In0 <= x"0002";
        pi <= '0';
        pl <= '0';
        reset <= '1';
        wait for 100 ns;
        
        reset <= '0';
        wait for 100 ns;
        
        pl <= '1';
        wait for 100 ns;
        
        pi <= '1';
        wait for 100 ns;
        
        pl <= '0';
        wait for 100 ns;
        
        In0 <= x"ffff";
        pl <= '1';
        wait for 100 ns;
        
        In0 <= x"dead";
        pl <= '0';
        pi <= '0';
        wait for 100 ns;

        TbSimEnded <= '1';
        wait;
    end process;

end tb;