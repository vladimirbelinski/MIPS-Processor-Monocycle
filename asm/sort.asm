		.data

array:		.word		1, 3, 2, 5, 4, 7, 6, 9, 8, 10
tam:		.word		10
lib:		.byte		'\n'

################################################################################

		.text

main:
		la $s0, array						# $s0 = vetor
		la $s1, tam							# $s1 = tam do vetor

		add $a0, $s0, $0					# 1o arg da ordena_vetor: vetor que vou ordenar
		lw $a1, ($s1)	 					# 2o arg da ordena_vetor: tam do vetor
		jal ordena_vetor					# chamada da função

		add $a0, $s0, $0					# 1o arg da vprint: vetor que vou printar
		lw $a1, ($s1)						# 2o arg da vprint: tam do vetor
		jal vprint							# chamada da função

		li $v0, 10							# código da syscall pra terminar a main
		syscall								# "return 0"

################################################################################

ordena_vetor:
		la $t0, ($a0)						# põe em $t0 o endereço do vetor
		add $t6, $ra, $0					# salva o retorno, porque vai chamar outra função aqui...
		addi $t2, $a1, -1					# $t2 = tamanho - 1
		addi $t7, $0, 1						# ($t7 == troca) = (true == 1)
while:
		beq $t7, $0, end_while				# ^ if ($t7 == false) goto end_while <==> while (troca)
		add $t7, $0, $0						# ($t7 == troca) = (false == 0)

		add $t1, $0, $0						# $t1 == i = 0, $t3 == aux. t8 == [i], t9 = [i + 1]
		add $t8, $t0, $0					# é o que vai percorrer o vetor ([i])
for:
		slt $t4, $t1, $t2					# $t1 < $t2 ? $t4 = 1 : $t4 = 0 <==> i < vector.length
        beq $t4, $0, end_for				# ^ if ($t4 == 0) goto end_while <==> while (troca)

		addi $t9, $t8, 4					# $t9 = $t8 + 4 == i + 1

		# vetor[i] > vetor[i + 1]?
		lw $a0, ($t8)						# $a0 = vetor[i]
		lw $a1, ($t9)						# $a1 = vetor[i + 1]
		jal maior
		bne $v0, $0, end_if
if:
		lw $t3, ($t8)						# aux = vetor[i]
		lw $t5, ($t9)						# $t5 = vetor[i + 1]

		sw $t5, ($t8)						# ($t8) = $t5 == vetor[i] = vetor[i + 1]
		sw $t3, ($t9)						# ($t9) = $t3 == vetor[i + 1] = aux
		addi $t7, $0, 1						# ($t7 == troca) = (true == 1)
end_if:
		addi $t1, $t1, 1						# $t1++ == i++
		addi $t8, $t8, 4					# incrementa a memória correspondente à posição do vetor
		j for
end_for:
		j while
end_while:
		add $ra, $t6, $0					# devolve pra $ra o lugar que é pra voltar no retorno
		jr $ra

################################################################################

maior:
		slt $v0, $a0, $a1					# $a0 < $a1 ? $v0 = 1 : $v0 = 0
		bne $v0, $0, fim					# se é != 0, significa que $a1 >= $a0
		addi $a1, $a1, 1					# $a1++
		slt $v0, $a0, $a1					# $a0 < ($a1 + 1) ? $v0 = 1 : $v0 = 0
fim:
		jr $ra

################################################################################

vprint:
		# não dá pra reaproveitar $a0 como o $a1 porque
		# ele é utilizado nas syscalls de printar
		add $t0, $0, $a0				    # copia pra $t0 o ponteiro pro vetor a printar
		add $t1, $0, $0					    # $t1 é var de controle do for

        li $v0, 4
        la $a0, lib
        syscall						        # printa '\n'

printfor:
		slt $t2, $t1, $a1				    # $t1 < $a1 ? $t2 = 1 : $t2 = 0
        beq $t2, $0, end_printfor		    # ^ if ($t2 == 0) goto end_printfor

		li $v0, 1						    # código da syscall para printar int
		lw $a0, ($t0)					    # vetor[$t0] vai pra $a0 pra printar
		syscall							    # printa vetor[$t0]

		li $v0, 4
		la $a0, lib
		syscall							    # printa '\n'

        addi $t0, $t0, 4				    # $t0 += 4: avançar na posição do vetor
		addi $t1, $t1, 1				    # var de controle $t1++
        j printfor
end_printfor:
		jr $ra
