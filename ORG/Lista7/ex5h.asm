.data
	A:	.word 0
	B:	.word 0
	C:	.word 0
	prompt_a:	.asciiz "Digite o valor de a: "
	prompt_c:	.asciiz "Digite o valor de c: "
.text
.globl main
main:
	la	$s0, A
	la	$s1, B
	la	$s2, C
	
	# Solicita o valor de A
	li	$v0,4		# pede o valor de A
	la	$a0,prompt_a
	syscall
	
	# Le o valor de A do teclado
	li	$v0, 5
	syscall
	sw	$v0, ($s0)
	
	# Solicita o valor de c
	li	$v0,4		# pede o valor de C
	la	$a0,prompt_c
	syscall
	
	# Le o valor de C do teclado
	li	$v0, 5
	syscall
	sw	$v0, ($s2)
	
	lw	$t0,($s0)
	lw	$t1,($s1)
	lw	$t2,($s2)
	
switch:
	beq	$t0,1, case_1
	beq	$t0,2, case_2
	j	default_case
	
	case_1:
		add	$t1,$t2,1	# b = c + 1
		sw	$t1,($s1)
		j end
	case_2:
		add	$t1,$t2,2	# b = c + 2
		sw	$t1,($s1)
		j end
	default_case:
		move	$t1,$t2		# b = c
		sw	$t1,($s1)
end:
	# Termina o programa
	li	$v0,10
	syscall