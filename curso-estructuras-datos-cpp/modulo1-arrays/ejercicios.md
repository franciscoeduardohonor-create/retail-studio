# Ejercicios Prácticos - Módulo 1: Arrays

## 📝 Instrucciones
- Intenta resolver cada ejercicio por tu cuenta primero
- Compila y prueba tu código
- Verifica con las soluciones proporcionadas
- Analiza la complejidad de tu solución

---

## Nivel Principiante ⭐

### Ejercicio 1: Invertir un Array
Escribe una función que invierta los elementos de un array.

**Ejemplo:**
```
Entrada: [1, 2, 3, 4, 5]
Salida:  [5, 4, 3, 2, 1]
```

**Prototipo:**
```cpp
void invertirArray(int arr[], int tamanio);
```

---

### Ejercicio 2: Sumar Elementos
Crea una función que sume todos los elementos de un array.

**Ejemplo:**
```
Entrada: [10, 20, 30, 40]
Salida:  100
```

**Prototipo:**
```cpp
int sumarElementos(int arr[], int tamanio);
```

---

### Ejercicio 3: Contar Ocurrencias
Escribe una función que cuente cuántas veces aparece un número en un array.

**Ejemplo:**
```
Array: [1, 2, 3, 2, 4, 2, 5]
Número a buscar: 2
Salida: 3
```

**Prototipo:**
```cpp
int contarOcurrencias(int arr[], int tamanio, int numero);
```

---

## Nivel Intermedio ⭐⭐

### Ejercicio 4: Rotar Array
Crea una función que rote un array k posiciones a la derecha.

**Ejemplo:**
```
Entrada: [1, 2, 3, 4, 5], k = 2
Salida:  [4, 5, 1, 2, 3]
```

**Prototipo:**
```cpp
void rotarArray(int arr[], int tamanio, int k);
```

**Pista:** Considera usar un array temporal o el algoritmo de reversión triple.

---

### Ejercicio 5: Eliminar Duplicados
Escribe una función que elimine elementos duplicados de un array ordenado.

**Ejemplo:**
```
Entrada: [1, 1, 2, 2, 3, 4, 4, 5]
Salida:  [1, 2, 3, 4, 5]
```

**Prototipo:**
```cpp
int eliminarDuplicados(int arr[], int tamanio);
// Retorna el nuevo tamaño del array
```

---

### Ejercicio 6: Fusionar Arrays Ordenados
Fusiona dos arrays ordenados en un solo array ordenado.

**Ejemplo:**
```
Array 1: [1, 3, 5, 7]
Array 2: [2, 4, 6, 8]
Salida:  [1, 2, 3, 4, 5, 6, 7, 8]
```

**Prototipo:**
```cpp
int* fusionarArrays(int arr1[], int tam1, int arr2[], int tam2);
```

---

## Nivel Avanzado ⭐⭐⭐

### Ejercicio 7: Subarreglo de Suma Máxima (Kadane's Algorithm)
Encuentra la suma máxima de un subarreglo contiguo.

**Ejemplo:**
```
Entrada: [-2, 1, -3, 4, -1, 2, 1, -5, 4]
Salida:  6
Explicación: [4, -1, 2, 1] tiene la suma máxima = 6
```

**Prototipo:**
```cpp
int sumaMaximaSubarreglo(int arr[], int tamanio);
```

**Pista:** Este es un problema clásico. Investiga el algoritmo de Kadane.

---

### Ejercicio 8: Producto Excepto Sí Mismo
Dado un array, retorna un array donde cada posición contiene el producto de todos los elementos excepto el de esa posición.

**Ejemplo:**
```
Entrada: [1, 2, 3, 4]
Salida:  [24, 12, 8, 6]
Explicación:
  Posición 0: 2 * 3 * 4 = 24
  Posición 1: 1 * 3 * 4 = 12
  Posición 2: 1 * 2 * 4 = 8
  Posición 3: 1 * 2 * 3 = 6
```

**Restricción:** No usar división y hacerlo en O(n).

**Prototipo:**
```cpp
int* productoExceptoSiMismo(int arr[], int tamanio);
```

---

### Ejercicio 9: Matriz Espiral
Dada una matriz n x m, imprime todos sus elementos en orden espiral.

**Ejemplo:**
```
Matriz:
1  2  3  4
5  6  7  8
9  10 11 12

Salida: 1 2 3 4 8 12 11 10 9 5 6 7
```

**Prototipo:**
```cpp
void imprimirEspiral(int matriz[][100], int filas, int columnas);
```

**Pista:** Usa 4 punteros para los límites: arriba, abajo, izquierda, derecha.

---

### Ejercicio 10: Encontrar Todos los Pares con Suma K
Encuentra todos los pares de elementos en un array que sumen un valor k.

**Ejemplo:**
```
Entrada: [1, 5, 7, -1, 5], k = 6
Salida:  (1, 5), (7, -1), (1, 5)
```

**Prototipo:**
```cpp
void encontrarPares(int arr[], int tamanio, int k);
```

---

## 🎯 Desafío Especial

### Ejercicio Bonus: Sistema de Gestión de Estudiantes
Crea un programa completo que:
1. Almacene información de estudiantes (nombre, edad, calificaciones)
2. Permita agregar, eliminar y buscar estudiantes
3. Calcule el promedio general
4. Encuentre al estudiante con mejor calificación
5. Ordene estudiantes por calificación

**Estructura sugerida:**
```cpp
struct Estudiante {
    string nombre;
    int edad;
    double calificacion;
};
```

---

## 📚 Consejos para Resolver los Ejercicios

1. **Lee el problema cuidadosamente** - Asegúrate de entender qué se pide
2. **Piensa en casos extremos** - Arrays vacíos, un solo elemento, etc.
3. **Escribe pseudocódigo primero** - Planifica antes de codificar
4. **Prueba con ejemplos** - Usa los ejemplos dados y crea los tuyos
5. **Analiza la complejidad** - ¿Cuál es el Big O de tu solución?
6. **Optimiza si es necesario** - ¿Hay una forma más eficiente?

---

## ✅ Criterios de Evaluación

Para cada ejercicio, verifica:
- [ ] El código compila sin errores
- [ ] Pasa todos los casos de prueba
- [ ] Maneja casos extremos correctamente
- [ ] La complejidad es razonable
- [ ] El código está bien comentado
- [ ] Liberas la memoria (si usas allocación dinámica)

---

Las soluciones se encuentran en el archivo `soluciones.cpp`. ¡Intenta resolverlos primero antes de mirar las soluciones!
