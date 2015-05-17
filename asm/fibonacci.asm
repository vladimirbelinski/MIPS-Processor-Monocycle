# Authors: Gabriel Galli and Vladimir Belinski
# Description: program that calculates the first "x" numbers of Fibonacci;

		.data

lib:	.asciiz		"\n"

################################################################################

		.text

main:							# inicializações:
		addi $t0, $0, 10		# max
		addi $t1, $0, 0			# a
		addi $t2, $0, 1			# b
		add $t3, $0, $0			# c
		add $t5, $0 $0			# for counter

		li $v0, 1
		add $a0, $0, $t1
		syscall					# printa a
		li $v0, 4
		la $a0, lib
		syscall					# printa "\n"

		li $v0, 1
		add $a0, $0, $t2
		syscall					# printa b
		li $v0, 4
		la $a0, lib
		syscall					# printa "\n"

for:							# $t0 = max, $t3 = c
		slt $t4, $t5, $t0		# i < max ? $t4 = 1 : $t4 = 0
	    beq $t4, $0, rof		# ^ if ($t4 == 0) goto rof
		
	    add $t3, $t1, $t2		# $t3 = c = a + b, ou fib(n) = fib(n - 2) + fib(n - 1)
	    add $t1, $t2, $0		# a = b
	    add $t2, $t3, $0		# b = c
	    addi $t5, $t5, 1		# i++

    li $v0, 1
		add $a0, $0, $t3
		syscall					# printa c
		li $v0, 4
		la $a0, lib
		syscall					# printa "\n"

    	j for					# volta pro for pra ver se continua ou acabou o laço

rof:
		li $v0, 10				# código da syscall pra terminar a main
		syscall					# "return 0"
