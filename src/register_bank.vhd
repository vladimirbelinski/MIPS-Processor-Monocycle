--Authors: Gabriel Galli and Vladimir Belinski
--Description: entity and architecture of the register bank.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.matrix.all;

entity register_bank is
    port(
       RegWrite: in std_logic;
       r1, r2, wr: in unsigned(4 downto 0);
       wd: in signed(31 downto 0);
       d1, d2: out signed(31 downto 0)
    );
end register_bank;

architecture behavior of register_bank is

    signal bank: reg_bank;

begin

    process (RegWrite) is
    begin
        if rising_edge(RegWrite) then
            bank(to_integer(wr)) <= wd;
        end if;
    end process;

    process (r1) is
    begin
        d1 <= bank(to_integer(r1));
    end process;

    process (r2) is
    begin
        d2 <= bank(to_integer(r2));
    end process;

end behavior;
