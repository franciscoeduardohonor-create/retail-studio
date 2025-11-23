# EJERCICIOS - MÓDULO 2: CONTROL DE FLUJO Y FUNCIONES

## PARTE 1: CONDICIONALES Y SWITCH

### Ejercicio 1: Calculadora de Notas
**Dificultad:** Fácil

Crea un programa que:
1. Pida una calificación numérica (0-100)
2. Convierta la nota a letra según:
   - A: 90-100
   - B: 80-89
   - C: 70-79
   - D: 60-69
   - F: 0-59
3. Muestre si aprobó o reprobó

---

### Ejercicio 2: Año Bisiesto
**Dificultad:** Media

Un año es bisiesto si:
- Es divisible entre 4 Y
- NO es divisible entre 100, EXCEPTO que también sea divisible entre 400

Ejemplos:
- 2020: bisiesto (divisible entre 4 y no entre 100)
- 1900: no bisiesto (divisible entre 100 pero no entre 400)
- 2000: bisiesto (divisible entre 400)

Crea un programa que determine si un año es bisiesto.

---

### Ejercicio 3: Menú de Restaurante
**Dificultad:** Media

Crea un programa que:
1. Muestre un menú con 5 platillos y sus precios
2. Permita al usuario seleccionar un platillo
3. Pregunte si quiere bebida (+$20)
4. Pregunte si quiere postre (+$35)
5. Calcule el total con IVA (16%)
6. Muestre el ticket completo

**Usa switch para el menú principal**

---

### Ejercicio 4: Piedra, Papel o Tijera
**Dificultad:** Media

Crea el juego clásico contra la computadora:
1. El jugador elige (1=Piedra, 2=Papel, 3=Tijera)
2. La computadora elige aleatoriamente
3. Determina el ganador
4. Muestra el resultado

**Pista:** Para número aleatorio: `rand() % 3 + 1`

---

## PARTE 2: BUCLES

### Ejercicio 5: Tabla de Multiplicar
**Dificultad:** Fácil

Crea un programa que:
1. Pida un número al usuario
2. Muestre su tabla de multiplicar del 1 al 10

**Ejemplo:**
```
Tabla del 7:
7 x 1 = 7
7 x 2 = 14
...
7 x 10 = 70
```

---

### Ejercicio 6: Números Primos
**Dificultad:** Media

Crea un programa que:
1. Pida un número al usuario
2. Determine si es primo
3. Si no es primo, muestre sus divisores

**Recordatorio:** Un número primo solo es divisible entre 1 y sí mismo.

---

### Ejercicio 7: Fibonacci
**Dificultad:** Media

Genera los primeros N números de la secuencia Fibonacci.

**Secuencia:** 0, 1, 1, 2, 3, 5, 8, 13, 21, 34...

Cada número es la suma de los dos anteriores.

**Ejemplo:**
```
¿Cuántos números?: 10
0 1 1 2 3 5 8 13 21 34
```

---

### Ejercicio 8: Patrón de Asteriscos
**Dificultad:** Media

Crea un programa que dibuje estos patrones usando bucles anidados:

**Patrón 1 (Triángulo):**
```
*
**
***
****
*****
```

**Patrón 2 (Pirámide):**
```
    *
   ***
  *****
 *******
*********
```

**Patrón 3 (Rombo):**
```
    *
   ***
  *****
   ***
    *
```

---

### Ejercicio 9: Suma de Dígitos
**Dificultad:** Media

Crea un programa que:
1. Pida un número entero
2. Sume todos sus dígitos

**Ejemplo:**
```
Número: 12345
Suma de dígitos: 1+2+3+4+5 = 15
```

**Pista:** Usa % 10 para obtener el último dígito y / 10 para quitar el último dígito.

---

## PARTE 3: FUNCIONES

### Ejercicio 10: Calculadora con Funciones
**Dificultad:** Fácil-Media

Crea una calculadora usando funciones separadas:
- `sumar(a, b)`
- `restar(a, b)`
- `multiplicar(a, b)`
- `dividir(a, b)` (validar división entre cero)

El programa debe:
1. Mostrar un menú
2. Pedir dos números
3. Llamar la función correspondiente
4. Mostrar el resultado

---

### Ejercicio 11: Funciones de Validación
**Dificultad:** Media

Crea funciones que validen:
- `esVocal(char c)`: retorna true si es vocal
- `esDigito(char c)`: retorna true si es dígito (0-9)
- `esMayuscula(char c)`: retorna true si es mayúscula
- `esMinuscula(char c)`: retorna true si es minúscula

Prueba cada función con diferentes caracteres.

---

### Ejercicio 12: Conversor de Temperatura
**Dificultad:** Media

Crea un programa con estas funciones:
- `celsiusAFahrenheit(double c)`
- `fahrenheitACelsius(double f)`
- `celsiusAKelvin(double c)`
- `kelvinACelsius(double k)`

El programa debe:
1. Mostrar un menú de conversión
2. Pedir la temperatura
3. Mostrar el resultado

---

### Ejercicio 13: Área de Figuras (Sobrecarga)
**Dificultad:** Media

Usa sobrecarga de funciones para calcular áreas:

```cpp
double area(double radio);              // Círculo
double area(double base, double altura); // Rectángulo o triángulo
double area(double a, double b, double c); // Triángulo (Herón)
```

**Fórmula de Herón:**
```
s = (a + b + c) / 2
area = √(s(s-a)(s-b)(s-c))
```

---

### Ejercicio 14: Números Perfectos
**Dificultad:** Media-Alta

Un número perfecto es igual a la suma de sus divisores (excluyéndose a sí mismo).

Ejemplo: 6 es perfecto porque 1 + 2 + 3 = 6

Crea estas funciones:
- `sumaDivisores(int n)`: suma los divisores de n
- `esPerfecto(int n)`: retorna true si es perfecto
- `mostrarDivisores(int n)`: muestra los divisores

Encuentra los primeros 3 números perfectos.

---

### Ejercicio 15: MCD y MCM
**Dificultad:** Alta

Crea funciones para calcular:
- `mcd(int a, int b)`: Máximo Común Divisor (Algoritmo de Euclides)
- `mcm(int a, int b)`: Mínimo Común Múltiplo

**Algoritmo de Euclides para MCD:**
```
mientras b ≠ 0:
    temp = b
    b = a % b
    a = temp
retornar a
```

**Relación:** MCM(a,b) = (a × b) / MCD(a,b)

---

### Ejercicio 16: Palíndromo (Recursivo)
**Dificultad:** Alta

Crea una función RECURSIVA que determine si un número es palíndromo.

Un palíndromo se lee igual al derecho y al revés.

Ejemplos: 121, 1221, 12321

**Pista:** Necesitarás funciones auxiliares para obtener dígitos.

---

## EJERCICIO INTEGRADOR

### Ejercicio 17: Sistema de Gestión de Biblioteca
**Dificultad:** Alta

Crea un programa completo que:

**Funciones requeridas:**
- Menú principal con switch
- Agregar libro (máximo 100 libros)
- Buscar libro por título
- Mostrar todos los libros
- Calcular total de libros
- Salir

**Estructura de datos:**
- Arrays para almacenar información
- Usa funciones para cada operación

**Menú:**
```
=== BIBLIOTECA ===
1. Agregar libro
2. Buscar libro
3. Mostrar todos
4. Total de libros
5. Salir
```

---

## CONSEJOS GENERALES

1. **Para condicionales:**
   - Usa `if-else` para rangos y comparaciones complejas
   - Usa `switch` para opciones discretas (menús, días, etc.)

2. **Para bucles:**
   - Usa `for` cuando sabes cuántas iteraciones necesitas
   - Usa `while` cuando la condición es más importante que el contador
   - Usa `do-while` para menús y validaciones

3. **Para funciones:**
   - Una función = una responsabilidad
   - Nombres descriptivos (calcular, verificar, obtener)
   - Usa referencias para modificar variables
   - Usa const para parámetros que no cambian

4. **Testing:**
   - Prueba con casos normales
   - Prueba con casos extremos (0, negativos, muy grandes)
   - Prueba con entradas inválidas

---

Las soluciones están en la carpeta `../soluciones/`

¡Recuerda: la práctica hace al maestro! 💪
