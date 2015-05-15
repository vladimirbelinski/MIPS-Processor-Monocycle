--Authors: Gabriel Galli and Vladimir Belinski
--Description: entity and architecture of an ALU.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ULA is
    port(
       ALU_control: in unsigned(2 downto 0);
       A, B: in signed(31 downto 0);
       Zero: out std_logic;
       ALU_result: out signed(31 downto 0)
    );
end ULA;

architecture behavior of ULA is

	signal result: signed(31 downto 0);

begin
    process(ALU_control) is
    begin
        case ALU_control is
            when "000"  => result <= A and B;
            when "001"  => result <= A or B;
            when "110"  => result <= A - B;
            when "111"  =>
				if (A < B) then result <= x"00000000";
                else result <= x"00000001";
                end if;
            when "011" => result <= x"00000000";
            when others => result <= A + B;
        end case;

        if (result = x"00000000") then Zero <= '1';
        else Zero <= '0';
        end if;
    end process;

    ALU_result <= result;

end behavior;
