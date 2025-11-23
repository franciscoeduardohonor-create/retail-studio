# 🎯 Ejercicios Prácticos - Curso de Python

## Instrucciones Generales

1. Lee cada ejercicio cuidadosamente
2. Intenta resolverlo sin mirar las soluciones
3. Prueba tu código con diferentes casos
4. Si te atascas, revisa los módulos relevantes
5. Compara tu solución con otras posibles

---

## 📗 Nivel Principiante

### Variables y Tipos de Datos

#### Ejercicio 1: Información Personal
**Dificultad**: ⭐

Crea un programa que:
- Pida al usuario su nombre, edad y ciudad
- Muestre la información formateada

```python
# Tu código aquí
```

#### Ejercicio 2: Calculadora de Propina
**Dificultad**: ⭐

- Cuenta de restaurante: $450
- Porcentaje de propina: 15%
- Calcula propina y total a pagar

#### Ejercicio 3: Conversor de Temperatura
**Dificultad**: ⭐⭐

Crea funciones para convertir:
- Celsius a Fahrenheit
- Fahrenheit a Celsius
- Celsius a Kelvin

---

### Operadores

#### Ejercicio 4: Calculadora de IMC
**Dificultad**: ⭐⭐

```python
peso = 70  # kg
altura = 1.75  # metros

# 1. Calcula IMC = peso / (altura ** 2)
# 2. Muestra el resultado con 2 decimales
# 3. Interpreta el resultado:
#    < 18.5: Bajo peso
#    18.5-24.9: Normal
#    25-29.9: Sobrepeso
#    >= 30: Obesidad
```

#### Ejercicio 5: Verificador de Número Par/Impar
**Dificultad**: ⭐

Usa el operador módulo (%) para determinar si un número es par o impar.

---

### Estructuras de Control

#### Ejercicio 6: Sistema de Calificaciones
**Dificultad**: ⭐⭐

```python
calificacion = 85

# Asigna letra según:
# 90-100: A (Excelente)
# 80-89: B (Muy bien)
# 70-79: C (Bien)
# 60-69: D (Suficiente)
# <60: F (Reprobado)
```

#### Ejercicio 7: Calculadora de Descuento
**Dificultad**: ⭐⭐

```python
precio = 1000
es_cliente_vip = True
tiene_cupon = True

# Descuentos:
# - VIP: 10%
# - Cupón: 5%
# - Ambos: 15%
# Calcula precio final
```

#### Ejercicio 8: Año Bisiesto
**Dificultad**: ⭐⭐⭐

Un año es bisiesto si:
- Es divisible por 4 Y
- (NO es divisible por 100 O es divisible por 400)

```python
año = 2024
# Determina si es bisiesto
```

---

### Bucles

#### Ejercicio 9: Tabla de Multiplicar
**Dificultad**: ⭐

```python
numero = 7
# Imprime la tabla del 7 (del 1 al 10)
```

#### Ejercicio 10: FizzBuzz
**Dificultad**: ⭐⭐

Clásico problema de programación:
```python
# Para números del 1 al 30:
# - Si es múltiplo de 3: imprime "Fizz"
# - Si es múltiplo de 5: imprime "Buzz"
# - Si es múltiplo de 3 y 5: imprime "FizzBuzz"
# - Si no: imprime el número
```

#### Ejercicio 11: Factorial
**Dificultad**: ⭐⭐

```python
numero = 5
# Calcula 5! = 5 × 4 × 3 × 2 × 1
```

#### Ejercicio 12: Números Primos
**Dificultad**: ⭐⭐⭐

```python
# Imprime todos los números primos del 1 al 50
# Un número primo solo es divisible por 1 y por sí mismo
```

---

### Funciones

#### Ejercicio 13: Función es_primo()
**Dificultad**: ⭐⭐

```python
def es_primo(numero):
    # Retorna True si es primo, False si no
    pass

# Prueba
print(es_primo(7))   # True
print(es_primo(10))  # False
```

#### Ejercicio 14: Función calcular_promedio()
**Dificultad**: ⭐⭐

```python
def calcular_promedio(*numeros):
    # Acepta cualquier cantidad de números
    # Retorna el promedio
    pass

print(calcular_promedio(10, 20, 30))  # 20.0
```

#### Ejercicio 15: Función palindromo()
**Dificultad**: ⭐⭐

```python
def es_palindromo(texto):
    # Verifica si un texto se lee igual al derecho y al revés
    # Ejemplo: "anilina" -> True
    pass
```

---

### Estructuras de Datos

#### Ejercicio 16: Lista de Compras
**Dificultad**: ⭐⭐

```python
# 1. Crea una lista de productos y precios (usar diccionarios)
# 2. Calcula el total
# 3. Encuentra el producto más caro
# 4. Cuenta cuántos productos cuestan más de $50

productos = [
    {"nombre": "Pan", "precio": 30},
    {"nombre": "Leche", "precio": 25},
    {"nombre": "Huevos", "precio": 50},
    {"nombre": "Queso", "precio": 80},
]
```

#### Ejercicio 17: Agenda de Contactos
**Dificultad**: ⭐⭐

```python
# Crea un programa con estas funciones:
# - agregar_contacto(nombre, telefono)
# - buscar_contacto(nombre)
# - listar_contactos()
# - eliminar_contacto(nombre)

# Usa un diccionario para almacenar
```

#### Ejercicio 18: Análisis de Frecuencia
**Dificultad**: ⭐⭐⭐

```python
texto = "python es genial python es poderoso"

# 1. Convierte a minúsculas y divide en palabras
# 2. Cuenta frecuencia de cada palabra (usa diccionario)
# 3. Muestra las palabras ordenadas por frecuencia
```

---

## 📘 Nivel Intermedio

### Programación Orientada a Objetos

#### Ejercicio 19: Clase Estudiante
**Dificultad**: ⭐⭐

```python
class Estudiante:
    def __init__(self, nombre, edad):
        self.nombre = nombre
        self.edad = edad
        self.calificaciones = []

    def agregar_calificacion(self, calificacion):
        # Agrega calificación a la lista
        pass

    def promedio(self):
        # Retorna el promedio de calificaciones
        pass

    def aprobo(self):
        # Retorna True si promedio >= 70
        pass

# Prueba
estudiante = Estudiante("Juan", 20)
estudiante.agregar_calificacion(85)
estudiante.agregar_calificacion(90)
estudiante.agregar_calificacion(78)
print(estudiante.promedio())
print(estudiante.aprobo())
```

#### Ejercicio 20: Sistema de Productos
**Dificultad**: ⭐⭐⭐

```python
# Crea la clase base Producto con:
# - Atributos: nombre, precio, stock
# - Métodos: vender(cantidad), reabastecer(cantidad)

# Crea clases hijas:
# - ProductoElectronico (+ garantia)
# - ProductoAlimenticio (+ fecha_vencimiento)

# Implementa __str__ para mostrar información
```

#### Ejercicio 21: Clase Vector2D
**Dificultad**: ⭐⭐⭐

```python
class Vector2D:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __add__(self, otro):
        # Suma de vectores
        pass

    def __mul__(self, escalar):
        # Multiplicación por escalar
        pass

    def magnitud(self):
        # Calcula √(x² + y²)
        pass

# Prueba
v1 = Vector2D(3, 4)
v2 = Vector2D(1, 2)
v3 = v1 + v2  # (4, 6)
print(v1.magnitud())  # 5.0
```

---

### Manejo de Archivos

#### Ejercicio 22: Contador de Palabras
**Dificultad**: ⭐⭐

```python
# Lee un archivo de texto y:
# 1. Cuenta total de palabras
# 2. Cuenta total de líneas
# 3. Encuentra la palabra más larga
# 4. Guarda estadísticas en archivo JSON
```

#### Ejercicio 23: Conversor CSV a JSON
**Dificultad**: ⭐⭐

```python
# Lee un archivo CSV con datos de empleados
# Convierte a formato JSON
# Guarda en nuevo archivo
```

#### Ejercicio 24: Gestor de Configuración
**Dificultad**: ⭐⭐⭐

```python
class Config:
    def __init__(self, archivo="config.json"):
        self.archivo = archivo
        self.config = self.cargar()

    def get(self, clave, default=None):
        # Obtiene valor de configuración
        pass

    def set(self, clave, valor):
        # Establece valor de configuración
        pass

    def guardar(self):
        # Guarda configuración en archivo
        pass

    def cargar(self):
        # Carga configuración de archivo
        pass
```

---

### Excepciones

#### Ejercicio 25: Calculadora Segura
**Dificultad**: ⭐⭐

```python
def calculadora_segura(operacion, a, b):
    """
    Realiza operación con manejo de errores
    operacion: 'suma', 'resta', 'multiplicacion', 'division'
    """
    try:
        # Tu código aquí
        # Maneja division por cero
        # Maneja operación inválida
        pass
    except ZeroDivisionError:
        return "Error: División por cero"
    except:
        return "Error desconocido"
```

#### Ejercicio 26: Validador de Formulario
**Dificultad**: ⭐⭐⭐

```python
# Crea excepciones personalizadas:
# - NombreInvalidoError
# - EmailInvalidoError
# - EdadInvalidaError

# Función validar_formulario() que valide:
# - Nombre: no vacío, solo letras
# - Email: contiene @ y .
# - Edad: 18-100

# Lanza excepciones apropiadas
# Retorna True si todo válido
```

---

## 📕 Nivel Avanzado

### Decoradores

#### Ejercicio 27: Decorador Contador
**Dificultad**: ⭐⭐

```python
def contador_llamadas(func):
    """
    Cuenta cuántas veces se llama una función
    """
    # Tu código aquí
    pass

@contador_llamadas
def saludar(nombre):
    print(f"Hola, {nombre}")

saludar("Ana")   # Llamada #1
saludar("Juan")  # Llamada #2
```

#### Ejercicio 28: Decorador de Validación
**Dificultad**: ⭐⭐⭐

```python
def validar_tipos(*tipos):
    """
    Decorador que valida tipos de argumentos
    """
    def decorador(func):
        def envoltura(*args):
            # Validar que cada arg coincida con su tipo
            # Si no, lanzar TypeError
            pass
        return envoltura
    return decorador

@validar_tipos(int, int)
def sumar(a, b):
    return a + b

sumar(5, 3)      # OK
sumar(5, "3")    # TypeError
```

---

## 🏆 Proyectos Completos

### Proyecto 1: Sistema de Inventario
**Nivel**: Intermedio

Características:
- Clase Producto con nombre, precio, stock
- Guardar/cargar desde JSON
- Funciones: agregar, eliminar, buscar, actualizar stock
- Generar reporte de inventario
- Alertas de stock bajo

### Proyecto 2: Gestor de Tareas con Prioridades
**Nivel**: Intermedio

Características:
- Agregar tareas con prioridad (alta, media, baja)
- Marcar como completadas
- Filtrar por prioridad
- Guardar en archivo JSON
- Interfaz de línea de comandos

### Proyecto 3: Analizador de Logs
**Nivel**: Avanzado

Características:
- Lee archivos de log
- Cuenta errores, warnings, info
- Genera reporte estadístico
- Filtra por fecha
- Exporta a CSV

---

## 💡 Consejos para Resolver Ejercicios

1. **Lee bien el problema**: Entiende qué se pide antes de programar
2. **Divide en pasos**: Descompón el problema en partes pequeñas
3. **Prueba con casos simples**: Antes de casos complejos
4. **Usa print()**: Para debuggear y ver valores intermedios
5. **No te rindas**: Si te atascas, descansa y vuelve después
6. **Busca ayuda**: Google, Stack Overflow, documentación

---

## 📚 Recursos para Practicar Más

- [LeetCode](https://leetcode.com/) - Problemas algorítmicos
- [HackerRank](https://www.hackerrank.com/) - Desafíos de Python
- [Codewars](https://www.codewars.com/) - Katas de programación
- [Project Euler](https://projecteuler.net/) - Problemas matemáticos

---

**¡Sigue practicando y nunca dejes de aprender! 🚀**
