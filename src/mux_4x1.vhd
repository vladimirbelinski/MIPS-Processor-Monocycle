-- Authors: Gabriel Galli and Vladimir Belinski
-- Description: entity and architecture of a MUX 4X1.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_4x1 is
    port(
        sel: in unsigned(1 downto 0);
        I00, I01, I10, I11: in signed(31 downto 0);
        O: out signed(31 downto 0)
    );
end mux_4x1;

architecture behavior of mux_4x1 is
begin
    process (sel) is
    begin
        case sel is
            when "00"   => O <= I00;
            when "01"   => O <= I01;
            when "10"   => O <= I10;
            when others => O <= I11;
        end case;
    end process;
end behavior;
