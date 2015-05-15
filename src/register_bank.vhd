--Authors: Gabriel Galli and Vladimir Belinski
--Description: entity and architecture of the register bank.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.matrix.all;

entity register_bank is
    port(
       RegWrite: in std_logic;
       read1, read2, write_address: in unsigned(4 downto 0);
       write_data: in signed(31 downto 0);
       data1, data2: out signed(31 downto 0)
    );
end register_bank;

architecture behavior of register_bank is

    signal bank: reg_bank;

begin

	bank(0) <= x"00000000";

    process (RegWrite) is
    begin
        if rising_edge(RegWrite) then
			if (write_address > "00000") then
				bank(to_integer(write_address)) <= write_data;
			end if;
        end if;
    end process;

    process (read1) is
    begin
        data1 <= bank(to_integer(read1));
    end process;

    process (read2) is
    begin
        data2 <= bank(to_integer(read2));
    end process;

end behavior;
