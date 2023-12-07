.data
	A:	.word 10
	B:	.word 15
	C:	.word 20
	D:	.word 25
	E:	.word 30
	F:	.word 35
	G:	.word 0:4
	H:	.word 0:4
	
.text
main:
	# Carregar os valores das variáveis da memória de dados para registradores
	lw	$s0, A
	lw	$s1, B
	lw	$s2, C
	lw	$s3, D
	lw	$s4, E
	lw	$s5, F
	la	$s6, G
	la	$s7, H
	
	# a) G[0] = (A - (B + C) + F);
	add	$t0, $s1, $s2 	# $t0 = B + C
	sub	$t0, $s0, $t0 	# $t0 = A - (B + C)
	add	$t0, $t0, $s5 	# $t0 = (A - (B + C) + F)
	sw	$t0, ($s6)	# G[0] = $t0
	
	# b) G[1] = E - (A - B) * (B - C);
	sub	$t1,$s0,$s1	# $t1 = A - B
	sub	$t2,$s1,$s2	# $t1 = B - C
	mult	$t1,$t2		# (A - B) * (B - C)
	mflo	$t1		# $t1 = (A - B) * (B - C)
	sub	$t1,$s4,$t1	# $t1 = E - (A - B) * (B - C)
	sw	$t1, 4($s6)	# G[1] = $t1
	
	# c) G[2] = G[1] - C;
	lw	$t0,4($s6)	# $t0 = G[1]
	sub	$t0,$t0,$s2	# $t0 = G[1] - C
	sw	$t0,8($s6)	# G[2] = $t0
	
	# d) G[3] = G[2] + G[0];
	lw	$t0, ($s6)	# $t0 = G[0]
	lw	$t1, 8($s6)	# $t1 = G[2]
	add	$t0,$t1,$t0	# $t0 = G[2] + G[0]
	sw	$t0, 12($s6)	# G[3] = $t0	
	
	# e) H[0] = B - C;
	sub	$t0,$s1,$s2	# $t0 = B - C
	sw	$t0,($s7)	# H[0] = $t0
	
	# f) H[1] = A + C;
	add	$t0,$s0,$s2	# $t0 = A + C
	sw	$t0, 4($s7)	# H[1] = St0
	
	# g) H[2] = B - C + G[3]
	lw	$t0,12($s6)	# $t0 = G[3]
	sub	$t1,$s1,$s2	# $t1 = B - C
	add	$t0,$t1,$t0	# $t0 = B - C + G[3]
	sw	$t0,8($s7)	# H[2] = B - C + G[3]
	
	# h) H[3] = B - G[0] + D;
	lw	$t0, ($s6)	# $t0 = G[0]
	sub	$t0,$s1,$t0	# $t0 = B - G[0]
	add	$t0,$t0,$s3	# $t0 = B - G[0] + D
	sw	$t0,12($s7)	# H[3] = $t0
	