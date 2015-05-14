library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_memory is
    port(
	   MemRead, MemWrite: in std_logic;
       address: in UNSIGNED(4 downto 0);
       wr_data: in SIGNED(31 downto 0);
       r_data: out SIGNED(31 downto 0)
    );
end data_memory;

architecture behavior of data_memory is

    type rbank is array(0 to 255) of SIGNED(31 downto 0);
    signal bank: rbank;

begin

	process(MemRead, MemWrite) is
    begin
		if RISING_EDGE(MemRead) then
			r_data <= bank(TO_INTEGER(address));
		elsif RISING_EDGE(MemWrite) then
			bank(TO_INTEGER(address)) <= wr_data;
		end if;
    end process;

end behavior;
