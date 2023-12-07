.data
	A:	.word 1
	B:	.word 2
.text
.globl main
main:
	la	$s0,A
	la	$s1,B
	
	lw	$t0,($s0)
	lw	$t1,($s1)
	li	$t2,0		# Indice i = 0 
	li	$t3,5		# Numero total de loop
	
loop:
	
	add	$t0,$t1,1	# a = b + 1
	add	$t1,$t1,3	# b = b + 3
	sw	$t0,($s0)
	sw	$t1,($s1)
	addi	$t2,$t2,1	# Incremeta o i
	slt	$t4,$t2,$t3
	beq	$t4,$zero,end
	
	j 	loop

end:
	# Termina o programa
	li	$v0,10
	syscall
