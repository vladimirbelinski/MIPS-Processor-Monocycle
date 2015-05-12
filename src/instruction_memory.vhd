--Authors: Gabriel Galli and Vladimir Belinski
--Description: entity and architecture of the instruction memory.

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity instruction_memory is
    port(
       ra: in std_logic_vector(4 downto 0);
       i: out std_logic_vector(31 downto 0)
    );
end instruction_memory;

architecture behavior of instruction_memory is
    
    type rbank is array(0 to 255) of std_logic_vector(31 downto 0);
    signal bank: rbank;
    
begin
    
    process(ra) is
    begin
        i <= bank(conv_integer(ra));
    end process;
    
end behavior;
