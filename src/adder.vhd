-- Authors: Gabriel Galli and Vladimir Belinski
-- Description: entity and architecture of an adder.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
	port(
		A, B: in signed(31 downto 0);
		A_plus_B: out signed(31 downto 0)
	);
end entity adder;

architecture add of adder is
begin
	A_plus_B <= A + B;
end add;
