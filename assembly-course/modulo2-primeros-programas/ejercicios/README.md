# Ejercicios del Módulo 2: Primeros Programas

## 📝 Ejercicio 1: Personaliza Hello World

**Dificultad:** ⭐ Muy Fácil

**Tarea:**
Crea un programa que imprima "Hola, [TU NOMBRE]!" seguido de una nueva línea.

**Archivo:** `ejercicio1.asm`

---

## 📝 Ejercicio 2: Dos Líneas

**Dificultad:** ⭐ Muy Fácil

**Tarea:**
Imprime dos líneas separadas:
```
Primera línea
Segunda línea
```

**Pistas:**
- Puedes usar un solo string con '\n' en medio
- O dos strings separados con dos syscalls write

**Archivo:** `ejercicio2.asm`

---

## 📝 Ejercicio 3: Resultado de Suma

**Dificultad:** ⭐⭐ Fácil

**Tarea:**
Calcula 5 + 3 e imprime:
```
5 + 3 = 8
```

**Pistas:**
- Necesitas imprimir texto y números
- Convierte el número a ASCII (+ '0')

**Archivo:** `ejercicio3.asm`

---

## 📝 Ejercicio 4: Menú Simple

**Dificultad:** ⭐⭐ Fácil

**Tarea:**
Crea un menú:
```
=== MENÚ ===
1. Opción A
2. Opción B
3. Salir
=============
```

**Archivo:** `ejercicio4.asm`

---

## 📝 Ejercicio 5: Calcular e Imprimir

**Dificultad:** ⭐⭐⭐ Medio

**Tarea:**
Calcula (7 + 2) - 4 e imprime el resultado (5).
Debe mostrar: "Resultado: 5"

**Archivo:** `ejercicio5.asm`

---

## 📝 Ejercicio 6: Número de Dos Dígitos

**Dificultad:** ⭐⭐⭐ Medio

**Tarea:**
Imprime el número 42 usando el algoritmo de división.

**Pistas:**
- Usa el ejemplo 04 como referencia
- 42 ÷ 10 = 4 residuo 2

**Archivo:** `ejercicio6.asm`

---

## 📝 Ejercicio 7: Tabla ASCII

**Dificultad:** ⭐⭐⭐ Medio

**Tarea:**
Imprime los caracteres del 65 al 70 (A-F en ASCII):
```
A
B
C
D
E
F
```

**Archivo:** `ejercicio7.asm`

---

## ✅ Compilar y Ejecutar

```bash
nasm -f elf64 ejercicio1.asm -o ejercicio1.o
ld ejercicio1.o -o ejercicio1
./ejercicio1
```
