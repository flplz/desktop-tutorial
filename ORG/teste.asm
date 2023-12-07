.data
	g:	.word 0
	h:	.word 0
	i:	.word 0
	j:	.word 0
	A:	.word 0
	aux:	.word 0
.text
.globl main
main:
	la	$s1,g
	la	$s2,h
	la	$s3,i
	la	$s4,j
	la	$s5,A
	lw	$t3,aux
	li	$t2,4
	
	loop:
		mult	$t2,$s3
		mflo	$t1
		add	$t1,$t1,$s5
		sw	$t3,($t1)
		lw	$t0,0($t1)
		add	$s1,$s1,$t0
		add	$s3,$s3,$s4
		addi	$s3,$s3,1
		bne	$s3,$s2,loop
		
	