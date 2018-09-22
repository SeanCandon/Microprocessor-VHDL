library ieee;
use ieee.std_logic_1164.all;

entity tb_functional_unit is
end tb_functional_unit;

architecture tb of tb_functional_unit is

    component functional_unit
        port (A : in std_logic_vector (15 downto 0);
              B : in std_logic_vector (15 downto 0);
              fs    : in std_logic_vector (4 downto 0);
              C     : out std_logic;
              V     : out std_logic;
              N     : out std_logic;
              Z     : out std_logic;
              F     : out std_logic_vector (15 downto 0));
    end component;

    signal A : std_logic_vector (15 downto 0);
    signal B : std_logic_vector (15 downto 0);
    signal fs    : std_logic_vector (4 downto 0);
    signal C     : std_logic;
    signal V     : std_logic;
    signal N     : std_logic;
    signal Z     : std_logic;
    signal F     : std_logic_vector (15 downto 0);

begin

    dut : functional_unit
    port map (A => A,
              B => B,
              fs    => fs,
              C     => C,
              V     => V,
              N     => N,
              Z     => Z,
              F     => F);

    stimuli : process
    begin
       
        A <= x"0000";
        B <= x"ffff";
        fs <= "00000";
        wait for 100 ns;
        A <= x"abcd";
        wait for 100 ns;
        
        -- Test F = A + 1
        -- abcd + 1 should give abce
        fs <= "00001";
        wait for 200 ns;
        -- 0 +1 should give 1
        A <= x"0000";
        wait for 200 ns;
        
        -- Test F = A + B
        fs <= "00010";
        -- Should get 7
        A <= x"0004";
        B <= x"0003";
        wait for 200 ns;
        -- Should get carry and 4
        A <= x"ffff";
        B <= x"0005";
        wait for 200 ns;
        -- Should get overflow
        A <= x"7fff";
        B <= x"0001";
        wait for 200 ns;
        
        -- Test F = A + B + 1
        fs <= "00011";
        -- Should get 0 and a carry
        A <= x"fffe";
        B <= x"0001";
        wait for 200 ns;
        -- Should get 8001 and overflow
        A <= x"7ffe";
        B <= x"0002";
        wait for 200 ns;
        
        -- Test F = A + notB
        fs <= "00100";
        -- Should get 0
        A <= x"0004";
        B <= x"0003";
        wait for 200 ns; 
        -- Should get 7
        B <= x"fffc";
        wait for 200 ns;
        
        -- Test F = A + notB + 1 (subtraction)
        fs <= "00101";
        -- subtract 3 from 4, should get 1
        B <= x"0003";
        wait for 200 ns;
        -- substract 6 from -1, should get -7
        A <= x"ffff";
        B <= x"0006";
        wait for 200 ns;
        -- subtract -6 from -1, should get 5
        B <= x"fffa";
        wait for 200 ns;
        
        -- Test F = A - 1
        fs <= "00110";
        -- decrement 11, should get 10
        A <= x"000b";
        wait for 200 ns;
        -- decrement 0, should get -1
        A <= x"0000";
        wait for 200 ns;
        -- decrement -32767, should get 32767 
        A <= x"8000";
        wait for 200 ns;
        
        -- Test F = A
        fs <= "00111";
        -- should get 0
        A <= x"0000";
        wait for 200 ns;
        -- should get -1
        A <= x"ffff";
        wait for 200 ns;
        
        -- Test F = A and B
        fs <= "01000";
        -- A anded with itself, should get A
        B <= x"ffff";
        wait for 200 ns;
        A <= x"1234";
        B <= x"1234";
        wait for 200 ns;
        -- A anded with 0 should give 0
        B <= x"0000";
        wait for 200 ns;
        
        -- Test F = A or B
        fs <= "01010";
        -- A orred with 0 should give A
        A <= x"0001";
        B <= x"0000";
        wait for 200 ns;
        A <= x"ffff";
        wait for 200 ns;
        -- aaaa and 5555 are opposites (e.g bit 14 in aaaa is 1, but in 
        -- 5555 it's 0. The two of them orred should give ffff 
        A <= x"aaaa";
        B <= x"5555";
        wait for 200 ns;
        
        -- Test F = A xor B
        fs <= "01100";
        -- A xorred with itself should give 0
        A <= x"1234";
        B <= x"1234";
        wait for 200 ns;
        -- A xorred with 0 should give A
        B <= x"0000";
        wait for 200 ns;
        -- should give ffff
        A <= x"aaaa";
        B <= x"5555";
        wait for 200 ns;
        
        -- Test F = notA
        fs <= "01110";
        -- 0000 negated should give ffff
        A <= x"0000";
        wait for 200 ns;
        -- 5555 negates should give aaaa
        A <= x"5555";
        wait for 200 ns;
        
        -- Test shift transfer
        fs <= "10000";
        -- should get F = abcd
        B <= x"abcd";
        wait for 200 ns;
        
        -- Test shift right
        fs <= "10100";
        -- should get F = 0001
        B <= x"0002";
        wait for 200 ns;
        
        -- Test shift left
        fs <= "11000";
        -- should get F = 0004
        wait for 200 ns;


        wait;
    end process;

end tb;