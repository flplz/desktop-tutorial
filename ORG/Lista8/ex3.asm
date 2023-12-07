.data
	base:		.word 0
	expoente:	.word 0
	result:		.word 0

.text
.globl main
main:
	la	$s0,base
	la	$s1,expoente
	la	$s2,result
	
	#Ler os valores da base e do expoente
	# base
	li	$v0,5
	syscall
	sw	$v0,($s0)
	
	# expoente
	li	$v0,5
	syscall
	sw	$v0,($s1)
	
	# Chamada da função pow (base,expoente)
	lw	$a0,($s0)	# Carrega o valor da base
	lw	$a1,($s1)	# Carrega o valor do expoente
	
	jal pow
	
	# Armazena o resultado em result

	sw	$v0,($s2)	# Salva o resultado na memória
	
	# Imprime o resultado na tela
	lw	$a0,($s2)
	li	$v0,1
	syscall
	
	j	end

pow:
	#Função pow(base,expoente)
	li	$t1,1		# $t1 = 1
	li	$t2,0		# Indice i começa em 0
	
	
	loop:
		mult	$t1,$a0			# result *= base
		mflo	$t1
		addi	$t2,$t2,1		# Incrementa o i
		slt	$t3,$t2,$a1
		beq	$t3,$zero,done		# if i < expoente
		j	loop
	done:
		move $v0, $t1		# Coloca o resultado em $v0
		
		jr	$ra		# Retorna da função

end:
	# Termina o programa
	li	$v0,10
	syscall
