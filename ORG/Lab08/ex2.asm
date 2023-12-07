.data    
    MAX:	.word 0       
    block_size:	.word 0           
.text

main:   
        
    li 		$v0 5                      
    syscall
    move    	$t3 $v0                # Store matrix size in $t3
    sw  	$t3 MAX           # Save matrix size in memory
    mul     	$t3 $t3 $t3            # Calculate square of matrix size
    mul 	$t2 $t3 4                  # Calculate total size (in bytes) for the matrix
    
    li 		$v0 5                      
    syscall
    move    	$t5 $v0                # Store block size in $t5
    sw  	$t5 block_size             # Save block size in memory
    
    
    li     	$v0 9                   # Allocate memory for the first matrix
    move     	$a0 $t2                # Set the size of the memory block to allocate
    syscall
    move     	$s0 $v0                # Save the starting address of the allocated memory block
      
    move    	$a0 $s0                  # Set the base address of the first matrix
    move     	$a1 $t3                # Set the matrix size
    jal     	initialize_matrix       # Call the matrix initialization function for the first matrix

    li  	$v0 9                        # Allocate memory for the second matrix
    move    	$a0 $t2                 # Set the size of the memory block to allocate
    syscall
    move    	$s1 $v0                 # Save the starting address of the allocated memory block
        
    move    	$a0 $s1                 # Set the base address of the second matrix
    move    	$a1 $t3                 # Set the matrix size
    jal     	initialize_matrix       # Call the matrix initialization function for the second matrix

    lw  	$t2 MAX             # Load matrix size from memory
    mul     	$s6 $t2 4               # Calculate total size (in bytes) for a row
    lw  	$t3 block_size               # Load block size from memory
    li  	$t4 0                        # Initialize loop variable
    
	i_loop:
    	bge     $t4 $t2 exit            # Exit loop if the loop variable is greater than or equal to matrix size
    		li  $t5 0                        # Initialize inner loop variable
          
    		j_loop:
        	bge     $t5 $t2 exit_j       # Exit inner loop if the inner loop variable is greater than or equal to matrix size
        		move    $t6 $t4               # Copy the outer loop variable to the temporary variable
        
        		ii_loop:
            		add     $t0 $t4 $t3       # Calculate the end index of the row
            		bge     $t6 $t0 exit_ii   # Exit innermost loop if the temporary variable is greater than or equal to the end index
           			 move    $t7 $t5            
            
            			jj_loop:
                		add     $t1 $t5 $t3   # Calculate the end index of the column
                		bge     $t7 $t1 jj_exit# Exit the innermost loop if the temporary variable is greater than or equal to the end index
                
                			move    $s4 $s0         
               				move    $s5 $s1         
                
                			mul     $t0 $s6 $t6     # Calculate the offset for the first matrix
                			mul     $t1 $t7 4        # Calculate the offset for the second matrix
                			add     $t0 $t0 $t1     # Add both offsets to get the final offset for the elements
                
                			add     $s4 $s4 $t0     # Calculate the address of the element in the first matrix
                                
                			mul     $t0 $s6 $t7     # Calculate the offset for the second matrix
                			mul     $t1 $t6 4        # Calculate the offset for the first matrix
                			add     $t0 $t0 $t1     # Add both offsets to get the final offset for the elements
                
                			add     $s5 $s5 $t0     # Calculate the address of the element in the second matrix
                
                			lw  	$t0 0($s4)         
                			lw     	$t1 0($s5)          
                
                			add     $t0 $t0 $t1      # Add both values
                			sw  $t0 ($s4)           # Store the result in the first matrix
                
                			addi    $t7 $t7 1       
                			j   jj_loop            
            			jj_exit:
                		addi    $t6 $t6 1       
                		j   ii_loop             
        		exit_ii:
            		add     $t5 $t5 $t3          # Increment the outer loop variable by the block size
                	j   j_loop                 # Jump back to the inner loop
        	exit_j:
            	add     $t4 $t4 $t3             # Increment the outer loop variable by the block size
            	j   i_loop                      # Jump back to the outer loop
    
initialize_matrix:
    li  $t0 0                            # Initialize loop variable
    loop_matrix:
        beq     $t0 $a1 exit_matrix       # Exit loop if the loop variable is equal to matrix size   
        sw  $t0 0($a0)                    # Store the loop variable in the current position of the matrix
        addi    $a0 $a0 4                  # Increment the base address by 4 bytes to move to the next position
        addi    $t0 $t0 1                  # Increment the loop variable
        j   loop_matrix                    # Jump back to the loop
    exit_matrix:
        jr  $ra                         
    
exit:

