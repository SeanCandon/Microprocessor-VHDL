library ieee;
use ieee.std_logic_1164.all;

entity tb_microprocessor is
end tb_microprocessor;

architecture tb of tb_microprocessor is

    component microprocessor
        port (Clk      : in std_logic;
              reset    : in std_logic;
              pc       : out std_logic_vector (15 downto 0);
              data_out : out std_logic_vector (15 downto 0);
              mc       : out std_logic;
              il       : out std_logic;
              opcode   : out std_logic_vector (7 downto 0);
              na       : out std_logic_vector (7 downto 0);
              car      : out std_logic_vector (7 downto 0);
              reg_0 : out std_logic_vector(15 downto 0);
              reg_1 : out std_logic_vector(15 downto 0);
              reg_2 : out std_logic_vector(15 downto 0);
              reg_3 : out std_logic_vector(15 downto 0);
              reg_4 : out std_logic_vector(15 downto 0);
              reg_5 : out std_logic_vector(15 downto 0);
              reg_6 : out std_logic_vector(15 downto 0);
              reg_7 : out std_logic_vector(15 downto 0);
              control_out : out std_logic_vector (11 downto 0));
    end component;

    signal Clk      : std_logic;
    signal reset    : std_logic;
    signal pc       : std_logic_vector (15 downto 0);
    signal data_out : std_logic_vector (15 downto 0);
    signal mc       : std_logic;
    signal il       : std_logic;
    signal opcode   : std_logic_vector (7 downto 0);
    signal na       : std_logic_vector (7 downto 0);
    signal car      : std_logic_vector (7 downto 0);
    signal reg_0    : std_logic_vector (15 downto 0);
    signal reg_1    : std_logic_vector (15 downto 0);
    signal reg_2    : std_logic_vector (15 downto 0);
    signal reg_3    : std_logic_vector (15 downto 0);
    signal reg_4    : std_logic_vector (15 downto 0);
    signal reg_5    : std_logic_vector (15 downto 0);
    signal reg_6    : std_logic_vector (15 downto 0);
    signal reg_7    : std_logic_vector (15 downto 0);
    signal control_out : std_logic_vector (11 downto 0);

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : microprocessor
    port map (Clk      => Clk,
              reset    => reset,
              pc       => pc,
              data_out => data_out,
              mc       => mc,
              il       => il,
              opcode   => opcode,
              na       => na,
              car      => car,
              reg_0    => reg_0,
              reg_1    => reg_1,
              reg_2    => reg_2,
              reg_3    => reg_3,
              reg_4    => reg_4,
              reg_5    => reg_5,
              reg_6    => reg_6,
              reg_7    => reg_7,
              control_out => control_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that Clk is really your main clock signal
    Clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed

        reset <= '1';
        wait for 100 ns;
        reset <= '0';
      
        wait for 5000 ns;

        TbSimEnded <= '1';
        wait;
    end process;

end tb;