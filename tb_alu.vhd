library ieee;
use ieee.std_logic_1164.all;

entity tb_alu is
end tb_alu;

architecture tb of tb_alu is

    component alu
        port (In0  : in std_logic;
              In1  : in std_logic;
              S0   : in std_logic;
              S1   : in std_logic;
              S2   : in std_logic;
              cIn  : in std_logic;
              Z    : out std_logic;
              cOut : out std_logic);
    end component;

    signal In0  : std_logic;
    signal In1  : std_logic;
    signal S0   : std_logic;
    signal S1   : std_logic;
    signal S2   : std_logic;
    signal cIn  : std_logic;
    signal Z    : std_logic;
    signal cOut : std_logic;

begin

    dut : alu
    port map (In0  => In0,
              In1  => In1,
              S0   => S0,
              S1   => S1,
              S2   => S2,
              cIn  => cIn,
              Z    => Z,
              cOut => cOut);

    stimuli : process
    begin
    
    -- Test Z = In0 for all values
        In0 <= '0';
        In1 <= '0';
        S0 <= '0';
        S1 <= '0';
        S2 <= '0';
        cIn <= '0';
        wait for 100 ns;
        In0 <= '1';
        wait for 100 ns;
        
    -- Test Z = In0 + 1  
        In0 <= '0';
        cIn <= '1';
        wait for 100 ns;
        In0 <= '1';
        wait for 100 ns;
        
    -- Test Z = In0 + In1    
        In0 <= '0';
        cIn <= '0';
        S0 <= '1';
        wait for 100 ns;
        In1 <= '1';
        wait for 100 ns;
        In0 <= '1';
        In1 <= '0';
        wait for 100 ns;
        In1 <= '1';
        wait for 100 ns;
        
        
    -- Test Z = In0 + In1 + 1    
        In0 <= '0';
        In1 <= '0';
        cIn <= '1';
        wait for 100 ns;
        In1 <= '1';
        wait for 100 ns;
        In0 <= '1';
        In1 <= '0';
        wait for 100 ns;
        In1 <= '1';
        wait for 100 ns;
    
    -- Test Z = In0 + (not In1)    
        S0 <= '0';
        cIn <= '0';
        S1 <= '1';
        In0 <= '0';
        In1 <= '0';
        wait for 100 ns;
        In1 <= '1';
        wait for 100 ns;
        In0 <= '1';
        In1 <= '0';
        wait for 100 ns;
        In1 <= '1';
        wait for 100 ns;
    
    -- Test Z = In0 + (not In1) + 1    
        cIn <= '1';
        In0 <= '0';
        In1 <= '0';
        wait for 100 ns;
        In1 <= '1';
        wait for 100 ns;
        In0 <= '1';
        In1 <= '0';
        wait for 100 ns;
        In1 <= '1';
        wait for 100 ns;
    
    -- Test Z = In0 - 1    
        cIn <= '0';
        S0 <= '1';
        In0 <= '0';
        In1 <= '0';
        wait for 100 ns;
        In1 <= '1';
        wait for 100 ns;
        In0 <= '1';
        In1 <= '0';
        wait for 100 ns;
        In1 <= '1';
        wait for 100 ns;
    
    -- Test Z = In0    
        cIn <= '1';
        In0 <= '0';
        In1 <= '0';
        wait for 100 ns;
        In1 <= '1';
        wait for 100 ns;
        In0 <= '1';
        In1 <= '0';
        wait for 100 ns;
        In1 <= '1';
        wait for 100 ns;
    
    -- Test Z = In0 and In1    
        S0 <= '0';
        S1 <= '0';
        S2 <= '1';
        In0 <= '0';
        In1 <= '0';
        wait for 100 ns;
        In1 <= '1';
        wait for 100 ns;
        In0 <= '1';
        In1 <= '0';
        wait for 100 ns;
        In1 <= '1';
        wait for 100 ns;
    
    -- Test Z = In0 or In1    
        S0 <= '1';
        In0 <= '0';
        In1 <= '0';
        wait for 100 ns;
        In1 <= '1';
        wait for 100 ns;
        In0 <= '1';
        In1 <= '0';
        wait for 100 ns;
        In1 <= '1';
        wait for 100 ns;
    
    -- Test Z = In0 xor In1    
        S0 <= '0';
        S1 <= '1';
        In0 <= '0';
        In1 <= '0';
        wait for 100 ns;
        In1 <= '1';
        wait for 100 ns;
        In0 <= '1';
        In1 <= '0';
        wait for 100 ns;
        In1 <= '1';
        wait for 100 ns;
    
    -- Test Z = not In0    
        S0 <= '1';
        In0 <= '0';
        In1 <= '0';
        wait for 100 ns;
        In1 <= '1';
        wait for 100 ns;
        In0 <= '1';
        In1 <= '0';
        wait for 100 ns;
        In1 <= '1';
        wait for 100 ns;
        

        wait;
    end process;

end tb;