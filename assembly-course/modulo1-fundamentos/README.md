# Módulo 1: Fundamentos de Assembly

## 🎯 Objetivos de Aprendizaje

Al finalizar este módulo, serás capaz de:
- Entender qué es el lenguaje ensamblador y por qué es importante
- Conocer la arquitectura básica x86-64
- Identificar los registros principales del procesador
- Comprender la sintaxis básica de NASM

## 📖 ¿Qué es Assembly?

**Assembly (Ensamblador)** es un lenguaje de programación de bajo nivel que está muy cerca del código máquina que entiende directamente el procesador.

### Jerarquía de Lenguajes:
```
Alto Nivel (Python, Java)
    ↓ (compilador/intérprete)
Nivel Medio (C, C++)
    ↓ (compilador)
Assembly (código ensamblador)
    ↓ (ensamblador)
Código Máquina (binario: 0s y 1s)
    ↓
Hardware (CPU)
```

### ¿Por qué Aprender Assembly?

1. **Entender cómo funciona realmente una computadora**
2. **Optimización extrema** de código crítico
3. **Seguridad y análisis** de malware
4. **Desarrollo de sistemas** operativos y drivers
5. **Reverse engineering** y debugging
6. **Programación embebida** en bajo nivel

## 🖥️ Arquitectura x86-64

### ¿Qué es x86-64?

- **x86**: Familia de arquitecturas de Intel (8086, 80286, 80386, etc.)
- **x86-64** (o AMD64): Extensión de 64 bits de x86
- Es la arquitectura más común en computadoras modernas

### Características Principales:

- **Registros de 64 bits**: Pueden almacenar números muy grandes
- **Espacio de direcciones grande**: Puede acceder a mucha RAM
- **Instrucciones CISC**: Complex Instruction Set Computer (muchas instrucciones)

## 📦 Registros del Procesador

Los **registros** son memoria super rápida dentro del CPU. Son como variables especiales.

### Registros de Propósito General (64 bits):

| Registro | Tamaño | Uso Común | Descripción |
|----------|--------|-----------|-------------|
| **RAX** | 64 bits | Acumulador | Retorno de funciones, operaciones aritméticas |
| **RBX** | 64 bits | Base | Puntero a datos |
| **RCX** | 64 bits | Contador | Loops, iteraciones |
| **RDX** | 64 bits | Datos | Operaciones I/O, multiplicación/división |
| **RSI** | 64 bits | Source Index | Operaciones con strings (origen) |
| **RDI** | 64 bits | Destination Index | Operaciones con strings (destino) |
| **RBP** | 64 bits | Base Pointer | Puntero base del stack frame |
| **RSP** | 64 bits | Stack Pointer | Puntero al tope del stack |
| **R8-R15** | 64 bits | General | Registros adicionales en x86-64 |

### Versiones de Registros:

Cada registro de 64 bits tiene versiones más pequeñas:

```
RAX (64 bits): |................................|
                        EAX (32 bits): |................|
                              AX (16 bits): |........|
                                  AH (8 bits alto): |....|
                                  AL (8 bits bajo):     |....|
```

Ejemplo:
- **RAX**: 64 bits completos
- **EAX**: 32 bits inferiores de RAX
- **AX**: 16 bits inferiores de RAX
- **AL**: 8 bits inferiores de RAX
- **AH**: 8 bits superiores de AX

### Registros Especiales:

| Registro | Descripción |
|----------|-------------|
| **RIP** | Instruction Pointer - apunta a la próxima instrucción |
| **RFLAGS** | Banderas de estado (zero, carry, overflow, etc.) |

### Banderas Importantes en RFLAGS:

- **ZF** (Zero Flag): Se activa si el resultado es cero
- **CF** (Carry Flag): Se activa en acarreo/préstamo
- **SF** (Sign Flag): Se activa si el resultado es negativo
- **OF** (Overflow Flag): Se activa en desbordamiento

## 📝 Sintaxis NASM

NASM (Netwide Assembler) es el ensamblador que usaremos.

### Estructura Básica de un Programa:

```nasm
; Esto es un comentario

section .data
    ; Aquí van las variables inicializadas
    mensaje db 'Hola', 0

section .bss
    ; Aquí van las variables sin inicializar
    buffer resb 64

section .text
    global _start

_start:
    ; Aquí va el código
    mov rax, 1      ; Instrucción
    ; ...
    mov rax, 60     ; syscall: exit
    xor rdi, rdi    ; código de salida 0
    syscall         ; llamar al kernel
```

### Componentes:

1. **Secciones**:
   - `.data`: Variables con valores iniciales
   - `.bss`: Variables sin inicializar (solo reserva espacio)
   - `.text`: Código ejecutable

2. **Etiquetas**:
   - `_start:` - Punto de entrada del programa
   - `loop:` - Etiqueta para saltos

3. **Instrucciones**:
   - Formato: `instrucción destino, origen`
   - Ejemplo: `mov rax, 5` → Mover 5 a RAX

4. **Comentarios**:
   - Todo después de `;` es un comentario

### Directivas Comunes:

- **db** (Define Byte): Define bytes (8 bits)
- **dw** (Define Word): Define words (16 bits)
- **dd** (Define Double): Define double words (32 bits)
- **dq** (Define Quad): Define quad words (64 bits)
- **resb**: Reserva bytes sin inicializar
- **equ**: Define constantes

### Tipos de Operandos:

```nasm
mov rax, 5          ; Inmediato (un número literal)
mov rax, rbx        ; Registro a registro
mov rax, [rbx]      ; Desde memoria (dirección en RBX)
mov [rbx], rax      ; A memoria
mov rax, [var]      ; Desde variable
```

## 🔢 Sistemas Numéricos en Assembly

```nasm
mov rax, 42         ; Decimal
mov rax, 0x2A       ; Hexadecimal (mismo valor)
mov rax, 052        ; Octal
mov rax, 101010b    ; Binario
```

## 💡 Conceptos Clave

### 1. Sistema de Llamadas (Syscalls)

En Linux, para interactuar con el sistema operativo:

```nasm
mov rax, número_syscall
; Parámetros en RDI, RSI, RDX, R10, R8, R9
syscall
```

Syscalls comunes:
- **rax=1**: write (escribir)
- **rax=60**: exit (salir)
- **rax=0**: read (leer)

### 2. Convención Intel vs AT&T

Este curso usa **sintaxis Intel**:
```nasm
; Intel (NASM)
mov rax, rbx        ; destino, origen

; AT&T (GAS) - NO usaremos esta
mov %rbx, %rax      ; origen, destino
```

## 📚 Instrucciones Básicas para Empezar

| Instrucción | Descripción | Ejemplo |
|-------------|-------------|---------|
| `mov dest, orig` | Copiar valor | `mov rax, 5` |
| `add dest, orig` | Sumar | `add rax, 3` |
| `sub dest, orig` | Restar | `sub rax, 2` |
| `inc dest` | Incrementar en 1 | `inc rax` |
| `dec dest` | Decrementar en 1 | `dec rax` |
| `syscall` | Llamada al sistema | `syscall` |
| `xor dest, orig` | XOR lógico | `xor rax, rax` (poner a 0) |

## ✅ Resumen

En este módulo aprendiste:
- ✓ Qué es Assembly y por qué es importante
- ✓ La arquitectura x86-64 básica
- ✓ Los registros principales del procesador
- ✓ La sintaxis básica de NASM
- ✓ Cómo se estructura un programa en Assembly

## 🎯 Próximos Pasos

Ahora estás listo para:
1. Ver los **ejemplos/** de este módulo
2. Hacer los **ejercicios/** para practicar
3. Continuar con el **Módulo 2** donde escribirás tu primer programa

---

**¡Excelente trabajo! La teoría está clara, ahora vamos a la práctica.**
