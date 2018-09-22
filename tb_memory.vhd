library ieee;
use ieee.std_logic_1164.all;

entity tb_memory is
end tb_memory;

architecture tb of tb_memory is

    component memory
        port (address    : in std_logic_vector (15 downto 0);
              write_data : in std_logic_vector (15 downto 0);
              MemWrite   : in std_logic;
              read_data  : out std_logic_vector (15 downto 0));
    end component;

    signal address    : std_logic_vector (15 downto 0);
    signal write_data : std_logic_vector (15 downto 0);
    signal MemWrite   : std_logic;
    signal read_data  : std_logic_vector (15 downto 0);

begin

    dut : memory
    port map (address    => address,
              write_data => write_data,
              MemWrite   => MemWrite,
              read_data  => read_data);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        
        address <= x"0000";
        write_data <= x"ffff";
        MemWrite <= '0';
        wait for 100 ns;
        
        address <= x"0001";
        write_data <= x"ffff";
        MemWrite <= '1';
        wait for 100 ns;
        
        MemWrite <= '1';
        address <= x"0000";
        write_data <= x"abcd";
        wait for 100 ns;
        
        MemWrite <= '0';
        address <= x"0001";
        wait for 100 ns;

        wait;
    end process;

end tb;