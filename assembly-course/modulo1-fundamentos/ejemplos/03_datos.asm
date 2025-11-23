; ============================================================================
; Ejemplo 3: Trabajando con Datos y Variables
; ============================================================================
; Este programa muestra cómo declarar y usar datos en las secciones
; .data y .bss, y cómo acceder a ellos desde el código.
;
; Compilar y ejecutar:
;   nasm -f elf64 03_datos.asm -o 03_datos.o
;   ld 03_datos.o -o 03_datos
;   ./03_datos
; ============================================================================

section .data
    ; ============================================
    ; DECLARACIÓN DE DATOS INICIALIZADOS
    ; ============================================

    ; DB - Define Byte (8 bits = 1 byte)
    byte_var    db 255              ; Un byte con valor 255
    char_var    db 'A'              ; Un carácter (ASCII de 'A' = 65)
    string_var  db 'Hola', 0        ; String terminado en null (0)
                                    ; Ocupa 5 bytes: H,o,l,a,0

    ; DW - Define Word (16 bits = 2 bytes)
    word_var    dw 65535            ; Valor máximo de 16 bits sin signo

    ; DD - Define Double Word (32 bits = 4 bytes)
    dword_var   dd 100000           ; Número grande de 32 bits

    ; DQ - Define Quad Word (64 bits = 8 bytes)
    qword_var   dq 123456789        ; Número de 64 bits

    ; Arrays (múltiples valores)
    array_bytes db 10, 20, 30, 40, 50   ; Array de 5 bytes
    array_words dw 100, 200, 300         ; Array de 3 words (16 bits cada uno)

    ; Declaración con múltiples valores del mismo dato
    zeros       db 0, 0, 0, 0, 0         ; 5 ceros
    ; O más eficiente:
    zeros2      times 10 db 0            ; 10 ceros (usando TIMES)

    ; Constantes (no ocupan memoria, solo son sustituciones)
    NUMERO_MAGICO equ 42                 ; Constante = 42
    BUFFER_SIZE   equ 256                ; Constante = 256

section .bss
    ; ============================================
    ; RESERVA DE ESPACIO SIN INICIALIZAR
    ; ============================================
    ; BSS es para variables que no tienen valor inicial
    ; Es más eficiente que .data porque no ocupa espacio en el ejecutable

    ; RESB - Reserve Bytes
    buffer      resb 64             ; Reserva 64 bytes sin inicializar

    ; RESW - Reserve Words (16 bits)
    word_buffer resw 10             ; Reserva 10 words (20 bytes total)

    ; RESD - Reserve Double Words (32 bits)
    dword_buffer resd 5             ; Reserva 5 dwords (20 bytes total)

    ; RESQ - Reserve Quad Words (64 bits)
    qword_buffer resq 3             ; Reserva 3 qwords (24 bytes total)

section .text
    global _start

_start:
    ; ============================================
    ; CARGAR DATOS DESDE MEMORIA
    ; ============================================

    ; Cargar un byte desde memoria
    ; Los corchetes [] significan "el valor en la dirección de memoria"
    mov al, [byte_var]      ; AL = valor en byte_var = 255
                            ; [byte_var] obtiene el VALOR
                            ; byte_var (sin corchetes) sería la DIRECCIÓN

    ; Cargar un carácter
    mov bl, [char_var]      ; BL = 'A' = 65 (en ASCII)

    ; Cargar una word (16 bits)
    mov ax, [word_var]      ; AX = 65535

    ; Cargar una double word (32 bits)
    mov eax, [dword_var]    ; EAX = 100000

    ; Cargar una quad word (64 bits)
    mov rax, [qword_var]    ; RAX = 123456789

    ; ============================================
    ; OBTENER LA DIRECCIÓN DE UNA VARIABLE
    ; ============================================

    ; Sin corchetes, obtenemos la DIRECCIÓN de memoria
    lea rbx, [byte_var]     ; RBX = dirección de byte_var
                            ; LEA = Load Effective Address

    ; O también podemos usar MOV con la dirección:
    mov rcx, byte_var       ; RCX = dirección de byte_var
                            ; (equivalente a LEA en este caso)

    ; Ahora RBX y RCX apuntan a byte_var
    ; Podemos usar estos punteros para acceder al dato:
    mov dl, [rbx]           ; DL = 255 (acceso indirecto)

    ; ============================================
    ; ESCRIBIR DATOS EN MEMORIA
    ; ============================================

    ; Modificar un byte en memoria
    mov byte [byte_var], 100    ; byte_var ahora vale 100
                                ; La palabra "byte" especifica el tamaño

    ; Modificar una word
    mov word [word_var], 500    ; word_var ahora vale 500

    ; Modificar una dword
    mov dword [dword_var], 999  ; dword_var ahora vale 999

    ; Modificar una qword
    mov qword [qword_var], 777  ; qword_var ahora vale 777

    ; ============================================
    ; TRABAJAR CON ARRAYS
    ; ============================================

    ; array_bytes = [10, 20, 30, 40, 50]
    ; Índices:        0   1   2   3   4

    ; Acceder al primer elemento (índice 0)
    mov al, [array_bytes]       ; AL = 10 (primer elemento)

    ; Acceder al segundo elemento (índice 1)
    mov al, [array_bytes + 1]   ; AL = 20 (segundo elemento)
                                ; +1 porque cada elemento ocupa 1 byte

    ; Acceder al tercer elemento
    mov al, [array_bytes + 2]   ; AL = 30

    ; Acceder usando un registro como índice
    mov rcx, 3                  ; Índice 3
    mov al, [array_bytes + rcx] ; AL = 40 (cuarto elemento)

    ; ============================================
    ; ARRAYS DE WORDS (16 bits = 2 bytes)
    ; ============================================

    ; array_words = [100, 200, 300]
    ; Cada elemento ocupa 2 bytes

    mov ax, [array_words]       ; AX = 100 (índice 0)
    mov ax, [array_words + 2]   ; AX = 200 (índice 1) +2 porque 1*2bytes
    mov ax, [array_words + 4]   ; AX = 300 (índice 2) +4 porque 2*2bytes

    ; Usando un registro como índice con escala
    mov rcx, 1                  ; Queremos el índice 1
    mov ax, [array_words + rcx*2]  ; AX = 200
                                   ; rcx*2 porque cada word son 2 bytes

    ; ============================================
    ; USAR EL BUFFER DE BSS
    ; ============================================

    ; Escribir en el buffer (que estaba sin inicializar)
    mov byte [buffer], 'H'      ; buffer[0] = 'H'
    mov byte [buffer + 1], 'i'  ; buffer[1] = 'i'
    mov byte [buffer + 2], 0    ; buffer[2] = 0 (null terminator)
    ; Ahora buffer contiene "Hi"

    ; ============================================
    ; USAR CONSTANTES
    ; ============================================

    mov rax, NUMERO_MAGICO      ; RAX = 42
                                ; NUMERO_MAGICO se sustituye por 42

    mov rcx, BUFFER_SIZE        ; RCX = 256

    ; ============================================
    ; COPIAR DATOS DE MEMORIA A MEMORIA
    ; ============================================

    ; No podemos hacer directamente: mov [destino], [origen]
    ; Necesitamos usar un registro intermedio

    mov al, [byte_var]          ; AL = valor de byte_var
    mov [buffer], al            ; buffer[0] = AL

    ; ============================================
    ; SALIR
    ; ============================================

    mov rax, 60                 ; syscall: exit
    xor rdi, rdi                ; código de salida 0
    syscall

; ============================================================================
; RESUMEN DE CONCEPTOS:
; ============================================================================
;
; SECCIONES:
;   .data - Datos inicializados (tienen valor al inicio)
;   .bss  - Datos sin inicializar (solo reserva espacio)
;
; DIRECTIVAS DE DATOS:
;   db  - Define Byte (8 bits)
;   dw  - Define Word (16 bits)
;   dd  - Define Double Word (32 bits)
;   dq  - Define Quad Word (64 bits)
;
; DIRECTIVAS DE RESERVA:
;   resb - Reserve Bytes
;   resw - Reserve Words
;   resd - Reserve Double Words
;   resq - Reserve Quad Words
;
; CONSTANTES:
;   equ - Define constante (no ocupa memoria)
;   times - Repite una directiva N veces
;
; ACCESO A MEMORIA:
;   [variable]      - Obtiene el VALOR en la dirección
;   variable        - Obtiene la DIRECCIÓN de memoria
;   lea reg, [var]  - Carga la dirección efectiva
;   [array + N]     - Acceso a elemento N del array
;   [array + reg*escala] - Acceso indexado con escala
;
; ESPECIFICADORES DE TAMAÑO:
;   byte [...]  - Operación de 8 bits
;   word [...]  - Operación de 16 bits
;   dword [...] - Operación de 32 bits
;   qword [...] - Operación de 64 bits
;
; ============================================================================
; EJERCICIO:
; ============================================================================
; 1. Crea un array de 5 números (usa dq)
; 2. Suma todos los elementos del array
; 3. Guarda el resultado en una variable llamada "suma"
; 4. Sal del programa con el resultado como código de salida
; ============================================================================
