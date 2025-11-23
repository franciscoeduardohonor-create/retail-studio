# Módulo 2: Primeros Programas

## 🎯 Objetivos de Aprendizaje

Al finalizar este módulo, serás capaz de:
- Escribir y ejecutar el clásico "Hello World"
- Usar syscalls de Linux para entrada/salida
- Crear programas que interactúen con el usuario
- Entender el paso de parámetros a syscalls

## 📖 System Calls en Linux

Las **system calls** (syscalls) son la forma en que tu programa se comunica con el kernel de Linux para realizar operaciones como:
- Leer entrada del teclado
- Escribir en la pantalla
- Abrir archivos
- Salir del programa

### Cómo Hacer una Syscall en x86-64 Linux

```nasm
mov rax, número_syscall    ; Número de la syscall
mov rdi, argumento1        ; Primer argumento
mov rsi, argumento2        ; Segundo argumento
mov rdx, argumento3        ; Tercer argumento
; ... más argumentos en R10, R8, R9 si es necesario
syscall                    ; Ejecutar la syscall
```

### Syscalls Importantes para este Módulo

| Número | Nombre | Argumentos | Descripción |
|--------|--------|------------|-------------|
| **0** | read | rdi=fd, rsi=buffer, rdx=count | Leer datos |
| **1** | write | rdi=fd, rsi=buffer, rdx=count | Escribir datos |
| **60** | exit | rdi=código | Salir del programa |

#### Descriptores de Archivo (File Descriptors)

| Número | Nombre | Descripción |
|--------|--------|-------------|
| 0 | stdin | Entrada estándar (teclado) |
| 1 | stdout | Salida estándar (pantalla) |
| 2 | stderr | Salida de errores |

## 🖥️ Hello World en Assembly

Este es el programa más famoso en cualquier lenguaje:

```nasm
section .data
    mensaje db 'Hello, World!', 10    ; 10 = '\n' (nueva línea)
    longitud equ $ - mensaje           ; Calcular longitud

section .text
    global _start

_start:
    ; write(stdout, mensaje, longitud)
    mov rax, 1              ; syscall: write
    mov rdi, 1              ; fd = 1 (stdout)
    mov rsi, mensaje        ; buffer = dirección del mensaje
    mov rdx, longitud       ; count = longitud del mensaje
    syscall

    ; exit(0)
    mov rax, 60             ; syscall: exit
    xor rdi, rdi            ; código = 0
    syscall
```

### Explicación Detallada

1. **`mensaje db 'Hello, World!', 10`**
   - Define una cadena de caracteres
   - `10` es el código ASCII de nueva línea (`\n`)

2. **`longitud equ $ - mensaje`**
   - `$` = posición actual en memoria
   - `mensaje` = posición del inicio del mensaje
   - `$ - mensaje` = longitud del mensaje en bytes
   - `equ` = define una constante

3. **Syscall write**
   - RAX = 1 (número de syscall write)
   - RDI = 1 (stdout)
   - RSI = dirección del mensaje
   - RDX = cantidad de bytes a escribir

## 📝 Imprimiendo Números

Assembly no tiene un `printf` integrado. Para imprimir números, debemos:
1. Convertir el número a caracteres ASCII
2. Imprimir esos caracteres

### Conversión Simple (un dígito)

```nasm
mov al, 5           ; Número a imprimir (0-9)
add al, '0'         ; Convertir a ASCII ('0' = 48)
                    ; 5 + 48 = 53 = ASCII de '5'
```

## 💡 Calculando Longitudes

### Método 1: Usando $ (posición actual)
```nasm
mensaje db 'Hola'
long equ $ - mensaje    ; long = 4
```

### Método 2: Contando manualmente
```nasm
mensaje db 'Hola'
long equ 4              ; Contamos: H-o-l-a = 4
```

### Método 3: Para strings terminados en null
```nasm
mensaje db 'Hola', 0    ; String con null terminator
; Necesitarías un loop para contar hasta encontrar el 0
```

## 🔧 Macros Útiles (Avanzado)

Para simplificar código repetitivo, podemos usar macros:

```nasm
%macro print 2          ; Macro con 2 parámetros
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; stdout
    mov rsi, %1         ; primer parámetro: mensaje
    mov rdx, %2         ; segundo parámetro: longitud
    syscall
%endmacro

; Uso:
print mensaje, longitud
```

## 📊 Tabla ASCII (Caracteres Importantes)

| Carácter | Decimal | Hex | Descripción |
|----------|---------|-----|-------------|
| '0' | 48 | 0x30 | Cero |
| '9' | 57 | 0x39 | Nueve |
| 'A' | 65 | 0x41 | A mayúscula |
| 'Z' | 90 | 0x5A | Z mayúscula |
| 'a' | 97 | 0x61 | a minúscula |
| 'z' | 122 | 0x7A | z minúscula |
| ' ' | 32 | 0x20 | Espacio |
| '\n' | 10 | 0x0A | Nueva línea |
| '\t' | 9 | 0x09 | Tabulación |
| '\0' | 0 | 0x00 | Null (fin de string) |

## 🎨 Formato de Salida

### Nueva Línea
```nasm
mensaje db 'Línea 1', 10, 'Línea 2', 10
```

### Tabulación
```nasm
mensaje db 'Nombre', 9, 'Apellido', 10    ; 9 = '\t'
```

### Múltiples Líneas
```nasm
mensaje db 'Línea 1', 10
        db 'Línea 2', 10
        db 'Línea 3', 10
```

## ⚠️ Errores Comunes

### 1. Olvidar la Nueva Línea
```nasm
; ❌ Sin nueva línea
mensaje db 'Hola'

; ✅ Con nueva línea
mensaje db 'Hola', 10
```

### 2. Longitud Incorrecta
```nasm
; ❌ Longitud incorrecta
mensaje db 'Hola', 10
long equ 4              ; Debería ser 5 (incluyendo el 10)

; ✅ Longitud correcta
mensaje db 'Hola', 10
long equ $ - mensaje    ; Automáticamente = 5
```

### 3. Usar el Registro Equivocado
```nasm
; ❌ Syscall incorrecta
mov rdi, 1              ; syscall en RDI (debería ser RAX)

; ✅ Syscall correcta
mov rax, 1              ; syscall en RAX
```

## ✅ Resumen

En este módulo aprendiste:
- ✓ Cómo usar la syscall `write` para imprimir en pantalla
- ✓ Cómo calcular la longitud de strings
- ✓ El concepto de descriptores de archivo (stdin, stdout, stderr)
- ✓ Cómo funcionan los parámetros de las syscalls
- ✓ La tabla ASCII básica

## 🎯 Próximos Pasos

1. Estudia los **ejemplos/** de este módulo
2. Practica con los **ejercicios/**
3. Experimenta modificando los programas
4. Continúa con el **Módulo 3** para profundizar en registros y memoria

---

**¡Ahora puedes crear programas que realmente hagan algo visible!**
