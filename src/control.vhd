-- Authors: Gabriel Galli and Vladimir Belinski
-- Description: entity and architecture of Control module.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control is
	port(
		ins_31_26: in unsigned(5 downto 0);
		RegDst, ALUSrc, MemtoReg, RegWrite, MemWrite, MemRead, Branch, BrBNE, JMUX, JalMUX: out std_logic;
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
				MemtoReg <= '0';
				RegWrite <= '1';
				MemWrite <= '0';
				MemRead  <= '0';
				Branch   <= '0';
				BrBNE    <= '0';
				ALUOp    <= "11";
				JMUX     <= '0';
				JalMUX   <= '0';
			when x"23"  => -- lw
				RegDst   <= '0';
				ALUSrc   <= '1';
				MemtoReg <= '1';
				RegWrite <= '1';
				MemWrite <= '0';
				MemRead  <= '1';
				Branch   <= '0';
				BrBNE    <= '0';
				ALUOp    <= "00";
				JMUX     <= '0';
				JalMUX   <= '0';
			when x"2B"  => -- sw
				RegDst   <= '0'; -- X
				ALUSrc   <= '1';
				MemtoReg <= '0'; -- X
				RegWrite <= '0';
				MemWrite <= '1';
				MemRead  <= '0';
				Branch   <= '0';
				BrBNE    <= '0';
				ALUOp    <= "00";
				JMUX     <= '0';
				JalMUX   <= '0'; -- X
			when x"08"  => -- addi
				RegDst   <= '0';
				ALUSrc   <= '1';
				MemtoReg <= '0';
				RegWrite <= '1';
				MemWrite <= '0';
				MemRead  <= '0';
				Branch   <= '0';
				BrBNE    <= '0';
				ALUOp    <= "00";
				JMUX     <= '0';
				JalMUX   <= '0';
			when x"0C"  => -- slti
				RegDst   <= '0';
				ALUSrc   <= '1';
				MemtoReg <= '0';
				RegWrite <= '1';
				MemWrite <= '0';
				MemRead  <= '0';
				Branch   <= '0';
				BrBNE    <= '0';
				ALUOp    <= "10";
				JMUX     <= '0';
				JalMUX   <= '0';
			when x"04"  => -- beq
				RegDst   <= '0'; -- X
				ALUSrc   <= '0';
				MemtoReg <= '0'; -- X
				RegWrite <= '0';
				MemWrite <= '0';
				MemRead  <= '0';
				Branch   <= '1';
				BrBNE    <= '0';
				ALUOp    <= "01";
				JMUX     <= '0';
				JalMUX   <= '0'; -- X
			when x"05"  => -- bne
				RegDst   <= '0'; -- X
				ALUSrc   <= '0';
				MemtoReg <= '0'; -- X
				RegWrite <= '0';
				MemWrite <= '0';
				MemRead  <= '0';
				Branch   <= '0';
				BrBNE    <= '1';
				ALUOp    <= "01";
				JMUX     <= '0';
				JalMUX   <= '0'; -- X
			when x"02"  => -- j
				RegDst   <= '0'; -- X
				ALUSrc   <= '0'; -- X
				MemtoReg <= '0'; -- X
				RegWrite <= '0';
				MemWrite <= '0';
				MemRead  <= '0';
				Branch   <= '0'; -- X
				BrBNE    <= '0'; -- X
				ALUOp    <= "00"; -- XX
				JMUX     <= '1';
				JalMUX   <= '0'; -- X
			when x"03"  => -- jal
				RegDst   <= '0'; -- X
				ALUSrc   <= '0'; -- X
				MemtoReg <= '0';
				RegWrite <= '1';
				MemWrite <= '0';
				MemRead  <= '0';
				Branch   <= '0'; -- X
				BrBNE    <= '0'; -- X
				ALUOp    <= "00"; -- XX
				JMUX     <= '1';
				JalMUX   <= '1';
			when others => -- nop
				RegDst   <= '0';
				ALUSrc   <= '0';
				MemtoReg <= '0';
				RegWrite <= '0';
				MemWrite <= '0';
				MemRead  <= '0';
				Branch   <= '0';
				BrBNE    <= '0';
				ALUOp    <= "00";
				JMUX     <= '0';
				JalMUX   <= '0';
		end case;
	end process;
end behavior;
