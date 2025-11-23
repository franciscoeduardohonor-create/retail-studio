; ============================================================================
; Ejemplo 2: Imprimir Múltiples Mensajes
; ============================================================================
; Este programa demuestra cómo imprimir varios mensajes diferentes.
; Aprenderás a organizar múltiples strings y a imprimirlos secuencialmente.
;
; Compilar y ejecutar:
;   nasm -f elf64 02_multiples_mensajes.asm -o 02_multiples_mensajes.o
;   ld 02_multiples_mensajes.o -o 02_multiples_mensajes
;   ./02_multiples_mensajes
; ============================================================================

section .data
    ; Definimos varios mensajes
    msg1 db '======================', 10
    len1 equ $ - msg1

    msg2 db 'Curso de Assembly x86-64', 10
    len2 equ $ - msg2

    msg3 db 'Módulo 2: Primeros Programas', 10
    len3 equ $ - msg3

    msg4 db '======================', 10
    len4 equ $ - msg4

    msg5 db 10, 'Bienvenido al curso más completo de Assembly!', 10, 10
    len5 equ $ - msg5

section .text
    global _start

_start:
    ; ============================================
    ; IMPRIMIR PRIMER MENSAJE (línea superior)
    ; ============================================
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; stdout
    mov rsi, msg1       ; mensaje 1
    mov rdx, len1       ; longitud 1
    syscall

    ; ============================================
    ; IMPRIMIR SEGUNDO MENSAJE (título)
    ; ============================================
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; stdout
    mov rsi, msg2       ; mensaje 2
    mov rdx, len2       ; longitud 2
    syscall

    ; ============================================
    ; IMPRIMIR TERCER MENSAJE (subtítulo)
    ; ============================================
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; stdout
    mov rsi, msg3       ; mensaje 3
    mov rdx, len3       ; longitud 3
    syscall

    ; ============================================
    ; IMPRIMIR CUARTO MENSAJE (línea inferior)
    ; ============================================
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; stdout
    mov rsi, msg4       ; mensaje 4
    mov rdx, len4       ; longitud 4
    syscall

    ; ============================================
    ; IMPRIMIR QUINTO MENSAJE (mensaje final)
    ; ============================================
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; stdout
    mov rsi, msg5       ; mensaje 5
    mov rdx, len5       ; longitud 5
    syscall

    ; ============================================
    ; SALIR
    ; ============================================
    mov rax, 60         ; syscall: exit
    xor rdi, rdi        ; código 0
    syscall

; ============================================================================
; EXPLICACIÓN:
; ============================================================================
;
; ORGANIZACIÓN DE MENSAJES:
;   - Cada mensaje está en su propia variable (msg1, msg2, etc.)
;   - Cada uno tiene su propia longitud calculada automáticamente
;   - Esto hace el código más organizado y fácil de mantener
;
; IMPRIMIR MÚLTIPLES MENSAJES:
;   - Para cada mensaje, repetimos el patrón de write
;   - Podríamos optimizar esto con un loop (lo veremos más adelante)
;   - Por ahora, la repetición nos ayuda a aprender la mecánica
;
; CARACTERES ESPECIALES:
;   - 10 = '\n' (nueva línea)
;   - Podemos poner múltiples '\n' para líneas en blanco
;   - msg5 empieza con 10 para añadir una línea en blanco antes
;
; MEJORAS POSIBLES:
;   - Usar macros para simplificar el código repetitivo (módulo avanzado)
;   - Usar loops para imprimir arrays de mensajes (módulo 4)
;   - Crear una función de impresión reutilizable (módulo 5)
;
; ============================================================================
; EXPERIMENTOS:
; ============================================================================
;
; 1. Añade tu propio mensaje:
;    msg6 db 'Mi mensaje personalizado', 10
;    len6 equ $ - msg6
;    (Y añade el código para imprimirlo)
;
; 2. Crea un menú:
;    '1. Opción 1', 10
;    '2. Opción 2', 10
;    etc.
;
; 3. Usa tabulaciones (9 = '\t'):
;    msg db 'Nombre', 9, 'Apellido', 9, 'Edad', 10
;
; 4. Crea arte ASCII:
;    msg db '  *  ', 10
;         db ' *** ', 10
;         db '*****', 10
;
; ============================================================================
