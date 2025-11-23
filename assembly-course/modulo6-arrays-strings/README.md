# Módulo 6: Arrays y Strings

## 🎯 Objetivos
- Manipular arrays eficientemente
- Trabajar con strings (cadenas de caracteres)
- Implementar algoritmos de búsqueda
- Implementar algoritmos de ordenamiento

## 📊 Arrays

### Declaración
```nasm
section .data
    array_bytes db 1, 2, 3, 4, 5           ; Array de bytes
    array_words dw 100, 200, 300           ; Array de words
    array_dwords dd 1000, 2000, 3000       ; Array de dwords
    array_qwords dq 10000, 20000, 30000    ; Array de qwords
```

### Acceso a Elementos
```nasm
; array[indice]
mov rax, [array + indice*tamaño]

; Ejemplos:
mov al, [array_bytes + 2]      ; byte: tamaño = 1
mov ax, [array_words + 4]      ; word: tamaño = 2, índice 2
mov eax, [array_dwords + rcx*4] ; dword con registro
mov rax, [array_qwords + rcx*8] ; qword con registro
```

### Recorrer Array
```nasm
    mov rcx, 0              ; Índice
    mov r8, longitud        ; Tamaño del array
loop_array:
    cmp rcx, r8
    jge fin_loop

    mov rax, [array + rcx*8]    ; Procesar elemento
    ; ... hacer algo con RAX ...

    inc rcx
    jmp loop_array
fin_loop:
```

## 📝 Strings (Cadenas)

### Strings con Terminador Null
```nasm
section .data
    str1 db 'Hola', 0           ; String terminado en null
    str2 db 'Mundo', 0
```

### Instrucciones de String

| Instrucción | Descripción |
|-------------|-------------|
| **movsb** | Mover byte de RSI a RDI, incrementar ambos |
| **movsw** | Mover word |
| **movsd** | Mover dword |
| **movsq** | Mover qword |
| **lodsb** | Cargar byte de RSI a AL, incrementar RSI |
| **stosb** | Guardar AL en RDI, incrementar RDI |
| **scasb** | Comparar AL con byte en RDI, incrementar RDI |
| **cmpsb** | Comparar byte RSI con RDI, incrementar ambos |

**Prefijos de repetición:**
- **rep**: Repetir RCX veces
- **repe/repz**: Repetir mientras sea igual/cero
- **repne/repnz**: Repetir mientras no sea igual/no-cero

### Copiar String
```nasm
    lea rsi, [origen]       ; RSI = dirección origen
    lea rdi, [destino]      ; RDI = dirección destino
    mov rcx, longitud       ; RCX = cantidad de bytes
    rep movsb               ; Copiar RCX bytes
```

### Longitud de String (strlen)
```nasm
strlen:
    ; RDI = string
    ; Retorna longitud en RAX
    push rdi
    xor rax, rax
    xor rcx, rcx
    not rcx                 ; RCX = -1 (máximo)
    xor al, al              ; AL = 0 (buscar null)
    repne scasb             ; Buscar null
    not rcx                 ; Invertir
    dec rcx                 ; -1 (no contar el null)
    mov rax, rcx
    pop rdi
    ret
```

### Comparar Strings
```nasm
strcmp:
    ; RSI = string1, RDI = string2
    ; Retorna 0 si iguales
loop_cmp:
    lodsb               ; AL = *RSI++
    scasb               ; Comparar con *RDI++
    jne no_iguales
    test al, al         ; ¿Llegamos al final?
    jz iguales
    jmp loop_cmp
iguales:
    xor rax, rax
    ret
no_iguales:
    mov rax, 1
    ret
```

## 🔍 Búsqueda en Arrays

### Búsqueda Lineal
```nasm
; Buscar 'valor' en array
; RDI = array, RSI = tamaño, RDX = valor
; Retorna índice en RAX, o -1 si no se encuentra

busqueda_lineal:
    xor rcx, rcx            ; Índice = 0
loop_buscar:
    cmp rcx, rsi            ; ¿i < tamaño?
    jge no_encontrado

    cmp [rdi + rcx*8], rdx  ; ¿array[i] == valor?
    je encontrado

    inc rcx
    jmp loop_buscar

encontrado:
    mov rax, rcx
    ret

no_encontrado:
    mov rax, -1
    ret
```

## 📊 Ordenamiento

### Bubble Sort
```nasm
bubble_sort:
    ; RDI = array, RSI = tamaño
    push rbx
    push r12
    push r13

    mov r12, rsi            ; R12 = tamaño
    dec r12                 ; n-1

outer_loop:
    cmp r12, 0
    jle fin_sort

    xor r13, r13            ; j = 0
inner_loop:
    cmp r13, r12
    jge fin_inner

    ; Comparar array[j] y array[j+1]
    mov rax, [rdi + r13*8]
    mov rbx, [rdi + r13*8 + 8]

    cmp rax, rbx
    jle no_swap

    ; Intercambiar
    mov [rdi + r13*8], rbx
    mov [rdi + r13*8 + 8], rax

no_swap:
    inc r13
    jmp inner_loop

fin_inner:
    dec r12
    jmp outer_loop

fin_sort:
    pop r13
    pop r12
    pop rbx
    ret
```

Ver ejemplos completos en `ejemplos/`.
