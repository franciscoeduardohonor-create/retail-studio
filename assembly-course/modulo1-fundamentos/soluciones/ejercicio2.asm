; Solución Ejercicio 2: Suma Simple
; Objetivo: Calcular 7 + 8 = 15

section .text
    global _start

_start:
    mov rax, 7          ; RAX = 7
    add rax, 8          ; RAX = 7 + 8 = 15

    mov rdi, rax        ; RDI = 15 (código de salida)
    mov rax, 60         ; syscall: exit
    syscall
