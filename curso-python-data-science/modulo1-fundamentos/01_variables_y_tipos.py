"""
MÓDULO 1 - FUNDAMENTOS DE PYTHON
Lección 1: Variables y Tipos de Datos

En esta lección aprenderás:
- Cómo declarar variables
- Tipos de datos básicos
- Conversión entre tipos
- Operaciones básicas
"""

# ============================================
# 1. VARIABLES Y ASIGNACIÓN
# ============================================

# En Python no necesitas declarar el tipo de variable
# El tipo se asigna automáticamente según el valor
nombre = "María"  # String (cadena de texto)
edad = 25  # Integer (número entero)
altura = 1.65  # Float (número decimal)
es_estudiante = True  # Boolean (verdadero/falso)

# Puedes imprimir variables usando print()
print("Nombre:", nombre)
print("Edad:", edad)
print("Altura:", altura)
print("¿Es estudiante?:", es_estudiante)

# ============================================
# 2. TIPOS DE DATOS BÁSICOS
# ============================================

# String (cadenas de texto)
mensaje = "Hola, mundo de la ciencia de datos!"
print("\nTipo de 'mensaje':", type(mensaje))

# Integer (números enteros)
cantidad_datos = 1000
print("Tipo de 'cantidad_datos':", type(cantidad_datos))

# Float (números decimales)
promedio = 85.5
print("Tipo de 'promedio':", type(promedio))

# Boolean (valores lógicos)
datos_limpios = False
print("Tipo de 'datos_limpios':", type(datos_limpios))

# None (valor nulo/ausente)
resultado = None
print("Tipo de 'resultado':", type(resultado))

# ============================================
# 3. OPERACIONES CON NÚMEROS
# ============================================

a = 10
b = 3

suma = a + b  # 13
resta = a - b  # 7
multiplicacion = a * b  # 30
division = a / b  # 3.333...
division_entera = a // b  # 3 (división sin decimales)
modulo = a % b  # 1 (resto de la división)
potencia = a ** b  # 1000 (10 elevado a 3)

print("\n=== OPERACIONES NUMÉRICAS ===")
print(f"Suma: {a} + {b} = {suma}")
print(f"Resta: {a} - {b} = {resta}")
print(f"Multiplicación: {a} * {b} = {multiplicacion}")
print(f"División: {a} / {b} = {division}")
print(f"División entera: {a} // {b} = {division_entera}")
print(f"Módulo: {a} % {b} = {modulo}")
print(f"Potencia: {a} ** {b} = {potencia}")

# ============================================
# 4. OPERACIONES CON STRINGS
# ============================================

nombre = "Ana"
apellido = "García"

# Concatenación (unir strings)
nombre_completo = nombre + " " + apellido
print("\n=== OPERACIONES CON STRINGS ===")
print("Nombre completo:", nombre_completo)

# f-strings (formato moderno - muy útil)
edad = 28
mensaje = f"{nombre} tiene {edad} años"
print(mensaje)

# Métodos útiles de strings
texto = "  Python para Ciencia de Datos  "
print("Original:", repr(texto))
print("Mayúsculas:", texto.upper())
print("Minúsculas:", texto.lower())
print("Sin espacios:", texto.strip())
print("Capitalizado:", texto.strip().title())
print("Reemplazar:", texto.replace("Python", "R"))

# ============================================
# 5. CONVERSIÓN DE TIPOS
# ============================================

print("\n=== CONVERSIÓN DE TIPOS ===")

# String a número
edad_texto = "25"
edad_numero = int(edad_texto)
print(f"'{edad_texto}' convertido a int: {edad_numero} (tipo: {type(edad_numero)})")

# Número a string
precio = 99.99
precio_texto = str(precio)
print(f"{precio} convertido a string: '{precio_texto}' (tipo: {type(precio_texto)})")

# Float a int (pierde decimales)
promedio = 85.7
promedio_entero = int(promedio)
print(f"{promedio} convertido a int: {promedio_entero}")

# Int a float
cantidad = 100
cantidad_decimal = float(cantidad)
print(f"{cantidad} convertido a float: {cantidad_decimal}")

# ============================================
# 6. EJERCICIO PRÁCTICO
# ============================================

print("\n=== EJERCICIO PRÁCTICO ===")
print("Calculadora de IMC (Índice de Masa Corporal)")
print("-" * 50)

# Datos de entrada
peso_kg = 70  # peso en kilogramos
altura_m = 1.75  # altura en metros

# Cálculo del IMC: peso / (altura^2)
imc = peso_kg / (altura_m ** 2)

# Mostrar resultado
print(f"Peso: {peso_kg} kg")
print(f"Altura: {altura_m} m")
print(f"IMC: {imc:.2f}")  # .2f = 2 decimales

# Interpretación del resultado
if imc < 18.5:
    categoria = "Bajo peso"
elif imc < 25:
    categoria = "Peso normal"
elif imc < 30:
    categoria = "Sobrepeso"
else:
    categoria = "Obesidad"

print(f"Categoría: {categoria}")

# ============================================
# EJERCICIOS PARA PRACTICAR
# ============================================

print("\n" + "="*50)
print("EJERCICIOS PARA TI:")
print("="*50)
print("""
1. Crea variables para almacenar:
   - Tu nombre
   - Tu edad
   - Tu ciudad
   - Si tienes experiencia en programación (True/False)
   Luego imprime un mensaje usando f-strings

2. Calcula el área de un círculo (π * radio²)
   - Usa radio = 5
   - π = 3.14159

3. Convierte temperatura de Celsius a Fahrenheit
   - Fórmula: F = (C * 9/5) + 32
   - Prueba con 25°C

4. Crea un programa que calcule el precio final de un producto
   - Precio base: 100
   - IVA: 16%
   - Descuento: 10%

¡Modifica este archivo y practica!
""")
