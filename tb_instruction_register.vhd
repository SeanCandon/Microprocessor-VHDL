library ieee;
use ieee.std_logic_1164.all;

entity tb_instruction_register is
end tb_instruction_register;

architecture tb of tb_instruction_register is

    component instruction_register
        port (In0    : in std_logic_vector (15 downto 0);
              IL     : in std_logic;
              Clk    : in std_logic;
              DR     : out std_logic_vector (2 downto 0);
              SA     : out std_logic_vector (2 downto 0);
              SB     : out std_logic_vector (2 downto 0);
              opcode : out std_logic_vector (6 downto 0));
    end component;

    signal In0    : std_logic_vector (15 downto 0);
    signal IL     : std_logic;
    signal Clk    : std_logic;
    signal DR     : std_logic_vector (2 downto 0);
    signal SA     : std_logic_vector (2 downto 0);
    signal SB     : std_logic_vector (2 downto 0);
    signal opcode : std_logic_vector (6 downto 0);

    constant TbPeriod : time := 100 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : instruction_register
    port map (In0    => In0,
              IL     => IL,
              Clk    => Clk,
              DR     => DR,
              SA     => SA,
              SB     => SB,
              opcode => opcode);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- EDIT: Check that Clk is really your main clock signal
    Clk <= TbClock;

    stimuli : process
    begin

        In0 <= x"ffff";
        IL <= '0';
        wait for 100 ns;
        
        IL <= '1';
        wait for 100 ns;
        
        In0 <= x"0000";
        wait for 100 ns;
        
        IL <= '0';
        In0 <= x"ffff";
        wait for 100 ns;
        
        IL <= '1';
        wait for 100 ns;


        --wait for 100 * TbPeriod;

   
        TbSimEnded <= '1';
        wait;
    end process;

end tb;