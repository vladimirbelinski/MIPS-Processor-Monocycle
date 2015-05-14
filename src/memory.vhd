library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.matrix.all;

entity data_memory is
    port(
	   MemRead, MemWrite: in std_logic;
       address: in unsigned(31 downto 0);
       wr_data: in signed(31 downto 0);
       r_data: out signed(31 downto 0)
    );
end data_memory;

architecture behavior of data_memory is

    signal bank: memory;

begin

	process(MemRead, MemWrite) is
    begin
		if rising_edge(MemRead) then
            r_data <= bank(to_integer(address));
		elsif rising_edge(MemWrite) then
			bank(to_integer(address)) <= wr_data;
		end if;
    end process;

end behavior;
