; ============================================================================
; Ejemplo 2: Trabajando con Registros
; ============================================================================
; Este programa demuestra cómo usar los registros del procesador.
; Los registros son como variables super rápidas dentro del CPU.
;
; Compilar y ejecutar:
;   nasm -f elf64 02_registros.asm -o 02_registros.o
;   ld 02_registros.o -o 02_registros
;   ./02_registros
;   echo $?  # Verás el resultado: 15
; ============================================================================

section .text
    global _start

_start:
    ; ============================================
    ; OPERACIONES CON REGISTROS
    ; ============================================

    ; Vamos a hacer una operación simple: (5 + 3) + 7 = 15

    ; 1. Cargar el valor 5 en el registro RAX
    mov rax, 5          ; RAX = 5
                        ; El registro RAX ahora contiene el número 5

    ; 2. Sumar 3 a RAX
    add rax, 3          ; RAX = RAX + 3 = 5 + 3 = 8
                        ; ADD suma el segundo operando al primero
                        ; El resultado se guarda en el primer operando (RAX)

    ; 3. Sumar 7 a RAX
    add rax, 7          ; RAX = RAX + 7 = 8 + 7 = 15

    ; Ahora RAX contiene 15

    ; ============================================
    ; USANDO OTROS REGISTROS
    ; ============================================

    ; Vamos a mover el resultado a otro registro
    mov rbx, rax        ; RBX = RAX = 15
                        ; Copiamos el contenido de RAX a RBX
                        ; Ahora ambos registros contienen 15

    ; Operación con RBX
    sub rbx, 10         ; RBX = RBX - 10 = 15 - 10 = 5
                        ; SUB resta el segundo operando del primero

    ; Ahora:
    ; RAX = 15
    ; RBX = 5

    ; ============================================
    ; DEMOSTRANDO DIFERENTES TAMAÑOS DE REGISTROS
    ; ============================================

    ; Recordatorio de tamaños:
    ; RAX = 64 bits (8 bytes)
    ; EAX = 32 bits inferiores de RAX
    ; AX  = 16 bits inferiores de RAX
    ; AL  = 8 bits inferiores de AX
    ; AH  = 8 bits superiores de AX

    mov rax, 0          ; Limpiar RAX (ponerlo en 0)

    mov al, 100         ; AL (8 bits inferiores) = 100
                        ; Solo modificamos 1 byte de RAX

    mov ah, 50          ; AH (segundo byte) = 50
                        ; Ahora AX = 0x3264 en hex

    ; ============================================
    ; OPERACIONES DE INCREMENTO Y DECREMENTO
    ; ============================================

    mov rcx, 10         ; RCX = 10
                        ; RCX se usa típicamente como contador

    inc rcx             ; RCX = RCX + 1 = 11
                        ; INC incrementa en 1 (más eficiente que ADD)

    dec rcx             ; RCX = RCX - 1 = 10
                        ; DEC decrementa en 1 (más eficiente que SUB)

    inc rcx             ; RCX = 11
    inc rcx             ; RCX = 12
    inc rcx             ; RCX = 13

    ; ============================================
    ; OPERACIÓN XOR (TRUCO COMÚN)
    ; ============================================

    ; XOR de un registro consigo mismo siempre da 0
    ; Es la forma más eficiente de poner un registro en 0

    mov rdx, 999        ; RDX = 999

    xor rdx, rdx        ; RDX XOR RDX = 0
                        ; Esto es más rápido que: mov rdx, 0
                        ; XOR compara bit a bit: 1^1=0, 0^0=0

    ; ============================================
    ; INTERCAMBIAR VALORES ENTRE REGISTROS
    ; ============================================

    mov r8, 100         ; R8 = 100
    mov r9, 200         ; R9 = 200

    ; Para intercambiar, necesitamos un registro temporal
    mov r10, r8         ; R10 = 100 (guardamos R8)
    mov r8, r9          ; R8 = 200
    mov r9, r10         ; R9 = 100
    ; Ahora están intercambiados: R8=200, R9=100

    ; O podemos usar la instrucción XCHG (exchange)
    xchg r8, r9         ; Intercambia R8 y R9
    ; Ahora: R8=100, R9=200 (volvieron a su valor original)

    ; ============================================
    ; COPIAR ENTRE MÚLTIPLES REGISTROS
    ; ============================================

    mov rsi, 777        ; RSI = 777
    mov rdi, rsi        ; RDI = 777
    mov r11, rsi        ; R11 = 777
    ; Ahora RSI, RDI y R11 todos tienen el valor 777

    ; ============================================
    ; SALIR DEL PROGRAMA
    ; ============================================

    ; Usamos el valor de RCX (que es 13) como código de salida
    mov rax, 60         ; syscall: exit
    mov rdi, rcx        ; código de salida = RCX = 13
    syscall

; ============================================================================
; EXPLICACIÓN DE REGISTROS:
; ============================================================================
;
; REGISTROS DE PROPÓSITO GENERAL (puedes usarlos para lo que quieras):
;   RAX - Acumulador (típicamente para resultados)
;   RBX - Base
;   RCX - Contador (para loops)
;   RDX - Datos
;   RSI - Source Index (índice origen)
;   RDI - Destination Index (índice destino)
;   R8-R15 - Registros adicionales en x86-64
;
; REGISTROS ESPECIALES:
;   RSP - Stack Pointer (puntero al stack)
;   RBP - Base Pointer (base del stack frame)
;   RIP - Instruction Pointer (próxima instrucción)
;
; INSTRUCCIONES VISTAS:
;   MOV  - Copiar datos
;   ADD  - Sumar
;   SUB  - Restar
;   INC  - Incrementar en 1
;   DEC  - Decrementar en 1
;   XOR  - OR exclusivo (bit a bit)
;   XCHG - Intercambiar valores
;
; ============================================================================
; EJERCICIO:
; ============================================================================
; Modifica este programa para calcular: (10 + 20) - (3 * 2)
; Pista: No hay instrucción de multiplicación directa simple,
;        pero puedes sumar el número a sí mismo.
; Respuesta esperada: 30 - 6 = 24
; ============================================================================
