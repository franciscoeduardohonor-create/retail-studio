# Módulo 4: Control de Flujo

## 🎯 Objetivos
- Entender las comparaciones y banderas
- Usar saltos condicionales
- Implementar if/else
- Crear loops (while, for)

## 🚦 Banderas (FLAGS)

Las banderas se activan/desactivan según el resultado de operaciones:

| Bandera | Nombre | Se activa cuando... |
|---------|--------|---------------------|
| **ZF** | Zero | El resultado es 0 |
| **CF** | Carry | Hay acarreo/préstamo |
| **SF** | Sign | El resultado es negativo |
| **OF** | Overflow | Desbordamiento con signo |
| **PF** | Parity | Paridad par |

## 📊 Instrucción CMP (Compare)

```nasm
cmp operando1, operando2    ; Hace: operando1 - operando2
                            ; NO guarda el resultado
                            ; SOLO actualiza las banderas
```

Ejemplos:
```nasm
cmp rax, 5      ; Compara RAX con 5
cmp rax, rbx    ; Compara RAX con RBX
cmp [var], 10   ; Compara variable con 10
```

## 🔀 Saltos (Jumps)

### Salto Incondicional
```nasm
jmp etiqueta    ; Salta siempre
```

### Saltos Condicionales (después de CMP)

**Para números sin signo:**
| Instrucción | Significado | Condición |
|-------------|-------------|-----------|
| je / jz | Jump if Equal / Zero | ZF = 1 |
| jne / jnz | Jump if Not Equal / Not Zero | ZF = 0 |
| ja | Jump if Above | CF=0 y ZF=0 |
| jae / jnc | Jump if Above or Equal | CF = 0 |
| jb / jc | Jump if Below | CF = 1 |
| jbe | Jump if Below or Equal | CF=1 o ZF=1 |

**Para números con signo:**
| Instrucción | Significado | Condición |
|-------------|-------------|-----------|
| jg | Jump if Greater | ZF=0 y SF=OF |
| jge | Jump if Greater or Equal | SF = OF |
| jl | Jump if Less | SF ≠ OF |
| jle | Jump if Less or Equal | ZF=1 o SF≠OF |

## 🔨 Estructura IF

```nasm
; if (rax == 5) {
;     rbx = 10
; }

    cmp rax, 5          ; Comparar RAX con 5
    jne fin_if          ; Si NO es igual, saltar
    mov rbx, 10         ; Código del if
fin_if:
```

## 🔨 Estructura IF-ELSE

```nasm
; if (rax > 10) {
;     rbx = 1
; } else {
;     rbx = 0
; }

    cmp rax, 10         ; Comparar RAX con 10
    jle else_parte      ; Si menor o igual, ir a else
    mov rbx, 1          ; Código del if
    jmp fin_if_else     ; Saltar el else
else_parte:
    mov rbx, 0          ; Código del else
fin_if_else:
```

## 🔁 Loops

### Loop WHILE

```nasm
; while (rcx > 0) {
;     rax += 1
;     rcx -= 1
; }

loop_while:
    cmp rcx, 0          ; ¿RCX > 0?
    jle fin_while       ; Si no, salir
    inc rax             ; Cuerpo del loop
    dec rcx
    jmp loop_while      ; Volver al inicio
fin_while:
```

### Loop FOR (con contador)

```nasm
; for (rcx = 0; rcx < 10; rcx++) {
;     rax += 1
; }

    mov rcx, 0          ; Inicializar contador
loop_for:
    cmp rcx, 10         ; ¿RCX < 10?
    jge fin_for         ; Si no, salir
    inc rax             ; Cuerpo del loop
    inc rcx             ; rcx++
    jmp loop_for        ; Repetir
fin_for:
```

### Instrucción LOOP

```nasm
; LOOP usa RCX como contador automáticamente
; Decrementa RCX y salta si RCX != 0

    mov rcx, 10         ; Contador
loop_inicio:
    ; ... código ...
    loop loop_inicio    ; rcx--; if (rcx != 0) jmp loop_inicio
```

## ⚡ Instrucción TEST

Similar a CMP, pero hace AND en lugar de SUB:

```nasm
test rax, rax       ; AND de RAX consigo mismo
                    ; Actualiza ZF: si RAX=0 entonces ZF=1
jz es_cero          ; Salta si es cero
```

## 📝 Ejemplo Completo: Máximo de Dos Números

```nasm
; Encontrar el mayor entre RAX y RBX, guardarlo en RDX

    cmp rax, rbx        ; Comparar
    jge rax_mayor       ; Si RAX >= RBX
    mov rdx, rbx        ; RDX = RBX (el mayor)
    jmp fin
rax_mayor:
    mov rdx, rax        ; RDX = RAX (el mayor)
fin:
```

## 🎯 Consejos

1. **Siempre usa la comparación correcta**: signada vs no signada
2. **Las banderas se sobreescriben**: CMP/TEST antes del salto
3. **Nombra bien las etiquetas**: `loop_inicio`, `fin_if`, etc.
4. **Evita loops infinitos**: asegúrate de tener condición de salida

Ver ejemplos prácticos en `ejemplos/`.
