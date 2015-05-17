-- Authors: Gabriel Galli and Vladimir Belinski
-- Description: entity and architecture of the memories.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.matrix.all;

entity memory is
    port(
	    MemRead, MemWrite: in std_logic;
        address: in signed(31 downto 0);
        write_data: in signed(31 downto 0);
        read_data: out signed(31 downto 0)
    );
end memory;

architecture behavior of memory is

    signal bank: byte_array(0 to 255);

begin

	process (MemRead, MemWrite, address, write_data) is
        variable addr: integer;
	begin
        addr := to_integer(address);

        if MemWrite = '1' then
			bank(addr)     <= write_data(31 downto 24);
			bank(addr + 1) <= write_data(23 downto 16);
			bank(addr + 2) <= write_data(15 downto 8);
			bank(addr + 3) <= write_data(7 downto 0);
		elsif MemRead = '1' then
            read_data <= bank(addr) & bank(addr + 1) & bank(addr + 2) & bank(addr + 3);
		end if;
    end process;

end behavior;
