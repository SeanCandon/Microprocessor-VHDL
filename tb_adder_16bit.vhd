library ieee;
use ieee.std_logic_1164.all;

entity tb_adder_16bit is
end tb_adder_16bit;

architecture tb of tb_adder_16bit is

    component adder_16bit
        port (A : in std_logic_vector (15 downto 0);
              B : in std_logic_vector (15 downto 0);
              c : out std_logic;
              Z : out std_logic_vector (15 downto 0));
    end component;

    signal A : std_logic_vector (15 downto 0);
    signal B : std_logic_vector (15 downto 0);
    signal c : std_logic;
    signal Z : std_logic_vector (15 downto 0);

begin

    dut : adder_16bit
    port map (A => A,
              B => B,
              c => c,
              Z => Z);

    stimuli : process
    begin
       
        A <= x"0003";
        B <= x"0004";
        wait for 100 ns;
        
        A <= x"ffff";
        B <= x"0002";
        wait for 100 ns;

  
        wait for 100 ns;

        wait;
    end process;

end tb;