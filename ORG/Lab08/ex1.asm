.data
	MAX:	.word 0
	A:	.word 1,2,3,4,5,6,7,8,9
	B:	.word 1,4,7,2,4,8,3,6,9
.text	 
	### Gets data matrix size from user
	li	$v0, 5
	syscall
	add	$t0, $v0, $zero
	
	sw	$t0, MAX
	
	mul	$t0, $t0, $t0	# squares the read value to use as parameter in next syscall
	mul	$a0, $t0, 4	# multiply by 4 to use word sizes (4 bytes per number)
	
	# Allocates memory for A
	li	$v0, 9
	syscall
	move	$s0, $v0	# $s0 is now our pointer to matrix A
	
	# Allocates memory for B
	li	$v0, 9
	syscall
	move	$s1, $v0	# $s0 is now our pointer to matrix B
	
	### Matrixes addition
	lw	$t0, MAX
	add	$t1, $zero, 0	# counter_outer
	
	outer_loop:
	bge	$t1, $t0, end_outer_loop
		
		add	$t2, $zero, 0	# inner_counter
			
		inner_loop:
		bge	$t2, $t0, end_inner_loop
			
			# Deslocation calc for A: 4 * ((coluna) + (linha * MAX))
			mul	$t3, $t1, $t0	# (linha * MAX)
			add	$t3, $t3, $t2	# ((coluna) + (linha * MAX))
			mul	$t3, $t3, 4	# corrects deslocation in bytes
			
			# Deslocation calc for B: 4 * ((coluna * MAX) + linha)
			mul	$t4, $t2, $t0	# (coluna * MAX)
			add	$t4, $t4, $t1	# ((coluna * MAX) + (linha))
			mul	$t4, $t4, 4	# corrects deslocation in bytes
			
			# loads numbers
			add	$t5, $s0, $t3	# address in A deslocated
			lw	$t3, ($t5)	
			
			add	$t6, $s1, $t4	# address in B deslocated
			lw	$t4, ($t6)
			
			# adds numbers
			add	$t3, $t3, $t4	# A[i, j] + B[j, i]
			
			#saves result
			sw	$t3, ($t5)
			
			addi 	$t2, $t2, 1	# updates inner counter
			j	inner_loop
		end_inner_loop:
		 	
		addi	$t1, $t1, 1	# updates counter
		j	outer_loop
	end_outer_loop:
	