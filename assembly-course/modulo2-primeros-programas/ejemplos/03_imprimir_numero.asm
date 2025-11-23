; ============================================================================
; Ejemplo 3: Imprimir un Número (Un Solo Dígito)
; ============================================================================
; Este programa muestra cómo convertir un número a ASCII y mostrarlo.
; Funciona con números de un solo dígito (0-9).
;
; Compilar y ejecutar:
;   nasm -f elf64 03_imprimir_numero.asm -o 03_imprimir_numero.o
;   ld 03_imprimir_numero.o -o 03_imprimir_numero
;   ./03_imprimir_numero
; ============================================================================

section .data
    msg db 'El resultado es: '
    len_msg equ $ - msg

    newline db 10       ; Nueva línea

section .bss
    ; Reservamos espacio para el dígito convertido a ASCII
    digito resb 1       ; 1 byte para almacenar el carácter

section .text
    global _start

_start:
    ; ============================================
    ; REALIZAR UN CÁLCULO
    ; ============================================
    ; Vamos a calcular: 3 + 4 = 7

    mov al, 3           ; AL = 3
    add al, 4           ; AL = 3 + 4 = 7

    ; Ahora AL contiene 7 (el número, no el carácter)

    ; ============================================
    ; CONVERTIR NÚMERO A ASCII
    ; ============================================
    ; Para imprimir un número, necesitamos convertirlo a ASCII
    ; Tabla ASCII:
    ;   '0' = 48
    ;   '1' = 49
    ;   '2' = 50
    ;   ...
    ;   '9' = 57
    ;
    ; Patrón: Para obtener el carácter ASCII de un dígito,
    ;         sumamos el valor ASCII de '0' (48)

    add al, '0'         ; AL = 7 + 48 = 55
                        ; 55 es el código ASCII del carácter '7'

    ; Guardamos el carácter en memoria
    mov [digito], al    ; digito ahora contiene el carácter '7'

    ; ============================================
    ; IMPRIMIR MENSAJE
    ; ============================================
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; stdout
    mov rsi, msg        ; "El resultado es: "
    mov rdx, len_msg
    syscall

    ; ============================================
    ; IMPRIMIR EL DÍGITO
    ; ============================================
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; stdout
    mov rsi, digito     ; dirección del dígito
    mov rdx, 1          ; imprimir 1 byte
    syscall

    ; ============================================
    ; IMPRIMIR NUEVA LÍNEA
    ; ============================================
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; stdout
    mov rsi, newline    ; '\n'
    mov rdx, 1          ; 1 byte
    syscall

    ; ============================================
    ; SALIR
    ; ============================================
    mov rax, 60         ; syscall: exit
    xor rdi, rdi        ; código 0
    syscall

; ============================================================================
; EXPLICACIÓN DETALLADA:
; ============================================================================
;
; CONVERSIÓN NÚMERO → ASCII:
;   - Los números en la computadora son valores binarios
;   - Los caracteres también son valores binarios (códigos ASCII)
;   - Para imprimir un número, debemos convertirlo a su carácter ASCII
;
; TABLA ASCII DE DÍGITOS:
;   Dígito | Valor | ASCII | Fórmula
;   -------|-------|-------|--------
;     0    |   0   |  48   | 0 + 48
;     1    |   1   |  49   | 1 + 48
;     2    |   2   |  50   | 2 + 48
;     ...
;     9    |   9   |  57   | 9 + 48
;
;   Patrón: ASCII = Número + 48
;   O bien: ASCII = Número + '0' (porque '0' = 48)
;
; SECCIÓN .bss:
;   - Usamos .bss para reservar espacio temporal
;   - 'digito resb 1' reserva 1 byte sin inicializar
;   - Es más eficiente que poner la variable en .data
;
; PROCESO:
;   1. Calcular el número (en nuestro caso: 3 + 4 = 7)
;   2. Convertir a ASCII (7 + 48 = 55 = '7')
;   3. Guardar en memoria
;   4. Imprimir usando write
;
; LIMITACIÓN:
;   - Este método solo funciona con un dígito (0-9)
;   - Para números mayores, necesitamos un algoritmo más complejo
;   - Lo veremos en módulos posteriores
;
; ============================================================================
; EXPERIMENTOS:
; ============================================================================
;
; 1. Cambia el cálculo:
;    mov al, 5
;    add al, 2
;    (Debería imprimir 7)
;
; 2. Prueba con otros números:
;    mov al, 8
;    (Sin add)
;    (Debería imprimir 8)
;
; 3. Imprime múltiples dígitos:
;    Calcula 3 + 2 = 5
;    Luego calcula 4 + 4 = 8
;    Imprime ambos: "58"
;
; 4. ¿Qué pasa si el resultado es > 9?
;    mov al, 5
;    add al, 7   ; = 12
;    add al, '0' ; = 12 + 48 = 60 = ASCII de '<'
;    (No imprimirá un número válido - por eso necesitamos
;     algoritmos más complejos para números de varios dígitos)
;
; ============================================================================
