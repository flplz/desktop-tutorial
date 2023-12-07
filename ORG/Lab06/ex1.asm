.data
	GET_NUMBER_TXT: .asciiz "Digite um numero para calcular o fatorial: \n"
.text
	main:
		# print message to get the number
		addi		$v0, $zero, 4
		la		$a0, GET_NUMBER_TXT
		syscall
		# get number from keyboard
		addi		$v0, $zero, 5
		syscall
		
		add	$t0, $zero, $v0		# x
		addi	$t1, $zero, 1		# fat
		
		fat_loop:
			ble 	$t0, 1, end_fat_loop	# loop while x > 1
			
			mul	$t1, $t1, $t0		# fat = fat * x
			subi	$t0, $t0, 1		# x = x - 1
			
			j 	fat_loop
		end_fat_loop:
		
		# print result
		addi		$v0, $zero, 1
		move		$a0, $t1
		syscall