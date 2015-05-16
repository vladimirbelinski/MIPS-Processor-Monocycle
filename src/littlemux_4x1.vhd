-- Authors: Gabriel Galli and Vladimir Belinski
-- Description: entity and architecture of a MUX 4X1.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity littlemux_4x1 is
    port(
        sel1, sel2: in std_logic;
        I00, I01, I10, I11: in signed(4 downto 0);
        O: out signed(4 downto 0)
    );
end littlemux_4x1;

architecture behavior of littlemux_4x1 is
begin
    process (sel1, sel2) is
      variable sel: std_logic_vector(1 downto 0);
    begin
        sel := sel1 & sel2;
        case sel is
            when "00"   => O <= I00;
            when "01"   => O <= I01;
            when "10"   => O <= I10;
            when others => O <= I11;
        end case;
    end process;
end behavior;
