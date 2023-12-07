.data
v: .word 0:6     # Inicialize um array de 6 elementos com zeros

.text
.globl main
main:
    # Inicialize registradores
    li $s0, 0x10010020  # $s0 cont�m o endere�o base da matriz v
    li $s1, 0          # $s1 cont�m o �ndice i (inicialmente 0)

    # v[i] = 1;
    li $t1, 1           # $t1 cont�m o valor 1
    sll $t0, $s1, 2    # Multiplique i por 4 (shift left de 2 bits)
    add $t0, $t0, $s0  # Adicione o endere�o base
    sw $t1, ($t0)
    
    # i = i + 1;
    addi $s1, $s1, 1

    # v[i] = 3;
    li $t1, 3           # $t1 cont�m o valor 3
    sll $t0, $s1, 2    # Multiplique i por 4 (shift left de 2 bits)
    add $t0, $t0, $s0  # Adicione o endere�o base
    sw $t1, ($t0)
    
    # i = i + 1;
    addi $s1, $s1, 1

    # v[i] = 2;
    li $t1, 2           # $t1 cont�m o valor 2
    sll $t0, $s1, 2    # Multiplique i por 4 (shift left de 2 bits)
    add $t0, $t0, $s0  # Adicione o endere�o base
    sw $t1, ($t0)

    # i = i + 1;
    addi $s1, $s1, 1

    # v[i] = 1;
    li $t1, 1           # $t1 cont�m o valor 1
    sll $t0, $s1, 2    # Multiplique i por 4 (shift left de 2 bits)
    add $t0, $t0, $s0  # Adicione o endere�o base
    sw $t1, ($t0)

    # i = i + 1;
    addi $s1, $s1, 1

    # v[i] = 4;
    li $t1, 4           # $t1 cont�m o valor 4
    sll $t0, $s1, 2    # Multiplique i por 4 (shift left de 2 bits)
    add $t0, $t0, $s0  # Adicione o endere�o base
    sw $t1, ($t0)

    # i = i + 1;
    addi $s1, $s1, 1

    # v[i] = 5;
    li $t1, 5           # $t1 cont�m o valor 5
    sll $t0, $s1, 2    # Multiplique i por 4 (shift left de 2 bits)
    add $t0, $t0, $s0  # Adicione o endere�o base
    sw $t1, ($t0)

    # Fim do programa
    li $v0, 10          # C�digo de sa�da do programa
    syscall