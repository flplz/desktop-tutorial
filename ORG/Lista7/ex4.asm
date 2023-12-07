.data
	values:	.word 1,3,2,1,4,5
	v:	.space	24
	
.text
main:
	la	$s0, v		# Endere�o base de v
	la	$s1,values	# Endere�o base de values
	li	$t0, 0		# Indice i come�a com 0
	
	# Elementos para fazer o loop
	li	$t1, 6		# Total de elementos	

loop:
	lw	$t2,($s1)	# Carrega os valores
	sw	$t2,8($s0)	# Armazena o valor no vetor v[i]
	addi	$s0,$s0,4	# Aponta para o proxima palavra do vetor
	addi	$s1,$s1,4	# Aponta para o proximo valor
	addi	$t0,$t0,1	# Incrementa o i
	
	#Verifica se o loop deve continuar
	bne	$t0,$t1,loop
	
	#Fim do programa
	li	$v0,10
	syscall