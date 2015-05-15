library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- tem problema tratar a instrução em si como signed de 32 bits
-- e os pedaços dela (tipo RS, RT, OP, FUNCT...) como unsigned?
package matrix is
	type reg_bank is array(0 to 31) of signed(31 downto 0);
	type byte_memory is array(0 to 255) of signed(7 downto 0);
end;

-- package body matrix is
-- end package body;
