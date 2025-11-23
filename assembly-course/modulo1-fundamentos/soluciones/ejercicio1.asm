; Solución Ejercicio 1: Mi Primer Programa
; Objetivo: Salir con código de salida 5

section .text
    global _start

_start:
    mov rax, 60         ; syscall: exit
    mov rdi, 5          ; código de salida = 5
    syscall
