-- Authors: Gabriel Galli and Vladimir Belinski
-- Description: entity and architecture of the register bank.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.matrix.all;

entity register_bank is
    port(
        clock, RegWrite: in std_logic;
        read_register1, read_register2, write_register: in signed(4 downto 0);
        write_data: in signed(31 downto 0);
        read_data1, read_data2: out signed(31 downto 0)
    );
end register_bank;

architecture behavior of register_bank is

    signal bank: word_array(0 to 31);

begin

    process (clock) is
        variable wr: integer;
    begin
        bank(0) <= x"00000000";

        if falling_edge(clock) then
            wr := to_integer('0' & write_register);
            if RegWrite = '1' and wr > 0 then
                bank(wr) <= write_data;
            end if;
        end if;
    end process;

    process (read_register1) is
        variable rr1: integer;
    begin
        rr1 := to_integer('0' & read_register1);
        if (rr1 >= 0) then
            read_data1 <= bank(rr1);
        end if;
    end process;

    process (read_register2) is
        variable rr2: integer;
    begin
        rr2 := to_integer('0' & read_register2);
        if (rr2 >= 0) then
            read_data2 <= bank(rr2);
        end if;
    end process;

end behavior;
