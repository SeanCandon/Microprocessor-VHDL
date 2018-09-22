library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity decoder_3to8 is
	Port (A0 : in std_logic_vector(2 downto 0);
		Q0 : out std_logic;
		Q1 : out std_logic;
		Q2 : out std_logic;
		Q3 : out std_logic;
		Q4 : out std_logic;
		Q5 : out std_logic;
		Q6 : out std_logic;
		Q7 : out std_logic);
end decoder_3to8;

architecture Behavioral of decoder_3to8 is

begin 

Q0 <= '1' when (A0="000") else '0';
Q1 <= '1' when (A0="001") else '0';
Q2 <= '1' when (A0="010") else '0';
Q3 <= '1' when (A0="011") else '0';
Q4 <= '1' when (A0="100") else '0';
Q5 <= '1' when (A0="101") else '0';
Q6 <= '1' when (A0="110") else '0';
Q7 <= '1' when (A0="111") else '0';


end Behavioral;