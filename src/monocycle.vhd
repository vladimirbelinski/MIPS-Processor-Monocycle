-- Authors: Gabriel Galli and Vladimir Belinski
-- Description: entity and architecture of the general module/encapsulation.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity monocycle is
	port(
		Is_the_first, clock, Read_IM, Write_IM, Is_Out, MemWrite_Out, MemRead_Out: in std_logic;
		Initial_address, Instruction, Address_Out, Data_Out: in signed(31 downto 0)
	);
end monocycle;

architecture behavior of monocycle is

	component adder is
		port(
		    A, B: in signed(31 downto 0);
		    A_plus_B: out signed(31 downto 0)
		);
	end component;

	component alu_control is
		port(
			ALUOp: in signed(1 downto 0);
			funct: in signed(5 downto 0);
			op: out signed(2 downto 0);
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
			ins_31_26: in signed(5 downto 0);
			RegDst, ALUSrc, MemtoReg, RegWrite, MemWrite, MemRead, Branch, BrBNE, JMUX, JalMUX: out std_logic;
			ALUOp: out signed(1 downto 0)
		);
	end component;

	component littlemux_4x1 is
	    port(
	        sel1, sel2: in std_logic;
	        I00, I01, I10, I11: in signed(4 downto 0);
	        O: out signed(4 downto 0)
	    );
	end component;

	component memory is
		port(
		   MemRead, MemWrite: in std_logic;
	       address: in signed(31 downto 0);
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
	        sel1, sel2: in std_logic;
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
			read_register1, read_register2, write_register: in signed(4 downto 0);
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
	        ALU_control: in signed(2 downto 0);
	        A, B: in signed(31 downto 0);
	        Zero: out std_logic;
	        ALU_result: out signed(31 downto 0)
	    );
	end component;

		signal PC_Out, MUX_PC_Out, Adder_PC_4_Out, Adder_Branch_Out, mux_4x1_PC_In_Out, IM_Out, Cat_Out, mux_4x1_DM_Out, SE_Out, mux_2x1_Branch_Out, mux_2x1_ALU_Out, ALU_Out, mux_2x1_DMA_Out, mux_2x1_DMWD_Out, DM_Out, read_data1_Out, read_data2_Out, SE_OutShifted: signed(31 downto 0);
		signal RegDst_I, ALUSrc_I, MemtoReg_I, RegWrite_I, MemWrite_I, MemRead_I, Branch_I, BrBNE_I, JMUX_I, JalMUX_I, JrMux_I, Zero_Out, MemReadOr, MemWriteOr, BranchSel: std_logic;
		signal ALUOp_I: signed (1 downto 0);
		signal ALUC_Out: signed (2 downto 0);
		signal mux_4x1_R_Out: signed (4 downto 0);

begin

	MemReadOr <= MemRead_I or MemRead_Out;
	MemWriteOr <= MemWrite_I or MemWrite_Out;
	BranchSel <= ((not Zero_Out) and (BrBNE_I)) or (Branch_I and Zero_Out);
	SE_OutShifted <= shift_left(SE_Out, 2);

	MUX_PC: mux_2x1 port map (Is_the_first, mux_4x1_PC_In_Out, Initial_address, MUX_PC_Out);
	PC_I: PC port map (clock, MUX_PC_Out, PC_Out);
	Adder_PC_4: adder port map (PC_Out, x"00000004", Adder_PC_4_Out);
	IM: memory port map (Read_IM, Write_IM, PC_Out, Instruction, IM_Out);
	Cat: concatenator port map (PC_Out(31 downto 28), IM_Out(25 downto 0), Cat_Out);
	Ctrl: control port map (IM_Out(31 downto 26), RegDst_I, ALUSrc_I, MemtoReg_I, RegWrite_I, MemWrite_I, MemRead_I, Branch_I, BrBNE_I, JMUX_I, JalMUX_I, ALUOp_I);
	mux_4x1_R: littlemux_4x1 port map (JalMUX_I, RegDst_I, IM_Out(20 downto 16), IM_Out(15 downto 11), "11111", "00000", mux_4x1_R_Out);
	RB: register_bank port map (RegWrite_I, IM_Out(25 downto 21), IM_Out(20 downto 16), mux_4x1_R_Out, mux_4x1_DM_Out, read_data1_Out, read_data2_Out);
	SE: signal_extender port map (IM_Out(15 downto 0), SE_Out);
	mux_4x1_PC_In: mux_4x1 port map (JMUX_I, JrMux_I, mux_2x1_Branch_Out, read_data1_Out, Cat_Out, Cat_Out, mux_4x1_PC_In_Out);
	mux_2x1_ALU: mux_2x1 port map (ALUSrc_I, read_data2_Out, SE_Out, mux_2x1_ALU_Out);
	ALU: ULA port map (ALUC_Out, read_data1_Out, mux_2x1_ALU_Out, Zero_Out, ALU_Out);
	ALUC: alu_control port map (ALUOp_I, IM_Out(5 downto 0), ALUC_Out, JrMux_I);
	Adder_Branch: adder port map (Adder_PC_4_Out, SE_OutShifted, Adder_Branch_Out);
	mux_2x1_Branch: mux_2x1 port map (BranchSel, Adder_PC_4_Out, Adder_Branch_Out, mux_2x1_Branch_Out);
	mux_2x1_DMA: mux_2x1 port map (Is_Out, ALU_Out, Address_Out, mux_2x1_DMA_Out);
	mux_2x1_DMWD: mux_2x1 port map (Is_Out, read_data2_Out, Data_Out, mux_2x1_DMWD_Out);
	DM: memory port map (MemReadOr, MemWriteOr, mux_2x1_DMA_Out, mux_2x1_DMWD_Out, DM_Out);
	mux_4x1_DM: mux_4x1 port map (JalMUX_I, MemtoReg_I, mux_2x1_DMA_Out, DM_Out, Adder_PC_4_Out, x"00000000", mux_4x1_DM_Out);

end behavior;
