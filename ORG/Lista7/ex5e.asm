.data
	A:	.word 0
	B:	.word 0
	prompt_a:	.asciiz "Digite o valor de a: "
	prompt_b:	.asciiz "Digite o valor de b: "
	greater_message:	.asciiz "a >= b"
	not_greater_message:	.asciiz "a < b"

.text
.globl main
main:
	la	$s0, A
	la	$s1, B
	
	# Solicita o valor de A
	li	$v0,4		# pede o valor de A
	la	$a0,prompt_a
	syscall
	
	# Le o valor de A do teclado
	li	$v0, 5
	syscall
	sw	$v0, ($s0)
	
	# Solicita o valor de B
	li	$v0,4		# pede o valor de B
	la	$a0,prompt_b
	syscall
	
	# Le o valor de B do teclado
	li	$v0, 5
	syscall
	sw	$v0, ($s1)
	
	# Compara a e b
	lw $t0, ($s0)
	lw $t1, ($s1)
	blt $t0,$t1,not_greater	# if (a<b)
	
	# Se nã0
	j greater

greater:
	# Chama a mensgagem que a >= b
	li 	$v0,4
	la 	$a0, greater_message
	syscall
	addi	$t1,$t1,1	# incrementa b
	sw	$t1,($s1)
	j end
	

not_greater:
	# Chama a mensgagem que a < b
	li 	$v0,4
	la 	$a0, not_greater_message
	syscall
	addi	$t0,$t0,1	# Incrementa a
	sw	$t0, ($s0)
	j end

end: 
	# Acaba programa
	li	$v0,10
	syscall	
	