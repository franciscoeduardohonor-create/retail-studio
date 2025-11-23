; Solución Ejercicio 9: Array Simple
; Objetivo: Sumar elementos de un array [5, 10, 15] = 30

section .data
    array db 5, 10, 15      ; Array de 3 bytes

section .text
    global _start

_start:
    xor rax, rax            ; RAX = 0 (acumulador)

    mov bl, [array]         ; BL = array[0] = 5
    add al, bl              ; AL = 0 + 5 = 5

    mov bl, [array + 1]     ; BL = array[1] = 10
    add al, bl              ; AL = 5 + 10 = 15

    mov bl, [array + 2]     ; BL = array[2] = 15
    add al, bl              ; AL = 15 + 15 = 30

    mov rdi, rax            ; RDI = 30 (código de salida)
    mov rax, 60             ; syscall: exit
    syscall
