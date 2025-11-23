; ============================================================================
; Ejemplo 1: Manipulación de Bits y Operaciones Avanzadas
; ============================================================================

section .text
    global _start

_start:
    ; ==========================================
    ; OPERACIONES LÓGICAS
    ; ==========================================

    ; AND - Enmascarar bits
    mov rax, 0b11110101     ; RAX = 245
    and rax, 0b00001111     ; Mantener solo los 4 bits bajos
                            ; RAX = 0b00000101 = 5

    ; OR - Activar bits
    mov rbx, 0b10100000
    or rbx, 0b00000101      ; Activar bits 0 y 2
                            ; RBX = 0b10100101

    ; XOR - Invertir bits
    mov rcx, 0b11110000
    xor rcx, 0b00001111     ; Invertir los 4 bits bajos
                            ; RCX = 0b11111111

    ; NOT - Complemento
    mov rdx, 0b10101010
    not rdx                 ; RDX = 0b01010101

    ; ==========================================
    ; DESPLAZAMIENTOS (SHIFTS)
    ; ==========================================

    ; SHL - Multiplicar por potencias de 2
    mov rax, 5              ; RAX = 5
    shl rax, 1              ; RAX = 10 (5 * 2)
    shl rax, 2              ; RAX = 40 (10 * 4)

    ; SHR - Dividir por potencias de 2
    mov rbx, 80             ; RBX = 80
    shr rbx, 1              ; RBX = 40 (80 / 2)
    shr rbx, 3              ; RBX = 5 (40 / 8)

    ; SAR - Shift aritmético (preserva signo)
    mov rcx, -16            ; RCX = -16
    sar rcx, 2              ; RCX = -4 (divide preservando signo)

    ; ==========================================
    ; ROTACIONES
    ; ==========================================

    mov rax, 0b10110001
    rol rax, 2              ; Rotar izquierda 2 bits
                            ; RAX = 0b11000110

    mov rbx, 0b10110001
    ror rbx, 2              ; Rotar derecha 2 bits
                            ; RBX = 0b01101100

    ; ==========================================
    ; OPERACIONES DE BITS INDIVIDUALES
    ; ==========================================

    mov r8, 0b00000000

    ; Activar bit 3
    bts r8, 3               ; R8 = 0b00001000

    ; Activar bit 7
    bts r8, 7               ; R8 = 0b10001000

    ; Desactivar bit 3
    btr r8, 3               ; R8 = 0b10000000

    ; Invertir bit 7
    btc r8, 7               ; R8 = 0b00000000

    ; ==========================================
    ; MULTIPLICACIÓN
    ; ==========================================

    ; IMUL - forma simple
    mov rax, 6
    mov rbx, 7
    imul rax, rbx           ; RAX = 42

    ; IMUL - con inmediato
    mov rcx, 5
    imul rcx, rcx, 10       ; RCX = 50

    ; MUL - sin signo (resultado en RDX:RAX)
    mov rax, 1000000000     ; 1 billón
    mov rbx, 100
    mul rbx                 ; RDX:RAX = 100 billones

    ; ==========================================
    ; DIVISIÓN
    ; ==========================================

    ; DIV - sin signo
    mov rax, 100
    xor rdx, rdx            ; RDX = 0 (parte alta)
    mov rbx, 7
    div rbx                 ; RAX = 14 (cociente)
                            ; RDX = 2 (residuo)

    ; IDIV - con signo
    mov rax, -100
    cqo                     ; Extender signo RAX → RDX:RAX
    mov rbx, 7
    idiv rbx                ; RAX = -14, RDX = -2

    ; ==========================================
    ; TRUCOS CON BITS
    ; ==========================================

    ; Verificar si es par o impar
    mov r9, 42
    test r9, 1              ; ZF=1 si es par
    jz es_par
    ; ... código si es impar ...
es_par:

    ; Verificar si es potencia de 2
    mov r10, 64
    mov r11, r10
    dec r11
    and r10, r11
    test r10, r10           ; ZF=1 si es potencia de 2
    jz es_potencia_2
es_potencia_2:

    ; Swap sin variable temporal
    mov r12, 10
    mov r13, 20
    xor r12, r13            ; r12 = 10 ^ 20
    xor r13, r12            ; r13 = 20 ^ (10 ^ 20) = 10
    xor r12, r13            ; r12 = (10 ^ 20) ^ 10 = 20
    ; Ahora: r12=20, r13=10

    ; Valor absoluto
    mov r14, -42
    mov r15, r14
    sar r15, 63             ; R15 = todos 1s si negativo, 0s si positivo
    xor r14, r15
    sub r14, r15            ; R14 = |R14|
    ; R14 = 42

    ; Contar bits activados (población count)
    mov rax, 0b10110101
    popcnt rbx, rax         ; RBX = 5 (cinco bits en 1)

    ; ==========================================
    ; EXTRAER Y EMPAQUETAR BITS
    ; ==========================================

    ; Extraer bits 4-7 de un byte
    mov al, 0b11010110
    shr al, 4               ; AL = 0b00001101
    and al, 0b00001111      ; AL = 0b00001101

    ; Empaquetar dos nibbles
    mov bl, 0b00001010      ; Nibble bajo
    mov bh, 0b00000101      ; Nibble alto
    shl bh, 4               ; BH = 0b01010000
    or bl, bh               ; BL = 0b01011010

    ; ==========================================
    ; SALIR
    ; ==========================================

    mov rax, 60
    xor rdi, rdi
    syscall

; ============================================================================
; NOTAS:
; - Los desplazamientos son muy rápidos para multiplicar/dividir por 2^n
; - Las operaciones de bits son fundamentales en criptografía
; - BT, BTS, BTR, BTC son muy útiles para manipular banderas
; - POPCNT requiere CPU moderno (SSE4.2)
; ============================================================================
