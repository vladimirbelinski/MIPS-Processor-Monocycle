library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity register_bank is
    port(
       RegWrite: in std_logic;
       r1, r2, wr: in std_logic_vector(4 downto 0);
       wd: in std_logic_vector(31 downto 0);
       d1, d2: out std_logic_vector(31 downto 0)
    );
end register_bank;

architecture behavior of register_bank is
    
    type rbank is array(0 to 31) of std_logic_vector(31 downto 0);
    signal bank: rbank;
    
begin
    
    process(RegWrite) is
    begin
        if rising_edge(RegWrite) then
            bank(conv_integer(wr)) <= wd;
        end if;
    end process;
    
    process(r1) is
    begin
        d1 <= bank(conv_integer(r1));
    end process;
    
    process(r2) is
    begin
        d2 <= bank(conv_integer(r2));
    end process;
    
end behavior;