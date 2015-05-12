--Authors: Gabriel Galli and Vladimir Belinski
--Description: entity and architecture of a MUX 2X1.

library ieee;
use ieee.std_logic_1164.all;

entity mux_2x1 is
	port (
		sel: in std_logic;
		A, B: in std_logic_vector(31 downto 0);
      O: out std_logic_vector(31 downto 0)
	);
end mux_2x1;

architecture atrib of mux_2x1 is begin
	O <= (A and (not sel)) or (B and sel);
end atrib;
