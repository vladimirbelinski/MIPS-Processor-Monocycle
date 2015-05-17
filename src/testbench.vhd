-- Authors: Gabriel Galli and Vladimir Belinski
-- Description: entity and architecture of the testbench.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.matrix.all;

entity testbench is
end testbench;

architecture behavior of testbench is

    constant clk_time: time := 10 ps;
    signal tb_clk, Is_the_first_tb, Read_IM_tb, Write_IM_tb, Is_Out_tb, MemWrite_Out_tb, MemRead_Out_tb: std_logic;
    signal Initial_address_tb, Instruction_tb, Address_Out_tb, Data_Out_tb: signed(31 downto 0);

    component monocycle is
        port(
            Is_the_first, clock, Read_IM, Write_IM, Is_Out, MemWrite_Out, MemRead_Out: in std_logic;
            Initial_address, Instruction, Address_Out, Data_Out: in signed(31 downto 0)
        );
    end component;

begin

    MIPS: monocycle port map (Is_the_first_tb, tb_clk, Read_IM_tb, Write_IM_tb, Is_Out_tb, MemWrite_Out_tb, MemRead_Out_tb, Initial_address_tb, Instruction_tb, Address_Out_tb, Data_Out_tb);

    CLK: process is
    begin
        tb_clk <= '1';
        wait for (clk_time / 2);
        tb_clk <= '0';
        wait for (clk_time / 2);
    end process CLK;

    TB: process is
    begin
        wait for clk_time;

        Is_the_first_tb <= '1';
        Read_IM_tb <= '0';
        Write_IM_tb <= '1';
        Is_Out_tb <= '0'; -- controla muxes pra escrever na memória de dados
        MemWrite_Out_tb <= '0'; -- or pra escrita na memória de dados
        MemRead_Out_tb <= '0'; -- or pra leitura na memória de dados
        Address_Out_tb <= x"00000000"; -- endereço para memória de dados
        Data_Out_tb <= x"00000000"; -- dado para a memória de dados
        -- Instruction_tb <= "00000000000000000100000000100000"; -- add $t0, $0, $0
        -- Instruction_tb <= "00010000000000001111111111111111"; -- beq $t0, $0, -1
        -- Instruction_tb <= "00001100000000000000000000001010"; -- jal somewhere (10 linhas abaixo de PC+4)

        Initial_address_tb <= x"00000000";
        Instruction_tb <= "00100000000010000000000000001010";
        wait for clk_time;

        Initial_address_tb <= Initial_address_tb + 4;
        Instruction_tb <= "00100000000010010000000000000000";
        wait for clk_time;

        Initial_address_tb <= Initial_address_tb + 4;
        Instruction_tb <= "00100000000010100000000000000001";
        wait for clk_time;

        Initial_address_tb <= Initial_address_tb + 4;
        Instruction_tb <= "00000000000000000101100000100000";
        wait for clk_time;

        Initial_address_tb <= Initial_address_tb + 4;
        Instruction_tb <= "00000000000000000110100000100000";
        wait for clk_time;

        Initial_address_tb <= Initial_address_tb + 4;
        Instruction_tb <= "00000001101010000110000000101010";
        wait for clk_time;

        Initial_address_tb <= Initial_address_tb + 4;
        Instruction_tb <= "00010000000011000000000000000101";
        wait for clk_time;

        Initial_address_tb <= Initial_address_tb + 4;
        Instruction_tb <= "00000001001010100101100000100000";
        wait for clk_time;

        Initial_address_tb <= Initial_address_tb + 4;
        Instruction_tb <= "00000001010000000100100000100000";
        wait for clk_time;

        Initial_address_tb <= Initial_address_tb + 4;
        Instruction_tb <= "00000001011000000101000000100000";
        wait for clk_time;

        Initial_address_tb <= Initial_address_tb + 4;
        Instruction_tb <= "00100001101011010000000000000001";
        wait for clk_time;

        Initial_address_tb <= Initial_address_tb + 4;
        Instruction_tb <= "00001011111111111111111111111001";
        wait for clk_time;

        Is_the_first_tb <= '0';
        Write_IM_tb <= '0';
        Read_IM_tb <= '1';

        wait for clk_time;

        Is_the_first_tb <= '0';
        Write_IM_tb <= '0';
        Read_IM_tb <= '1';

        wait for clk_time;

        Is_the_first_tb <= '0';
        Write_IM_tb <= '0';
        Read_IM_tb <= '1';

        wait for clk_time;

        Is_the_first_tb <= '0';
        Write_IM_tb <= '0';
        Read_IM_tb <= '1';

        wait for clk_time;

        Is_the_first_tb <= '0';
        Write_IM_tb <= '0';
        Read_IM_tb <= '1';

        wait;
    end process TB;

end behavior;
