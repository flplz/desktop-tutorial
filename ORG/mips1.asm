.data
    MAX:        .word 4          # Defina o tamanho MAX desejado
    block_size: .word 2          # Defina o tamanho do bloco desejado
    A:          .space 0          # Espa�o para a matriz A
    B:          .space 0          # Espa�o para a matriz B

.text
main:
    # Inicialize as matrizes A e B com valores apropriados
    # (certifique-se de carregar valores para A e B antes de iniciar o c�digo principal)

    lw $t2, MAX          # Carrega o tamanho MAX
    lw $t3, block_size   # Carrega o tamanho do bloco

    # Calcula o tamanho total da matriz A e reserva espa�o
    li $t4, 4            # Tamanho de cada elemento (float = 4 bytes)
    mul $t2, $t2, $t2    # Calcula MAX * MAX
    mul $t2, $t2, $t4    # Calcula o tamanho total da matriz A
    la $t0, A            # Endere�o base de A
    li $v0, 9            # C�digo do sistema para sbrk
    syscall
    move $t2, $v0        # $t2 agora cont�m o endere�o do bloco de mem�ria alocado para A

    # Calcula o tamanho total da matriz B e reserva espa�o
    mul $t3, $t3, $t3    # Calcula block_size * block_size
    mul $t3, $t3, $t4    # Calcula o tamanho total da matriz B
    la $t1, B            # Endere�o base de B
    li $v0, 9            # C�digo do sistema para sbrk
    syscall
    move $t3, $v0        # $t3 agora cont�m o endere�o do bloco de mem�ria alocado para B

    # Seu c�digo continua aqui...

    li $t4, 0        # Inicializa o �ndice i

outer_loop_i:
    bge $t4, $t2, end_soma_com_transposta_cache_blocking  # Se i >= MAX, sai do loop externo

    li $t5, 0        # Inicializa o �ndice j

outer_loop_j:
    bge $t5, $t2, next_outer_iteration_i  # Se j >= MAX, sai do loop interno

    li $t6, 0        # Inicializa o �ndice ii

inner_loop_i:
    bge $t6, $t3, next_outer_iteration_j  # Se ii >= block_size, sai do loop interno

    li $t7, 0        # Inicializa o �ndice jj

inner_loop_j:
    bge $t7, $t3, next_inner_iteration_i  # Se jj >= block_size, sai do loop interno

    # Restante do c�digo permanece inalterado, substituindo as refer�ncias de registradores pelos argumentos:

    lw $s0, 0($t0)         # Carrega A[ii,jj]
    lw $s1, 0($t1)         # Carrega B[jj,ii]
    add $s0, $s0, $s1      # Soma A[ii,jj] e B[jj,ii]
    sw $s0, 0($t0)         # Armazena o resultado de volta em A[ii,jj]

    addi $t0, $t0, 4       # Avan�a para o pr�ximo elemento em A
    addi $t1, $t1, 4       # Avan�a para o pr�ximo elemento em B

    addi $t7, $t7, 1       # Incrementa jj
    j inner_loop_j

next_inner_iteration_i:
    addi $t6, $t6, 1       # Incrementa ii
    j inner_loop_i

next_outer_iteration_j:
    addi $t5, $t5, 1     # Avan�a para o pr�ximo bloco em j
    j outer_loop_j

next_outer_iteration_i:
    addi $t4, $t4, 1     # Avan�a para o pr�ximo bloco em i
    j outer_loop_i

end_soma_com_transposta_cache_blocking:
    # Seu c�digo continua aqui...
