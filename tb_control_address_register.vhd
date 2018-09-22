library ieee;
use ieee.std_logic_1164.all;

entity tb_control_address_register is
end tb_control_address_register;

architecture tb of tb_control_address_register is

    component control_address_register
        port (In0 : in std_logic_vector (7 downto 0);
              sel : in std_logic;
              Clk : in std_logic;
              reset : in std_logic;
              Z   : out std_logic_vector (7 downto 0));
    end component;

    signal In0 : std_logic_vector (7 downto 0);
    signal sel : std_logic;
    signal Clk : std_logic;
    signal reset : std_logic;
    signal Z   : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : control_address_register
    port map (In0 => In0,
              sel => sel,
              Clk => Clk,
              reset => reset,
              Z   => Z);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that Clk is really your main clock signal
    Clk <= TbClock;

    stimuli : process
    begin
        
        In0 <= x"fe";
        sel <= '0';
        reset <= '1';
        wait for 100 ns;
        
        reset <= '0';
        wait for 100 ns;
        
        sel <= '1';
        wait for 100 ns;
        
        In0 <= x"aa";
        sel <= '0';
        wait for 100 ns;
        
        reset <= '1';
        wait for 100 ns;
     
        TbSimEnded <= '1';
        wait;
    end process;

end tb;