library ieee;
use ieee.std_logic_1164.all;

entity tb_control is
end tb_control;

architecture tb of tb_control is

    component control
        port (nextAddr : in std_logic_vector (15 downto 0);
              Clk      : in std_logic;
              reset    : in std_logic;
              Z        : in std_logic;
              C        : in std_logic;
              N        : in std_logic;
              V        : in std_logic;
              DR       : out std_logic_vector (2 downto 0);
              SA       : out std_logic_vector (2 downto 0);
              SB       : out std_logic_vector (2 downto 0);
              FS       : out std_logic_vector (4 downto 0);
              TD       : out std_logic;
              TA       : out std_logic;
              TB       : out std_logic;
              MB       : out std_logic;
              MD       : out std_logic;
              RW       : out std_logic;
              MM       : out std_logic;
              MW       : out std_logic;
              mc_out   : out std_logic;
              il_out   : out std_logic;
              na_out   : out std_logic_vector(7 downto 0);
              opcode_out : out std_logic_vector(7 downto 0);
              car_output : out std_logic_vector(7 downto 0);
              pc_out   : out std_logic_vector (15 downto 0));
    end component;

    signal nextAddr : std_logic_vector (15 downto 0);
    signal Clk      : std_logic;
    signal reset    : std_logic;
    signal Z        : std_logic;
    signal C        : std_logic;
    signal N        : std_logic;
    signal V        : std_logic;
    signal DR       : std_logic_vector (2 downto 0);
    signal SA       : std_logic_vector (2 downto 0);
    signal SB       : std_logic_vector (2 downto 0);
    signal FS       : std_logic_vector (4 downto 0);
    signal TD       : std_logic;
    signal TA       : std_logic;
    signal TB       : std_logic;
    signal MB       : std_logic;
    signal MD       : std_logic;
    signal RW       : std_logic;
    signal MM       : std_logic;
    signal MW       : std_logic;
    signal mc_out   : std_logic;
    signal il_out   : std_logic;
    signal na_out   : std_logic_vector(7 downto 0);
    signal opcode_out : std_logic_vector(7 downto 0);
    signal car_output : std_logic_vector(7 downto 0);
    signal pc_out   : std_logic_vector (15 downto 0);

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : control
    port map (nextAddr => nextAddr,
              Clk      => Clk,
              reset    => reset,
              Z        => Z,
              C        => C,
              N        => N,
              V        => V,
              DR       => DR,
              SA       => SA,
              SB       => SB,
              FS       => FS,
              TD       => TD,
              TA       => TA,
              TB       => TB,
              MB       => MB,
              MD       => MD,
              RW       => RW,
              MM       => MM,
              MW       => MW,
              mc_out   => mc_out,
              il_out   => il_out,
              na_out   => na_out,
              opcode_out => opcode_out,
              car_output => car_output,
              pc_out   => pc_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that Clk is really your main clock signal
    Clk <= TbClock;

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        --nextAddr <= (others => '0');
        Z <= '0';
        C <= '0';
        N <= '0';
        V <= '0';
        --nextAddr <= x"ffff";
     
        reset <= '1';
        wait for 100 ns;
        
        nextAddr <= "0000001000001011";
        reset <= '0';
        wait for 400 ns;
--        reset <= '1';
--        wait for 100 ns;
        --wait for 100 ns;

        TbSimEnded <= '1';
        wait;
    end process;

end tb;