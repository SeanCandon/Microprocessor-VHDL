library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux2to1 is 
	port ( In0 : in std_logic;
		In1 : in std_logic;
		s : in std_logic;
		Z : out std_logic
		);
end mux2to1;

architecture Behavioral of mux2to1 is
begin 
Z <= In0 after 5 ns when S='0' else
		In1 after 5 ns when S='1' else
		'0' after 5 ns;
end Behavioral;
