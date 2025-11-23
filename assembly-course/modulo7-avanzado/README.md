# Módulo 7: Operaciones Avanzadas

## 🎯 Objetivos
- Manipulación de bits
- Operaciones lógicas avanzadas
- Multiplicación y división
- Punto flotante (FPU)
- Instrucciones SIMD (SSE)

## 🔢 Operaciones Lógicas Bit a Bit

### Operadores Básicos
```nasm
and rax, rbx    ; AND: 1 solo si ambos son 1
or  rax, rbx    ; OR: 1 si alguno es 1
xor rax, rbx    ; XOR: 1 si son diferentes
not rax         ; NOT: Invertir todos los bits
```

### Desplazamientos (Shifts)
```nasm
shl rax, n      ; Shift Left: desplazar izquierda n bits (× 2^n)
shr rax, n      ; Shift Right: desplazar derecha n bits (÷ 2^n)
sal rax, n      ; Shift Arithmetic Left (igual que SHL)
sar rax, n      ; Shift Arithmetic Right (preserva signo)
```

### Rotaciones
```nasm
rol rax, n      ; Rotate Left
ror rax, n      ; Rotate Right
rcl rax, n      ; Rotate through Carry Left
rcr rax, n      ; Rotate through Carry Right
```

### Operaciones de Bits
```nasm
; Activar bit N
or rax, (1 << N)
bts rax, N      ; Bit Test and Set

; Desactivar bit N
and rax, ~(1 << N)
btr rax, N      ; Bit Test and Reset

; Invertir bit N
xor rax, (1 << N)
btc rax, N      ; Bit Test and Complement

; Probar bit N
bt rax, N       ; Bit Test (CF = bit N)
```

## ✖️ Multiplicación y División

### Multiplicación Sin Signo
```nasm
; MUL: multiplica RAX por el operando
; Resultado en RDX:RAX (128 bits)

mov rax, 100
mov rbx, 50
mul rbx         ; RDX:RAX = RAX * RBX
                ; RAX = 5000 (parte baja)
                ; RDX = 0 (parte alta)
```

### Multiplicación Con Signo
```nasm
; IMUL tiene 3 formas:

; Forma 1: como MUL
imul rbx        ; RDX:RAX = RAX * RBX

; Forma 2: resultado en operando
imul rax, rbx   ; RAX = RAX * RBX (solo parte baja)

; Forma 3: con inmediato
imul rax, rbx, 10   ; RAX = RBX * 10
```

### División Sin Signo
```nasm
; DIV: divide RDX:RAX por el operando
; Cociente en RAX, Residuo en RDX

mov rax, 100
xor rdx, rdx    ; Limpiar RDX
mov rbx, 7
div rbx         ; RAX = 14, RDX = 2 (100 = 14×7 + 2)
```

### División Con Signo
```nasm
; IDIV: igual que DIV pero con signo

mov rax, -100
cqo             ; Extender signo de RAX a RDX:RAX
mov rbx, 7
idiv rbx        ; RAX = -14, RDX = -2
```

## 🎨 Trucos con Bits

```nasm
; Poner registro a 0
xor rax, rax            ; Más rápido que mov rax, 0

; Multiplicar por 2
shl rax, 1              ; Más rápido que imul rax, 2

; Dividir por 2
shr rax, 1              ; Más rápido que div (sin signo)

; Verificar si es potencia de 2
; n es potencia de 2 si (n & (n-1)) == 0
mov rbx, rax
dec rbx
and rax, rbx
test rax, rax           ; ZF=1 si es potencia de 2

; Obtener valor absoluto
mov rbx, rax
sar rbx, 63             ; RBX = todos 1s si negativo
xor rax, rbx
sub rax, rbx

; Swap sin variable temporal
xor rax, rbx
xor rbx, rax
xor rax, rbx

; Contar bits activados (población count)
popcnt rax, rbx         ; RAX = número de bits 1 en RBX (CPU moderno)
```

## 🔢 Punto Flotante (FPU)

### Registros FPU
- ST0-ST7: Stack de registros de 80 bits
- XMM0-XMM15: Registros SSE de 128 bits (más moderno)

### Operaciones Básicas FPU
```nasm
section .data
    float1 dd 3.14      ; float de 32 bits
    float2 dd 2.0
    result dd 0.0

section .text
    fld dword [float1]  ; Cargar float1 en ST0
    fld dword [float2]  ; Cargar float2 en ST0 (float1 → ST1)
    fmul st0, st1       ; ST0 = ST0 * ST1
    fstp dword [result] ; Guardar ST0 en result y pop
```

### SSE (Scalar) - Más Moderno
```nasm
section .data
    a dd 3.5
    b dd 2.0
    c dd 0.0

section .text
    movss xmm0, [a]     ; XMM0 = 3.5
    movss xmm1, [b]     ; XMM1 = 2.0
    addss xmm0, xmm1    ; XMM0 = 3.5 + 2.0 = 5.5
    movss [c], xmm0     ; c = 5.5
```

## ⚡ SIMD - Procesar Múltiples Datos

### SSE: 4 floats a la vez
```nasm
section .data
    align 16
    vec1 dd 1.0, 2.0, 3.0, 4.0      ; 4 floats
    vec2 dd 5.0, 6.0, 7.0, 8.0
    result times 4 dd 0.0

section .text
    movaps xmm0, [vec1]     ; Cargar 4 floats
    movaps xmm1, [vec2]
    addps xmm0, xmm1        ; Sumar 4 floats en paralelo
    movaps [result], xmm0
    ; result = [6.0, 8.0, 10.0, 12.0]
```

### Instrucciones SSE Comunes
- **movaps/movups**: Mover 4 floats (aligned/unaligned)
- **addps**: Sumar 4 floats
- **subps**: Restar 4 floats
- **mulps**: Multiplicar 4 floats
- **divps**: Dividir 4 floats
- **sqrtps**: Raíz cuadrada de 4 floats

Ver ejemplos prácticos en `ejemplos/`.
