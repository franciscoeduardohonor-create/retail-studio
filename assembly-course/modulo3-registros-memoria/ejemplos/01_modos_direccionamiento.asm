; ============================================================================
; Ejemplo 1: Modos de Direccionamiento
; ============================================================================

section .data
    array dq 10, 20, 30, 40, 50     ; Array de 5 qwords
    valor dq 100

section .text
    global _start

_start:
    ; ======== MODO INMEDIATO ========
    mov rax, 42                     ; RAX = 42 (valor directo)

    ; ======== MODO REGISTRO ========
    mov rbx, rax                    ; RBX = RAX = 42

    ; ======== MODO DIRECTO ========
    mov rcx, [valor]                ; RCX = 100 (valor en 'valor')

    ; ======== MODO INDIRECTO POR REGISTRO ========
    lea rdx, [valor]                ; RDX = dirección de 'valor'
    mov r8, [rdx]                   ; R8 = 100 (usando puntero)

    ; ======== MODO INDEXADO ========
    ; array[0] = 10
    mov rax, [array]                ; RAX = 10 (primer elemento)

    ; array[1] = 20 (cada elemento es 8 bytes)
    mov rbx, [array + 8]            ; RBX = 20 (segundo elemento)

    ; array[2] = 30
    mov rcx, [array + 16]           ; RCX = 30 (tercer elemento)

    ; ======== INDEXADO CON REGISTRO ========
    mov r9, 2                       ; Índice 2
    mov rdx, [array + r9*8]         ; RDX = array[2] = 30
                                    ; r9*8 porque cada qword son 8 bytes

    ; ======== RECORRER ARRAY CON PUNTERO ========
    lea rsi, [array]                ; RSI = dirección del array

    mov rax, [rsi]                  ; RAX = array[0] = 10
    add rsi, 8                      ; Avanzar al siguiente elemento
    mov rbx, [rsi]                  ; RBX = array[1] = 20
    add rsi, 8
    mov rcx, [rsi]                  ; RCX = array[2] = 30

    ; ======== LEA PARA CÁLCULOS ========
    mov r10, 5
    lea r11, [r10 + r10*2]          ; R11 = 5 + 5*2 = 15 (sin acceso a memoria)

    lea r12, [r10*4 + 8]            ; R12 = 5*4 + 8 = 28

    ; Salir
    mov rax, 60
    xor rdi, rdi
    syscall

; ============================================================================
; EJERCICIO: Modifica para sumar todos los elementos del array
; ============================================================================
