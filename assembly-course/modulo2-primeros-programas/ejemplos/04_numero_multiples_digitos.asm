; ============================================================================
; Ejemplo 4: Imprimir Número de Múltiples Dígitos
; ============================================================================
; Este programa muestra cómo convertir e imprimir un número de hasta 3 dígitos.
; Usa división repetida para extraer cada dígito.
;
; Compilar y ejecutar:
;   nasm -f elf64 04_numero_multiples_digitos.asm -o 04_numero_multiples_digitos.o
;   ld 04_numero_multiples_digitos.o -o 04_numero_multiples_digitos
;   ./04_numero_multiples_digitos
; ============================================================================

section .data
    msg db 'El numero es: '
    len_msg equ $ - msg

    newline db 10

section .bss
    buffer resb 4       ; Buffer para 3 dígitos + null terminator
    num_digitos resb 1  ; Contador de dígitos

section .text
    global _start

_start:
    ; ============================================
    ; EL NÚMERO A IMPRIMIR
    ; ============================================
    ; Vamos a imprimir el número 142

    mov rax, 142        ; El número a convertir

    ; ============================================
    ; ALGORITMO DE CONVERSIÓN
    ; ============================================
    ; Para convertir un número a string, usamos división:
    ; 1. Dividir el número por 10
    ; 2. El residuo es el último dígito
    ; 3. El cociente es el número sin el último dígito
    ; 4. Repetir hasta que el número sea 0
    ;
    ; Ejemplo con 142:
    ;   142 ÷ 10 = 14 residuo 2  → dígito '2'
    ;    14 ÷ 10 =  1 residuo 4  → dígito '4'
    ;     1 ÷ 10 =  0 residuo 1  → dígito '1'
    ; Resultado: "142" (pero obtenemos los dígitos al revés)

    ; Inicializar
    mov rcx, 0          ; RCX = contador de dígitos
    mov rbx, 10         ; RBX = divisor (10)

    ; ============================================
    ; EXTRAER DÍGITOS (se guardan al revés en el stack)
    ; ============================================

extraer_digitos:
    ; Preparar para división
    xor rdx, rdx        ; RDX = 0 (parte alta del dividendo)
                        ; DIV usa RDX:RAX como dividendo de 128 bits

    div rbx             ; RAX = RAX ÷ 10, RDX = RAX % 10
                        ; Divide RDX:RAX entre RBX
                        ; Cociente en RAX, Residuo en RDX

    ; El residuo (RDX) es nuestro dígito
    add dl, '0'         ; Convertir número a ASCII
    push rdx            ; Guardar en el stack
    inc rcx             ; Incrementar contador de dígitos

    ; ¿Terminamos?
    cmp rax, 0          ; Si RAX = 0, ya extrajimos todos los dígitos
    jne extraer_digitos ; Si no, seguir extrayendo

    ; Ahora los dígitos están en el stack en orden correcto
    ; RCX contiene cuántos dígitos tenemos

    ; ============================================
    ; CONSTRUIR STRING DESDE EL STACK
    ; ============================================

    mov rdi, buffer     ; RDI apunta al buffer
    mov r8, rcx         ; R8 = cantidad de dígitos (para después)

construir_string:
    pop rax             ; Sacar un dígito del stack
    mov [rdi], al       ; Guardarlo en el buffer
    inc rdi             ; Avanzar al siguiente byte
    loop construir_string   ; LOOP decrementa RCX y salta si RCX != 0

    ; Añadir null terminator (opcional, no necesario para write)
    mov byte [rdi], 0

    ; ============================================
    ; IMPRIMIR MENSAJE
    ; ============================================

    mov rax, 1          ; syscall: write
    mov rdi, 1          ; stdout
    mov rsi, msg        ; "El numero es: "
    mov rdx, len_msg
    syscall

    ; ============================================
    ; IMPRIMIR EL NÚMERO
    ; ============================================

    mov rax, 1          ; syscall: write
    mov rdi, 1          ; stdout
    mov rsi, buffer     ; nuestro número convertido
    mov rdx, r8         ; cantidad de dígitos
    syscall

    ; ============================================
    ; IMPRIMIR NUEVA LÍNEA
    ; ============================================

    mov rax, 1          ; syscall: write
    mov rdi, 1          ; stdout
    mov rsi, newline
    mov rdx, 1
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
; DIVISIÓN EN ASSEMBLY (x86-64):
;   - Instrucción: DIV divisor
;   - Dividendo: RDX:RAX (128 bits combinados)
;   - Divisor: El operando (en nuestro caso RBX = 10)
;   - Resultado:
;     * Cociente → RAX
;     * Residuo → RDX
;
; EJEMPLO DE DIVISIÓN:
;   RAX = 142, RBX = 10
;   xor rdx, rdx        ; RDX:RAX = 142
;   div rbx             ; RAX = 14, RDX = 2
;
; EL STACK:
;   - PUSH: Poner un valor en el stack (crece hacia abajo)
;   - POP: Sacar un valor del stack (LIFO - Last In First Out)
;   - Usamos el stack para invertir el orden de los dígitos
;
; INSTRUCCIÓN LOOP:
;   - Decrementa RCX automáticamente
;   - Si RCX != 0, salta a la etiqueta
;   - Equivalente a: dec rcx; jnz etiqueta
;
; INSTRUCCIÓN CMP y JNE:
;   - CMP: Compara dos valores (hace una resta sin guardar resultado)
;   - JNE: Jump if Not Equal (salta si no son iguales)
;
; PROCESO COMPLETO:
;   1. Número en RAX: 142
;   2. Extraer dígitos con DIV:
;      - 142 % 10 = 2 → push 2
;      - 14 % 10 = 4  → push 4
;      - 1 % 10 = 1   → push 1
;   3. Stack (de arriba a abajo): 1, 4, 2
;   4. Pop y construir: '1', '4', '2' → "142"
;
; REGISTROS USADOS:
;   - RAX: Número a convertir / cocientes sucesivos
;   - RBX: Divisor (10)
;   - RCX: Contador de dígitos (también usado por LOOP)
;   - RDX: Residuos (dígitos extraídos)
;   - RDI: Puntero al buffer
;   - R8: Guardar cantidad de dígitos
;
; ============================================================================
; EXPERIMENTOS:
; ============================================================================
;
; 1. Prueba con otros números:
;    mov rax, 255
;    mov rax, 999
;    mov rax, 7
;
; 2. Imprime el resultado de un cálculo:
;    mov rax, 50
;    add rax, 75  ; = 125
;    (Luego el algoritmo de conversión)
;
; 3. Modifica para números más grandes:
;    Aumenta el buffer: buffer resb 20
;    Prueba con: mov rax, 123456789
;
; 4. ¿Qué pasa con 0?
;    mov rax, 0
;    (Funciona, pero necesitarías un caso especial)
;
; ============================================================================
