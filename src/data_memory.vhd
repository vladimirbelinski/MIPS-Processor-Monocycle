library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity data_memory is
    port(
	   MemRead, MemWrite: in std_logic;
       address: in std_logic_vector(4 downto 0);
       wr_data: in std_logic_vector(31 downto 0);
       r_data: out std_logic_vector(31 downto 0)
    );
end data_memory;

architecture behavior of data_memory is
    
    type rbank is array(0 to 255) of std_logic_vector(31 downto 0);
    signal bank: rbank;
    
begin

	process(MemRead, MemWrite) is
    begin
		if rising_edge(MemRead) then
			r_data <= bank(conv_integer(address));
		elsif rising_edge(MemWrite) then
			bank(conv_integer(address)) <= wr_data;
		end if;
    end process;
    
end behavior;
