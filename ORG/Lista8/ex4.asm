.data
	n1:	.word 0
	n2:	.word 0
	resultado:	.word 0
	prompt_n1:	.asciiz	"Digite o valor do primeiro numero: "
	prompt_n2:	.asciiz	"Digite o valor do segundo numero: "	
	result_prompt:	.asciiz	"O resultado da soma e: "
.text
.globl main
main:
	la	$s0,n1
	la	$s1,n2
	la	$s2,result_prompt
	la	$s3,resultado

	jal soma

	sw	$v0,($s3)
	# Imprime a mensagem do resultado
	li	$v0, 4
	la	$a0,($s2)
	syscall
	# Imprime o resultado
	lw	$a0, ($s3)
	li	$v0, 1
	syscall

	j	end


leitura:
	#Fun??o leitura()
	li	$v0,4
	la	$a0, prompt_n1
	syscall
	
	li	$v0,5
	syscall
	move	$t0,$v0

	li	$v0,4
	la	$a0, prompt_n2
	syscall

	li	$v0,5
	syscall
	move	$t1,$v0

	jr	$ra



soma:
	# Fun??o soma(n1, n2)
	# Salva o registrador de endereço de retorno na pilha
	addi	$sp,$sp,-4
	sw	$ra,0($sp)

	#Chama a função leitura
	jal leitura

	#Carrega o valor de $ra da pilha
	lw	$ra,0($sp)
	add	$sp,$sp,4

	add	$t2,$t0,$t1

	#Retorna o resultado em $t2
	move	$v0,$t2
	jr $ra


end:
	#Termina o programa
	li	$v0,10
	syscall