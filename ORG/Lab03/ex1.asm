.data
	NUM: .double 0
	INIT_ESTIMATE: .double 1
	DIV_CONST: .double 2
	RESULT: .double 0
	TXT_RESULT: .asciiz "\nResultado da equacao: "
	TXT_SQRT: .asciiz "\nResultado da funcao sqrt.d: "
.text
	main:
		# Get number of iterations
		addi		$v0, $zero, 5
		syscall
		move		$a1, $v0	# save number in a1 register
	
		# Get number of number to square and saves in mem
		addi		$v0, $zero, 7
		syscall
		s.d		$f0, NUM	# stores double precision number to square
		
		la		$a0, NUM
		jal		raiz_quadrada
		l.d		$f12, ($v0)
		
		## prints returned number
		# prints text
		addi		$v0, $zero, 4
		la		$a0, TXT_RESULT
		syscall
		
		# prints number
		addi		$v0, $zero, 3
		syscall
		
		## calcs sqrt.d operator to compare
		l.d		$f2, NUM
		sqrt.d 		$f2, $f2
		
		# print text to sqrt.d result
		addi		$v0, $zero, 4
		la		$a0, TXT_SQRT
		syscall
		
		# print sqrt result
		mov.d		$f12, $f2
		addi		$v0, $zero, 3
		syscall
		
	end_main:
		j	end_main
		
raiz_quadrada:			# args: $a0 = double precision number address
	l.d		$f0, INIT_ESTIMATE	# initial estimate
	l.d		$f2, ($a0)		# loads number passed as parameter
	
	addi		$t0, $zero, 1
	loop:
		beq		$t0, $a1, end_loop
		
		# calc of equation: estimate = ((x/estimate) + estimate)/2
		div.d		$f4, $f2, $f0		# x / estimate
		add.d		$f4, $f4, $f0		# new_x + estimate
		l.d		$f0, DIV_CONST		# loads division constant of equation
		div.d 		$f0, $f4, $f0		# new_x / 2 is now the new estimate
		
		addi		$t0, $t0, 1
		j		loop
	end_loop:
	
	# saves result in mem and returns address
	s.d		$f0, RESULT
	la		$v0, RESULT			# returns address cause it is not possible to return 64 bits to 32 bits registers
	
	jr		$ra
end_raiz_quadrada: