library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.matrix.all;

entity data_memory_tb is
end data_memory_tb;

architecture behavior of data_memory_tb is

	constant clk_time: time := 50ns;
	signal tb_MemRead, tb_MemWrite: std_logic;
	signal tb_address: unsigned(4 downto 0);
	signal tb_wr_data, tb_r_data: signed(31 downto 0);

	component data_memory is
		port(
		   tb_clk, MemRead, MemWrite: in std_logic;
		   address: in unsigned(4 downto 0);
		   wr_data: in signed(31 downto 0);
		   r_data: out signed(31 downto 0)
		);
	end component;

begin

	MEMORY: data_memory port map(tb_MemRead, tb_MemWrite, tb_address, tb_wr_data, tb_r_data);
	
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
		
		tb_MemRead <= '0';
		tb_MemWrite <= '0';
		tb_address <= "00000";
		tb_wr_data <= x"00000000"
		
		tb_MemWrite <= '1';
		for i in 0 to 255 loop -- if it's 256 bytes, the address should be 8 bits...!?
		wait for clk_time;
		tb_address <= tb_address + 4;
		tb_wr_data <= tb_wr_data + 1;
		end loop;
		tb_MemWrite <= '0';
		
	end process TB;
	
end behavior;
