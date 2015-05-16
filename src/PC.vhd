--Authors: Gabriel Galli and Vladimir Belinski
--Description: entity and architecture of a 32 bits register.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC is
    port(
        clock: in std_logic;
		D: in signed(31 downto 0);
		Q: out signed(31 downto 0)
    );
end PC;

architecture behavior of PC is
    signal aux: signed(31 downto 0);
begin
    process (clock) begin
        if rising_edge(clock) then
            aux <= D;
        end if;
    end process;
    Q <= aux;
end behavior;
