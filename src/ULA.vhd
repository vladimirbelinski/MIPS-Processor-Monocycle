-- Authors: Gabriel Galli and Vladimir Belinski
-- Description: entity and architecture of an ALU.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ULA is
    port(
        ALU_control: in signed(2 downto 0);
        A, B: in signed(31 downto 0);
        Zero: out std_logic;
        ALU_result: out signed(31 downto 0)
    );
end ULA;

architecture behavior of ULA is
begin
    process (ALU_control, A, B) is
        variable result: signed(31 downto 0);
    begin
        case ALU_control is
            when "000"  => result := A and B;
            when "001"  => result := A or B;
            when "110"  => result := A - B;
            when "111"  =>
                if (A < B) then result := x"00000001";
                else result := x"00000000";
                end if;
            when "011"  => result := x"00000000";
            when others => result := A + B;
        end case;

        if (result = x"00000000") then Zero <= '1';
        else Zero <= '0';
        end if;

        ALU_result <= result;
    end process;

end behavior;
