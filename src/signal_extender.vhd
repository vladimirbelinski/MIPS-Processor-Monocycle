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
    output <= shift_right(ins_15_0, 16) & ins_15_0;
end behavior;
