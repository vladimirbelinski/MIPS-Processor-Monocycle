--Authors: Gabriel Galli and Vladimir Belinski
--Description: entity and architecture of the instruction memory.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.matrix.all;

entity instruction_memory is
    port(
       ra: in unsigned(4 downto 0);
       i: out signed(31 downto 0)
    );
end instruction_memory;

architecture behavior of instruction_memory is
    
    signal bank: memory;
    
begin
    
    process(ra) is
    begin
        i <= bank(to_integer(ra));
    end process;
    
end behavior;
