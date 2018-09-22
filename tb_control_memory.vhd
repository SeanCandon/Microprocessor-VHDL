library ieee;
use ieee.std_logic_1164.all;

entity tb_control_memory is
end tb_control_memory;

architecture tb of tb_control_memory is

    component control_memory
        port (MW     : out std_logic;
              MM     : out std_logic;
              RW     : out std_logic;
              MD     : out std_logic;
              FS     : out std_logic_vector (4 downto 0);
              MB     : out std_logic;
              TB     : out std_logic;
              TA     : out std_logic;
              TD     : out std_logic;
              PL     : out std_logic;
              PI     : out std_logic;
              IL     : out std_logic;
              MC     : out std_logic;
              MS     : out std_logic_vector (2 downto 0);
              NA     : out std_logic_vector (7 downto 0);
              IN_CAR : in std_logic_vector (7 downto 0));
    end component;

    signal MW     : std_logic;
    signal MM     : std_logic;
    signal RW     : std_logic;
    signal MD     : std_logic;
    signal FS     : std_logic_vector (4 downto 0);
    signal MB     : std_logic;
    signal TB     : std_logic;
    signal TA     : std_logic;
    signal TD     : std_logic;
    signal PL     : std_logic;
    signal PI     : std_logic;
    signal IL     : std_logic;
    signal MC     : std_logic;
    signal MS     : std_logic_vector (2 downto 0);
    signal NA     : std_logic_vector (7 downto 0);
    signal IN_CAR : std_logic_vector (7 downto 0);

begin

    dut : control_memory
    port map (MW     => MW,
              MM     => MM,
              RW     => RW,
              MD     => MD,
              FS     => FS,
              MB     => MB,
              TB     => TB,
              TA     => TA,
              TD     => TD,
              PL     => PL,
              PI     => PI,
              IL     => IL,
              MC     => MC,
              MS     => MS,
              NA     => NA,
              IN_CAR => IN_CAR);

    stimuli : process
    begin
        
        IN_CAR <= x"00";
        wait for 100 ns;
        
        IN_CAR <= x"01";
        wait for 100 ns;
        
        IN_CAR <= x"02";
        wait for 100 ns;
                
        IN_CAR <= x"03";
        wait for 100 ns;
        
        IN_CAR <= x"04";
        wait for 100 ns;
        
        IN_CAR <= x"05";
        wait for 100 ns;
        
        IN_CAR <= x"06";
        wait for 100 ns;

        wait;
    end process;

end tb;