library ieee;
use ieee.std_logic_1164.all;

entity tb_datapath is
end tb_datapath;

architecture tb of tb_datapath is

    component datapath
        port (data_in      : in std_logic_vector (15 downto 0);
              control_word : in std_logic_vector (11 downto 0);
              dest_sel     : in std_logic_vector(2 downto 0);
              sel_A        : in std_logic_vector(2 downto 0);
              sel_B        : in std_logic_vector(2 downto 0);
              pc           : in std_logic_vector(15 downto 0);
              Clk          : in std_logic;
              constant_in  : in std_logic_vector (2 downto 0);
              address_out  : out std_logic_vector (15 downto 0);
              data_out     : out std_logic_vector (15 downto 0);
              V            : out std_logic;
              C            : out std_logic;
              N            : out std_logic;
              Z            : out std_logic);
    end component;

    signal data_in      : std_logic_vector (15 downto 0);
    signal control_word : std_logic_vector (11 downto 0);
    signal dest_sel     : std_logic_vector (2 downto 0);
    signal sel_A        : std_logic_vector (2 downto 0);
    signal sel_B        : std_logic_vector (2 downto 0);
    signal pc           : std_logic_vector (15 downto 0);
    signal Clk          : std_logic;
    signal constant_in  : std_logic_vector (2 downto 0);
    signal address_out  : std_logic_vector (15 downto 0);
    signal data_out     : std_logic_vector (15 downto 0);
    signal V            : std_logic;
    signal C            : std_logic;
    signal N            : std_logic;
    signal Z            : std_logic;

    constant TbPeriod : time := 10 ns; -- EDIT Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : datapath
    port map (data_in      => data_in,
              control_word => control_word,
              dest_sel     => dest_sel,
              sel_A        => sel_A,
              sel_B        => sel_B,
              pc           => pc,
              Clk          => Clk,
              constant_in  => constant_in,
              address_out  => address_out,
              data_out     => data_out,
              V            => V,
              C            => C,
              N            => N,
              Z            => Z);

   
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';
    Clk <= TbClock;

    stimuli : process
    begin
        
        -- write ffff to reg0, outputted in both 
        --address_out and _data_out
        data_in <= x"ffff";
        dest_sel <= "000";
        sel_A <= "000";
        sel_B <= "000";
        pc <= x"0000";
        control_word <= "000000000110";
        constant_in <= "000";
        wait for 200 ns;
        -- write abcd into reg1, outputting in
        --data_out
        data_in <= x"abcd";
        dest_sel <= "001";
        sel_B <= "001";
        control_word <= "000000000110";        
        wait for 200 ns;
        -- write dead into reg2, outputting in
        --data_out
        data_in <= x"dead";
        dest_sel <= "010";
        sel_B <= "010";
        control_word <= "000000000110";
        wait for 200 ns;
        -- write beef into reg3, outputted in
        -- data_out
        data_in <= x"beef";
        dest_sel <= "011";
        sel_B <= "011";
        control_word <= "000000000110";
        wait for 200 ns;
        -- write 0000 into reg4, outputted in
        -- data_out
        data_in <= x"0000";
        dest_sel <= "100";
        sel_B <= "100";
        control_word <= "000000000110";
        wait for 200 ns;
        -- write 0123 into reg5, outputted in #
        -- data_out
        data_in <= x"0123";
        dest_sel <= "101";
        sel_B <= "101";
        control_word <= "000000000110";
        wait for 200 ns;
        -- write 4567 into reg6, outputted in
        -- data_out
        data_in <= x"4567";
        dest_sel <= "110";
        sel_B <= "110";
        control_word <= "000000000110";
        wait for 200 ns;
        -- write 89ab into reg7, outputted in 
        -- data_out
        data_in <= x"89ab";
        dest_sel <= "111";
        sel_B <= "111";
        control_word <= "000000000110";
        wait for 200 ns;
          
      -- test increment of A in the alu
       -- get value in reg6, pass it along
       -- bus A, into the alu where it's  
       -- incremented and then the result is storted in 
      -- reg0. The result is outputted in data_out
        dest_sel <= "000";
        sel_A <= "110";
        sel_B <= "000";
        control_word <= "000000001010";
        wait for 200 ns;
        
        -- test addition
        -- move ffff into reg0
        data_in <= x"ffff";
        dest_sel <= "000";
        control_word <= "000000000110";
        wait for 200 ns;
        -- move 0001 into reg1
        data_in <= x"0001";
        dest_sel <= "001";
        control_word <= "000000000110";
        wait for 200 ns; 
        -- extract values from reg0 and reg1,
        -- pass them into the alu, perform addition
        -- and store result in reg2. 
        -- carry and zero flags should be set
        sel_A <= "000";
        sel_B <= "001";
        dest_sel <= "010";
        control_word <= "000000010010";
        wait for 200 ns;
        -- put result (which should be 0000) to data_out
        sel_A <= "010";
        sel_B <= "010";
        control_word <= "000000000010";
        wait for 200 ns;
        
        -- test a + b + 1 in alu
        -- move 7ffe into reg3
         data_in <= x"7ffe";
         dest_sel <= "011";
         control_word <= "000000000110";
         wait for 200 ns;
         -- extract 7ffe from reg3 and 0001 from
         -- reg1. Pass both into the alu, performing
         -- the operation A+B+1. Store the result(which should 
         -- be 8000, in reg4. Overflow should be set
         sel_A <= "011";
         sel_B <= "001";
         dest_sel <= "100";
         control_word <= "000000011010";
         wait for 200 ns;
         -- put result to data_out
         sel_B <= "100";
         control_word <= "000010000010";
         wait for 200 ns;
        
        -- test a + not b, where a is 0004 and
        -- b is 0003
        -- write 0004 to reg4
        data_in <= x"0004";
        dest_sel <= "100";
        control_word <= "000000000110";
        wait for 200 ns;
        -- write 0003 to reg5
        data_in <= x"0003";
        dest_sel <= "101";
        control_word <= "000000000110";
        wait for 200 ns;
        -- pass both into alu, perform operation
        -- 0004 + (not)0003. Store result in reg6
        -- C should be set
        sel_A <= "100";
        sel_B <= "101";
        dest_sel <= "110";
        control_word <= "000000100010";
        wait for 200 ns;
        -- put result (should be 0000) to data_out
        sel_B <= "110";
        control_word <= "000010000010";
        wait for 200 ns;
        
        -- test subtraction
        -- perform -1 - (-6)
        -- write -1 into reg6
        data_in <= x"ffff";
        dest_sel <= "110";
        control_word <= "000000000110";
        wait for 200 ns;
        -- write -6 to reg7
        data_in <= x"fffa";
        dest_sel <= "111";
        control_word <= "000000000110";
        wait for 200 ns;
        -- substract val in reg7 from val in
        -- reg6. Store result in reg0
        -- C should be set
        sel_A <= "110";
        sel_B <= "111";
        dest_sel <= "000";
        control_word <= "000000101010";
        wait for 200 ns;
        -- put result( which should be 0005) to data_out;
        sel_B <= "000";
        control_word <= "000010000010";
        wait for 200 ns;
        
        -- test decrement A
        -- get val from reg7 (fffa),
        -- and decrement it in the alu
        -- store the result in reg0
        -- put result (which should be fff9) to data_out
        sel_A <= "111";
        sel_B <= "000";
        dest_sel <= "000";
        control_word <= "000000110010";
        wait for 200 ns;
        
--       test and operation
--       move abcd into reg2
        data_in <= x"abcd";
        dest_sel <= "010";
        control_word <= "000000000110";
        wait for 200 ns;
        -- move abcd into reg3
        dest_sel <= "011";
        control_word <= "000000000110";
        wait for 200 ns;
        -- perform and operation on values
        -- in reg2 and reg3
        -- store result in reg4
        sel_A <= "010";
        sel_B <= "011";
        dest_sel <= "100";
        control_word <= "000001000010";
        wait for 200 ns;
--        result should be abcd, as anything anded
--        with itself is itself. 
--        put result to data_out
        sel_B <= "100";
        control_word <= "000010000010";
        wait for 200 ns;
        
        -- test OR operation
--       move aaaa into reg2
        data_in <= x"aaaa";
        dest_sel <= "010";
        control_word <= "000000000110";
        wait for 200 ns;
        -- move 5555 into reg3
        data_in <= x"5555";
        dest_sel <= "011";
        control_word <= "000000000110";
        wait for 200 ns;
        -- perform orr operation on values
        -- in reg2 and reg3
        -- store result in reg4
        sel_A <= "010";
        sel_B <= "011";
        dest_sel <= "100";
        control_word <= "000001010010";
        wait for 200 ns;
--        result to data_out should be ffff
        sel_B <= "100";
        control_word <= "000010000010";
        wait for 200 ns;
        
        -- test XOR operation
        -- move 1234 into reg1
        data_in <= x"1234";
        dest_sel <= "001";
        control_word <= "000000000110";
        wait for 200 ns;
        -- move 1234 into reg2
        dest_sel <= "010";
        control_word <= "000000000110";
        wait for 200 ns;
        -- perform xor operation on vals
        -- in reg1 and reg2
        -- result (should be 0) to be stored in
        -- reg0
        sel_A <= "001";
        sel_B <= "010";
        dest_sel <= "000";
        control_word <= "000001100010";
        wait for 200 ns;
        -- put res to data_out
        sel_B <= "000";
        control_word <= "000010000010";
        wait for 200 ns;
        
        -- test NOT operation
        -- write 5555 to reg5
        data_in <= x"5555";
        dest_sel <= "101";
        control_word <= "000000000110";
        wait for 200 ns;
        -- perform not operation
        -- put res in reg7
        sel_A <= "101";
        dest_sel <= "111";
        control_word <= "000001110010";
        wait for 200 ns;
        -- put res (aaaa) to data_out
        sel_B <= "111";
        control_word <= "000010000010";
        wait for 200 ns;
        
        -- test shift right
        -- write 0002 to reg0
        data_in <= x"0002";
        dest_sel <= "000";
        control_word <= "000000000110";
        wait for 200 ns;
        -- shift 0002 right, should get 0001,
        -- put res in reg1
        sel_B <= "000";
        dest_sel <= "001";
        control_word <= "000010100010";
        wait for 200 ns;
        -- put res to data_out
        sel_B <= "001";
        control_word <= "000010000010";
        wait for 200 ns;
        
        -- test shift left
        -- shift 0002 left, should get 0004
        -- put res in reg1
        sel_B <= "000";
        dest_sel <= "001";
        control_word <= "000011000010";
        wait for 200 ns;
        -- put res to data_out
        sel_B <= "001";
        control_word <= "000010000010";
        wait for 200 ns;
        
        
        wait for 100000 * TbPeriod;

        
        TbSimEnded <= '1';
        wait;
    end process;

end tb;