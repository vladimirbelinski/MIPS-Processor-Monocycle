--Authors: Gabriel Galli and Vladimir Belinski
--Description: entity and architecture of a signal extender.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity signal_extender is
    port(
        ins: in signed(15 downto 0);
        output: out signed(31 downto 0)
    );
end signal_extender;

architecture behavior of signal_extender is
begin
    process(ins) is
    begin
        if ins(15) = '0' then
            output <= "0000000000000000" & ins;
        else
            output <= "1111111111111111" & ins;
        end if;
    end process;
    
end behavior;
