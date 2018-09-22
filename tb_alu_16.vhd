library ieee;
use ieee.std_logic_1164.all;

entity tb_alu_16 is
end tb_alu_16;

architecture tb of tb_alu_16 is

    component alu_16
        port (A       : in std_logic_vector (15 downto 0);
              B       : in std_logic_vector (15 downto 0);
              fs4     : in std_logic_vector (3 downto 0);
              c_final : out std_logic;
              overflow : out std_logic;
              Q       : out std_logic_vector (15 downto 0));
    end component;

    signal A       : std_logic_vector (15 downto 0);
    signal B       : std_logic_vector (15 downto 0);
    signal fs4     : std_logic_vector (3 downto 0);
    signal c_final : std_logic;
    signal overflow : std_logic;
    signal Q       : std_logic_vector (15 downto 0);

begin

    dut : alu_16
    port map (A       => A,
              B       => B,
              fs4     => fs4,
              c_final => c_final,
              overflow => overflow,
              Q       => Q);

    stimuli : process
    begin
       
        A <= x"0000";
        B <= x"ffff";
        fs4 <= "0000";
        wait for 200 ns;
        A <= x"ffff";
        wait for 200 ns;
        
        fs4 <= "0001";
        wait for 200 ns;
        A <= x"0000";
        wait for 200 ns;
        
        -- Test Q = A + B
        fs4 <= "0010";
        -- Should get 7
        A <= x"0004";
        B <= x"0003";
        wait for 200 ns;
        -- Should get carry
        A <= x"ffff";
        B <= x"0005";
        wait for 200 ns;
        -- Should get overflow
        A <= x"7fff";
        B <= x"0001";
        wait for 200 ns;
        
        -- Test Q = A + B + 1
        fs4 <= "0011";
        -- Should get 0 and a carry
        A <= x"fffe";
        B <= x"0001";
        wait for 200 ns;
        -- Should get 8001 and overflow
        A <= x"7ffe";
        B <= x"0002";
        wait for 200 ns;
        
        -- Test Q = A + notB
        fs4 <= "0100";
        -- Should get 0
        A <= x"0004";
        B <= x"0003";
        wait for 200 ns; 
        -- Should get 7
        B <= x"fffc";
        wait for 200 ns;
        
        -- Test Q = A + notB + 1 (subtraction)
        fs4 <= "0101";
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
        
        -- Test Q = A - 1
        fs4 <= "0110";
        -- decrement 11, should get 10
        A <= x"000b";
        wait for 200 ns;
        -- decrement 0, should get -1
        A <= x"0000";
        wait for 200 ns;
        -- decrement -32767, should get 32767 
        A <= x"8000";
        wait for 200 ns;
        
        -- Test Q = A
        fs4 <= "0111";
        -- should get 0
        A <= x"0000";
        wait for 200 ns;
        -- should get -1
        A <= x"ffff";
        wait for 200 ns;
        
        -- Test Q = A and B
        fs4 <= "1000";
        -- A anded with itself, should get A
        B <= x"ffff";
        wait for 200 ns;
        A <= x"1234";
        B <= x"1234";
        wait for 200 ns;
        -- A anded with 0 should give 0
        B <= x"0000";
        wait for 200 ns;
        
        -- Test Q = A or B
        fs4 <= "1010";
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
        
        -- Test Q = A xor B
        fs4 <= "1100";
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
        
        -- Test Q = notA
        fs4 <= "1110";
        -- 0000 negated should give ffff
        A <= x"0000";
        wait for 200 ns;
        -- 5555 negates should give aaaa
        A <= x"5555";
        wait for 200 ns;
        

        wait;
    end process;

end tb;

