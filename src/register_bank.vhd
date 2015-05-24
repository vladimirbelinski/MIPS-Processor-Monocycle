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

    signal bank: word_array(0 to 31) := (others => x"00000000");

begin

    process (clock, read_register1, read_register2, write_register, write_data) is
        variable wr, rr1, rr2: integer;
    begin
        if falling_edge(clock) then
            wr := to_integer('0' & write_register);
            if RegWrite = '1' and wr > 0 then
                bank(wr) <= write_data;
            end if;
        end if;

        rr1 := to_integer('0' & read_register1);
        read_data1 <= bank(rr1);

        rr2 := to_integer('0' & read_register2);
        read_data2 <= bank(rr2);
    end process;

    -- process (read_register1) is
    --     variable rr1: integer;
    -- begin
    --     rr1 := to_integer('0' & read_register1);
    --     read_data1 <= bank(rr1);
    -- end process;
    --
    -- process (read_register2) is
    --     variable rr2: integer;
    -- begin
    --     rr2 := to_integer('0' & read_register2);
    --     read_data2 <= bank(rr2);
    -- end process;

end behavior;
