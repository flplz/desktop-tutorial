.data
	h:	.word 0
	w:	.word 0
	area:	.word 0
	val:	.word 0
.text
.globl main
main:
	la	$s0,h
	la	$s1,w
	la	$s2,area
	la	$s3,val
	# Variaveis a e b
	li	$t0,4		# $t0 = a = 4
	li	$t1,10		# $t1 = b 10

	sw	$t0,($s0)
	sw	$t1,($s1)



	# Passagem de argumentos para a fun??o CalculaAreaQuadrado
	lw	$a0,($s0)
	lw	$a1,($s1)


	# Chamada da fun??o CalculaAreaQuadrado
	jal	CalculaAreaQuadrado

	sw	$v0,($s3)	# val = retorno da fun??o

	j	end

CalculaAreaQuadrado:
	# Procedimento CalculoAreaQuadrado(h, w)

	# Calcula area = h * w
	mult	$a0,$a1		# h * w
	mflo	$t2		# $t4 = h * w

	move	$v0,$t2		# Retorna o resulta em $v0

	jr	$ra		# Retorno do procedimento


end:
	# Termina o programa
	li	$v0,10
	syscall