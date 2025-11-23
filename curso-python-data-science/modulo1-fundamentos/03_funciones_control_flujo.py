"""
MÓDULO 1 - FUNDAMENTOS DE PYTHON
Lección 3: Funciones y Control de Flujo

En esta lección aprenderás:
- Condicionales (if, elif, else)
- Bucles (for, while)
- Funciones
- Argumentos y parámetros
- Lambda functions
- Manejo de errores
"""

# ============================================
# 1. CONDICIONALES
# ============================================

print("="*50)
print("CONDICIONALES (if, elif, else)")
print("="*50)

# Estructura básica if-else
temperatura = 25

if temperatura > 30:
    print("Hace mucho calor")
elif temperatura > 20:
    print("Clima agradable")
elif temperatura > 10:
    print("Clima fresco")
else:
    print("Hace frío")

# Operadores de comparación
# == igual, != diferente, > mayor, < menor, >= mayor o igual, <= menor o igual

edad = 18
tiene_licencia = True

# Operadores lógicos: and, or, not
if edad >= 18 and tiene_licencia:
    print("\nPuede conducir")
else:
    print("\nNo puede conducir")

# Operador ternario (condición en una línea)
resultado = "Aprobado" if 85 >= 60 else "Reprobado"
print(f"\nResultado: {resultado}")

# Verificar pertenencia con 'in'
frutas = ["manzana", "banana", "naranja"]
if "banana" in frutas:
    print("\nBanana está en la lista")

# ============================================
# 2. BUCLE FOR
# ============================================

print("\n" + "="*50)
print("BUCLE FOR")
print("="*50)

# Iterar sobre una lista
print("\n--- Iterando sobre lista ---")
ciudades = ["Madrid", "Barcelona", "Valencia", "Sevilla"]
for ciudad in ciudades:
    print(f"Ciudad: {ciudad}")

# Iterar con índice usando enumerate()
print("\n--- Con índice ---")
for i, ciudad in enumerate(ciudades, start=1):
    print(f"{i}. {ciudad}")

# Iterar sobre un rango de números
print("\n--- Tabla del 5 ---")
for i in range(1, 11):  # range(inicio, fin) - no incluye el fin
    print(f"5 x {i} = {5 * i}")

# Iterar sobre diccionario
print("\n--- Iterando diccionario ---")
ventas = {"enero": 1000, "febrero": 1200, "marzo": 1500}
for mes, cantidad in ventas.items():
    print(f"{mes}: ${cantidad}")

# ============================================
# 3. BUCLE WHILE
# ============================================

print("\n" + "="*50)
print("BUCLE WHILE")
print("="*50)

# El bucle while se ejecuta mientras la condición sea True
contador = 1
print("\n--- Contando hasta 5 ---")
while contador <= 5:
    print(f"Contador: {contador}")
    contador += 1

# Ejemplo práctico: Búsqueda
print("\n--- Búsqueda de elemento ---")
numeros = [10, 25, 30, 45, 50]
objetivo = 30
indice = 0
encontrado = False

while indice < len(numeros) and not encontrado:
    if numeros[indice] == objetivo:
        print(f"¡Encontrado {objetivo} en el índice {indice}!")
        encontrado = True
    indice += 1

if not encontrado:
    print(f"No se encontró {objetivo}")

# Control de bucles: break y continue
print("\n--- Break y Continue ---")
for i in range(1, 11):
    if i == 3:
        continue  # Saltar esta iteración
    if i == 8:
        break  # Salir del bucle
    print(i, end=" ")
print()

# ============================================
# 4. FUNCIONES
# ============================================

print("\n" + "="*50)
print("FUNCIONES")
print("="*50)

# Definir una función simple
def saludar():
    """Esta es una función simple que saluda"""
    print("¡Hola, bienvenido al curso de Data Science!")

# Llamar la función
saludar()

# Función con parámetros
def saludar_persona(nombre):
    """Función que recibe un parámetro"""
    return f"¡Hola, {nombre}!"

mensaje = saludar_persona("María")
print(f"\n{mensaje}")

# Función con múltiples parámetros
def calcular_area_rectangulo(largo, ancho):
    """Calcula el área de un rectángulo"""
    area = largo * ancho
    return area

area = calcular_area_rectangulo(5, 3)
print(f"\nÁrea del rectángulo: {area}")

# Parámetros con valores por defecto
def crear_perfil(nombre, edad, ciudad="No especificada"):
    """Función con parámetro opcional"""
    return {
        "nombre": nombre,
        "edad": edad,
        "ciudad": ciudad
    }

perfil1 = crear_perfil("Ana", 25, "Madrid")
perfil2 = crear_perfil("Luis", 30)  # ciudad usa valor por defecto

print(f"\nPerfil 1: {perfil1}")
print(f"Perfil 2: {perfil2}")

# Función con múltiples retornos
def analizar_numero(n):
    """Retorna múltiples valores"""
    es_par = n % 2 == 0
    es_positivo = n > 0
    cuadrado = n ** 2
    return es_par, es_positivo, cuadrado

par, positivo, cuad = analizar_numero(4)
print(f"\n4 es par: {par}, positivo: {positivo}, cuadrado: {cuad}")

# Argumentos *args y **kwargs
def sumar_todo(*numeros):
    """Acepta cualquier cantidad de argumentos"""
    return sum(numeros)

print(f"\nSuma: {sumar_todo(1, 2, 3, 4, 5)}")

def mostrar_info(**datos):
    """Acepta argumentos con nombre"""
    for clave, valor in datos.items():
        print(f"{clave}: {valor}")

print("\n--- Información ---")
mostrar_info(nombre="Carlos", edad=28, profesion="Data Scientist")

# ============================================
# 5. FUNCIONES LAMBDA
# ============================================

print("\n" + "="*50)
print("FUNCIONES LAMBDA (Anónimas)")
print("="*50)

# Función lambda: función pequeña en una línea
cuadrado = lambda x: x ** 2
print(f"\nCuadrado de 5: {cuadrado(5)}")

# Útil con funciones como map(), filter(), sorted()

# map(): Aplica una función a cada elemento
numeros = [1, 2, 3, 4, 5]
cuadrados = list(map(lambda x: x ** 2, numeros))
print(f"\nNúmeros: {numeros}")
print(f"Cuadrados: {cuadrados}")

# filter(): Filtra elementos según una condición
pares = list(filter(lambda x: x % 2 == 0, numeros))
print(f"Pares: {pares}")

# sorted(): Ordenar con función personalizada
estudiantes = [
    {"nombre": "Ana", "nota": 85},
    {"nombre": "Luis", "nota": 92},
    {"nombre": "María", "nota": 78}
]

# Ordenar por nota (descendente)
ordenados = sorted(estudiantes, key=lambda x: x["nota"], reverse=True)
print("\n--- Estudiantes ordenados por nota ---")
for e in ordenados:
    print(f"{e['nombre']}: {e['nota']}")

# ============================================
# 6. MANEJO DE ERRORES (try-except)
# ============================================

print("\n" + "="*50)
print("MANEJO DE ERRORES")
print("="*50)

# Sin manejo de errores, el programa se detendría
def dividir(a, b):
    """División con manejo de errores"""
    try:
        resultado = a / b
        return resultado
    except ZeroDivisionError:
        print("Error: No se puede dividir entre cero")
        return None
    except TypeError:
        print("Error: Tipos de datos incorrectos")
        return None

print(f"\n10 / 2 = {dividir(10, 2)}")
print(f"10 / 0 = {dividir(10, 0)}")
print(f"10 / 'a' = {dividir(10, 'a')}")

# try-except-else-finally
def procesar_datos(datos):
    """Ejemplo completo de manejo de errores"""
    try:
        # Intentar procesar
        promedio = sum(datos) / len(datos)
    except ZeroDivisionError:
        print("La lista está vacía")
        promedio = 0
    except TypeError:
        print("Los datos no son numéricos")
        promedio = 0
    else:
        # Se ejecuta si NO hubo error
        print("Procesamiento exitoso")
    finally:
        # SIEMPRE se ejecuta
        print("Finalizando proceso")

    return promedio

print("\n--- Procesando datos ---")
resultado = procesar_datos([10, 20, 30])
print(f"Promedio: {resultado}")

# ============================================
# 7. EJERCICIO INTEGRADOR
# ============================================

print("\n" + "="*50)
print("EJERCICIO INTEGRADOR: SISTEMA DE CALIFICACIONES")
print("="*50)

def calcular_promedio(calificaciones):
    """Calcula el promedio de calificaciones"""
    if not calificaciones:
        return 0
    return sum(calificaciones) / len(calificaciones)

def obtener_letra(promedio):
    """Convierte promedio numérico a letra"""
    if promedio >= 90:
        return "A"
    elif promedio >= 80:
        return "B"
    elif promedio >= 70:
        return "C"
    elif promedio >= 60:
        return "D"
    else:
        return "F"

def analizar_estudiante(nombre, calificaciones):
    """Análisis completo de un estudiante"""
    promedio = calcular_promedio(calificaciones)
    letra = obtener_letra(promedio)
    aprobado = promedio >= 60

    # Estadísticas
    mejor_nota = max(calificaciones) if calificaciones else 0
    peor_nota = min(calificaciones) if calificaciones else 0

    return {
        "nombre": nombre,
        "promedio": promedio,
        "letra": letra,
        "aprobado": aprobado,
        "mejor_nota": mejor_nota,
        "peor_nota": peor_nota,
        "total_examenes": len(calificaciones)
    }

# Procesar múltiples estudiantes
estudiantes_datos = [
    ("Ana García", [85, 90, 88, 92]),
    ("Luis Pérez", [70, 75, 68, 72]),
    ("María López", [95, 98, 93, 97]),
    ("Pedro Ruiz", [55, 60, 58, 52])
]

print("\n--- REPORTE DE CALIFICACIONES ---\n")
for nombre, calificaciones in estudiantes_datos:
    resultado = analizar_estudiante(nombre, calificaciones)

    print(f"Estudiante: {resultado['nombre']}")
    print(f"  Promedio: {resultado['promedio']:.2f}")
    print(f"  Calificación: {resultado['letra']}")
    print(f"  Estado: {'APROBADO' if resultado['aprobado'] else 'REPROBADO'}")
    print(f"  Mejor nota: {resultado['mejor_nota']}")
    print(f"  Peor nota: {resultado['peor_nota']}")
    print(f"  Total de exámenes: {resultado['total_examenes']}")
    print("-" * 50)

# Análisis del grupo
promedios = [
    calcular_promedio(cals)
    for nombre, cals in estudiantes_datos
]

print("\n--- ESTADÍSTICAS DEL GRUPO ---")
print(f"Promedio general: {sum(promedios) / len(promedios):.2f}")
print(f"Promedio más alto: {max(promedios):.2f}")
print(f"Promedio más bajo: {min(promedios):.2f}")

# Estudiantes aprobados
aprobados = [
    nombre for nombre, cals in estudiantes_datos
    if calcular_promedio(cals) >= 60
]
print(f"Estudiantes aprobados: {len(aprobados)} de {len(estudiantes_datos)}")
print(f"Tasa de aprobación: {len(aprobados) / len(estudiantes_datos) * 100:.1f}%")

# ============================================
# EJERCICIOS PARA PRACTICAR
# ============================================

print("\n" + "="*50)
print("EJERCICIOS PARA TI:")
print("="*50)
print("""
1. CONDICIONALES:
   - Crea una función que determine si un año es bisiesto
   - Reglas: divisible por 4, excepto si es divisible por 100
     (a menos que también sea divisible por 400)

2. BUCLES:
   - Imprime los primeros 10 números de la serie Fibonacci
   - Crea una función que cuente vocales en una frase

3. FUNCIONES:
   - Crea una función que convierta temperatura (C ↔ F)
   - Crea una calculadora con funciones para +, -, *, /

4. LAMBDAS:
   - Usa map() para convertir una lista de nombres a mayúsculas
   - Usa filter() para obtener números primos de una lista

5. EJERCICIO INTEGRADOR:
   - Sistema de gestión de inventario con funciones para:
     * Agregar producto
     * Actualizar stock
     * Calcular valor total del inventario
     * Buscar productos por categoría
     * Generar reporte de productos con bajo stock

¡Practica escribiendo tu propio código!
""")
