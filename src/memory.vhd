library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.matrix.all;

entity memory is
    port(
	   MemRead, MemWrite: in std_logic;
       address: in unsigned(31 downto 0);
       wr_data: in signed(31 downto 0);
       r_data: out signed(31 downto 0)
    );
end memory;

architecture behavior of memory is

    signal bank: byte_memory;

begin

	process (MemRead, MemWrite) is
    begin
		if rising_edge(MemRead) then
            r_data <= bank(to_integer(address)) & bank(to_integer(address + 1)) & bank(to_integer(address + 2)) & bank(to_integer(address + 3));
		elsif rising_edge(MemWrite) then
			bank(to_integer(address)) <= wr_data(31 downto 24);
			bank(to_integer(address + 1)) <= wr_data(23 downto 16);
			bank(to_integer(address + 2)) <= wr_data(15 downto 8);
			bank(to_integer(address + 3)) <= wr_data(7 downto 0);
		end if;
    end process;

end behavior;
