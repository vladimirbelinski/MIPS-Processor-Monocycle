--Authors: Gabriel Galli and Vladimir Belinski
--Description: entity and architecture of a MUX 2X1.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_2x1 is
	port (
		sel: in std_logic;
		A, B: in signed(31 downto 0);
		O: out signed(31 downto 0)
	);
end mux_2x1;

architecture atrib of mux_2x1 is
begin
	process (sel) is
    begin
        case sel is
            when '0'    => O <= A;
            when others => O <= B;
        end case;
    end process;
end atrib;
