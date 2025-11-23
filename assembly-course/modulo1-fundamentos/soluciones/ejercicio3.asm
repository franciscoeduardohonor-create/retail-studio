; Solución Ejercicio 3: Operaciones Múltiples
; Objetivo: Calcular (10 + 5) - 3 = 12

section .text
    global _start

_start:
    mov rax, 10         ; RAX = 10
    add rax, 5          ; RAX = 10 + 5 = 15
    sub rax, 3          ; RAX = 15 - 3 = 12

    mov rdi, rax        ; RDI = 12 (código de salida)
    mov rax, 60         ; syscall: exit
    syscall
