; ============================================================================
; Ejemplo 1: Funciones, Stack y Llamadas
; ============================================================================

section .text
    global _start

; ============================================================================
; FUNCIÓN: suma(a, b) -> a + b
; Parámetros: RDI=a, RSI=b
; Retorna: RAX
; ============================================================================
suma:
    push rbp            ; Guardar RBP
    mov rbp, rsp        ; Nuevo frame

    mov rax, rdi        ; RAX = a
    add rax, rsi        ; RAX = a + b

    pop rbp             ; Restaurar RBP
    ret                 ; Retornar

; ============================================================================
; FUNCIÓN: multiplicar(a, b) -> a * b (con sumas repetidas)
; Parámetros: RDI=a, RSI=b
; Retorna: RAX
; ============================================================================
multiplicar:
    push rbp
    mov rbp, rsp
    push rbx            ; Preservar RBX

    mov rax, 0          ; Resultado = 0
    mov rbx, rsi        ; RBX = b (contador)

loop_mult:
    cmp rbx, 0
    jle fin_mult
    add rax, rdi        ; Resultado += a
    dec rbx
    jmp loop_mult
fin_mult:

    pop rbx             ; Restaurar RBX
    pop rbp
    ret

; ============================================================================
; FUNCIÓN: factorial(n)
; Parámetros: RDI=n
; Retorna: RAX
; ============================================================================
factorial:
    push rbp
    mov rbp, rsp

    cmp rdi, 1          ; ¿n <= 1?
    jle caso_base_fact

    push rdi            ; Guardar n
    dec rdi             ; n-1
    call factorial      ; factorial(n-1)
    pop rdi             ; Recuperar n
    imul rax, rdi       ; RAX = n * factorial(n-1)
    jmp fin_fact

caso_base_fact:
    mov rax, 1

fin_fact:
    pop rbp
    ret

; ============================================================================
; FUNCIÓN: maximo(a, b) -> max(a, b)
; Parámetros: RDI=a, RSI=b
; Retorna: RAX
; ============================================================================
maximo:
    push rbp
    mov rbp, rsp

    mov rax, rdi        ; Asumir que a es el mayor
    cmp rdi, rsi        ; ¿a >= b?
    jge fin_max
    mov rax, rsi        ; b es mayor

fin_max:
    pop rbp
    ret

; ============================================================================
; PROGRAMA PRINCIPAL
; ============================================================================
_start:
    ; ========== LLAMAR suma(10, 20) ==========
    mov rdi, 10
    mov rsi, 20
    call suma
    ; RAX = 30

    mov r8, rax         ; Guardar resultado en R8

    ; ========== LLAMAR multiplicar(6, 7) ==========
    mov rdi, 6
    mov rsi, 7
    call multiplicar
    ; RAX = 42

    mov r9, rax         ; Guardar resultado en R9

    ; ========== LLAMAR factorial(5) ==========
    mov rdi, 5
    call factorial
    ; RAX = 5! = 120

    mov r10, rax        ; Guardar resultado en R10

    ; ========== LLAMAR maximo(25, 42) ==========
    mov rdi, 25
    mov rsi, 42
    call maximo
    ; RAX = 42

    mov r11, rax        ; Guardar resultado en R11

    ; ========== COMPONER FUNCIONES ==========
    ; suma(multiplicar(3, 4), 10)

    ; Primero: multiplicar(3, 4)
    mov rdi, 3
    mov rsi, 4
    call multiplicar    ; RAX = 12

    ; Segundo: suma(RAX, 10)
    mov rdi, rax        ; Primer parámetro = 12
    mov rsi, 10         ; Segundo parámetro = 10
    call suma           ; RAX = 22

    mov r12, rax        ; Guardar resultado

    ; ========== SALIR ==========
    ; Resultados guardados:
    ; R8  = 30 (suma)
    ; R9  = 42 (multiplicar)
    ; R10 = 120 (factorial)
    ; R11 = 42 (maximo)
    ; R12 = 22 (composición)

    mov rax, 60
    xor rdi, rdi
    syscall

; ============================================================================
; NOTAS:
; - Las funciones siguen la convención System V AMD64
; - Los primeros 6 parámetros en: RDI, RSI, RDX, RCX, R8, R9
; - El valor de retorno siempre en RAX
; - Preservamos RBX porque lo modificamos
; - El prólogo y epílogo mantienen el stack balanceado
; ============================================================================
