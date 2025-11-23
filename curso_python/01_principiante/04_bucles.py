"""
===============================================================================
CURSO PYTHON - NIVEL PRINCIPIANTE
Módulo 4: Bucles (Loops)
===============================================================================
En este módulo aprenderás:
- Bucle for
- Bucle while
- range()
- break y continue
- Bucles anidados
- Comprensión de listas (list comprehension)
===============================================================================
"""

# ============================================================================
# 1. BUCLE FOR BÁSICO
# ============================================================================
print("=== BUCLE FOR BÁSICO ===\n")

# El bucle for itera sobre una secuencia (lista, string, rango, etc.)

print("--- Ejemplo 1: Iterar sobre una lista ---")
frutas = ["manzana", "pera", "naranja", "uva", "fresa"]

for fruta in frutas:
    print(f"🍎 {fruta}")

print()

print("--- Ejemplo 2: Iterar sobre un string ---")
palabra = "PYTHON"

for letra in palabra:
    print(f"Letra: {letra}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 2. FUNCIÓN range()
# ============================================================================
print("=== FUNCIÓN range() ===\n")

# range(n) genera números de 0 a n-1
print("--- range(5) ---")
for i in range(5):
    print(f"Número: {i}")

print()

# range(inicio, fin) genera números desde inicio hasta fin-1
print("--- range(1, 6) ---")
for i in range(1, 6):
    print(f"Número: {i}")

print()

# range(inicio, fin, paso) con incremento personalizado
print("--- range(0, 11, 2) - Números pares del 0 al 10 ---")
for i in range(0, 11, 2):
    print(f"Número: {i}")

print()

# range con decremento
print("--- range(10, 0, -1) - Cuenta regresiva ---")
for i in range(10, 0, -1):
    print(f"Cuenta regresiva: {i}")
print("🚀 ¡Despegue!")

print("\n" + "="*70 + "\n")

# ============================================================================
# 3. BUCLE WHILE
# ============================================================================
print("=== BUCLE WHILE ===\n")

# while ejecuta mientras la condición sea True

print("--- Ejemplo 1: Contador simple ---")
contador = 1

while contador <= 5:
    print(f"Contador: {contador}")
    contador += 1  # IMPORTANTE: incrementar para evitar loop infinito

print()

print("--- Ejemplo 2: Suma acumulativa ---")
numero = 1
suma = 0

while numero <= 10:
    suma += numero
    print(f"Sumando {numero}, total acumulado: {suma}")
    numero += 1

print(f"Suma total de 1 a 10: {suma}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 4. BREAK - Romper el bucle
# ============================================================================
print("=== BREAK - Romper el bucle ===\n")

# break termina el bucle inmediatamente

print("--- Ejemplo 1: Buscar un número ---")
numeros = [5, 12, 8, 20, 3, 15]
buscar = 20

for numero in numeros:
    print(f"Revisando: {numero}")
    if numero == buscar:
        print(f"✓ ¡Encontrado {buscar}!")
        break  # Salir del bucle
else:
    # Este else se ejecuta si NO se usó break
    print(f"✗ No se encontró {buscar}")

print()

print("--- Ejemplo 2: Límite de intentos ---")
intentos = 0
max_intentos = 5

while True:  # Loop infinito
    intentos += 1
    print(f"Intento {intentos}")

    if intentos >= max_intentos:
        print("Límite de intentos alcanzado")
        break  # Salir del bucle

print("\n" + "="*70 + "\n")

# ============================================================================
# 5. CONTINUE - Saltar a la siguiente iteración
# ============================================================================
print("=== CONTINUE - Saltar iteración ===\n")

# continue salta a la siguiente iteración sin ejecutar el resto del código

print("--- Ejemplo 1: Imprimir solo números impares ---")
for i in range(1, 11):
    if i % 2 == 0:  # Si es par
        continue  # Saltar a la siguiente iteración
    print(f"Número impar: {i}")

print()

print("--- Ejemplo 2: Filtrar valores negativos ---")
numeros = [10, -5, 8, -3, 15, -1, 20]

print("Números positivos:")
for numero in numeros:
    if numero < 0:
        continue  # Saltar números negativos
    print(f"✓ {numero}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 6. BUCLES ANIDADOS
# ============================================================================
print("=== BUCLES ANIDADOS ===\n")

# Un bucle dentro de otro bucle

print("--- Ejemplo 1: Tabla de multiplicar ---")
for i in range(1, 4):
    print(f"\nTabla del {i}:")
    for j in range(1, 6):
        resultado = i * j
        print(f"  {i} × {j} = {resultado}")

print()

print("--- Ejemplo 2: Patrón de asteriscos ---")
filas = 5

for i in range(1, filas + 1):
    for j in range(i):
        print("★", end=" ")
    print()  # Nueva línea

print("\n" + "="*70 + "\n")

# ============================================================================
# 7. ENUMERATE() - Obtener índice y valor
# ============================================================================
print("=== ENUMERATE() - Índice y valor ===\n")

# enumerate() devuelve el índice y el valor

frutas = ["manzana", "pera", "naranja", "uva"]

print("--- Sin enumerate ---")
for i in range(len(frutas)):
    print(f"{i}: {frutas[i]}")

print()

print("--- Con enumerate (más pythonic) ---")
for indice, fruta in enumerate(frutas):
    print(f"{indice}: {fruta}")

print()

print("--- enumerate con inicio personalizado ---")
for indice, fruta in enumerate(frutas, start=1):
    print(f"#{indice}: {fruta}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 8. ZIP() - Iterar sobre múltiples listas
# ============================================================================
print("=== ZIP() - Combinar listas ===\n")

# zip() combina múltiples listas elemento por elemento

nombres = ["Ana", "Carlos", "María"]
edades = [25, 30, 28]
ciudades = ["CDMX", "Guadalajara", "Monterrey"]

print("--- Iterar sobre tres listas simultáneamente ---")
for nombre, edad, ciudad in zip(nombres, edades, ciudades):
    print(f"{nombre} tiene {edad} años y vive en {ciudad}")

print()

# Crear diccionario con zip
print("--- Crear diccionario con zip ---")
productos = ["Laptop", "Mouse", "Teclado"]
precios = [15000, 300, 800]

catalogo = dict(zip(productos, precios))
print(catalogo)

print("\n" + "="*70 + "\n")

# ============================================================================
# 9. LIST COMPREHENSION - Comprensión de listas
# ============================================================================
print("=== LIST COMPREHENSION ===\n")

# Forma concisa de crear listas

print("--- Forma tradicional vs List Comprehension ---")

# Forma tradicional: cuadrados de 1 a 5
cuadrados_tradicional = []
for i in range(1, 6):
    cuadrados_tradicional.append(i ** 2)
print(f"Forma tradicional: {cuadrados_tradicional}")

# List comprehension: misma operación en una línea
cuadrados_comprehension = [i ** 2 for i in range(1, 6)]
print(f"List comprehension: {cuadrados_comprehension}")

print()

print("--- Filtrar con list comprehension ---")
numeros = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# Solo números pares
pares = [n for n in numeros if n % 2 == 0]
print(f"Números pares: {pares}")

# Solo números mayores a 5
mayores = [n for n in numeros if n > 5]
print(f"Números > 5: {mayores}")

print()

print("--- Transformaciones con list comprehension ---")
palabras = ["python", "java", "javascript"]

# Convertir a mayúsculas
mayusculas = [palabra.upper() for palabra in palabras]
print(f"Mayúsculas: {mayusculas}")

# Obtener longitud de cada palabra
longitudes = [len(palabra) for palabra in palabras]
print(f"Longitudes: {longitudes}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 10. EJEMPLO PRÁCTICO: TABLA DE MULTIPLICAR COMPLETA
# ============================================================================
print("=== EJEMPLO PRÁCTICO: TABLA DE MULTIPLICAR ===\n")

numero = 7
print(f"TABLA DEL {numero}")
print("-" * 25)

for i in range(1, 11):
    resultado = numero * i
    print(f"{numero} × {i:2d} = {resultado:3d}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 11. EJEMPLO PRÁCTICO: CONTADOR DE VOCALES
# ============================================================================
print("=== EJEMPLO PRÁCTICO: CONTADOR DE VOCALES ===\n")

texto = "Python es un lenguaje de programación increíble"
vocales = "aeiouAEIOUáéíóúÁÉÍÓÚ"
contador_vocales = 0

print(f"Texto: {texto}")
print()

for letra in texto:
    if letra in vocales:
        contador_vocales += 1

print(f"Total de vocales: {contador_vocales}")

# Versión con list comprehension
vocales_encontradas = [letra for letra in texto if letra in vocales]
print(f"Vocales encontradas: {vocales_encontradas}")
print(f"Cantidad: {len(vocales_encontradas)}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 12. EJEMPLO PRÁCTICO: SISTEMA DE INVENTARIO
# ============================================================================
print("=== EJEMPLO PRÁCTICO: SISTEMA DE INVENTARIO ===\n")

# Inventario de productos
productos = ["Laptop", "Mouse", "Teclado", "Monitor", "Audífonos"]
precios = [15000, 300, 800, 5000, 1200]
stock = [5, 15, 8, 3, 12]

print("REPORTE DE INVENTARIO")
print("=" * 60)
print(f"{'Producto':<15} {'Precio':>10} {'Stock':>8} {'Total':>12}")
print("-" * 60)

total_inventario = 0

for producto, precio, cantidad in zip(productos, precios, stock):
    total_producto = precio * cantidad
    total_inventario += total_producto

    print(f"{producto:<15} ${precio:>9,.2f} {cantidad:>8} ${total_producto:>11,.2f}")

print("-" * 60)
print(f"{'VALOR TOTAL DEL INVENTARIO:':<35} ${total_inventario:>11,.2f}")
print("=" * 60)

print()

# Productos con stock bajo
print("⚠️  ALERTA DE STOCK BAJO (menos de 5 unidades):")
for producto, cantidad in zip(productos, stock):
    if cantidad < 5:
        print(f"  • {producto}: {cantidad} unidades")

print("\n" + "="*70 + "\n")

# ============================================================================
# 13. EJEMPLO PRÁCTICO: CALCULADORA DE PROMEDIO
# ============================================================================
print("=== EJEMPLO PRÁCTICO: CALCULADORA DE PROMEDIO ===\n")

calificaciones = [85, 92, 78, 95, 88, 90, 76]

print("Calificaciones del estudiante:")
for i, calificacion in enumerate(calificaciones, start=1):
    print(f"  Examen {i}: {calificacion}")

# Calcular promedio
suma_calificaciones = 0
for calificacion in calificaciones:
    suma_calificaciones += calificacion

promedio = suma_calificaciones / len(calificaciones)

print(f"\nTotal de exámenes: {len(calificaciones)}")
print(f"Suma total: {suma_calificaciones}")
print(f"Promedio: {promedio:.2f}")

# Determinar aprobación
if promedio >= 70:
    print("✓ Estudiante APROBADO")
else:
    print("✗ Estudiante REPROBADO")

# Calificaciones arriba del promedio
print(f"\nCalificaciones arriba del promedio ({promedio:.2f}):")
for i, calificacion in enumerate(calificaciones, start=1):
    if calificacion > promedio:
        print(f"  Examen {i}: {calificacion}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 14. EJEMPLO PRÁCTICO: JUEGO DE ADIVINANZA
# ============================================================================
print("=== EJEMPLO PRÁCTICO: JUEGO DE ADIVINANZA ===\n")

numero_secreto = 7
intentos_maximos = 5
intentos_realizados = 0

print("¡Juego de adivinanza!")
print(f"Adivina el número entre 1 y 10 (tienes {intentos_maximos} intentos)")
print()

# Simulación de intentos (en un programa real, usarías input())
intentos_usuario = [5, 8, 7]  # Lista de intentos simulados

for intento in intentos_usuario:
    intentos_realizados += 1

    print(f"Intento {intentos_realizados}: {intento}")

    if intento == numero_secreto:
        print(f"🎉 ¡Felicidades! Adivinaste en {intentos_realizados} intentos")
        break
    elif intento < numero_secreto:
        print("  ⬆️  El número es mayor")
    else:
        print("  ⬇️  El número es menor")

    if intentos_realizados >= intentos_maximos:
        print(f"\n❌ Se acabaron los intentos. El número era {numero_secreto}")
        break
else:
    if intentos_realizados < intentos_maximos and intento != numero_secreto:
        print(f"\n❌ No adivinaste. El número era {numero_secreto}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 15. EJEMPLO PRÁCTICO: ANÁLISIS DE VENTAS
# ============================================================================
print("=== EJEMPLO PRÁCTICO: ANÁLISIS DE VENTAS MENSUALES ===\n")

meses = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio"]
ventas = [45000, 52000, 48000, 63000, 55000, 67000]

print("REPORTE DE VENTAS DEL SEMESTRE")
print("=" * 50)

# Mostrar ventas por mes
total_ventas = 0
mes_mayor_venta = ""
mayor_venta = 0
mes_menor_venta = ""
menor_venta = float('inf')

for mes, venta in zip(meses, ventas):
    total_ventas += venta
    print(f"{mes:<10} ${venta:>10,}")

    # Encontrar mayor venta
    if venta > mayor_venta:
        mayor_venta = venta
        mes_mayor_venta = mes

    # Encontrar menor venta
    if venta < menor_venta:
        menor_venta = venta
        mes_menor_venta = mes

promedio_ventas = total_ventas / len(ventas)

print("=" * 50)
print(f"Total:      ${total_ventas:>10,}")
print(f"Promedio:   ${promedio_ventas:>10,.2f}")
print(f"\n📈 Mejor mes: {mes_mayor_venta} (${mayor_venta:,})")
print(f"📉 Peor mes: {mes_menor_venta} (${menor_venta:,})")

# Meses arriba del promedio
print(f"\nMeses con ventas arriba del promedio (${promedio_ventas:,.2f}):")
for mes, venta in zip(meses, ventas):
    if venta > promedio_ventas:
        diferencia = venta - promedio_ventas
        print(f"  • {mes}: ${venta:,} (+${diferencia:,.2f})")

print("\n" + "="*70 + "\n")

# ============================================================================
# EJERCICIOS PARA PRACTICAR
# ============================================================================
print("EJERCICIOS PARA PRACTICAR:")
print("="*70)
print("""
1. Suma de números:
   - Crea un programa que sume todos los números del 1 al 100
   - Imprime el resultado

2. Factorial:
   - numero = 5
   - Calcula el factorial (5! = 5×4×3×2×1)

3. Números primos:
   - Imprime todos los números primos del 1 al 50
   - (Un número primo solo es divisible por 1 y por sí mismo)

4. Pirámide de números:
   - Crea esta figura:
     1
     1 2
     1 2 3
     1 2 3 4
     1 2 3 4 5

5. FizzBuzz:
   - Para números del 1 al 30:
   - Si es múltiplo de 3: imprime "Fizz"
   - Si es múltiplo de 5: imprime "Buzz"
   - Si es múltiplo de 3 y 5: imprime "FizzBuzz"
   - Si no: imprime el número

6. Palíndromo:
   - palabra = "anilina"
   - Verifica si es un palíndromo (se lee igual al derecho y al revés)

7. Lista de compras:
   - productos = ["pan", "leche", "huevos", "queso"]
   - precios = [30, 25, 50, 80]
   - Calcula el total de la compra
   - Encuentra el producto más caro

8. Generador de contraseñas:
   - Usa bucles para generar una contraseña de 8 caracteres
   - Combina números y letras

¡Practica estos ejercicios para dominar los bucles!
""")
