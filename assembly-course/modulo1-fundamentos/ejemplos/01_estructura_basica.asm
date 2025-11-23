; ============================================================================
; Ejemplo 1: Estructura Básica de un Programa en Assembly
; ============================================================================
; Este es el programa más simple posible. Solo inicia y termina.
; Demuestra la estructura básica que todo programa debe tener.
;
; Para compilar y ejecutar:
;   nasm -f elf64 01_estructura_basica.asm -o 01_estructura_basica.o
;   ld 01_estructura_basica.o -o 01_estructura_basica
;   ./01_estructura_basica
;   echo $?  # Ver el código de salida
; ============================================================================

; SECCIÓN DE DATOS
; Aquí declaramos variables que tienen valores iniciales
section .data
    ; Por ahora está vacía, no necesitamos datos para este ejemplo

; SECCIÓN BSS (Block Started by Symbol)
; Aquí declaramos variables sin inicializar (solo reservamos espacio)
section .bss
    ; Por ahora está vacía

; SECCIÓN DE TEXTO (CÓDIGO)
; Aquí va el código ejecutable del programa
section .text
    global _start       ; Declaramos _start como punto de entrada global
                        ; El linker (ld) busca este símbolo para saber dónde empezar

_start:
    ; ============================================
    ; INICIO DEL PROGRAMA
    ; ============================================

    ; Para salir de un programa en Linux, usamos la syscall "exit"
    ; En x86-64 Linux, las syscalls se hacen así:
    ;   1. Poner el número de syscall en RAX
    ;   2. Poner los argumentos en RDI, RSI, RDX, R10, R8, R9 (en ese orden)
    ;   3. Ejecutar la instrucción SYSCALL

    ; La syscall "exit" es la número 60
    ; Recibe un argumento: el código de salida (en RDI)

    mov rax, 60         ; RAX = 60 (número de syscall para "exit")
                        ; MOV copia el valor del segundo operando al primero
                        ; Sintaxis: mov destino, origen

    mov rdi, 0          ; RDI = 0 (código de salida 0 significa "éxito")
                        ; En Linux, 0 = éxito, cualquier otro = error

    syscall             ; Ejecutar la syscall
                        ; El kernel toma control y termina el programa

; ============================================================================
; EXPLICACIÓN DETALLADA:
; ============================================================================
;
; 1. SECCIONES:
;    - .data:  Variables inicializadas (con valores)
;    - .bss:   Variables sin inicializar (solo espacio reservado)
;    - .text:  Código ejecutable
;
; 2. GLOBAL _start:
;    - Hace que la etiqueta _start sea visible para el linker
;    - El linker usa _start como punto de entrada del programa
;
; 3. MOV (Move):
;    - Copia datos de un lugar a otro
;    - NO mueve, sino que COPIA (el origen no se modifica)
;    - Sintaxis Intel: mov destino, origen
;
; 4. SYSCALL:
;    - Instrucción para llamar al kernel de Linux
;    - El kernel hace el trabajo (en este caso, terminar el programa)
;
; 5. REGISTROS USADOS:
;    - RAX: Contiene el número de la syscall
;    - RDI: Contiene el primer argumento de la syscall
;
; ============================================================================
; EXPERIMENTO:
; ============================================================================
; Cambia "mov rdi, 0" por "mov rdi, 42" y recompila.
; Ejecuta y luego haz: echo $?
; Verás que el código de salida es 42 en lugar de 0.
; ============================================================================
