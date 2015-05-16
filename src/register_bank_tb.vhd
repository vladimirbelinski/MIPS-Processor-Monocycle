library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.matrix.all;

entity register_bank_tb is
end register_bank_tb;

architecture behavior of register_bank_tb is

	constant clk_time: time := 10 ns;
	signal tb_clk, tb_RegWrite: std_logic;
	signal tb_read1, tb_read2, tb_write_register: unsigned(4 downto 0);
	signal tb_write_data, tb_data1, tb_data2: signed(31 downto 0);

	component register_bank is
		port(
		   RegWrite: in std_logic;
		   read1, read2, write_register: in unsigned(4 downto 0);
		   write_data: in signed(31 downto 0);
		   data1, data2: out signed(31 downto 0)
		);
	end component;

begin

	RB: register_bank port map(tb_RegWrite, tb_read1, tb_read2, tb_write_register, tb_write_data, tb_data1, tb_data2);

	CLK: process is
	begin
		tb_clk <= '0';
		wait for (clk_time / 2);
		tb_clk <= '1';
		wait for (clk_time / 2);
	end process CLK;

	TB: process is
		variable i: natural;
	begin

		tb_RegWrite <= '0';
		tb_read1 <= "00000";
		tb_read2 <= "00000";
		tb_write_register <= "00000";
		tb_write_data <= x"00000000";

		tb_RegWrite <= '1';
		for i in 0 to 31 loop
			wait for clk_time;
			tb_write_register <= tb_write_register + 1;
			tb_write_data <= tb_write_data + 1;
		end loop;
		tb_RegWrite <= '0';

		----------------------------------------------------------------

		tb_read1 <= "00000";
		tb_read2 <= "10000";

		for i in 0 to 15 loop
			wait for clk_time;
			tb_read1 <= tb_read1 + 1;
			tb_read2 <= tb_read2 + 1;
		end loop;
	end process TB;

end behavior;
