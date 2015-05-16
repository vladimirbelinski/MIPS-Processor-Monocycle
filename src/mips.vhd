--Authors: Gabriel Galli and Vladimir Belinski
--Description: entity and architecture of the general module/encapsulation.

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

	component concatenator is
		port(
			pc_31_28: in signed(3 downto 0);
			ins_25_0: in signed(25 downto 0);
	        j: out signed(31 downto 0)
	    );
	end component;

	component control is
		port(
			ins_31_26: in unsigned(5 downto 0);
			RegDst, ALUSrc, MemtoReg, RegWrite, MemWrite, MemRead, Branch, BrBNE, JMUX, JalMUX: out std_logic;
			ALUOp: out unsigned(1 downto 0)
		);
	end component;

	component memory is
		port(
		   MemRead, MemWrite: in std_logic;
	       address: in unsigned(31 downto 0);
	       write_data: in signed(31 downto 0);
	       read_data: out signed(31 downto 0)
	    );
	end component;

	component mux_2x1 is
		port (
			sel: in std_logic;
			A, B: in signed(31 downto 0);
			O: out signed(31 downto 0)
		);
	end component;

	component mux_4x1 is
		port(
	        sel: in unsigned(1 downto 0);
	        I00, I01, I10, I11: in signed(31 downto 0);
	        O: out signed(31 downto 0)
	    );
	end component;

	component PC is
		port(
			clock: in std_logic;
			D: in signed(31 downto 0);
			Q: out signed(31 downto 0)
	    );
	end component;

	component register_bank is
		port(
	        RegWrite: in std_logic;
	        read_address1, read_address2, write_address: in unsigned(4 downto 0);
	        write_data: in signed(31 downto 0);
	        read_data1, read_data2: out signed(31 downto 0)
	    );
	end component;

	component signal_extender is
		port(
					ins_15_0: in signed(15 downto 0);
					output: out signed(31 downto 0)
			);
	end component;

	component ULA is
		port(
	        ALU_control: in unsigned(2 downto 0);
	        A, B: in signed(31 downto 0);
	        Zero: out std_logic;
	        ALU_result: out signed(31 downto 0)
	    );
	end component;

begin

end behavior;
