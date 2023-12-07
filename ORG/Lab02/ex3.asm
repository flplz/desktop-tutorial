.data
    A: .word 1 2 3 0 1 4 0 0 1
    B: .word 1 -2 5 0 1 -4 0 0 1
    Bt: .space 36   # Espa�o para a matriz Bt (9 elementos de 4 bytes cada)
    RESULT: .space 36   # Espa�o para a matriz RESULT (9 elementos de 4 bytes cada)

.text

main:
    # Configura os argumentos para a chamada do procedimento transpose_matrix
    la  $a0, B     # endere�o da matriz de origem
    la  $a1, Bt    # endere�o da matriz de destino
    li  $a2, 3     # n�mero de linhas em A e B
    li  $a3, 3     # n�mero de colunas em A e B
    move $s4, $a3  # copia o n�mero de colunas para $s4

    # Chama o procedimento transpose_matrix
    jal PROC_TRANS

    # Configura os argumentos para a chamada do procedimento matrix_multiply
    la  $a0, A     # endere�o da matriz de origem A
    la  $a1, Bt    # endere�o da matriz de origem Bt
    la  $a2, RESULT   # endere�o da matriz de resultado RESULT
    li  $a3, 3     # n�mero de linhas e colunas em A e B
    move $s4, $a3  # copia o n�mero de colunas para $s4

    # Chama o procedimento matrix_multiply
    jal PROC_MUL

    # Resto do c�digo main (se houver)

   j	end
    
# Procedure for matrix transposition
PROC_TRANS:
    # $a0 = endere�o da matriz de origem
    # $a1 = endere�o da matriz de destino
    # $a2 = n�mero de linhas da matriz
    # $a3 = n�mero de colunas da matriz

    addi    $t5, $zero, 0     # col index
    addi    $t6, $zero, 0     # Bt deslocated
    addi    $t7, $zero, 0     # Bt deslocation number

    loop_col:
        bgt     $t5, 2, end_loop_col

        # Atualiza o ponteiro B para apontar para a coluna correta
        li      $t4, 4
        mult    $t4, $t5         # index * 4
        mflo    $t4
        add     $t0, $a0, $t4    # adiciona valores de $t4 ao endere�o

        addi    $t4, $zero, 0    # contador de linhas / index_lines
        loop_lines:
            bgt     $t4, 2, end_loop_lines

            # Atualiza o ponteiro Bt para apontar para o item correto no vetor (que representa uma matriz)
            add     $t6, $a1, $t7    # desloca o endere�o de Bt
            addi    $t7, $t7, 4      # atualiza o n�mero de deslocamento

            # Calcula index_lines * 12 para chegar na posi��o correta no vetor
            li      $t3, 12
            mult    $t3, $t4
            mflo    $t3

            add     $t2, $t0, $t3    # o imediato escolhe qual item da coluna deve ser tomado, sendo 0 = primeiro; 12 = segundo; 24 = terceiro;
            lw      $t3, ($t2)
            sw      $t3, ($t6)       # salva o valor de B[i][j] em Bt[k][j]
            addi    $t4, $t4, 1      # atualiza o contador do loop de linha
            j       loop_lines
        end_loop_lines:

        addi    $t5, $t5, 1        # atualiza col_index
        j       loop_col
    end_loop_col:
    jr      $ra                    # retorna

# Fim do procedimento de transposi��o de matriz

# Procedure for matrix multiplication
PROC_MUL:
    # $a0 = endere�o da matriz de origem A
    # $a1 = endere�o da matriz de origem Bt (transposta de B)
    # $a2 = endere�o da matriz de resultado RESULT
    # $a3 = n�mero de linhas e colunas (igual para ambas as matrizes A e B)
    # $s4 = n�mero de colunas (igual para ambas as matrizes A e B)

    addi    $t1, $zero, 0      # posi��o na matriz resultante (vetor em assembly)

    addi    $t2, $zero, 0      # �ndice da linha para o loop
    loop_lines_multiplication:
        beq     $t2, $a3, end_loop_lines_multiplication  # current_line < num_of_lines

        addi $t3, $zero, 0      # �ndice da coluna para o loop
        loop_columns:
            beq     $t3, $a3, end_loop_columns

            addi    $t6, $zero, 0  # resultado
            addi    $t7, $zero, 0  # �ndice dos itens do loop

            loop_items:    # itera pelos itens de cada linha e coluna multiplicando-os como linha[i][j] * coluna[j][k]
                beq     $t7, $a3, end_loop_items

                # L�gica para multiplica��o entre linhas e colunas para cada posi��o

                ## Calcula a posi��o do in�cio da linha no vetor + �ndice do item da linha
                mult    $t2, $a3     # current_line * num_of_lines (in�cio da linha no vetor)
                mflo    $t4
                add     $t4, $t4, $t7   # adiciona o �ndice do item da linha
                                        # $t4 agora tem a posi��o no vetor para a linha

                mul     $t4, $t4, 4     # multiplica o �ndice pelo tamanho da palavra (4 bytes)

                ## Calcula a posi��o do in�cio da coluna no vetor + �ndice do item da coluna
                mul     $t5, $a3, $t7   # num_of_columns * index_of_column_item
                add     $t5, $t5, $t3   # adiciona o valor da current_column
                                        # $t5 agora tem a posi��o no vetor para a coluna

                mul     $t5, $t5, 4     # multiplica o �ndice pelo tamanho da palavra (4 bytes)

                ## Carrega os valores a serem multiplicados
                add     $t4, $a0, $t4   # vetor A + deslocamento calculado anteriormente
                lw      $t4, ($t4)      # A[i][j]

                add     $t5, $a1, $t5   # vetor Bt + deslocamento calculado anteriormente
                lw      $t5, ($t5)      # Bt[j][k]

                ## Multiplica os valores
                mul     $t4, $t4, $t5   # A[i][j] * Bt[j][k]

                add     $t6, $t6, $t4   # atualiza o resultado como resultado += mult

                #################################################
                addi    $t7, $t7, 1    # atualiza o �ndice de loop de itens
                j       loop_items
            end_loop_items:

            # Salva o resultado no vetor RESULT
            mul     $t4, $t1, 4      # �ndice atual em RESULT vetor * 4 bytes para calcular o deslocamento
            add     $t4, $a2, $t4    # calcula o endere�o + deslocamento

            sw      $t6, ($t4)       # salva o resultado em RESULT[current_result_position]

            addi    $t1, $t1, 1      # atualiza a posi��o atual do resultado

            ## Fim do loop
            addi    $t3, $t3, 1      # atualiza o �ndice da coluna
            j       loop_columns
        end_loop_columns:

        addi    $t2, $t2, 1      # atualiza o �ndice da linha
        j       loop_lines_multiplication
    end_loop_lines_multiplication:

    jr      $ra                    # retorna

# Fim do procedimento de multiplica��o de matrizes

end:
	# Termina o Programa
	li	$v0,10
	syscall
