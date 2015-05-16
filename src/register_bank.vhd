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

    signal bank: word_array(0 to 31);

begin

    process (RegWrite, write_register, write_data) is
      variable wr: integer;
    begin
		  bank(0) <= x"00000000";

      wr := to_integer(write_register);
      if (wr < 0) then
        wr := wr + 32;
      end if;

      if RegWrite = '1' then
    			if (wr > 0) then
    				bank(wr) <= write_data;
    			end if;
      end if;
    end process;

    process (read_register1) is
        variable r1: integer;
    begin
        r1 := to_integer(read_register1);
        if (r1 < 0) then
          r1 := r1 + 32;
        end if;
        read_data1 <= bank(r1);
    end process;

    process (read_register2) is
        variable r2: integer;
    begin
        r2 := to_integer(read_register2);
        if (r2 < 0) then
          r2 := r2 + 32;
        end if;
        read_data2 <= bank(r2);
    end process;

end behavior;
