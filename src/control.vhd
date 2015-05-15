library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control is
	port(
		ins_31_26: in unsigned(5 downto 0);
		RegDst, ALUSrc, MemToReg, RegWrite, MemWrite, MemRead, Branch, BrBne, JMux, JalMux: out std_logic;
		ALUOp: out unsigned(1 downto 0)
	);
end control;

architecture behavior of control is
	signal ins: unsigned(7 downto 0);
begin
	ins <= "00" & ins_31_26;
	process (ins_31_26) is -- activation should be ins_31_26 or ins?
	begin
		case ins is
			when x"00"  => -- R-format
				RegDst   <= '1';
				ALUSrc   <= '0';
				MemToReg <= '0';
				RegWrite <= '1';
				MemWrite <= '0';
				MemRead  <= '0';
				Branch   <= '0';
				BrBne    <= '0';
				ALUOp    <= "11";
				JMux     <= '0';
				JalMux   <= '0';
			when x"23"  => -- lw
				RegDst   <= '0';
				ALUSrc   <= '1';
				MemToReg <= '1';
				RegWrite <= '1';
				MemWrite <= '0';
				MemRead  <= '1';
				Branch   <= '0';
				BrBne    <= '0';
				ALUOp    <= "00";
				JMux     <= '0';
				JalMux   <= '0';
			when x"2B"  => -- sw
				RegDst   <= '0'; -- X
				ALUSrc   <= '1';
				MemToReg <= '0'; -- X
				RegWrite <= '0';
				MemWrite <= '1';
				MemRead  <= '0';
				Branch   <= '0';
				BrBne    <= '0';
				ALUOp    <= "00";
				JMux     <= '0';
				JalMux   <= '0'; -- X
			when x"08"  => -- addi
				RegDst   <= '0';
				ALUSrc   <= '1';
				MemToReg <= '0';
				RegWrite <= '1';
				MemWrite <= '0';
				MemRead  <= '0';
				Branch   <= '0';
				BrBne    <= '0';
				ALUOp    <= "00";
				JMux     <= '0';
				JalMux   <= '0';
			when x"0C"  => -- slti
				RegDst   <= '0';
				ALUSrc   <= '1';
				MemToReg <= '0';
				RegWrite <= '1';
				MemWrite <= '0';
				MemRead  <= '0';
				Branch   <= '0';
				BrBne    <= '0';
				ALUOp    <= "10";
				JMux     <= '0';
				JalMux   <= '0';
			when x"04"  => -- beq
				RegDst   <= '0'; -- X
				ALUSrc   <= '0';
				MemToReg <= '0'; -- X
				RegWrite <= '0';
				MemWrite <= '0';
				MemRead  <= '0';
				Branch   <= '1';
				BrBne    <= '0';
				ALUOp    <= "01";
				JMux     <= '0';
				JalMux   <= '0'; -- X
			when x"05"  => -- bne
				RegDst   <= '0'; -- X
				ALUSrc   <= '0';
				MemToReg <= '0'; -- X
				RegWrite <= '0';
				MemWrite <= '0';
				MemRead  <= '0';
				Branch   <= '0';
				BrBne    <= '1';
				ALUOp    <= "10";
				JMux     <= '0';
				JalMux   <= '0'; -- X
			when x"02"  => -- j
				RegDst   <= '0'; -- X
				ALUSrc   <= '0'; -- X
				MemToReg <= '0'; -- X
				RegWrite <= '0';
				MemWrite <= '0';
				MemRead  <= '0';
				Branch   <= '0'; -- X
				BrBne    <= '0'; -- X
				ALUOp    <= "00"; -- XX
				JMux     <= '1';
				JalMux   <= '0'; -- X
			when x"03"  => -- jal
				RegDst   <= '0'; -- X
				ALUSrc   <= '0'; -- X
				MemToReg <= '0';
				RegWrite <= '1';
				MemWrite <= '0';
				MemRead  <= '0';
				Branch   <= '0'; -- X
				BrBne    <= '0'; -- X
				ALUOp    <= "00"; -- XX
				JMux     <= '1';
				JalMux   <= '1';
			when others => -- nop :P
				RegDst   <= '0';
				ALUSrc   <= '0';
				MemToReg <= '0';
				RegWrite <= '0';
				MemWrite <= '0';
				MemRead  <= '0';
				Branch   <= '0';
				BrBne    <= '0';
				ALUOp    <= "00";
				JMux     <= '0';
				JalMux   <= '0';
		end case;
	end process;
end behavior;
