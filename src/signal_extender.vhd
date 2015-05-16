-- Authors: Gabriel Galli and Vladimir Belinski
-- Description: entity and architecture of a signal extender.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity signal_extender is
    port(
        ins_15_0: in signed(15 downto 0);
        output: out signed(31 downto 0)
    );
end signal_extender;

architecture behavior of signal_extender is
begin
    process (ins_15_0) is
    begin
        if ins_15_0(15) = '0' then
            output <= "0000000000000000" & ins_15_0;
        else
            output <= "1111111111111111" & ins_15_0;
        end if;
    end process;
end behavior;
