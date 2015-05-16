-- Authors: Gabriel Galli and Vladimir Belinski
-- Description: entity and architecture of the register bank.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.matrix.all;

entity register_bank is
    port(
        RegWrite: in std_logic;
        read_register1, read_register2, write_register: in signed(4 downto 0);
        write_data: in signed(31 downto 0);
        read_data1, read_data2: out signed(31 downto 0)
    );
end register_bank;

architecture behavior of register_bank is

    signal bank: word_array(-16 to 15);

begin

    process (RegWrite, write_register, write_data) is
    begin
		bank(0) <= x"00000000";

        if RegWrite = '1' then
			if (write_register > "00000") then
				bank(to_integer(write_register)) <= write_data;
			end if;
        end if;
    end process;

    process (read_register1) is
    begin
        read_data1 <= bank(to_integer(read_register1));
    end process;

    process (read_register2) is
    begin
        read_data2 <= bank(to_integer(read_register2));
    end process;

end behavior;
