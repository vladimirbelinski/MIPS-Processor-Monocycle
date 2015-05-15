--Authors: Gabriel Galli and Vladimir Belinski
--Description: entity and architecture of the register bank.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.matrix.all;

entity register_bank is
    port(
       RegWrite: in std_logic;
       read_address1, read_address2, write_address: in unsigned(4 downto 0);
       write_data: in signed(31 downto 0);
       read_data1, read_data2: out signed(31 downto 0)
    );
end register_bank;

architecture behavior of register_bank is

    signal bank: word_array(0 to 31);

begin

    process (RegWrite, write_address, write_data) is
    begin
		bank(0) <= x"00000000";

        if RegWrite = '1' then
			if (write_address > "00000") then
				bank(to_integer(write_address)) <= write_data;
			end if;
        end if;
    end process;

    process (read_address1) is
    begin
        read_data1 <= bank(to_integer(read_address1));
    end process;

    process (read_address2) is
    begin
        read_data2 <= bank(to_integer(read_address2));
    end process;

end behavior;
