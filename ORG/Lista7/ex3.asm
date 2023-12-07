.data
	v:	.word 0:5
.text
main:
	la	$s0,v		# Endereço base do vetor v em $s0
	
	
	# Carregando os valores [1,3,2,1,4,5] para o registrador $t0 e depois aguardando na memória
	li	$t0,1
	sw	$t0,32($s0)
	
	li	$t0,3
	sw	$t0,36($s0)
	
	li	$t0,2
	sw	$t0,40($s0)
	
	li	$t0,1
	sw	$t0,44($s0)
	
	li	$t0,4
	sw	$t0,48($s0)
	
	li	$t0,5
	sw	$t0,52($s0)
	
	
	
	
