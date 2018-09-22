library ieee;
use ieee.std_logic_1164.all;

entity tb_decoder_3to8 is
end tb_decoder_3to8;

architecture tb of tb_decoder_3to8 is

    component decoder_3to8
        port (A0 : in std_logic_vector (2 downto 0);
              Q0 : out std_logic;
              Q1 : out std_logic;
              Q2 : out std_logic;
              Q3 : out std_logic;
              Q4 : out std_logic;
              Q5 : out std_logic;
              Q6 : out std_logic;
              Q7 : out std_logic);
    end component;

    signal A0 : std_logic_vector (2 downto 0);
    signal Q0 : std_logic;
    signal Q1 : std_logic;
    signal Q2 : std_logic;
    signal Q3 : std_logic;
    signal Q4 : std_logic;
    signal Q5 : std_logic;
    signal Q6 : std_logic;
    signal Q7 : std_logic;

begin

    dut : decoder_3to8
    port map (A0 => A0,
              Q0 => Q0,
              Q1 => Q1,
              Q2 => Q2,
              Q3 => Q3,
              Q4 => Q4,
              Q5 => Q5,
              Q6 => Q6,
              Q7 => Q7);

    stimuli : process
    begin
       
        A0 <= "000"; 
        wait for 100 ns;
        A0 <= "001";
        wait for 100 ns;
        A0 <= "010";
        wait for 100 ns;
        A0 <= "011";
        wait for 100 ns;
        A0 <= "100";
        wait for 100 ns;
        A0 <= "101";
        wait for 100 ns;
        A0 <= "110";
        wait for 100 ns;
        A0 <= "111";
        wait for 100 ns;
        
        wait;
    end process;

end tb;

