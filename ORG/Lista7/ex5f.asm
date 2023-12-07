.data
	A:	.word 0
	B:	.word 0
	C:	.word 5
.text
.globl main
main:
	la	$s0,A
	la	$s1,B
	la	$s2,C
	
	lw	$t0,($s0)
	lw	$t1,($s1)
	lw	$t2,($s2)
	
loop:
	addi	$t0,$t0,1	# Incrementa A
	addi	$t1,$t1,2	# Incremnta B em 2
	sw	$t0,($s0)
	sw	$t1,($s1)
	blt	$t0,$t2,loop
	j	end
	

end:
	# Termina o programa
	li	$v0,10
	syscall