.data
    A:       .space  400
    B:       .space  400
    N:       .word   0
    newline: .asciiz "\n"

.text
main:
    # Leitura do tamanho N dos vetores
    li   $v0, 4
    la   $a0, newline
    syscall

    li   $v0, 5
    syscall
    sw   $v0, N         # Salva N na memória

    # Carrega N para um registrador
    lw   $a1, N

    # Le os vetores A e B
    la   $a0, A
    jal  read_vector

    la   $a0, B
    jal  read_vector

    # Calcula a média de A
    la   $a0, A
    jal  calculate_average

    # Imprime a média de A
    li   $v0, 2
    mov.s $f12, $f3
    syscall

    # Calcula a média de B
    la   $a0, B
    jal  calculate_average

    # Imprime a média de B
    li   $v0, 4
    la   $a0, newline
    syscall

    li   $v0, 2
    mov.s $f12, $f3
    syscall

    # Finaliza o programa
    li   $v0, 10
    syscall

read_vector:
    move $t2, $a0
    move  $t3, $a1  # Carrega N da memória
    li   $t4, 0
    read_loop:
    	beq  $t4, $t3, end_read  # Se o contador atingir ou ultrapassar N, saia do loop
        li   $v0, 6             # Código da syscall para ler um número de ponto flutuante
        syscall
        swc1 $f0, 0($t2)        # Armazena o número lido no vetor
        addi $t2, $t2, 4        # Avança para o próximo elemento
        addi $t4, $t4, 1        # Incrementa o contador
        
        j    read_loop

    end_read:
        jr $ra
calculate_average:
    move $t2, $a0   # $t2 = endereço do vetor
    li   $t4, 0     # Inicializa o contador em $t4

    average_loop:
        lwc1 $f0, 0($t2)  # Carrega um elemento do vetor em $f0
        add.s $f3, $f3, $f0  # Adiciona o elemento à soma
        addi $t2, $t2, 4    # Avança para o próximo elemento
        addi $t4, $t4, 1    # Incrementa o contador
        bne  $t4, $a1, average_loop  # Loop até o fim do vetor

    # Divide a soma pelo valor de N
    mtc1 $a1, $f4
    cvt.s.w $f4, $f4  # Converte N para ponto flutuante
    div.s $f3, $f3, $f4  # Divide a soma pelo valor de N

    # Retorna o resultado em $f3
    jr $ra
