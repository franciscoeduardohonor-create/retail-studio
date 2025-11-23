; ============================================================================
; Ejemplo 1: Operaciones con Strings
; ============================================================================

section .data
    str1 db 'Hola Mundo', 0
    str2 db 'Assembly', 0
    newline db 10

section .bss
    buffer resb 100
    len_result resq 1

section .text
    global _start

; ============================================================================
; FUNCIÓN: strlen - Calcular longitud de string
; Entrada: RDI = puntero al string
; Salida: RAX = longitud (sin contar null terminator)
; ============================================================================
strlen:
    push rdi
    xor rax, rax                ; Contador = 0
strlen_loop:
    cmp byte [rdi], 0           ; ¿Fin del string?
    je strlen_fin
    inc rax                     ; Incrementar contador
    inc rdi                     ; Siguiente carácter
    jmp strlen_loop
strlen_fin:
    pop rdi
    ret

; ============================================================================
; FUNCIÓN: strcpy - Copiar string
; Entrada: RDI = destino, RSI = origen
; ============================================================================
strcpy:
    push rdi
    push rsi
strcpy_loop:
    lodsb                       ; AL = *RSI++
    stosb                       ; *RDI++ = AL
    test al, al                 ; ¿Es null?
    jnz strcpy_loop
    pop rsi
    pop rdi
    ret

; ============================================================================
; FUNCIÓN: strcmp - Comparar strings
; Entrada: RDI = string1, RSI = string2
; Salida: RAX = 0 si iguales, != 0 si diferentes
; ============================================================================
strcmp:
    push rdi
    push rsi
strcmp_loop:
    mov al, [rdi]
    mov bl, [rsi]
    cmp al, bl
    jne strcmp_diff
    test al, al                 ; ¿Fin de string?
    jz strcmp_equal
    inc rdi
    inc rsi
    jmp strcmp_loop
strcmp_equal:
    xor rax, rax
    jmp strcmp_fin
strcmp_diff:
    mov rax, 1
strcmp_fin:
    pop rsi
    pop rdi
    ret

; ============================================================================
; FUNCIÓN: strcat - Concatenar strings
; Entrada: RDI = destino, RSI = origen
; ============================================================================
strcat:
    push rdi
    push rsi

    ; Ir al final del destino
strcat_find_end:
    cmp byte [rdi], 0
    je strcat_copy
    inc rdi
    jmp strcat_find_end

    ; Copiar origen
strcat_copy:
    lodsb
    stosb
    test al, al
    jnz strcat_copy

    pop rsi
    pop rdi
    ret

; ============================================================================
; PROGRAMA PRINCIPAL
; ============================================================================
_start:
    ; ========== TEST 1: strlen ==========
    lea rdi, [str1]
    call strlen
    mov [len_result], rax       ; Longitud de "Hola Mundo" = 10

    ; ========== TEST 2: strcpy ==========
    lea rdi, [buffer]
    lea rsi, [str1]
    call strcpy                 ; buffer = "Hola Mundo"

    ; ========== TEST 3: strcmp ==========
    lea rdi, [str1]
    lea rsi, [buffer]
    call strcmp                 ; Debe dar 0 (son iguales)

    ; ========== TEST 4: strcat ==========
    ; Concatenar str2 al final de buffer
    lea rdi, [buffer]
    lea rsi, [str2]
    call strcat                 ; buffer = "Hola MundoAssembly"

    ; ========== IMPRIMIR RESULTADO ==========
    ; Calcular longitud del buffer
    lea rdi, [buffer]
    call strlen
    mov rdx, rax                ; Longitud

    ; Imprimir
    mov rax, 1
    mov rdi, 1
    lea rsi, [buffer]
    syscall

    ; Nueva línea
    mov rax, 1
    mov rdi, 1
    lea rsi, [newline]
    mov rdx, 1
    syscall

    ; Salir
    mov rax, 60
    xor rdi, rdi
    syscall
