.data

.text

	li	$t0, 0
	li	$t1, 0
	li	$t2, 5
	
	loop:
		
		add	$t0,$t0,1
		add	$t1,$t1,2
		slt	$t3,$t0,$t2
		beq	$t3,$zero,exit
		j	loop
	
	
	exit:
		li	$v0,10
		syscall
	
	