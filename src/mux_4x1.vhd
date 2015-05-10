library ieee;
use ieee.std_logic_1164.all;

entity mux_4x1 is
    port(
        sel: in std_logic_vector(1 downto 0);
		I00: in std_logic_vector(31 downto 0);
		I01: in std_logic_vector(31 downto 0);
		I10: in std_logic_vector(31 downto 0);
		I11: in std_logic_vector(31 downto 0);
		O: out std_logic_vector(31 downto 0)
    );
end mux_4x1;

architecture behavior of mux_4x1 is
begin
    process(sel)
    begin
        case sel is
            when "00"   => O <= I00;
            when "01"   => O <= I01;
            when "10"   => O <= I10;
            when others => O <= I11;
        end case;
    end process;
end behavior;
