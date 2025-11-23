# Ejercicios del Módulo 1: Fundamentos

## Instrucciones Generales

1. Intenta resolver cada ejercicio por tu cuenta primero
2. Compila y prueba tu código
3. Si te atascas, revisa los ejemplos del módulo
4. Compara tu solución con la proporcionada en `../soluciones/`
5. No hay una única forma correcta, si funciona, ¡está bien!

## 📝 Ejercicio 1: Mi Primer Programa

**Dificultad:** ⭐ Muy Fácil

**Objetivo:** Familiarizarte con la estructura básica y la compilación.

**Tarea:**
Crea un programa que:
- Salga con código de salida 5

**Pistas:**
- Recuerda usar `mov rax, 60` para exit
- El código de salida va en RDI
- Compila con: `nasm -f elf64 ejercicio1.asm -o ejercicio1.o`
- Enlaza con: `ld ejercicio1.o -o ejercicio1`
- Ejecuta y verifica: `./ejercicio1; echo $?`

**Archivo:** `ejercicio1.asm`

---

## 📝 Ejercicio 2: Suma Simple

**Dificultad:** ⭐ Muy Fácil

**Objetivo:** Practicar operaciones aritméticas básicas.

**Tarea:**
Crea un programa que:
- Calcule 7 + 8
- El resultado debe ser el código de salida (15)

**Pistas:**
- Usa `mov` para cargar el primer número
- Usa `add` para sumar el segundo número
- Mueve el resultado a RDI antes de salir

**Archivo:** `ejercicio2.asm`

---

## 📝 Ejercicio 3: Operaciones Múltiples

**Dificultad:** ⭐⭐ Fácil

**Objetivo:** Combinar múltiples operaciones aritméticas.

**Tarea:**
Crea un programa que:
- Calcule: (10 + 5) - 3
- El resultado debe ser el código de salida (12)

**Pistas:**
- Usa un registro (como RAX) para hacer las operaciones
- Primero suma, luego resta
- Recuerda mover el resultado a RDI

**Archivo:** `ejercicio3.asm`

---

## 📝 Ejercicio 4: Usando Múltiples Registros

**Dificultad:** ⭐⭐ Fácil

**Objetivo:** Practicar el uso de varios registros.

**Tarea:**
Crea un programa que:
- Cargue 20 en RAX
- Cargue 30 en RBX
- Sume RAX + RBX
- El resultado debe ser el código de salida (50)

**Pistas:**
- Necesitarás sumar el contenido de un registro a otro
- `add rax, rbx` suma RBX a RAX

**Archivo:** `ejercicio4.asm`

---

## 📝 Ejercicio 5: Incrementos y Decrementos

**Dificultad:** ⭐⭐ Fácil

**Objetivo:** Practicar INC y DEC.

**Tarea:**
Crea un programa que:
- Inicie un contador en 0
- Lo incremente 8 veces usando `inc`
- Lo decremente 3 veces usando `dec`
- El resultado debe ser el código de salida (5)

**Pistas:**
- `inc registro` incrementa en 1
- `dec registro` decrementa en 1
- Puedes escribir `inc rax` múltiples veces

**Archivo:** `ejercicio5.asm`

---

## 📝 Ejercicio 6: Variables en .data

**Dificultad:** ⭐⭐ Fácil

**Objetivo:** Declarar y usar variables.

**Tarea:**
Crea un programa que:
- Declare una variable `numero` en la sección `.data` con valor 25
- Cargue ese valor en un registro
- Le sume 10
- El resultado debe ser el código de salida (35)

**Pistas:**
- Usa `db`, `dw`, `dd` o `dq` para declarar
- Usa corchetes `[]` para acceder al valor: `mov rax, [numero]`

**Archivo:** `ejercicio6.asm`

---

## 📝 Ejercicio 7: Suma de Tres Números

**Dificultad:** ⭐⭐ Fácil

**Objetivo:** Trabajar con datos en memoria.

**Tarea:**
Crea un programa que:
- Declare tres variables en `.data`: a=10, b=20, c=15
- Sume los tres valores
- El resultado debe ser el código de salida (45)

**Pistas:**
- Declara: `a db 10`, `b db 20`, `c db 15`
- Carga cada valor y ve sumando

**Archivo:** `ejercicio7.asm`

---

## 📝 Ejercicio 8: Intercambio de Valores

**Dificultad:** ⭐⭐⭐ Medio

**Objetivo:** Practicar manipulación de registros.

**Tarea:**
Crea un programa que:
- Cargue 100 en RAX
- Cargue 50 en RBX
- Intercambie los valores (sin usar XCHG)
- La resta RAX - RBX debe dar 50 (código de salida)

**Pistas:**
- Necesitarás un registro temporal (como RCX)
- Después del intercambio: RAX=50, RBX=100
- 50 - 100 = -50, pero usa valores absolutos

Corrección: Después del intercambio RAX=50, RBX=100
Entonces: RBX - RAX = 100 - 50 = 50

**Archivo:** `ejercicio8.asm`

---

## 📝 Ejercicio 9: Array Simple

**Dificultad:** ⭐⭐⭐ Medio

**Objetivo:** Acceder a elementos de un array.

**Tarea:**
Crea un programa que:
- Declare un array de 3 bytes: [5, 10, 15]
- Sume los tres elementos
- El resultado debe ser el código de salida (30)

**Pistas:**
- Declara: `array db 5, 10, 15`
- Accede: `[array]`, `[array+1]`, `[array+2]`
- Suma cada elemento a un acumulador

**Archivo:** `ejercicio9.asm`

---

## 📝 Ejercicio 10: Desafío Final del Módulo

**Dificultad:** ⭐⭐⭐⭐ Difícil

**Objetivo:** Combinar todo lo aprendido.

**Tarea:**
Crea un programa que:
- Declare 5 variables en `.data`: v1=2, v2=3, v3=5, v4=7, v5=11
- Calcule: (v1 + v2 + v3) * 2 (simulando multiplicación con sumas)
- Reste (v4 + v5)
- El resultado debe ser el código de salida

**Cálculo esperado:**
- v1 + v2 + v3 = 2 + 3 + 5 = 10
- 10 * 2 = 20 (suma 10 + 10)
- v4 + v5 = 7 + 11 = 18
- 20 - 18 = 2 (código de salida)

**Pistas:**
- Para multiplicar por 2, suma el número consigo mismo
- Usa múltiples registros para mantener valores intermedios

**Archivo:** `ejercicio10.asm`

---

## ✅ Verificación de Resultados

Para verificar que tu programa devuelve el código correcto:

```bash
./tu_programa
echo $?
```

El número mostrado debe coincidir con el resultado esperado.

## 🎯 ¡Buena suerte!

Recuerda: el objetivo es **aprender practicando**. No te preocupes si no lo consigues a la primera. ¡Sigue intentando!
