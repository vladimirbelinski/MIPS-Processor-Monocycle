--Authors: Gabriel Galli and Vladimir Belinski
--Description: entity and architecture of a 32 bits register.

library ieee;
use ieee.std_logic_1164.all;

entity PC is
   port(
      reg_clk: in std_logic;
		D: in std_logic_vector(31 downto 0);
		Q: out std_logic_vector(31 downto 0)
   );
end PC;

architecture behavior of PC is
    signal aux: std_logic_vector(31 downto 0);
begin
    process (reg_clk) begin
        if rising_edge(reg_clk) then
            aux <= D;
        end if;
    end process;
    Q <= aux;
end behavior;