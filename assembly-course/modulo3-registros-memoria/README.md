# Módulo 3: Registros y Memoria Avanzada

## 🎯 Objetivos
- Dominar el direccionamiento de memoria
- Entender los modos de direccionamiento
- Trabajar con punteros
- Manipular datos en diferentes tamaños

## 📖 Modos de Direccionamiento

### 1. Inmediato
```nasm
mov rax, 42         ; El valor 42 directamente
```

### 2. Registro
```nasm
mov rax, rbx        ; Valor de RBX a RAX
```

### 3. Directo
```nasm
mov rax, [variable] ; Valor en la dirección 'variable'
```

### 4. Indirecto por Registro
```nasm
mov rax, [rbx]      ; Valor en la dirección contenida en RBX
```

### 5. Indexado
```nasm
mov rax, [rbx + rcx]        ; rbx + rcx como dirección
mov rax, [array + 8]        ; Desplazamiento constante
mov rax, [rbx + rcx*4]      ; Con escala (1, 2, 4, 8)
```

### 6. Base + Índice + Desplazamiento
```nasm
mov rax, [rbx + rcx*8 + 16] ; Modo completo
```

## 🔢 Tamaños de Datos

| Nombre | Bits | Bytes | Registro | Ejemplo |
|--------|------|-------|----------|---------|
| Byte | 8 | 1 | AL, BL | db |
| Word | 16 | 2 | AX, BX | dw |
| Double Word | 32 | 4 | EAX, EBX | dd |
| Quad Word | 64 | 8 | RAX, RBX | dq |
| Double Quad | 128 | 16 | XMM | dq+dq |

## 💾 La Memoria

### Segmentos Importantes
- **Stack**: Crece hacia abajo, para datos temporales
- **Heap**: Memoria dinámica (malloc en C)
- **Data**: Variables globales inicializadas
- **BSS**: Variables globales sin inicializar
- **Text**: Código ejecutable

### Little Endian
x86-64 usa little endian: el byte menos significativo primero.

```nasm
; Número 0x12345678 en memoria:
; Dirección: 0x1000  0x1001  0x1002  0x1003
; Valor:       78      56      34      12
```

## 🎯 LEA - Load Effective Address

```nasm
lea rax, [rbx + rcx*4 + 8]  ; RAX = rbx + rcx*4 + 8 (la dirección)
; vs
mov rax, [rbx + rcx*4 + 8]  ; RAX = valor en esa dirección
```

LEA es útil para:
- Calcular direcciones
- Aritmética rápida (lea rax, [rax + rax*2] → rax *= 3)

## 📝 Instrucciones de Movimiento

```nasm
mov dest, src       ; Copiar
movzx rax, bl       ; Mover con extensión de ceros
movsx rax, bl       ; Mover con extensión de signo
xchg rax, rbx       ; Intercambiar
```

Ver ejemplos en la carpeta `ejemplos/` para prácticas.
