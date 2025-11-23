"""
MÓDULO 1 - FUNDAMENTOS DE PYTHON
Lección 2: Estructuras de Datos

En esta lección aprenderás:
- Listas (list)
- Tuplas (tuple)
- Diccionarios (dict)
- Conjuntos (set)
- Cuándo usar cada una
"""

# ============================================
# 1. LISTAS - Colecciones ordenadas y modificables
# ============================================

print("="*50)
print("LISTAS (list)")
print("="*50)

# Crear una lista
temperaturas = [22, 25, 23, 26, 24, 27, 25]
print("Temperaturas de la semana:", temperaturas)

# Las listas pueden contener diferentes tipos
datos_mixtos = [25, "María", True, 3.14, None]
print("Lista mixta:", datos_mixtos)

# Acceder a elementos (índices comienzan en 0)
print("\nPrimer elemento:", temperaturas[0])  # 22
print("Último elemento:", temperaturas[-1])  # 25
print("Tercer elemento:", temperaturas[2])  # 23

# Slicing (rebanadas)
print("\nPrimeros 3 días:", temperaturas[0:3])  # [22, 25, 23]
print("Del índice 2 al 4:", temperaturas[2:5])  # [23, 26, 24]
print("Últimos 3 días:", temperaturas[-3:])  # [24, 27, 25]
print("Cada 2 elementos:", temperaturas[::2])  # [22, 23, 24, 25]

# Modificar listas
temperaturas[0] = 20  # Cambiar primer elemento
print("\nDespués de modificar:", temperaturas)

# Agregar elementos
temperaturas.append(26)  # Agregar al final
print("Después de append:", temperaturas)

temperaturas.insert(0, 19)  # Insertar en posición específica
print("Después de insert:", temperaturas)

# Eliminar elementos
temperaturas.remove(19)  # Eliminar por valor
print("Después de remove:", temperaturas)

ultimo = temperaturas.pop()  # Eliminar y retornar el último
print(f"Eliminado: {ultimo}, Lista: {temperaturas}")

# Métodos útiles de listas
numeros = [5, 2, 8, 1, 9, 3]
print("\n=== MÉTODOS DE LISTAS ===")
print("Original:", numeros)
print("Longitud:", len(numeros))
print("Máximo:", max(numeros))
print("Mínimo:", min(numeros))
print("Suma:", sum(numeros))
print("Promedio:", sum(numeros) / len(numeros))

numeros.sort()  # Ordenar la lista
print("Ordenada:", numeros)

numeros.reverse()  # Invertir orden
print("Invertida:", numeros)

# ============================================
# 2. TUPLAS - Colecciones ordenadas e INMUTABLES
# ============================================

print("\n" + "="*50)
print("TUPLAS (tuple)")
print("="*50)

# Las tuplas son como listas pero NO se pueden modificar
coordenadas = (10.5, 20.3)
print("Coordenadas:", coordenadas)

# Acceder a elementos (igual que listas)
print("Latitud:", coordenadas[0])
print("Longitud:", coordenadas[1])

# Desempaquetado de tuplas (muy útil!)
lat, lon = coordenadas
print(f"Lat: {lat}, Lon: {lon}")

# Tupla con un solo elemento (nota la coma)
tupla_unitaria = (42,)
print("Tupla de un elemento:", tupla_unitaria)

# Uso práctico: retornar múltiples valores de una función
def obtener_estadisticas(datos):
    """Retorna mínimo, máximo y promedio"""
    return min(datos), max(datos), sum(datos) / len(datos)

datos = [10, 20, 30, 40, 50]
minimo, maximo, promedio = obtener_estadisticas(datos)
print(f"\nEstadísticas: Min={minimo}, Max={maximo}, Prom={promedio}")

# ============================================
# 3. DICCIONARIOS - Pares clave-valor
# ============================================

print("\n" + "="*50)
print("DICCIONARIOS (dict)")
print("="*50)

# Los diccionarios son muy importantes en ciencia de datos
# Almacenan pares clave-valor

estudiante = {
    "nombre": "Carlos",
    "edad": 22,
    "carrera": "Data Science",
    "calificaciones": [85, 90, 88, 92],
    "activo": True
}

print("Estudiante:", estudiante)

# Acceder a valores por clave
print("\nNombre:", estudiante["nombre"])
print("Edad:", estudiante["edad"])

# Método get() - más seguro (no da error si no existe la clave)
print("Email:", estudiante.get("email", "No registrado"))

# Agregar o modificar valores
estudiante["email"] = "carlos@universidad.edu"
estudiante["edad"] = 23  # Modificar
print("\nDespués de modificar:", estudiante)

# Obtener todas las claves, valores o pares
print("\nClaves:", list(estudiante.keys()))
print("Valores:", list(estudiante.values()))

# Iterar sobre diccionarios
print("\n=== ITERANDO DICCIONARIO ===")
for clave, valor in estudiante.items():
    print(f"{clave}: {valor}")

# Ejemplo práctico: Análisis de ventas
ventas_mensuales = {
    "enero": 15000,
    "febrero": 18000,
    "marzo": 22000,
    "abril": 19000,
    "mayo": 25000
}

print("\n=== ANÁLISIS DE VENTAS ===")
total_ventas = sum(ventas_mensuales.values())
promedio_ventas = total_ventas / len(ventas_mensuales)

print(f"Total de ventas: ${total_ventas:,.2f}")
print(f"Promedio mensual: ${promedio_ventas:,.2f}")

# Encontrar el mes con más ventas
mejor_mes = max(ventas_mensuales, key=ventas_mensuales.get)
print(f"Mejor mes: {mejor_mes} (${ventas_mensuales[mejor_mes]:,.2f})")

# ============================================
# 4. CONJUNTOS (SETS) - Colecciones únicas
# ============================================

print("\n" + "="*50)
print("CONJUNTOS (set)")
print("="*50)

# Los sets almacenan elementos únicos (sin duplicados)
frutas = {"manzana", "banana", "naranja", "manzana", "pera"}
print("Frutas (sin duplicados):", frutas)

# Agregar elementos
frutas.add("uva")
print("Después de add:", frutas)

# Operaciones de conjuntos
set_a = {1, 2, 3, 4, 5}
set_b = {4, 5, 6, 7, 8}

print("\nSet A:", set_a)
print("Set B:", set_b)
print("Unión:", set_a | set_b)  # Todos los elementos
print("Intersección:", set_a & set_b)  # Elementos comunes
print("Diferencia A-B:", set_a - set_b)  # En A pero no en B
print("Diferencia simétrica:", set_a ^ set_b)  # No comunes

# Uso práctico: Eliminar duplicados de una lista
numeros_con_duplicados = [1, 2, 2, 3, 4, 4, 4, 5, 6, 6]
numeros_unicos = list(set(numeros_con_duplicados))
print("\nCon duplicados:", numeros_con_duplicados)
print("Sin duplicados:", numeros_unicos)

# ============================================
# 5. COMPREHENSIONS (COMPRENSIONES)
# ============================================

print("\n" + "="*50)
print("LIST COMPREHENSIONS")
print("="*50)

# Forma tradicional
cuadrados = []
for i in range(1, 6):
    cuadrados.append(i ** 2)
print("Cuadrados (tradicional):", cuadrados)

# List comprehension (más elegante y rápida)
cuadrados = [i ** 2 for i in range(1, 6)]
print("Cuadrados (comprehension):", cuadrados)

# Con condición
pares = [x for x in range(20) if x % 2 == 0]
print("Números pares:", pares)

# Ejemplo práctico: Limpiar datos
temperaturas_str = ["22", "25", "23", "N/A", "26", "24", "", "27"]
temperaturas_limpias = [int(t) for t in temperaturas_str if t.isdigit()]
print("\nTemperaturas originales:", temperaturas_str)
print("Temperaturas limpias:", temperaturas_limpias)

# Dictionary comprehension
cuadrados_dict = {x: x**2 for x in range(1, 6)}
print("\nDiccionario de cuadrados:", cuadrados_dict)

# ============================================
# 6. EJERCICIO INTEGRADOR
# ============================================

print("\n" + "="*50)
print("EJERCICIO INTEGRADOR: ANÁLISIS DE ESTUDIANTES")
print("="*50)

# Base de datos de estudiantes
estudiantes = [
    {"nombre": "Ana", "edad": 20, "calificaciones": [85, 90, 88]},
    {"nombre": "Luis", "edad": 22, "calificaciones": [78, 82, 80]},
    {"nombre": "María", "edad": 21, "calificaciones": [92, 95, 93]},
    {"nombre": "Pedro", "edad": 23, "calificaciones": [70, 75, 72]},
    {"nombre": "Laura", "edad": 20, "calificaciones": [88, 86, 90]}
]

# Análisis 1: Calcular promedio de cada estudiante
print("\n--- PROMEDIOS POR ESTUDIANTE ---")
for estudiante in estudiantes:
    promedio = sum(estudiante["calificaciones"]) / len(estudiante["calificaciones"])
    estudiante["promedio"] = promedio  # Agregar promedio al diccionario
    print(f"{estudiante['nombre']}: {promedio:.2f}")

# Análisis 2: Mejor estudiante
mejor_estudiante = max(estudiantes, key=lambda x: x["promedio"])
print(f"\nMejor estudiante: {mejor_estudiante['nombre']} ({mejor_estudiante['promedio']:.2f})")

# Análisis 3: Estudiantes con promedio >= 85
estudiantes_sobresalientes = [
    e["nombre"] for e in estudiantes if e["promedio"] >= 85
]
print(f"\nEstudiantes sobresalientes (>=85): {estudiantes_sobresalientes}")

# Análisis 4: Edades únicas
edades_unicas = set(e["edad"] for e in estudiantes)
print(f"\nEdades presentes: {sorted(edades_unicas)}")

# Análisis 5: Promedio general del grupo
promedio_general = sum(e["promedio"] for e in estudiantes) / len(estudiantes)
print(f"\nPromedio general del grupo: {promedio_general:.2f}")

# ============================================
# EJERCICIOS PARA PRACTICAR
# ============================================

print("\n" + "="*50)
print("EJERCICIOS PARA TI:")
print("="*50)
print("""
1. LISTAS:
   - Crea una lista con tus 5 películas favoritas
   - Agrega 2 películas más
   - Ordena la lista alfabéticamente
   - Imprime solo las primeras 3

2. DICCIONARIOS:
   - Crea un diccionario con datos de un producto:
     (nombre, precio, stock, categoría)
   - Calcula el valor total del inventario (precio * stock)

3. COMPREHENSIONS:
   - Crea una lista con los números del 1 al 100 que sean divisibles por 7
   - Convierte una lista de temperaturas en Celsius a Fahrenheit

4. SETS:
   - Dadas dos listas de clientes, encuentra:
     * Clientes que están en ambas listas
     * Clientes únicos de cada lista

5. EJERCICIO INTEGRADOR:
   - Crea una lista de diccionarios con datos de productos
   - Calcula el producto más caro y más barato
   - Filtra productos de una categoría específica
   - Calcula el precio promedio

¡Modifica este archivo y practica!
""")
