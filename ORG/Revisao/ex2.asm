.data
	sum:	.word 0

.text

main:
	la	$s0,sum
	li	$t0,1
	li	$t1,5
	lw	$t2,($s0)
	
	loop:
		add	$t2,$t2,$t0
		addi	$t0,$t0,1
		
		sle	$t3,$t0,$t1
		beq	$t3,$zero,exit
		
		j	loop
	exit:
		sw	$t2,($s0)
		
		#Fim
		li	$v0,10
		syscall
	