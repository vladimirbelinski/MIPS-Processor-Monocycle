-- Authors: Gabriel Galli and Vladimir Belinski
-- Description: entity and architecture of the ALU Control.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_control is
	port(
		ALUOp: in unsigned(1 downto 0);
		funct: in unsigned(5 downto 0);
		op: out unsigned(2 downto 0);
		JrMux: out std_logic
	);
end alu_control;

architecture behavior of alu_control is
begin
	process (ALUOp, funct) is
	begin
	JrMux <= '0';
		case ALUOp is
			when "00"   => op <= "010"; -- lw, sw, addi
            when "01"   => op <= "110"; -- beq, bne
            when "10"   => op <= "111"; -- slti
            when others =>
				case funct(3 downto 0) is -- two MSB are 'X'
					when "0000" => op <= "010"; -- add
					when "0010" => op <= "110"; -- sub
					when "0100" => op <= "000"; -- and
					when "0101" => op <= "001"; -- or
					when "1000" =>
						op <= "011"; -- jr
						JrMux <= '1';
					when others => op <= "111"; -- 1010, slt
				end case;
		end case;
	end process;
end behavior;
