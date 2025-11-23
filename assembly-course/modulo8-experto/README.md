# Módulo 8: Programación Experta

## 🎯 Objetivos
- Usar macros y directivas avanzadas
- Optimización de código
- Interfaz con C
- Técnicas avanzadas de programación
- Debugging y análisis

## 🔧 Macros en NASM

### Macros Simples
```nasm
%macro print_msg 2          ; 2 parámetros
    mov rax, 1
    mov rdi, 1
    mov rsi, %1             ; Primer parámetro
    mov rdx, %2             ; Segundo parámetro
    syscall
%endmacro

; Uso:
print_msg mensaje, longitud
```

### Macros con Etiquetas Locales
```nasm
%macro if_equal 3           ; if_equal reg, valor, etiqueta
    cmp %1, %2
    je %3
%endmacro

%macro safe_div 2           ; safe_div dividendo, divisor
    cmp %2, 0
    je %%skip               ; Etiqueta local
    mov rax, %1
    xor rdx, rdx
    div %2
%%skip:
%endmacro
```

### Macros Multi-línea
```nasm
%macro push_all 0
    push rax
    push rbx
    push rcx
    push rdx
    push rsi
    push rdi
%endmacro

%macro pop_all 0
    pop rdi
    pop rsi
    pop rdx
    pop rcx
    pop rbx
    pop rax
%endmacro
```

## 📐 Directivas Avanzadas

### Condicionales en Tiempo de Ensamblado
```nasm
%define DEBUG 1

%if DEBUG
    ; Código de debug
    print_msg debug_msg, debug_len
%endif

%ifdef LINUX
    ; Código específico de Linux
%elifdef WINDOWS
    ; Código específico de Windows
%else
    ; Código genérico
%endif
```

### Includes
```nasm
%include "macros.asm"       ; Incluir archivo
%include "constants.inc"
```

### Repeticiones
```nasm
; times N instrucción
times 10 nop                ; 10 NOPs
times 100 db 0              ; 100 bytes en 0

; %rep/%endrep
%assign i 0
%rep 10
    dd i
    %assign i i+1
%endrep
```

## ⚡ Optimización de Código

### 1. Alineación
```nasm
align 16                    ; Alinear a 16 bytes
section .data
    align 16
    array dq 1, 2, 3, 4     ; Arrays SIMD necesitan alineación
```

### 2. Desenrollado de Loops (Loop Unrolling)
```nasm
; ❌ Loop normal (lento)
    mov rcx, 100
loop:
    inc rax
    loop loop

; ✅ Loop desenrollado (rápido)
    mov rcx, 25
loop:
    inc rax
    inc rax
    inc rax
    inc rax
    loop loop
```

### 3. Evitar Dependencias
```nasm
; ❌ Dependencia de datos
    add rax, rbx
    add rax, rcx        ; Espera a que termine la anterior

; ✅ Sin dependencia
    add rax, rbx
    add rdx, rcx        ; Puede ejecutarse en paralelo
    add rax, rdx
```

### 4. Preferir LEA sobre ADD/IMUL
```nasm
; ❌ Múltiples instrucciones
    mov rax, rbx
    add rax, rcx
    add rax, 5

; ✅ Una sola instrucción
    lea rax, [rbx + rcx + 5]
```

### 5. XOR para Poner a Cero
```nasm
xor rax, rax        ; ✅ 3 bytes, rápido
mov rax, 0          ; ❌ 10 bytes, más lento
```

## 🔗 Interfaz con C

### Llamar Función C desde Assembly
```nasm
extern printf           ; Declarar función externa

section .data
    fmt db "Número: %d", 10, 0

section .text
    global main         ; Punto de entrada para C

main:
    push rbp
    mov rbp, rsp

    ; printf("Número: %d\n", 42)
    lea rdi, [fmt]      ; Primer parámetro: formato
    mov rsi, 42         ; Segundo parámetro: número
    xor rax, rax        ; RAX=0 (sin parámetros flotantes)
    call printf

    xor rax, rax        ; Retornar 0
    pop rbp
    ret
```

Compilar:
```bash
nasm -f elf64 prog.asm -o prog.o
gcc prog.o -o prog -no-pie
```

### Función Assembly para C
```nasm
; int suma(int a, int b);

global suma

suma:
    mov eax, edi        ; Primer parámetro (int)
    add eax, esi        ; Segundo parámetro
    ret                 ; Retornar EAX
```

Desde C:
```c
extern int suma(int a, int b);

int main() {
    int resultado = suma(10, 20);   // 30
    return 0;
}
```

## 🐛 Debugging

### Usar GDB
```bash
nasm -f elf64 -g -F dwarf prog.asm -o prog.o
ld prog.o -o prog
gdb ./prog
```

Comandos GDB útiles:
```gdb
break _start        # Breakpoint en _start
run                 # Ejecutar
info registers      # Ver registros
x/10x $rsp          # Ver stack (10 qwords en hex)
si                  # Step instruction
ni                  # Next instruction
continue            # Continuar ejecución
```

### Imprimir Valores para Debug
```nasm
%macro debug_print 1
    push rax
    push rdi
    push rsi
    push rdx

    mov rax, 1
    mov rdi, 2          ; stderr
    lea rsi, [%1]
    mov rdx, 20
    syscall

    pop rdx
    pop rsi
    pop rdi
    pop rax
%endmacro
```

## 🎓 Técnicas Avanzadas

### 1. Tabla de Saltos (Jump Table)
```nasm
section .data
    jump_table dq case0, case1, case2, case3

section .text
    ; switch (rax) {
    cmp rax, 3
    ja default
    jmp [jump_table + rax*8]

case0:
    ; código caso 0
    jmp fin_switch
case1:
    ; código caso 1
    jmp fin_switch
case2:
    ; código caso 2
    jmp fin_switch
case3:
    ; código caso 3
    jmp fin_switch
default:
    ; código por defecto
fin_switch:
```

### 2. Corrutinas con Stack Switching
```nasm
; Guardar contexto
    push rbp
    push rbx
    push r12
    push r13
    push r14
    push r15
    mov [old_rsp], rsp

    ; Cambiar a nuevo stack
    mov rsp, [new_rsp]

    ; Restaurar contexto
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    pop rbp
```

### 3. Posición Independiente (PIC)
```nasm
; Para librerías compartidas
default rel         ; Direccionamiento relativo a RIP

section .data
    var dq 100

section .text
    mov rax, [rel var]  ; Acceso relativo a RIP
```

## 📊 Análisis de Rendimiento

### Contador de Ciclos (RDTSC)
```nasm
    rdtsc               ; EDX:EAX = timestamp counter
    shl rdx, 32
    or rax, rdx         ; RAX = ciclos de CPU

    ; ... código a medir ...

    rdtsc
    shl rdx, 32
    or rdx, rax
    sub rdx, rax        ; RDX = ciclos transcurridos
```

## 🏆 Proyectos Finales Sugeridos

1. **Mini Shell**: Intérprete de comandos básico
2. **Juego de Serpiente**: En terminal con syscalls
3. **Compresor Simple**: Algoritmo RLE en Assembly
4. **Parser JSON**: Lector de archivos JSON
5. **Web Server Mínimo**: Servidor HTTP básico
6. **Raytracer**: Renderizador 3D con SIMD

Ver `ejemplos/` para implementaciones completas.

---

**¡Felicidades! Has completado el curso de Assembly. Ahora eres un programador de bajo nivel experto.**
