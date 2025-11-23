"""
===============================================================================
CURSO PYTHON - NIVEL PRINCIPIANTE
Módulo 6: Estructuras de Datos
===============================================================================
En este módulo aprenderás:
- Listas (lists)
- Tuplas (tuples)
- Diccionarios (dictionaries)
- Conjuntos (sets)
- Operaciones con estructuras de datos
- Cuándo usar cada estructura
===============================================================================
"""

# ============================================================================
# 1. LISTAS - Colecciones ordenadas y modificables
# ============================================================================
print("=== LISTAS ===\n")

# Crear listas
frutas = ["manzana", "pera", "naranja", "uva"]
numeros = [1, 2, 3, 4, 5]
mixta = [1, "texto", 3.14, True]  # Puede contener diferentes tipos

print("--- Crear y acceder a listas ---")
print(f"Frutas: {frutas}")
print(f"Números: {numeros}")
print(f"Lista mixta: {mixta}")

# Acceder a elementos (índices empiezan en 0)
print(f"\nPrimer elemento: {frutas[0]}")
print(f"Segundo elemento: {frutas[1]}")
print(f"Último elemento: {frutas[-1]}")  # -1 es el último
print(f"Penúltimo elemento: {frutas[-2]}")

print()

# Modificar elementos
print("--- Modificar listas ---")
frutas[0] = "fresa"
print(f"Lista modificada: {frutas}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 2. MÉTODOS DE LISTAS
# ============================================================================
print("=== MÉTODOS DE LISTAS ===\n")

mi_lista = ["a", "b", "c"]

print(f"Lista inicial: {mi_lista}")

# append() - Agregar al final
mi_lista.append("d")
print(f"Después de append('d'): {mi_lista}")

# insert() - Insertar en posición específica
mi_lista.insert(1, "x")  # Insertar en índice 1
print(f"Después de insert(1, 'x'): {mi_lista}")

# extend() - Agregar múltiples elementos
mi_lista.extend(["e", "f"])
print(f"Después de extend(['e', 'f']): {mi_lista}")

print()

# remove() - Eliminar elemento específico
mi_lista.remove("x")
print(f"Después de remove('x'): {mi_lista}")

# pop() - Eliminar y retornar elemento (por defecto el último)
eliminado = mi_lista.pop()
print(f"Después de pop(): {mi_lista} (eliminado: {eliminado})")

# pop(índice) - Eliminar en posición específica
eliminado = mi_lista.pop(0)
print(f"Después de pop(0): {mi_lista} (eliminado: {eliminado})")

print()

# Otros métodos útiles
numeros = [3, 1, 4, 1, 5, 9, 2, 6]
print(f"Números: {numeros}")
print(f"Longitud: {len(numeros)}")
print(f"Máximo: {max(numeros)}")
print(f"Mínimo: {min(numeros)}")
print(f"Suma: {sum(numeros)}")
print(f"Contar 1's: {numeros.count(1)}")
print(f"Índice de 5: {numeros.index(5)}")

# sort() - Ordenar la lista
numeros.sort()
print(f"Ordenada (ascendente): {numeros}")

numeros.sort(reverse=True)
print(f"Ordenada (descendente): {numeros}")

# reverse() - Invertir orden
numeros.reverse()
print(f"Invertida: {numeros}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 3. SLICING - Rebanadas de listas
# ============================================================================
print("=== SLICING - Rebanadas ===\n")

letras = ["a", "b", "c", "d", "e", "f", "g", "h"]

print(f"Lista completa: {letras}")
print()

# [inicio:fin] - desde inicio hasta fin-1
print(f"letras[0:3]: {letras[0:3]}")  # Primeros 3
print(f"letras[2:5]: {letras[2:5]}")  # Del índice 2 al 4

# [:fin] - desde el inicio hasta fin-1
print(f"letras[:4]: {letras[:4]}")  # Primeros 4

# [inicio:] - desde inicio hasta el final
print(f"letras[3:]: {letras[3:]}")  # Del índice 3 en adelante

# [inicio:fin:paso] - con saltos
print(f"letras[::2]: {letras[::2]}")  # De 2 en 2
print(f"letras[1::2]: {letras[1::2]}")  # Impares

# Invertir lista con slicing
print(f"letras[::-1]: {letras[::-1]}")  # Lista invertida

print("\n" + "="*70 + "\n")

# ============================================================================
# 4. TUPLAS - Colecciones ordenadas e INMUTABLES
# ============================================================================
print("=== TUPLAS ===\n")

# Crear tuplas
coordenadas = (10, 20)
persona = ("Juan", 30, "México")
un_elemento = (5,)  # Nota la coma para tupla de un elemento
vacia = ()

print("--- Crear tuplas ---")
print(f"Coordenadas: {coordenadas}")
print(f"Persona: {persona}")
print(f"Un elemento: {un_elemento}")

# Acceder a elementos (igual que listas)
print(f"\nNombre: {persona[0]}")
print(f"Edad: {persona[1]}")
print(f"País: {persona[2]}")

# Desempaquetar tuplas
nombre, edad, pais = persona
print(f"\nDesempaquetado: {nombre}, {edad}, {pais}")

# Las tuplas son inmutables - esto daría error:
# persona[0] = "Carlos"  # ERROR!

print()

# Métodos de tuplas (solo tiene 2)
numeros_tupla = (1, 2, 3, 2, 4, 2, 5)
print(f"Tupla: {numeros_tupla}")
print(f"Contar 2's: {numeros_tupla.count(2)}")
print(f"Índice de 4: {numeros_tupla.index(4)}")

print("\n¿Cuándo usar tuplas?")
print("• Datos que no deben cambiar (coordenadas, RGB, etc.)")
print("• Claves de diccionarios")
print("• Retornar múltiples valores de funciones")
print("• Son más rápidas que las listas")

print("\n" + "="*70 + "\n")

# ============================================================================
# 5. DICCIONARIOS - Pares clave-valor
# ============================================================================
print("=== DICCIONARIOS ===\n")

# Crear diccionarios
persona = {
    "nombre": "Carlos",
    "edad": 30,
    "ciudad": "CDMX",
    "profesion": "Ingeniero"
}

print("--- Crear diccionario ---")
print(persona)

# Acceder a valores
print(f"\nNombre: {persona['nombre']}")
print(f"Edad: {persona['edad']}")

# Método get() - más seguro
print(f"Ciudad: {persona.get('ciudad')}")
print(f"Email: {persona.get('email', 'No disponible')}")  # Valor por defecto

print()

# Modificar valores
print("--- Modificar diccionario ---")
persona["edad"] = 31
print(f"Edad actualizada: {persona['edad']}")

# Agregar nuevos pares
persona["email"] = "carlos@email.com"
print(f"Email agregado: {persona['email']}")

# Eliminar elementos
del persona["profesion"]
print(f"Después de eliminar 'profesion': {persona}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 6. MÉTODOS DE DICCIONARIOS
# ============================================================================
print("=== MÉTODOS DE DICCIONARIOS ===\n")

producto = {
    "nombre": "Laptop",
    "precio": 15000,
    "marca": "Dell",
    "stock": 5
}

print(f"Diccionario: {producto}\n")

# keys() - Obtener todas las claves
print(f"Claves: {producto.keys()}")
print(f"Lista de claves: {list(producto.keys())}")

# values() - Obtener todos los valores
print(f"\nValores: {producto.values()}")
print(f"Lista de valores: {list(producto.values())}")

# items() - Obtener pares clave-valor
print(f"\nItems: {producto.items()}")

print("\n--- Iterar sobre diccionario ---")

# Iterar sobre claves
print("Claves:")
for clave in producto:
    print(f"  {clave}")

print("\nClaves y valores:")
for clave, valor in producto.items():
    print(f"  {clave}: {valor}")

print()

# update() - Actualizar múltiples valores
producto.update({"precio": 14000, "stock": 10, "garantia": "1 año"})
print(f"Después de update(): {producto}")

# pop() - Eliminar y retornar valor
garantia = producto.pop("garantia")
print(f"Garantía eliminada: {garantia}")
print(f"Producto: {producto}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 7. CONJUNTOS (SETS) - Colecciones sin orden ni duplicados
# ============================================================================
print("=== CONJUNTOS (SETS) ===\n")

# Crear sets
frutas = {"manzana", "pera", "naranja"}
numeros = {1, 2, 3, 4, 5}
set_vacio = set()  # No usar {} porque crea un diccionario vacío

print("--- Crear sets ---")
print(f"Frutas: {frutas}")
print(f"Números: {numeros}")

# Los sets eliminan duplicados automáticamente
numeros_con_duplicados = {1, 2, 2, 3, 3, 3, 4, 5}
print(f"\nSet con duplicados: {numeros_con_duplicados}")
print("(Los duplicados se eliminan automáticamente)")

print()

# Agregar elementos
frutas.add("uva")
print(f"Después de add('uva'): {frutas}")

# Eliminar elementos
frutas.remove("pera")  # Error si no existe
print(f"Después de remove('pera'): {frutas}")

frutas.discard("kiwi")  # No da error si no existe
print(f"Después de discard('kiwi'): {frutas}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 8. OPERACIONES CON SETS
# ============================================================================
print("=== OPERACIONES CON SETS ===\n")

a = {1, 2, 3, 4, 5}
b = {4, 5, 6, 7, 8}

print(f"Conjunto A: {a}")
print(f"Conjunto B: {b}")
print()

# Unión - elementos en A o B (o ambos)
print(f"Unión (A | B): {a | b}")
print(f"Unión con union(): {a.union(b)}")

# Intersección - elementos en A y B
print(f"\nIntersección (A & B): {a & b}")
print(f"Intersección con intersection(): {a.intersection(b)}")

# Diferencia - elementos en A pero no en B
print(f"\nDiferencia (A - B): {a - b}")
print(f"Diferencia con difference(): {a.difference(b)}")

# Diferencia simétrica - elementos en A o B pero no en ambos
print(f"\nDiferencia simétrica (A ^ B): {a ^ b}")
print(f"Diferencia simétrica con symmetric_difference(): {a.symmetric_difference(b)}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 9. EJEMPLO PRÁCTICO: GESTIÓN DE INVENTARIO
# ============================================================================
print("=== EJEMPLO PRÁCTICO: GESTIÓN DE INVENTARIO ===\n")

# Lista de productos con sus datos
inventario = [
    {"nombre": "Laptop", "precio": 15000, "stock": 5, "categoria": "Electrónica"},
    {"nombre": "Mouse", "precio": 300, "stock": 25, "categoria": "Electrónica"},
    {"nombre": "Teclado", "precio": 800, "stock": 15, "categoria": "Electrónica"},
    {"nombre": "Monitor", "precio": 5000, "stock": 8, "categoria": "Electrónica"},
    {"nombre": "Silla", "precio": 2500, "stock": 10, "categoria": "Muebles"},
]

print("INVENTARIO COMPLETO")
print("=" * 65)
print(f"{'Producto':<15} {'Precio':>10} {'Stock':>8} {'Categoría':<15}")
print("-" * 65)

for producto in inventario:
    print(f"{producto['nombre']:<15} ${producto['precio']:>9,} "
          f"{producto['stock']:>8} {producto['categoria']:<15}")

print("=" * 65)

# Calcular valor total del inventario
valor_total = sum(p['precio'] * p['stock'] for p in inventario)
print(f"\nValor total del inventario: ${valor_total:,}")

# Productos con stock bajo
print("\n⚠️  ALERTA: Productos con stock bajo (<10):")
for producto in inventario:
    if producto['stock'] < 10:
        print(f"  • {producto['nombre']}: {producto['stock']} unidades")

# Producto más caro
producto_mas_caro = max(inventario, key=lambda p: p['precio'])
print(f"\n💰 Producto más caro: {producto_mas_caro['nombre']} (${producto_mas_caro['precio']:,})")

print("\n" + "="*70 + "\n")

# ============================================================================
# 10. EJEMPLO PRÁCTICO: SISTEMA DE ESTUDIANTES
# ============================================================================
print("=== EJEMPLO PRÁCTICO: SISTEMA DE ESTUDIANTES ===\n")

# Diccionario con estudiantes y sus calificaciones
estudiantes = {
    "Juan": [85, 90, 78, 92, 88],
    "María": [95, 98, 92, 96, 94],
    "Carlos": [70, 75, 72, 68, 71],
    "Ana": [88, 85, 90, 87, 91],
    "Pedro": [60, 65, 58, 62, 64]
}

print("REPORTE DE CALIFICACIONES")
print("=" * 60)

for nombre, calificaciones in estudiantes.items():
    promedio = sum(calificaciones) / len(calificaciones)
    max_cal = max(calificaciones)
    min_cal = min(calificaciones)

    print(f"\nEstudiante: {nombre}")
    print(f"  Calificaciones: {calificaciones}")
    print(f"  Promedio: {promedio:.2f}")
    print(f"  Mejor nota: {max_cal}")
    print(f"  Peor nota: {min_cal}")

    if promedio >= 90:
        print(f"  Estado: ⭐ EXCELENTE")
    elif promedio >= 70:
        print(f"  Estado: ✓ APROBADO")
    else:
        print(f"  Estado: ✗ REPROBADO")

# Promedio general del grupo
todos_promedios = [sum(cals) / len(cals) for cals in estudiantes.values()]
promedio_grupo = sum(todos_promedios) / len(todos_promedios)

print("\n" + "=" * 60)
print(f"PROMEDIO DEL GRUPO: {promedio_grupo:.2f}")

# Mejor estudiante
mejor_estudiante = max(estudiantes.items(),
                       key=lambda x: sum(x[1]) / len(x[1]))
print(f"🏆 MEJOR ESTUDIANTE: {mejor_estudiante[0]} "
      f"(Promedio: {sum(mejor_estudiante[1]) / len(mejor_estudiante[1]):.2f})")

print("\n" + "="*70 + "\n")

# ============================================================================
# 11. EJEMPLO PRÁCTICO: ANÁLISIS DE TEXTO
# ============================================================================
print("=== EJEMPLO PRÁCTICO: ANÁLISIS DE TEXTO ===\n")

texto = """
Python es un lenguaje de programación de alto nivel.
Python es fácil de aprender y muy poderoso.
Muchas empresas usan Python para desarrollo web y ciencia de datos.
"""

print("ANÁLISIS DE TEXTO")
print("=" * 60)
print(f"Texto:\n{texto}")
print("=" * 60)

# Convertir a minúsculas y dividir en palabras
palabras = texto.lower().split()

# Limpiar puntuación
palabras_limpias = [palabra.strip('.,;:!?') for palabra in palabras]

# Contar palabras totales
total_palabras = len(palabras_limpias)
print(f"\nTotal de palabras: {total_palabras}")

# Palabras únicas (usando set)
palabras_unicas = set(palabras_limpias)
print(f"Palabras únicas: {len(palabras_unicas)}")

# Contar frecuencia de cada palabra (usando diccionario)
frecuencia = {}
for palabra in palabras_limpias:
    frecuencia[palabra] = frecuencia.get(palabra, 0) + 1

# Mostrar las 5 palabras más comunes
print("\nPalabras más frecuentes:")
palabras_ordenadas = sorted(frecuencia.items(),
                           key=lambda x: x[1],
                           reverse=True)

for palabra, conteo in palabras_ordenadas[:5]:
    print(f"  '{palabra}': {conteo} veces")

print("\n" + "="*70 + "\n")

# ============================================================================
# 12. ANIDACIÓN DE ESTRUCTURAS
# ============================================================================
print("=== ESTRUCTURAS ANIDADAS ===\n")

# Lista de diccionarios
empleados = [
    {
        "nombre": "Juan",
        "edad": 30,
        "departamento": "Ventas",
        "salario": 35000,
        "habilidades": ["Excel", "PowerPoint", "CRM"]
    },
    {
        "nombre": "María",
        "edad": 28,
        "departamento": "IT",
        "salario": 45000,
        "habilidades": ["Python", "SQL", "Django"]
    },
    {
        "nombre": "Carlos",
        "edad": 35,
        "departamento": "IT",
        "salario": 50000,
        "habilidades": ["JavaScript", "React", "Node.js"]
    }
]

print("INFORMACIÓN DE EMPLEADOS\n")

for empleado in empleados:
    print(f"Nombre: {empleado['nombre']}")
    print(f"  Edad: {empleado['edad']} años")
    print(f"  Departamento: {empleado['departamento']}")
    print(f"  Salario: ${empleado['salario']:,}")
    print(f"  Habilidades: {', '.join(empleado['habilidades'])}")
    print()

# Filtrar empleados de IT
empleados_it = [e for e in empleados if e['departamento'] == 'IT']
print(f"Empleados de IT: {len(empleados_it)}")

# Salario promedio
salario_promedio = sum(e['salario'] for e in empleados) / len(empleados)
print(f"Salario promedio: ${salario_promedio:,.2f}")

# Todas las habilidades únicas
todas_habilidades = set()
for empleado in empleados:
    todas_habilidades.update(empleado['habilidades'])

print(f"Habilidades en la empresa: {', '.join(sorted(todas_habilidades))}")

print("\n" + "="*70 + "\n")

# ============================================================================
# COMPARACIÓN Y CUÁNDO USAR CADA ESTRUCTURA
# ============================================================================
print("=== CUÁNDO USAR CADA ESTRUCTURA ===\n")

print("""
┌─────────────┬──────────────┬─────────────┬─────────────────────────┐
│ Estructura  │ Ordenada     │ Mutable     │ Cuándo usar             │
├─────────────┼──────────────┼─────────────┼─────────────────────────┤
│ Lista       │ ✓ Sí         │ ✓ Sí        │ Colección ordenada      │
│ []          │              │             │ que puede cambiar       │
├─────────────┼──────────────┼─────────────┼─────────────────────────┤
│ Tupla       │ ✓ Sí         │ ✗ No        │ Datos que no deben      │
│ ()          │              │             │ cambiar, coordenadas    │
├─────────────┼──────────────┼─────────────┼─────────────────────────┤
│ Diccionario │ ✗ No*        │ ✓ Sí        │ Relaciones clave-valor  │
│ {}          │ (*3.7+: sí)  │             │ búsquedas rápidas       │
├─────────────┼──────────────┼─────────────┼─────────────────────────┤
│ Set         │ ✗ No         │ ✓ Sí        │ Elementos únicos,       │
│ {}          │              │             │ operaciones de conjunto │
└─────────────┴──────────────┴─────────────┴─────────────────────────┘

Ejemplos de uso:
• Lista: ["manzana", "pera", "naranja"] - lista de compras
• Tupla: (10, 20) - coordenadas que no cambian
• Diccionario: {"nombre": "Juan", "edad": 30} - perfil de usuario
• Set: {1, 2, 3, 4, 5} - números únicos, sin duplicados
""")

print("="*70 + "\n")

# ============================================================================
# EJERCICIOS PARA PRACTICAR
# ============================================================================
print("EJERCICIOS PARA PRACTICAR:")
print("="*70)
print("""
1. Lista de tareas:
   - Crea una lista de 5 tareas
   - Agrega 2 tareas más
   - Marca la primera como completada (elimínala)
   - Imprime las tareas pendientes

2. Agenda de contactos:
   - Crea un diccionario con 3 contactos (nombre: teléfono)
   - Agrega 2 contactos más
   - Busca un contacto por nombre
   - Lista todos los contactos

3. Registro de temperaturas:
   - Lista: [23, 25, 22, 26, 24, 27, 23]
   - Calcula: promedio, máxima, mínima
   - Encuentra días arriba del promedio

4. Catálogo de productos:
   - Lista de diccionarios con: nombre, precio, categoría
   - Filtra productos por categoría
   - Encuentra el producto más caro
   - Calcula precio promedio

5. Análisis de palabras:
   - texto = "python es genial python es poderoso"
   - Crea un diccionario con frecuencia de cada palabra
   - Encuentra la palabra más repetida

6. Sets de estudiantes:
   - matematicas = {"Juan", "Ana", "Carlos", "María"}
   - fisica = {"Ana", "Pedro", "Carlos", "Luisa"}
   - Encuentra: estudiantes en ambas clases, solo en matemáticas

7. Matriz de calificaciones:
   - Lista de listas (tabla) con calificaciones de 3 estudiantes
   - Calcula promedio por estudiante y por materia

¡Practica con estos ejercicios para dominar las estructuras de datos!
""")
