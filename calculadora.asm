section .data
    menu_msg db 10, "---------------------------", 10
               db "  C A L C U L A D O R A  ", 10
               db "---------------------------", 10
               db "Escolha a operação ", 10
               db "1 - SOMA", 10
               db "2 - SUBTRAÇÃO", 10
               db "3 - MULTIPLICAÇÃO", 10
               db "4 - DIVISÃO", 10
               db "5 - SAIR", 10
               db "---------------------------", 10
               db "Opcao: ", 0
    num1_msg db "Digite o primeiro numero: ", 0
    num2_msg db "Digite o segundo numero: ", 0
    result_msg db "Resultado: ", 0
    division_by_zero_msg db "Divisao ilegal por zero", 10, 0
    newline db 10, 0
    ten dq 10  ; Constante usada para divisão por 10
    clear_screen db 27, "[2J", 27, "[H", 0  ; Sequência ANSI para limpar a tela

section .bss
    opt resb 2
    num1 resb 16
    num2 resb 16
    result_str resb 16

section .text
global _start

print_string:
    push rsi
    xor rdx, rdx

.loop:
    mov al, [rsi + rdx]
    test al, al
    jz .done
    inc rdx
    jmp .loop

.done:
    mov rax, 1
    mov rdi, 1
    pop rsi
    syscall
    ret

read_string:
    mov rax, 0
    mov rdi, 0
    mov rdx, 16
    syscall
    ret

str_to_int:
    xor rax, rax
    xor rcx, rcx

.loop:
    movzx rdx, byte [rsi + rcx]
    test rdx, rdx
    jz .done
    cmp rdx, 10
    je .done
    sub rdx, '0'
    imul rax, rax, 10
    add rax, rdx
    inc rcx
    jmp .loop

.done:
    ret

int_to_str:
    mov rsi, result_str
    add rsi, 15
    mov byte [rsi], 0
    dec rsi
    test rax, rax
    jnz .loop
    mov byte [rsi], '0'
    ret

.loop:
    xor rdx, rdx
    div qword [ten]
    add dl, '0'
    mov [rsi], dl
    dec rsi
    test rax, rax
    jnz .loop
    inc rsi
    ret

exit:
    mov rsi, clear_screen
    call print_string
    mov rax, 60
    syscall
    ret

_start:
    ; Exibe o menu inicial
    mov rsi, menu_msg
    call print_string
    mov rsi, opt
    call read_string
    mov al, byte [opt]
    cmp al, '1'
    je soma
    cmp al, '2'
    je subtracao
    cmp al, '3'
    je multiplicacao
    cmp al, '4'
    je divisao
    cmp al, '5'
    je exit_program
    jmp _start

ler_numeros:
    ; Limpa os buffers num1 e num2 antes de ler os novos números
    mov rdi, num1
    mov rbx, 16
.clear_num1:
    mov byte [rdi], 0
    inc rdi
    dec rbx
    jnz .clear_num1

    mov rdi, num2
    mov rbx, 16
.clear_num2:
    mov byte [rdi], 0
    inc rdi
    dec rbx
    jnz .clear_num2

    mov rsi, num1_msg
    call print_string
    mov rsi, num1
    call read_string
    mov rsi, num1
    call str_to_int
    mov rbx, rax

    mov rsi, num2_msg
    call print_string
    mov rsi, num2
    call read_string
    mov rsi, num2
    call str_to_int
    mov rcx, rax
    ret

soma:
    call ler_numeros
    add rbx, rcx
    jmp resultado

subtracao:
    call ler_numeros
    sub rbx, rcx
    jmp resultado

multiplicacao:
    call ler_numeros
    imul rbx, rcx
    jmp resultado

divisao:
    call ler_numeros
    cmp rcx, 0          ; Compara o divisor com 0
    je divisao_erro     ; Se for zero, pula para a mensagem de erro
    xor rdx, rdx        ; Zera rdx para evitar erros
    div rcx             ; Divide rax por rcx
    jmp resultado       ; Vai direto para a exibição do resultado

divisao_erro:
    ; Exibe a mensagem de erro de divisão por zero
    mov rsi, division_by_zero_msg
    call print_string
    jmp _start  ; Volta para o menu após erro

resultado:
    mov rsi, result_msg
    call print_string
    mov rax, rbx
    call int_to_str
    call print_string
    mov rsi, newline
    call print_string
    ; Pergunta se deseja voltar ao menu ou sair
    mov rsi, menu_msg
    call print_string
    mov rsi, opt
    call read_string
    mov al, byte [opt]
    cmp al, '5'         ; Opção de sair
    je exit_program
    cmp al, '1'         ; Se for qualquer outra opção, volta ao menu
    je _start
    cmp al, '2'
    je _start
    cmp al, '3'
    je _start
    cmp al, '4'
    je _start
    jmp _start

exit_program:
    mov rsi, clear_screen
    call print_string
    mov rax, 60
    syscall
    ret
