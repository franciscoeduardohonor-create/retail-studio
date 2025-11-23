; ============================================================================
; Ejemplo 1: Hello World - El Programa Más Famoso
; ============================================================================
; Este es el programa clásico que todo programador escribe primero.
; Imprime "Hello, World!" en la pantalla.
;
; Compilar y ejecutar:
;   nasm -f elf64 01_hello_world.asm -o 01_hello_world.o
;   ld 01_hello_world.o -o 01_hello_world
;   ./01_hello_world
; ============================================================================

section .data
    ; Definimos el mensaje a imprimir
    ; 'Hello, World!' seguido de una nueva línea (10 = '\n' en ASCII)
    mensaje db 'Hello, World!', 10

    ; Calculamos la longitud del mensaje automáticamente
    ; $ = posición actual en memoria
    ; mensaje = posición donde empieza el mensaje
    ; $ - mensaje = longitud en bytes
    longitud equ $ - mensaje

section .text
    global _start       ; Punto de entrada del programa

_start:
    ; ============================================
    ; SYSCALL: write (imprimir en pantalla)
    ; ============================================
    ; En Linux x86-64, write es la syscall número 1
    ; Prototipo: write(fd, buffer, count)
    ;   fd = file descriptor (1 = stdout/pantalla)
    ;   buffer = dirección del texto a imprimir
    ;   count = cantidad de bytes a imprimir

    mov rax, 1          ; RAX = 1 (syscall número 1 = write)

    mov rdi, 1          ; RDI = primer argumento = 1 (stdout)
                        ; stdout es la salida estándar (pantalla)

    mov rsi, mensaje    ; RSI = segundo argumento = dirección del mensaje
                        ; Aquí ponemos la dirección de memoria donde
                        ; empieza nuestro string

    mov rdx, longitud   ; RDX = tercer argumento = longitud del mensaje
                        ; Cuántos bytes queremos imprimir

    syscall             ; Ejecutar la syscall
                        ; El kernel toma control e imprime el mensaje

    ; ============================================
    ; SYSCALL: exit (salir del programa)
    ; ============================================
    ; exit es la syscall número 60
    ; Prototipo: exit(code)
    ;   code = código de salida (0 = éxito)

    mov rax, 60         ; RAX = 60 (syscall número 60 = exit)

    xor rdi, rdi        ; RDI = 0 (código de salida 0 = éxito)
                        ; xor rdi, rdi es más eficiente que mov rdi, 0
                        ; Cualquier número XOR consigo mismo = 0

    syscall             ; Ejecutar la syscall y terminar el programa

; ============================================================================
; EXPLICACIÓN DETALLADA:
; ============================================================================
;
; SECCIÓN .data:
;   - Contiene datos inicializados (que tienen valores)
;   - 'mensaje db ...' declara un array de bytes (caracteres)
;   - El '10' al final es el carácter de nueva línea (\n)
;   - 'longitud equ ...' es una constante que guarda la longitud
;
; OPERADOR $:
;   - $ representa la posición actual en el código/datos
;   - Se usa para calcular tamaños y desplazamientos
;   - En 'longitud equ $ - mensaje':
;     * $ = posición después del mensaje
;     * mensaje = posición del inicio del mensaje
;     * La resta nos da cuántos bytes ocupa el mensaje
;
; DESCRIPTORES DE ARCHIVO (File Descriptors):
;   - 0 = stdin  (entrada estándar - teclado)
;   - 1 = stdout (salida estándar - pantalla)
;   - 2 = stderr (salida de errores - pantalla)
;
; CONVENCIÓN DE LLAMADAS A SYSCALLS en x86-64 Linux:
;   - RAX = número de syscall
;   - RDI = 1er argumento
;   - RSI = 2do argumento
;   - RDX = 3er argumento
;   - R10 = 4to argumento
;   - R8  = 5to argumento
;   - R9  = 6to argumento
;
; SYSCALLS USADAS:
;   - write (1): Escribir bytes a un file descriptor
;   - exit (60): Terminar el programa
;
; ============================================================================
; EXPERIMENTOS:
; ============================================================================
;
; 1. Cambia el mensaje por tu nombre:
;    mensaje db 'Hola, [TU NOMBRE]!', 10
;
; 2. Imprime el mensaje dos veces:
;    Duplica el bloque de código de write antes del exit
;
; 3. Imprime un mensaje diferente:
;    Añade otro mensaje en .data y otra syscall write
;
; 4. Cambia el código de salida:
;    En lugar de 'xor rdi, rdi', usa 'mov rdi, 42'
;    Ejecuta y luego: echo $?
;    Verás que devuelve 42
;
; ============================================================================
