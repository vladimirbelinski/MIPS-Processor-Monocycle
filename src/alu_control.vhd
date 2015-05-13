library ieee;
use ieee.std_logic_1164.all;

entity alu_control is
	port(
		ALUOp: in std_logic_vector(1 downto 0);
		funct: in std_logic_vector(5 downto 0);
		op: out std_logic_vector(2 downto 0)
	);
end alu_control;

architecture behavior of alu_control is
begin
	process (ALUOp, funct) is
	begin
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
					when others => op <= "111"; -- 1010, slt
				end case;
		end case;
	end process;
end behavior;
