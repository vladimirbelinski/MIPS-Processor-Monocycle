library ieee;
use ieee.std_logic_1164.all;

entity 4x1_mux is
   port(
      sel: in std_logic_vector(1 downto 0);
		I00: in std_logic_vector(31 downto 0);
		I01: in std_logic_vector(31 downto 0);
		I10: in std_logic_vector(31 downto 0);
		I11: in std_logic_vector(31 downto 0);
		O: out std_logic_vector(31 downto 0)
   );
end 4x1_mux;

architecture behavior of 4x1_mux is
begin
   if (sel = '00') then
       O <= I00;
   elsif (sel = '01') then
       O <= I01;
   elsif (sel = '10') then
       O <= I10;
   else
       O <= I11;
   end if;
end behavior;