.data
	A: .word 1 2 3 0 1 4 0 0 1
	   
	B: .word 1 -2 5 0 1 -4 0 0 1
	   
	Bt: .word 0:9	# B transposta
	RESULT:	.word 0:9
	 
.text
	main:
		la	$s2, A  # pointer to A
		la	$s1, Bt	# pointer to Bt
		la	$s0, B	       # B pointer
		la	$s4, RESULT	# RESULT pointer
		
		# matrix transposition
		addi	$t5, $zero, 0  # col index
		addi	$t6, $zero, 0  # Bt deslocated
		addi	$t7, $zero, 0  # Bt deslocation number
	
		loop_col:
			bgt	$t5, 2, end_loop_col
	
			# updates B pointer to point at the correct column
			li	$t4, 4		#
			mult 	$t4, $t5	# index * 4
			mflo	$t4		# 
			add	$t0, $s0, $t4	# adds up values of $t4 to the address
			
			addi	$t4, $zero, 0	# counter of lines / index_lines
			loop_lines:
				bgt	$t4, 2, end_loop_lines
				
				# updates Bt pointer to point at the correct item in vector (which represents a matrix)
				add	$t6, $s1, $t7	# deslocate Bt address
				addi	$t7, $t7, 4	# update deslocation number
				
				# cals index_lines * 12 to get in the vector the correct position
				li	$t3, 12
				mult	$t3, $t4
				mflo	$t3
				
				add	$t2, $t0, $t3	#  the immediate chooses which item of column should take, being 0 = first; 12 = second; 24 = third;
				lw 	$t3, ($t2)	#  
				sw	$t3, ($t6)      #  saves value of B[i][j] in Bt[k][j]
				addi	$t4, $t4, 1	#  update line loop counter
				j 	loop_lines
			end_loop_lines:
	
			addi	$t5, $t5, 1	# updates col_index
			j	loop_col
		end_loop_col:
		# end of matrix transposition
		
		# matrix multiplication
		addi	$t0, $zero, 3   # num of lines and columns
		addi	$t1, $zero, 0	# position in resultant matrix (vector in assembly)
		
		addi	$t2, $zero, 0	# line index for loop	
		loop_lines_multiplication:
			beq	$t2, $t0, end_loop_lines_multiplication	# current_line < num_of_lines
			
			addi $t3, $zero, 0	# column index for loop
			loop_columns:
				beq	$t3, $t0, end_loop_columns
				
				addi	$t6, $zero, 0	# result
				addi	$t7, $zero, 0	# loop items index
				
				loop_items:	# loops thrue items of each line and column multiplying them as line[i][j] * column[j][k]
					beq 	$t7, $t0, end_loop_items
				
					# logic for multiplications beetwen lines and columns for each position
					
					## calcs position of line start in vector + index of line item
					mult	$t2, $t0	# current_line * num_of_lines (line start in vector)
					mflo	$t4
					add	$t4, $t4, $t7 	# adds index_of_line_item
								# $t4 has now the position in vector for line
								
					mul	$t4, $t4, 4	# multiplies index per word length (4 bytes)
								
					## calcs position of column start in vector + index of column item
					mul	$t5, $t0, $t7	# num_of_columns * index_of_column_item
					add	$t5, $t5, $t3	# adds current_column value
								# $t5 has now the position in vector for column
								
					mul	$t5, $t5, 4	# multiplies index per word length (4 bytes)
								
					## loads values to be multiplied
					add	$t4, $s2, $t4	# vector A + deslocation calculated previously
					lw	$t4, ($t4)	# A[i][j]
					
					add	$t5, $s1, $t5	# vector Bt + deslocation calculated previously
					lw	$t5, ($t5)	# Bt[j][k]
					
					## multiply values
					mul	$t4, $t4, $t5	# A[i][j] * Bt[j][k]
				
					add	$t6, $t6, $t4	# updates result as result += mult
					
					#################################################
					addi	$t7, $t7, 1	# updates loop items index
					j	loop_items
				end_loop_items:
				
				# saves result in RESULT vector
				mul	$t4, $t1, 4	# curret index in RESULT vector * 4 bytes to calc deslocation
				add 	$t4, $s4, $t4	# calcs address + deslocation
					
				sw	$t6, ($t4)	# saves result in RESULT[current_result_position]
				
				addi 	$t1, $t1, 1	# updates current result position
				
				## end of loop
				addi	$t3, $t3, 1	# updates column index
				j	loop_columns
			end_loop_columns:
			
			addi	$t2, $t2, 1	# updates line index
			j	loop_lines_multiplication
		end_loop_lines_multiplication:
		
	end_main:
		j	end_main
