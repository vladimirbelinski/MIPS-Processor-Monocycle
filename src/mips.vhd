library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mips is
end mips;

architecture behavior of mips is

	component adder is
		port(
		    A, B: in signed(31 downto 0);
		    A_plus_B: out signed(31 downto 0)
		);
	end component;

	component alu_control is
		port(
			ALUOp: in unsigned(1 downto 0);
			funct: in unsigned(5 downto 0);
			op: out unsigned(2 downto 0);
			JrMux: out std_logic
		);
	end component;

	

begin

end behavior;
