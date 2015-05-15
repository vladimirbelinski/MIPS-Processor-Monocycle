library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.matrix.all;

entity memory is
    port(
	   MemRead, MemWrite: in std_logic;
       address: in unsigned(31 downto 0);
       write_data: in signed(31 downto 0);
       read_data: out signed(31 downto 0)
    );
end memory;

architecture behavior of memory is

    signal bank: byte_array(0 to 255);

begin

	process (MemRead, MemWrite, address, write_data) is
	begin
		if MemRead = '1' then
            read_data <= bank(to_integer(address)) & bank(to_integer(address + 1)) & bank(to_integer(address + 2)) & bank(to_integer(address + 3));
		elsif MemWrite = '1' then
			bank(to_integer(address))     <= write_data(31 downto 24);
			bank(to_integer(address + 1)) <= write_data(23 downto 16);
			bank(to_integer(address + 2)) <= write_data(15 downto 8);
			bank(to_integer(address + 3)) <= write_data(7 downto 0);
		end if;
    end process;

end behavior;
