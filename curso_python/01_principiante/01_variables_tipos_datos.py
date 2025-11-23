"""
===============================================================================
CURSO PYTHON - NIVEL PRINCIPIANTE
Módulo 1: Variables y Tipos de Datos
===============================================================================
En este módulo aprenderás:
- Qué son las variables
- Tipos de datos básicos en Python
- Cómo crear y usar variables
- Conversión de tipos (casting)
===============================================================================
"""

# ============================================================================
# 1. ¿QUÉ SON LAS VARIABLES?
# ============================================================================
# Las variables son "contenedores" que almacenan información
# En Python, no necesitas declarar el tipo de variable, Python lo detecta automáticamente

# Ejemplo 1: Crear variables
nombre = "Francisco"  # Variable tipo string (texto)
edad = 25  # Variable tipo int (número entero)
altura = 1.75  # Variable tipo float (número decimal)
es_estudiante = True  # Variable tipo bool (booleano: True o False)

# Imprimir variables
print("=== EJEMPLO 1: Variables Básicas ===")
print("Nombre:", nombre)
print("Edad:", edad)
print("Altura:", altura)
print("¿Es estudiante?:", es_estudiante)
print()

# ============================================================================
# 2. TIPOS DE DATOS BÁSICOS
# ============================================================================

# --- String (str) - Cadenas de texto ---
print("=== EJEMPLO 2: Strings (Textos) ===")
mensaje = "Hola, estoy aprendiendo Python"
saludo = 'También puedes usar comillas simples'
parrafo = """Puedes usar triple comillas
para textos de múltiples líneas
como este"""

print(mensaje)
print(saludo)
print(parrafo)
print()

# --- Números Enteros (int) ---
print("=== EJEMPLO 3: Números Enteros ===")
cantidad_productos = 100
temperatura = -5
año_actual = 2024

print("Productos en inventario:", cantidad_productos)
print("Temperatura:", temperatura, "grados")
print("Año:", año_actual)
print()

# --- Números Decimales (float) ---
print("=== EJEMPLO 4: Números Decimales ===")
precio = 99.99
pi = 3.14159
peso = 75.5

print("Precio:", precio)
print("Valor de PI:", pi)
print("Peso:", peso, "kg")
print()

# --- Booleanos (bool) - True o False ---
print("=== EJEMPLO 5: Booleanos ===")
esta_lloviendo = False
tiene_descuento = True
es_mayor_edad = True

print("¿Está lloviendo?:", esta_lloviendo)
print("¿Tiene descuento?:", tiene_descuento)
print("¿Es mayor de edad?:", es_mayor_edad)
print()

# ============================================================================
# 3. FUNCIÓN type() - Conocer el tipo de dato
# ============================================================================
print("=== EJEMPLO 6: Verificar Tipo de Datos ===")
nombre_completo = "Juan Pérez"
numero_empleado = 12345
salario = 45000.50
activo = True

print("Tipo de 'nombre_completo':", type(nombre_completo))
print("Tipo de 'numero_empleado':", type(numero_empleado))
print("Tipo de 'salario':", type(salario))
print("Tipo de 'activo':", type(activo))
print()

# ============================================================================
# 4. CONVERSIÓN DE TIPOS (CASTING)
# ============================================================================
print("=== EJEMPLO 7: Conversión de Tipos ===")

# Convertir número a string
edad_numero = 30
edad_texto = str(edad_numero)  # Convertir int a string
print("Edad como número:", edad_numero, "- Tipo:", type(edad_numero))
print("Edad como texto:", edad_texto, "- Tipo:", type(edad_texto))
print()

# Convertir string a número
precio_texto = "150"
precio_numero = int(precio_texto)  # Convertir string a int
print("Precio como texto:", precio_texto, "- Tipo:", type(precio_texto))
print("Precio como número:", precio_numero, "- Tipo:", type(precio_numero))
print()

# Convertir a decimal (float)
cantidad_str = "25.5"
cantidad_float = float(cantidad_str)
print("Cantidad como texto:", cantidad_str, "- Tipo:", type(cantidad_str))
print("Cantidad como decimal:", cantidad_float, "- Tipo:", type(cantidad_float))
print()

# ============================================================================
# 5. OPERACIONES CON STRINGS
# ============================================================================
print("=== EJEMPLO 8: Operaciones con Textos ===")

# Concatenación (unir textos)
primer_nombre = "Carlos"
apellido = "González"
nombre_completo = primer_nombre + " " + apellido
print("Nombre completo:", nombre_completo)

# Repetición de strings
separador = "-" * 30  # Repite el guión 30 veces
print(separador)

# Formateo de strings - Método 1: f-strings (recomendado)
nombre = "Ana"
edad = 28
mensaje = f"Hola, me llamo {nombre} y tengo {edad} años"
print(mensaje)

# Formateo de strings - Método 2: format()
mensaje2 = "Hola, me llamo {} y tengo {} años".format(nombre, edad)
print(mensaje2)

# Formateo de strings - Método 3: %
mensaje3 = "Hola, me llamo %s y tengo %d años" % (nombre, edad)
print(mensaje3)
print()

# ============================================================================
# 6. MÉTODOS ÚTILES DE STRINGS
# ============================================================================
print("=== EJEMPLO 9: Métodos de Strings ===")
texto = "  Python es Fantástico  "

print("Original:", f"'{texto}'")
print("Mayúsculas:", texto.upper())
print("Minúsculas:", texto.lower())
print("Capitalizado:", texto.capitalize())
print("Sin espacios:", texto.strip())
print("Longitud:", len(texto))
print("Reemplazar:", texto.replace("Fantástico", "Increíble"))
print()

# ============================================================================
# 7. ENTRADA DE DATOS DEL USUARIO
# ============================================================================
print("=== EJEMPLO 10: Entrada de Datos ===")
print("Ejemplo de cómo pedir datos al usuario:")
print("nombre_usuario = input('¿Cuál es tu nombre? ')")
print("edad_usuario = int(input('¿Cuál es tu edad? '))")
print()

# Descomenta las siguientes líneas para probar (comenta con # las líneas print de arriba):
# nombre_usuario = input("¿Cuál es tu nombre? ")
# edad_usuario = int(input("¿Cuál es tu edad? "))
# print(f"Hola {nombre_usuario}, tienes {edad_usuario} años")

# ============================================================================
# 8. EJEMPLO PRÁCTICO COMPLETO
# ============================================================================
print("=== EJEMPLO 11: Calculadora de Precio con IVA ===")

# Definir variables
producto = "Laptop"
precio_base = 15000.00
iva_porcentaje = 16  # 16% de IVA
cantidad = 2

# Cálculos
iva_monto = precio_base * (iva_porcentaje / 100)
precio_con_iva = precio_base + iva_monto
total_compra = precio_con_iva * cantidad

# Mostrar resultados
print(f"Producto: {producto}")
print(f"Precio base: ${precio_base:.2f}")
print(f"IVA ({iva_porcentaje}%): ${iva_monto:.2f}")
print(f"Precio con IVA: ${precio_con_iva:.2f}")
print(f"Cantidad: {cantidad}")
print(f"Total a pagar: ${total_compra:.2f}")
print()

# ============================================================================
# 9. MÚLTIPLES ASIGNACIONES
# ============================================================================
print("=== EJEMPLO 12: Múltiples Asignaciones ===")

# Asignar varios valores a la vez
x, y, z = 10, 20, 30
print(f"x = {x}, y = {y}, z = {z}")

# Asignar el mismo valor a varias variables
a = b = c = 100
print(f"a = {a}, b = {b}, c = {c}")

# Intercambiar valores
num1 = 5
num2 = 10
print(f"Antes: num1 = {num1}, num2 = {num2}")
num1, num2 = num2, num1  # Intercambio elegante en Python
print(f"Después: num1 = {num1}, num2 = {num2}")
print()

# ============================================================================
# 10. CONSTANTES (Convención)
# ============================================================================
print("=== EJEMPLO 13: Constantes ===")
# En Python no hay constantes reales, pero por convención se escriben en MAYÚSCULAS
# para indicar que no deberían cambiar

PI = 3.14159
VELOCIDAD_LUZ = 299792458  # metros por segundo
IVA = 0.16

radio = 5
area_circulo = PI * (radio ** 2)
print(f"Área del círculo con radio {radio}: {area_circulo:.2f}")
print()

# ============================================================================
# EJERCICIOS PARA PRACTICAR
# ============================================================================
print("=" * 70)
print("EJERCICIOS PARA PRACTICAR:")
print("=" * 70)
print("""
1. Crea variables con tu información personal:
   - nombre, apellido, edad, ciudad, profesión
   - Imprime toda la información en un formato bonito

2. Crea un programa que calcule el área de un rectángulo:
   - Crea variables: base = 10, altura = 5
   - Calcula el área
   - Imprime el resultado

3. Calculadora de propina:
   - precio_cuenta = 450.00
   - porcentaje_propina = 15
   - Calcula la propina y el total a pagar

4. Conversión de temperatura:
   - celsius = 25
   - Convierte a Fahrenheit usando: F = (C * 9/5) + 32
   - Imprime el resultado

5. Crea un programa que intercambie los valores de dos variables
   y muestre el resultado antes y después

¡Intenta resolver estos ejercicios por tu cuenta!
""")
