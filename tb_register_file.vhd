library ieee;
use ieee.std_logic_1164.all;

entity tb_register_file is
end tb_register_file;

architecture tb of tb_register_file is

    component register_file
        port (load_enable : in std_logic;
              Clk         : in std_logic;
              select_A    : in std_logic_vector (3 downto 0);
              select_B    : in std_logic_vector (3 downto 0);
              dest_select : in std_logic_vector (3 downto 0);
              data_in     : in std_logic_vector (15 downto 0);
              reg_A       : out std_logic_vector (15 downto 0);
              reg_B       : out std_logic_vector (15 downto 0));
    end component;

    signal load_enable : std_logic;
    signal Clk         : std_logic;
    signal select_A    : std_logic_vector (3 downto 0);
    signal select_B    : std_logic_vector (3 downto 0);
    signal dest_select : std_logic_vector (3 downto 0);
    signal data_in     : std_logic_vector (15 downto 0);
    signal reg_A       : std_logic_vector (15 downto 0);
    signal reg_B       : std_logic_vector (15 downto 0);

    constant TbPeriod : time := 10 ns;
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : register_file
    port map (load_enable => load_enable,
              Clk         => Clk,
              select_A    => select_A,
              select_B    => select_B,
              dest_select => dest_select,
              data_in     => data_in,
              reg_A       => reg_A,
              reg_B       => reg_B);

    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';
    Clk <= TbClock;

    stimuli : process
    begin
        load_enable <= '1';
        data_in <= x"0123";
        dest_select <= "0000";
        select_A <= "0000";
        select_B <= "0000";  
        wait for 100 ns;
        
        data_in <= x"4567";
        dest_select <= "0001";
        select_A <= "0001";
        wait for 100 ns;
        
        data_in <= x"89ab";
        dest_select <= "0010";
        select_A <= "0010";
        wait for 100 ns;
        
        data_in <= x"cdef";
        dest_select <= "0011";
        select_A <= "0011";
        wait for 100 ns;
        
        data_in <= x"dead";
        dest_select <= "0100";
        select_A <= "0100";
        wait for 100 ns;
        
        data_in <= x"beef";
        dest_select <= "0101";
        select_A <= "0101";
        wait for 100 ns;
        
        data_in <= x"0000";
        dest_select <= "0110";
        select_A <= "0110";
        wait for 100 ns;
        
        data_in <= x"ffff";
        dest_select <= "0111";
        select_A <= "0111";
        wait for 100 ns;
        
        --write to ninth reg
        data_in <=x"1111";
        dest_select <= "1000";
        select_A <= "1000";
        wait for 100 ns;
        
        -- check if reg0 isn't overwritten
        select_A <= "0000";
        wait for 100 ns;

        wait for 100 * TbPeriod;

        TbSimEnded <= '1';
        wait;
    end process;

end tb;
