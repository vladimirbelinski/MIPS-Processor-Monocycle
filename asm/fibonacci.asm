# Implemente o algoritmo de Fibonacci utilizando o conjunto de instruções do MIPS.
# Sabendo que o registrador $s0 armazena um número "m", calcule todos os números de fibonacci menores que "m".

		.data

max:	.asciiz		"Digite o valor maximo do Fibonacci: "
lib:	.byte		'\n'
varA:	.word		0
varB:	.word		1
varC:	.word		1

########################################################################

		.text

main:							# inicializações:
		la $t5, varA			# $t5 = &varA
		la $t6, varB			# $t6 = &varB
		la $t7, varC			# $t7 = &varC
		lw $t1, 0($t5)			# $t1 = varA
		lw $t2, 0($t6)			# $t2 = varB
		lw $t3, 0($t7)			# $t3 = varC

		li $v0, 4				# código da syscall pra leitura de string
		la $a0, max				# coloca o endereço da string em $a0
		syscall 				# printa 'max' no console

		li $v0, 5
		syscall
		add $t0, $0, $v0		# armazena o valor max lido do teclado em $t0

		li $v0, 1
		add $a0, $0, $t1
		syscall					# printa a (0)

		li $v0, 4
		la $a0, lib
		syscall					# printa '\n'

for:							# $t0 = max, $t3 = c
		slt $t4, $t3, $t0		# fib < m ? $t4 = 1 : $t4 = 0
        beq $t4, $0, rof		# ^ if ($t4 == 0) goto rof

        li $v0, 1
		add $a0, $0, $t3
		syscall					# printa c

        add $t3, $t1, $t2		# $t3 = c = a + b, ou fib(n) = fib(n - 2) + fib(n - 1)

		li $v0, 4
		la $a0, lib
		syscall					# printa '\n'

        add $t1, $t2, $0		# a = b
        add $t2, $t3, $0		# b = c
        j for					# volta pro for pra ver se continua ou acabou o laço

rof:    li $v0, 10				# código da syscall pra terminar a main
		syscall					# "return 0"
