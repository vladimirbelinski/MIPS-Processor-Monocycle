library ieee;
use ieee.std_logic_1164.all;

entity D_reg is
   port(
        reg_clk: in std_logic;
		D: in std_logic_vector(31 downto 0);
		Q: out std_logic_vector(31 downto 0)
   );
end D_reg;

architecture behavior of D_reg is
    signal aux: std_logic_vector(31 downto 0);
begin
    process (reg_clk) begin
        if (reg_clk'event and reg_clk = '1') then
            aux <= D;
        end if;
    end process;
    Q <= aux;
end behavior;
