--Authors: Gabriel Galli and Vladimir Belinski
--Description: package.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package matrix is
	type word_array is array (natural range <>) of signed(31 downto 0);
	type byte_array is array (natural range <>) of signed(7 downto 0);
end;
