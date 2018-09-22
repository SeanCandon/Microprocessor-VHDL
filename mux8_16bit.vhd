library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux8_16bit is
	Port ( In0, In1, In2, In3, In4, In5, In6, In7 : 
			in std_logic_vector(15 downto 0);
		S0 : in std_logic_vector(2 downto 0);
		Z : out std_logic_vector(15 downto 0));
end mux8_16bit;

architecture Behavioral of mux8_16bit is
begin
    
    Z <= In0 when (S0="000") else
         In1 when (S0="001") else
         In2 when (S0="010") else
         In3 when (S0="011") else
         In4 when (S0="100") else
         In5 when (S0="101") else
         In6 when (S0="110") else
         In7 when (S0="111") else
         "0000000000000000" after 5 ns;
    
    
end Behavioral;