library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity concatenator is
    port(
		pc_31_28, ins_25_0: in signed(31 downto 0);
        j: out signed(31 downto 0)
    );
end concatenator;

architecture behavior of concatenator is
begin

	process(pc_31_28, ins_25_0) is
    begin
		j <= pc_31_28(31 downto 28) & ins_25_0(25 downto 0) & "00";
    end process;

end behavior;
