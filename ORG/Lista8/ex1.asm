.data
	g:	.word 0
	h:	.word 0
	i:	.word 0
	j:	.word 0
	f:	.word 0
	prompt_g:	.asciiz "Digite o valor de g: "
	prompt_h:	.asciiz "Digite o valor de h: "
	prompt_i:	.asciiz "Digite o valor de i: "
	prompt_j:	.asciiz "Digite o valor de j: "
.text
.globl main
main:
	# Endere?o base das variaveis
	la	$s0,g
	la	$s1,h
	la	$s2,i
	la	$s3,j
	la	$s4,f
	# Leitura dos valores g, h, i, j
	li	$v0, 4
	la	$a0,prompt_g
	syscall

	#Leo do teclado os valores das variaveis
	li	$v0, 5
	syscall
	sw	$v0,($s0)

	# Leitura dos valores g, h, i, j
	li	$v0, 4
	la	$a0,prompt_h
	syscall

	#Leo do teclado os valores das variaveis
	li	$v0, 5
	syscall
	sw	$v0,($s1)

	# Leitura dos valores g, h, i, j
	li	$v0, 4
	la	$a0,prompt_i
	syscall

	#Leo do teclado os valores das variaveis
	li	$v0, 5
	syscall
	sw	$v0,($s2)

	# Leitura dos valores g, h, i, j
	li	$v0, 4
	la	$a0,prompt_j
	syscall

	#Le do teclado os valores das variaveis
	li	$v0, 5
	syscall
	sw	$v0,($s3)

	#Parametros para o procedimento
	lw	$a0,($s0)
	lw	$a1,($s1)
	lw	$a2,($s2)
	lw	$a3,($s3)

	# Chama do procedimento calcula
	jal	calcula

	#Armazena o resultado em f
	
	sw	$v0,($s4)

	# Sa?da do resultado
	lw	$a0,($s4)	# Carrega o valor calculado (f) em $a0
	li	$v0, 1		# C?digo da syscall para imprimir um inteiro
	syscall

	j	end
	
calcula:
	# Procedimento calcula (g, h, i ,j)
	
	#push
	addi	$sp,$sp,-12
	sw	$t1,8($sp)
	sw	$t0,4($sp)
	sw	$s0,0($sp)

	# Calcula f = (g + h) - (i + j);
	add	$t0,$a0,$a1	# $t0 = g + h
	add	$t1,$a2,$a3	# $t1 = i + j
	sub	$s0,$t0,$t1	# $t4 = (g + h) - (i + j)
	move	$v0,$s0
	#pop
	lw	$s0,0($sp)
	lw	$t0,4($sp)
	lw	$t1,8($sp)
	addi	$sp,$sp,12

	

	jr	$ra		# Retorno do procedimento


end:
	# Termina o programa
	li	$v0,10
	syscall