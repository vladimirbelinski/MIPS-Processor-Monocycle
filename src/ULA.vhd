--Authors: Gabriel Galli and Vladimir Belinski
--Description: entity and architecture of an ALU.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ULA is
    port(
       ALU_control: in std_logic_vector(2 downto 0);
       A, B: in signed(31 downto 0);
       Zero: out std_logic;
       ALU_result: out signed(31 downto 0)
    );
end ULA;

architecture behavior of ULA is
begin
    process(ALU_control) is
    begin
        case ALU_control is
            when "000"   => if ((A and B)= "00000000000000000000000000000000") then ALU_result <= A and B; Zero <= '1';
                            else ALU_result <= A and B; Zero <= '0';
                            end if;
            when "001"   => if ((A or B)= "00000000000000000000000000000000") then ALU_result <= A or B; Zero <= '1';
                            else ALU_result <= A or B; Zero <= '0';
                            end if;
            when "110"   => if ((A - B)= "00000000000000000000000000000000") then ALU_result <= A - B; Zero <= '1';
                            else ALU_result <= A - B; Zero <= '0';
                            end if;
            when "111"   => if(A < B) then ALU_result <= "00000000000000000000000000000000"; Zero <= '1';
                            else ALU_result <= "11111111111111111111111111111111"; Zero <= '0';
                            end if;
            when others =>  if ((A + B)= "00000000000000000000000000000000") then ALU_result <= A + B; Zero <= '1';
                            else ALU_result <= A + B; Zero <= '0';
                            end if;
        end case;
    end process;
    
end behavior;
