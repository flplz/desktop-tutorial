.data
    prompt: .asciiz "Input an integer x:\n"
    result: .asciiz "Fact(x) = "
.text
main:
    # show prompt
    li        $v0, 4
    la        $a0, prompt
    syscall
    # read x
    li        $v0, 5
    syscall
    # function call
    move      $a0, $v0
    jal      factorial       # jump factorial and save position to $ra
    
    move      $t0, $v0        # $t0 = $v0
    # show prompt
    li        $v0, 4
    la        $a0, result
    syscall
    # print the result
    li        $v0, 1        # system call #1 - print int
    move      $a0, $t0        # $a0 = $t0
    syscall                # execute
    # return 0
    li        $v0, 10        # $v0 = 10
    syscall


factorial:
    # base case -- still in parent's stack segment
    # adjust stack pointer to store return address and argument
    addi    $sp, $sp, -8
    # save $s0 and $ra
    sw      $s0, 4($sp)
    sw      $ra, 0($sp)
    
    #base case
    li		$v0 ,1
    beq		$a0,0,factorialDone
    
    move	$s0, $a0
    addi	$a0,$a0,-1
    jal		factorial
    
    mul		$v0,$s0,$v0

factorialDone:
    lw      $s0, 4($sp)
    lw      $ra, 0($sp)
    addi    $sp, $sp, 8
    jr      $ra