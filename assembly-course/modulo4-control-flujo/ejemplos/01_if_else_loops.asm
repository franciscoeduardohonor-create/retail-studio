; ============================================================================
; Ejemplo 1: IF, ELSE y LOOPS
; ============================================================================

section .data
    array dq 5, 12, 3, 20, 8, 15    ; Array de 6 números
    tam equ 6

section .bss
    maximo resq 1       ; Variable para el máximo
    suma resq 1         ; Variable para la suma

section .text
    global _start

_start:
    ; ==========================================
    ; EJEMPLO 1: IF simple
    ; ==========================================
    ; if (rax > 10) { rax = 100 }

    mov rax, 15         ; RAX = 15
    cmp rax, 10         ; Comparar con 10
    jle skip_if1        ; Si RAX <= 10, saltar
    mov rax, 100        ; RAX = 100 (solo si RAX > 10)
skip_if1:
    ; Ahora RAX = 100

    ; ==========================================
    ; EJEMPLO 2: IF-ELSE
    ; ==========================================
    ; if (rbx == 0) {
    ;     rcx = 1
    ; } else {
    ;     rcx = 2
    ; }

    mov rbx, 5          ; RBX = 5 (no es 0)
    cmp rbx, 0          ; ¿Es 0?
    je then_parte       ; Si es igual a 0, ir a then
    mov rcx, 2          ; Parte ELSE
    jmp fin_if_else
then_parte:
    mov rcx, 1          ; Parte THEN
fin_if_else:
    ; Ahora RCX = 2

    ; ==========================================
    ; EJEMPLO 3: LOOP FOR - Sumar elementos
    ; ==========================================
    ; for (i=0; i<6; i++) { suma += array[i] }

    xor rax, rax        ; RAX = 0 (acumulador de suma)
    mov rcx, 0          ; RCX = 0 (índice i)

loop_suma:
    cmp rcx, tam        ; ¿i < 6?
    jge fin_suma        ; Si i >= 6, salir

    mov rbx, [array + rcx*8]    ; RBX = array[i]
    add rax, rbx        ; suma += array[i]

    inc rcx             ; i++
    jmp loop_suma
fin_suma:
    mov [suma], rax     ; Guardar suma
    ; Suma = 5+12+3+20+8+15 = 63

    ; ==========================================
    ; EJEMPLO 4: Encontrar el MÁXIMO
    ; ==========================================

    mov rax, [array]    ; RAX = primer elemento (máximo inicial)
    mov rcx, 1          ; Empezar desde índice 1

loop_maximo:
    cmp rcx, tam        ; ¿i < 6?
    jge fin_maximo

    mov rbx, [array + rcx*8]    ; RBX = array[i]
    cmp rbx, rax        ; ¿array[i] > máximo actual?
    jle no_actualizar   ; Si no, no hacer nada
    mov rax, rbx        ; Actualizar máximo
no_actualizar:
    inc rcx
    jmp loop_maximo
fin_maximo:
    mov [maximo], rax   ; Guardar máximo
    ; Máximo = 20

    ; ==========================================
    ; EJEMPLO 5: LOOP con instrucción LOOP
    ; ==========================================
    ; Contar de 10 a 1

    mov rcx, 10         ; Contador
    xor r8, r8          ; R8 = contador de iteraciones
loop_con_loop:
    inc r8              ; Incrementar contador
    loop loop_con_loop  ; Decrementa RCX, salta si RCX != 0
    ; Al terminar: R8 = 10, RCX = 0

    ; ==========================================
    ; EJEMPLO 6: WHILE
    ; ==========================================
    ; while (r9 != 100) { r9 += 10 }

    mov r9, 50
while_inicio:
    cmp r9, 100
    je while_fin
    add r9, 10
    jmp while_inicio
while_fin:
    ; Ahora R9 = 100

    ; ==========================================
    ; EJEMPLO 7: Números pares vs impares
    ; ==========================================
    ; if (rax % 2 == 0) { rbx = 1 } else { rbx = 0 }

    mov rax, 42         ; Número a probar
    test rax, 1         ; Prueba el bit menos significativo
    jz es_par           ; Si es 0, es par
    mov rbx, 0          ; Impar
    jmp fin_paridad
es_par:
    mov rbx, 1          ; Par
fin_paridad:
    ; RBX = 1 (42 es par)

    ; ==========================================
    ; SALIR
    ; ==========================================
    mov rax, 60
    xor rdi, rdi
    syscall

; ============================================================================
; EXPLICACIONES:
; ============================================================================
;
; CMP:
;   - cmp a, b  →  Hace (a - b) y actualiza banderas
;   - NO modifica a ni b
;
; SALTOS IMPORTANTES:
;   - je/jz   : Jump if Equal / Zero
;   - jne/jnz : Jump if Not Equal / Not Zero
;   - jg      : Jump if Greater (con signo)
;   - jl      : Jump if Less (con signo)
;   - jge     : Jump if Greater or Equal
;   - jle     : Jump if Less or Equal
;
; TEST vs CMP:
;   - test a, b → Hace (a AND b) y actualiza banderas
;   - test rax, 1 → Prueba si el bit 0 está encendido (impar/par)
;
; LOOP:
;   - Usa RCX como contador automáticamente
;   - Decrementa RCX y salta si RCX != 0
;   - Muy útil para loops con contador
;
; ============================================================================
