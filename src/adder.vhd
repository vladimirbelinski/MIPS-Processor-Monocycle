--Authors: Gabriel Galli and Vladimir Belinski
--Description: entity and architecture of an adder.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
	port(
	    Cin: in std_logic;
	    A, B: in signed(31 downto 0);
	    O: out signed(31 downto 0);
	    Cout: out std_logic
	);
end entity adder;

architecture add of adder is
begin
	process (A, B, Cin)
		variable ad: signed (31 downto 0);
		variable C: std_logic;
	begin

	C := Cin;

	for i in 0 to 31 loop
		ad(i) := (A(i) xor B(i) xor C);
		C :=(A(i) and B(i))or((A(i) xor B(i)) and C);
	end loop;
	Cout <= C;
	O <= ad;
	end process;
end add;
