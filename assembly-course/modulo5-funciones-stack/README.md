# Módulo 5: Funciones y Stack

## 🎯 Objetivos
- Entender el stack y sus operaciones
- Crear y llamar funciones
- Pasar parámetros
- Variables locales
- Convenciones de llamada

## 📚 El Stack (Pila)

El stack es una región de memoria que:
- Crece **hacia abajo** (de direcciones altas a bajas)
- Funciona como LIFO (Last In, First Out)
- Se usa para guardar datos temporales

### Registros del Stack
- **RSP**: Stack Pointer - apunta al tope del stack
- **RBP**: Base Pointer - apunta a la base del frame actual

### Operaciones Básicas

```nasm
push rax        ; Poner RAX en el stack
                ; 1. RSP -= 8
                ; 2. [RSP] = RAX

pop rbx         ; Sacar del stack a RBX
                ; 1. RBX = [RSP]
                ; 2. RSP += 8
```

## 🔧 Convención de Llamada System V AMD64

Para Linux x86-64, los primeros 6 parámetros van en registros:

| Parámetro | Registro |
|-----------|----------|
| 1º | RDI |
| 2º | RSI |
| 3º | RDX |
| 4º | RCX |
| 5º | R8 |
| 6º | R9 |
| 7º+ | Stack |

**Valor de retorno:** RAX

**Registros preservados** (callee-saved): RBX, RBP, R12-R15
**Registros volátiles** (caller-saved): RAX, RCX, RDX, RSI, RDI, R8-R11

## 📝 Estructura de una Función

```nasm
mi_funcion:
    ; Prólogo
    push rbp            ; Guardar RBP anterior
    mov rbp, rsp        ; RBP = base del frame actual
    sub rsp, N          ; Reservar N bytes para variables locales

    ; ... cuerpo de la función ...

    ; Epílogo
    mov rsp, rbp        ; Restaurar stack
    pop rbp             ; Restaurar RBP anterior
    ret                 ; Retornar (pop RIP)
```

## 🎯 Ejemplo: Función Suma

```nasm
; int suma(int a, int b)
; a en RDI, b en RSI
; retorna en RAX

suma:
    push rbp
    mov rbp, rsp

    mov rax, rdi        ; RAX = a
    add rax, rsi        ; RAX = a + b

    pop rbp
    ret

; Llamar a la función:
    mov rdi, 10         ; Primer parámetro
    mov rsi, 20         ; Segundo parámetro
    call suma           ; Llamar función
    ; RAX ahora contiene 30
```

## 🔄 Instrucción CALL y RET

```nasm
call funcion    ; 1. push RIP (dirección de retorno)
                ; 2. jmp funcion

ret             ; pop RIP (volver a donde se llamó)
```

## 🎒 Variables Locales

```nasm
funcion:
    push rbp
    mov rbp, rsp
    sub rsp, 16         ; Reservar 16 bytes (2 qwords)

    ; Variables locales:
    ; [rbp - 8]  = primera variable local
    ; [rbp - 16] = segunda variable local

    mov qword [rbp - 8], 100    ; local1 = 100
    mov qword [rbp - 16], 200   ; local2 = 200

    mov rax, [rbp - 8]
    add rax, [rbp - 16]         ; RAX = local1 + local2

    mov rsp, rbp
    pop rbp
    ret
```

## ⚠️ Preservar Registros

Si una función usa RBX, R12-R15, debe preservarlos:

```nasm
funcion:
    push rbp
    mov rbp, rsp
    push rbx            ; Guardar RBX
    push r12            ; Guardar R12

    ; ... usar RBX y R12 ...

    pop r12             ; Restaurar R12
    pop rbx             ; Restaurar RBX
    pop rbp
    ret
```

## 🔁 Recursión

```nasm
; factorial(n) = n * factorial(n-1)
; factorial(0) = 1

factorial:
    push rbp
    mov rbp, rsp

    cmp rdi, 0          ; ¿n == 0?
    je caso_base

    push rdi            ; Guardar n
    dec rdi             ; n-1
    call factorial      ; factorial(n-1) en RAX

    pop rdi             ; Recuperar n
    imul rax, rdi       ; RAX = n * factorial(n-1)
    jmp fin

caso_base:
    mov rax, 1          ; factorial(0) = 1

fin:
    pop rbp
    ret
```

Ver ejemplos completos en `ejemplos/`.
