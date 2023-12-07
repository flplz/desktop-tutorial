.data
	SUM:	.word 0
.text
main:
	la	$s0, SUM
	li	$t0,0		# Inicializar o contador i
	li	$t1,5		# Define o limite superior para i até 5
	lw	$t2, ($s0)	# $t2 = SUM
	
loop:
	add	$t2,$t2,$t0	# Soma i a variavel SUM
	addi	$t0,$t0,1	#Incrementa i em 1
	
	#Verifica se i atingiu o limite 5
	beq	$t0,$t1,done
	
	#Caso contrario, continua
	j	loop
	
done:
	#Armazena o resultado da soma no endereço de SUM
	sw	$t2,($s0)
	
	#Termina o programa
	li	$v0, 10
	syscall