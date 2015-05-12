library ieee;
use ieee.std_logic_1164.all;

entity signal_extender is
    port(
        ins: in std_logic_vector(15 downto 0);
        output: out std_logic_vector(31 downto 0)
    );
end signal_extender;

architecture behavior of signal_extender is
begin
    process(ins) is
    begin
        if ins(15) = '0' then
            output <= "0000000000000000" & ins;
        else
            output <= "1111111111111111" & ins;
        end if;
    end process;
    
end behavior;