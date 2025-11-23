; ============================================================================
; Ejemplo 1: Macros y Técnicas de Optimización
; ============================================================================

; ==========================================
; DEFINICIÓN DE MACROS
; ==========================================

; Macro simple: imprimir mensaje
%macro print 2
    mov rax, 1
    mov rdi, 1
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

; Macro: guardar todos los registros
%macro push_all 0
    push rax
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
    push r8
    push r9
%endmacro

; Macro: restaurar todos los registros
%macro pop_all 0
    pop r9
    pop r8
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rax
%endmacro

; Macro: if condicional
%macro if_equal 3       ; if_equal registro, valor, etiqueta
    cmp %1, %2
    je %3
%endmacro

; Macro: división segura (evita división por 0)
%macro safe_div 2
    cmp %2, 0
    je %%skip
    mov rax, %1
    xor rdx, rdx
    div %2
    jmp %%done
%%skip:
    xor rax, rax        ; Retornar 0 si divisor es 0
%%done:
%endmacro

; Macro: loop desenrollado (sum unroll)
%macro sum_unroll 2     ; array, size
    xor rax, rax
    mov rcx, %2
    shr rcx, 2          ; Dividir por 4
    mov rsi, %1
%%loop:
    add rax, [rsi]
    add rax, [rsi+8]
    add rax, [rsi+16]
    add rax, [rsi+24]
    add rsi, 32
    loop %%loop
%endmacro

; ==========================================
; CONSTANTES Y CONFIGURACIÓN
; ==========================================

%define BUFFER_SIZE 256
%define DEBUG 0

section .data
    msg1 db 'Ejemplo de macros', 10
    len1 equ $ - msg1

    msg2 db 'Optimizacion avanzada', 10
    len2 equ $ - msg2

    array dq 10, 20, 30, 40, 50, 60, 70, 80

%if DEBUG
    debug_msg db '[DEBUG] Modo debug activo', 10
    debug_len equ $ - debug_msg
%endif

section .bss
    buffer resb BUFFER_SIZE

section .text
    global _start

_start:
    ; ==========================================
    ; USO DE MACROS
    ; ==========================================

    ; Imprimir usando macro
    print msg1, len1

    ; If condicional con macro
    mov rax, 10
    if_equal rax, 10, valor_correcto
    ; ... código si no es igual ...
    jmp continuar
valor_correcto:
    print msg2, len2
continuar:

    ; División segura con macro
    safe_div 100, 0     ; División por 0, retorna 0 en RAX
    safe_div 100, 4     ; RAX = 25

%if DEBUG
    print debug_msg, debug_len
%endif

    ; ==========================================
    ; OPTIMIZACIÓN 1: LEA vs ADD/MUL
    ; ==========================================

    ; ❌ Forma lenta (múltiples instrucciones)
    mov rax, 10
    mov rbx, rax
    add rbx, rax
    add rbx, rax        ; RBX = 3 * RAX

    ; ✅ Forma rápida (una instrucción)
    lea rbx, [rax + rax*2]  ; RBX = RAX * 3

    ; Otro ejemplo:
    ; ❌ Lento
    mov rcx, rax
    shl rcx, 2
    add rcx, 10

    ; ✅ Rápido
    lea rcx, [rax*4 + 10]

    ; ==========================================
    ; OPTIMIZACIÓN 2: XOR para poner a 0
    ; ==========================================

    ; ❌ Lento (más bytes)
    mov rdx, 0

    ; ✅ Rápido (menos bytes, más eficiente)
    xor rdx, rdx

    ; ==========================================
    ; OPTIMIZACIÓN 3: Loop Unrolling
    ; ==========================================

    ; ❌ Loop normal
    xor r8, r8
    mov rcx, 8
    lea rsi, [array]
normal_loop:
    add r8, [rsi]
    add rsi, 8
    loop normal_loop
    ; R8 = suma de elementos

    ; ✅ Loop desenrollado (más rápido)
    xor r9, r9
    lea rsi, [array]
    add r9, [rsi]
    add r9, [rsi+8]
    add r9, [rsi+16]
    add r9, [rsi+24]
    add r9, [rsi+32]
    add r9, [rsi+40]
    add r9, [rsi+48]
    add r9, [rsi+56]
    ; R9 = suma de elementos (mismo resultado, más rápido)

    ; ==========================================
    ; OPTIMIZACIÓN 4: Evitar branch misprediction
    ; ==========================================

    ; ❌ Con branch
    mov r10, 10
    mov r11, 20
    cmp r10, r11
    jl r10_menor
    mov rax, r11
    jmp continuar2
r10_menor:
    mov rax, r10
continuar2:

    ; ✅ Sin branch (conditional move)
    mov rax, r11        ; Asumir r11 es mayor
    cmp r10, r11
    cmovl rax, r10      ; Si r10 < r11, entonces rax = r10
    ; RAX ahora tiene el menor

    ; ==========================================
    ; OPTIMIZACIÓN 5: Alineación de datos
    ; ==========================================

section .data
    align 16                    ; Alinear a 16 bytes
    aligned_array dq 1, 2, 3, 4 ; Mejor rendimiento para SIMD

section .text
    ; Acceso alineado es más rápido

    ; ==========================================
    ; OPTIMIZACIÓN 6: Predecir el branch común
    ; ==========================================

    mov rbx, 100
loop_with_unlikely_exit:
    ; Hacer algo...
    dec rbx
    cmp rbx, 0
    jne loop_with_unlikely_exit ; Poner el caso común primero
    ; (continuar es raro, loop es común)

    ; ==========================================
    ; TABLA DE SALTOS (Jump Table)
    ; ==========================================

section .data
    jump_table dq case0, case1, case2, case3

section .text
    ; switch (valor)
    mov rax, 2              ; Valor del switch
    cmp rax, 3
    ja default_case
    jmp [jump_table + rax*8]

case0:
    mov r12, 100
    jmp end_switch
case1:
    mov r12, 200
    jmp end_switch
case2:
    mov r12, 300
    jmp end_switch
case3:
    mov r12, 400
    jmp end_switch
default_case:
    xor r12, r12
end_switch:

    ; ==========================================
    ; MEDICIÓN DE RENDIMIENTO (RDTSC)
    ; ==========================================

    ; Guardar timestamp inicial
    rdtsc
    shl rdx, 32
    or rdx, rax
    mov r13, rdx            ; R13 = timestamp inicial

    ; ... código a medir ...
    mov rcx, 1000000
busy_loop:
    loop busy_loop

    ; Timestamp final
    rdtsc
    shl rdx, 32
    or rdx, rax
    sub rdx, r13            ; RDX = ciclos de CPU transcurridos

    ; RDX ahora contiene los ciclos de CPU que tardó el código

    ; ==========================================
    ; SALIR
    ; ==========================================

    mov rax, 60
    xor rdi, rdi
    syscall

; ============================================================================
; PRINCIPIOS DE OPTIMIZACIÓN:
; ============================================================================
; 1. Usar LEA para cálculos aritméticos simples
; 2. XOR reg, reg en lugar de MOV reg, 0
; 3. Desenrollar loops cuando sea posible
; 4. Evitar branches con CMOV cuando sea apropiado
; 5. Alinear datos importantes a 16 bytes
; 6. Usar tabla de saltos para switch grandes
; 7. Medir con RDTSC para optimización empírica
; 8. Minimizar dependencias de datos
; 9. Usar registros en lugar de memoria
; 10. Preferir instrucciones cortas
; ============================================================================
