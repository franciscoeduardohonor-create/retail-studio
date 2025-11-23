"""
===============================================================================
CURSO PYTHON - NIVEL PRINCIPIANTE
Módulo 5: Funciones
===============================================================================
En este módulo aprenderás:
- Qué son las funciones y por qué usarlas
- Definir y llamar funciones
- Parámetros y argumentos
- Retorno de valores
- Argumentos por defecto
- *args y **kwargs
- Scope (ámbito) de variables
- Funciones lambda
===============================================================================
"""

# ============================================================================
# 1. ¿QUÉ SON LAS FUNCIONES?
# ============================================================================
print("=== ¿QUÉ SON LAS FUNCIONES? ===\n")

print("""
Las funciones son bloques de código reutilizables que realizan una tarea específica.

Beneficios:
• Reutilización de código
• Organización y claridad
• Facilita el mantenimiento
• Evita repetir código
""")

print("="*70 + "\n")

# ============================================================================
# 2. DEFINIR Y LLAMAR FUNCIONES BÁSICAS
# ============================================================================
print("=== FUNCIONES BÁSICAS ===\n")

# Definir una función simple
def saludar():
    """Esta función imprime un saludo"""
    print("¡Hola! Bienvenido a Python")

# Llamar la función
print("--- Llamando a la función saludar() ---")
saludar()
saludar()  # Podemos llamarla múltiples veces

print()

# Función que hace cálculos
def mostrar_tabla_del_5():
    """Muestra la tabla de multiplicar del 5"""
    print("Tabla del 5:")
    for i in range(1, 11):
        print(f"5 × {i} = {5 * i}")

print("--- Llamando a mostrar_tabla_del_5() ---")
mostrar_tabla_del_5()

print("\n" + "="*70 + "\n")

# ============================================================================
# 3. FUNCIONES CON PARÁMETROS
# ============================================================================
print("=== FUNCIONES CON PARÁMETROS ===\n")

# Función con un parámetro
def saludar_persona(nombre):
    """Saluda a una persona específica"""
    print(f"¡Hola, {nombre}! ¿Cómo estás?")

print("--- Función con un parámetro ---")
saludar_persona("Carlos")
saludar_persona("Ana")
saludar_persona("Francisco")

print()

# Función con múltiples parámetros
def presentar_persona(nombre, edad, ciudad):
    """Presenta a una persona con su información"""
    print(f"Nombre: {nombre}")
    print(f"Edad: {edad} años")
    print(f"Ciudad: {ciudad}")
    print()

print("--- Función con múltiples parámetros ---")
presentar_persona("María", 28, "Guadalajara")
presentar_persona("Juan", 35, "CDMX")

print("="*70 + "\n")

# ============================================================================
# 4. FUNCIONES CON RETURN
# ============================================================================
print("=== FUNCIONES CON RETURN ===\n")

# Función que retorna un valor
def sumar(a, b):
    """Suma dos números y retorna el resultado"""
    resultado = a + b
    return resultado

# Usar el valor retornado
print("--- Función que retorna valor ---")
total = sumar(5, 3)
print(f"5 + 3 = {total}")

# Usar directamente en expresiones
print(f"10 + 20 = {sumar(10, 20)}")
print(f"Doble suma: {sumar(5, 3) + sumar(7, 2)}")

print()

# Función con múltiples operaciones
def calcular_area_rectangulo(base, altura):
    """Calcula el área de un rectángulo"""
    area = base * altura
    return area

print("--- Calcular área de rectángulo ---")
mi_area = calcular_area_rectangulo(5, 3)
print(f"Área del rectángulo (5×3): {mi_area}")

print()

# Función que retorna múltiples valores
def calcular_rectangulo(base, altura):
    """Calcula área y perímetro de un rectángulo"""
    area = base * altura
    perimetro = 2 * (base + altura)
    return area, perimetro  # Retorna una tupla

print("--- Función que retorna múltiples valores ---")
mi_area, mi_perimetro = calcular_rectangulo(5, 3)
print(f"Área: {mi_area}")
print(f"Perímetro: {mi_perimetro}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 5. PARÁMETROS POR DEFECTO
# ============================================================================
print("=== PARÁMETROS POR DEFECTO ===\n")

# Función con valor por defecto
def saludar_con_titulo(nombre, titulo="Sr./Sra."):
    """Saluda con un título (por defecto Sr./Sra.)"""
    print(f"Hola, {titulo} {nombre}")

print("--- Parámetros por defecto ---")
saludar_con_titulo("García")  # Usa el valor por defecto
saludar_con_titulo("Pérez", "Dr.")  # Usa el valor proporcionado
saludar_con_titulo("López", "Ing.")

print()

# Función de potencia con exponente por defecto
def potencia(base, exponente=2):
    """Calcula la potencia (por defecto al cuadrado)"""
    return base ** exponente

print("--- Función potencia ---")
print(f"5² = {potencia(5)}")  # Usa exponente por defecto (2)
print(f"5³ = {potencia(5, 3)}")  # Especifica exponente
print(f"2⁴ = {potencia(2, 4)}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 6. ARGUMENTOS NOMBRADOS (KEYWORD ARGUMENTS)
# ============================================================================
print("=== ARGUMENTOS NOMBRADOS ===\n")

def crear_perfil(nombre, edad, ciudad, profesion):
    """Crea un perfil de usuario"""
    print(f"Perfil de {nombre}:")
    print(f"  • Edad: {edad} años")
    print(f"  • Ciudad: {ciudad}")
    print(f"  • Profesión: {profesion}")
    print()

print("--- Argumentos posicionales ---")
crear_perfil("Ana", 30, "Monterrey", "Ingeniera")

print("--- Argumentos nombrados (más claro) ---")
crear_perfil(
    nombre="Carlos",
    edad=25,
    ciudad="CDMX",
    profesion="Desarrollador"
)

print("--- Argumentos nombrados en cualquier orden ---")
crear_perfil(
    profesion="Diseñador",
    ciudad="Guadalajara",
    nombre="Luis",
    edad=28
)

print("="*70 + "\n")

# ============================================================================
# 7. *args - ARGUMENTOS VARIABLES
# ============================================================================
print("=== *args - ARGUMENTOS VARIABLES ===\n")

# *args permite recibir cualquier cantidad de argumentos posicionales
def sumar_todos(*numeros):
    """Suma cualquier cantidad de números"""
    total = 0
    for numero in numeros:
        total += numero
    return total

print("--- Función con *args ---")
print(f"sumar_todos(1, 2, 3) = {sumar_todos(1, 2, 3)}")
print(f"sumar_todos(1, 2, 3, 4, 5) = {sumar_todos(1, 2, 3, 4, 5)}")
print(f"sumar_todos(10, 20) = {sumar_todos(10, 20)}")

print()

def presentar_nombres(*nombres):
    """Presenta una lista de nombres"""
    print("Lista de personas:")
    for i, nombre in enumerate(nombres, start=1):
        print(f"  {i}. {nombre}")

print("--- Presentar nombres ---")
presentar_nombres("Ana", "Carlos", "María", "Juan", "Pedro")

print("\n" + "="*70 + "\n")

# ============================================================================
# 8. **kwargs - ARGUMENTOS NOMBRADOS VARIABLES
# ============================================================================
print("=== **kwargs - ARGUMENTOS NOMBRADOS VARIABLES ===\n")

# **kwargs permite recibir cualquier cantidad de argumentos nombrados
def mostrar_info_producto(**info):
    """Muestra información de un producto"""
    print("Información del producto:")
    for clave, valor in info.items():
        print(f"  • {clave}: {valor}")
    print()

print("--- Función con **kwargs ---")
mostrar_info_producto(
    nombre="Laptop",
    precio=15000,
    marca="Dell",
    garantia="1 año"
)

mostrar_info_producto(
    nombre="Mouse",
    precio=300,
    color="Negro",
    inalambrico=True
)

print()

# Combinando *args y **kwargs
def mostrar_pedido(*productos, **detalles):
    """Muestra un pedido con productos y detalles adicionales"""
    print("PEDIDO:")
    print("\nProductos:")
    for producto in productos:
        print(f"  - {producto}")

    print("\nDetalles:")
    for clave, valor in detalles.items():
        print(f"  • {clave}: {valor}")
    print()

print("--- Combinando *args y **kwargs ---")
mostrar_pedido(
    "Laptop", "Mouse", "Teclado",
    cliente="Juan Pérez",
    direccion="Av. Principal 123",
    metodo_pago="Tarjeta"
)

print("="*70 + "\n")

# ============================================================================
# 9. SCOPE (ÁMBITO) DE VARIABLES
# ============================================================================
print("=== SCOPE DE VARIABLES ===\n")

# Variable global
nombre_global = "Global"

def mostrar_scope():
    # Variable local
    nombre_local = "Local"
    print(f"Dentro de la función:")
    print(f"  Variable local: {nombre_local}")
    print(f"  Variable global: {nombre_global}")

print("--- Scope de variables ---")
mostrar_scope()
print(f"\nFuera de la función:")
print(f"  Variable global: {nombre_global}")
# print(nombre_local)  # Esto daría error - variable local no existe aquí

print()

# Modificar variable global
contador_global = 0

def incrementar_contador():
    global contador_global  # Declarar que usaremos la variable global
    contador_global += 1
    print(f"Contador dentro de función: {contador_global}")

print("--- Modificar variable global ---")
print(f"Contador inicial: {contador_global}")
incrementar_contador()
incrementar_contador()
print(f"Contador final: {contador_global}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 10. FUNCIONES LAMBDA
# ============================================================================
print("=== FUNCIONES LAMBDA ===\n")

# Lambda: funciones anónimas de una sola línea

# Función tradicional
def cuadrado(x):
    return x ** 2

# Función lambda equivalente
cuadrado_lambda = lambda x: x ** 2

print("--- Función tradicional vs Lambda ---")
print(f"Función tradicional: cuadrado(5) = {cuadrado(5)}")
print(f"Función lambda: cuadrado_lambda(5) = {cuadrado_lambda(5)}")

print()

# Lambda con múltiples parámetros
sumar = lambda a, b: a + b
print(f"Lambda suma: sumar(10, 20) = {sumar(10, 20)}")

# Lambda con condicional
es_par = lambda x: "Par" if x % 2 == 0 else "Impar"
print(f"es_par(4) = {es_par(4)}")
print(f"es_par(7) = {es_par(7)}")

print()

# Usar lambda con funciones integradas
numeros = [1, 2, 3, 4, 5]

# map() - aplicar función a cada elemento
cuadrados = list(map(lambda x: x ** 2, numeros))
print(f"Cuadrados con map: {cuadrados}")

# filter() - filtrar elementos
pares = list(filter(lambda x: x % 2 == 0, numeros))
print(f"Números pares con filter: {pares}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 11. EJEMPLO PRÁCTICO: CALCULADORA
# ============================================================================
print("=== EJEMPLO PRÁCTICO: CALCULADORA ===\n")

def calculadora(operacion, num1, num2):
    """Calculadora con múltiples operaciones"""
    if operacion == "suma":
        return num1 + num2
    elif operacion == "resta":
        return num1 - num2
    elif operacion == "multiplicacion":
        return num1 * num2
    elif operacion == "division":
        if num2 != 0:
            return num1 / num2
        else:
            return "Error: División por cero"
    else:
        return "Operación no válida"

print("Calculadora:")
print(f"10 + 5 = {calculadora('suma', 10, 5)}")
print(f"10 - 5 = {calculadora('resta', 10, 5)}")
print(f"10 × 5 = {calculadora('multiplicacion', 10, 5)}")
print(f"10 ÷ 5 = {calculadora('division', 10, 5)}")
print(f"10 ÷ 0 = {calculadora('division', 10, 0)}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 12. EJEMPLO PRÁCTICO: VALIDADOR DE EMAIL
# ============================================================================
print("=== EJEMPLO PRÁCTICO: VALIDADOR DE EMAIL ===\n")

def validar_email(email):
    """Valida formato básico de email"""
    # Verificaciones básicas
    if "@" not in email:
        return False, "Falta el símbolo @"

    if "." not in email:
        return False, "Falta el punto en el dominio"

    partes = email.split("@")
    if len(partes) != 2:
        return False, "Debe tener exactamente un @"

    usuario, dominio = partes

    if len(usuario) == 0:
        return False, "El usuario no puede estar vacío"

    if len(dominio) == 0:
        return False, "El dominio no puede estar vacío"

    if "." not in dominio:
        return False, "El dominio debe contener un punto"

    return True, "Email válido"

# Probar validador
emails = [
    "usuario@gmail.com",
    "invalido.com",
    "@gmail.com",
    "usuario@",
    "usuario@@gmail.com"
]

print("Validación de emails:")
for email in emails:
    es_valido, mensaje = validar_email(email)
    simbolo = "✓" if es_valido else "✗"
    print(f"{simbolo} {email:25} - {mensaje}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 13. EJEMPLO PRÁCTICO: SISTEMA DE DESCUENTOS
# ============================================================================
print("=== EJEMPLO PRÁCTICO: SISTEMA DE DESCUENTOS ===\n")

def calcular_precio_final(precio, cantidad=1, descuento=0, cliente_vip=False):
    """
    Calcula el precio final con descuentos

    Args:
        precio: Precio unitario del producto
        cantidad: Cantidad de productos (default: 1)
        descuento: Porcentaje de descuento (default: 0)
        cliente_vip: Si es cliente VIP (default: False)

    Returns:
        tuple: (precio_final, ahorro_total)
    """
    subtotal = precio * cantidad

    # Aplicar descuento base
    ahorro_descuento = subtotal * (descuento / 100)

    # Descuento adicional para VIP
    ahorro_vip = 0
    if cliente_vip:
        ahorro_vip = subtotal * 0.05  # 5% adicional

    # Calcular total
    ahorro_total = ahorro_descuento + ahorro_vip
    precio_final = subtotal - ahorro_total

    return precio_final, ahorro_total

# Ejemplos de uso
print("Producto: $1000 × 3 unidades\n")

print("Cliente normal sin descuento:")
total, ahorro = calcular_precio_final(1000, 3)
print(f"  Total: ${total:.2f}, Ahorro: ${ahorro:.2f}\n")

print("Cliente normal con 10% descuento:")
total, ahorro = calcular_precio_final(1000, 3, descuento=10)
print(f"  Total: ${total:.2f}, Ahorro: ${ahorro:.2f}\n")

print("Cliente VIP con 10% descuento:")
total, ahorro = calcular_precio_final(1000, 3, descuento=10, cliente_vip=True)
print(f"  Total: ${total:.2f}, Ahorro: ${ahorro:.2f} (incluye 5% VIP)\n")

print("="*70 + "\n")

# ============================================================================
# 14. EJEMPLO PRÁCTICO: CONVERTIDOR DE TEMPERATURAS
# ============================================================================
print("=== EJEMPLO PRÁCTICO: CONVERTIDOR DE TEMPERATURAS ===\n")

def celsius_a_fahrenheit(celsius):
    """Convierte Celsius a Fahrenheit"""
    return (celsius * 9/5) + 32

def fahrenheit_a_celsius(fahrenheit):
    """Convierte Fahrenheit a Celsius"""
    return (fahrenheit - 32) * 5/9

def celsius_a_kelvin(celsius):
    """Convierte Celsius a Kelvin"""
    return celsius + 273.15

def convertir_temperatura(valor, de_unidad, a_unidad):
    """Convierte temperatura entre diferentes unidades"""
    # Primero convertir todo a Celsius
    if de_unidad == "F":
        celsius = fahrenheit_a_celsius(valor)
    elif de_unidad == "K":
        celsius = valor - 273.15
    else:  # Ya está en Celsius
        celsius = valor

    # Luego convertir de Celsius a la unidad deseada
    if a_unidad == "F":
        return celsius_a_fahrenheit(celsius)
    elif a_unidad == "K":
        return celsius_a_kelvin(celsius)
    else:  # Celsius
        return celsius

# Ejemplos
print("Conversiones de temperatura:\n")
temp = 25
print(f"{temp}°C = {celsius_a_fahrenheit(temp):.2f}°F")
print(f"{temp}°C = {celsius_a_kelvin(temp):.2f}K")
print()

temp_f = 77
print(f"{temp_f}°F = {fahrenheit_a_celsius(temp_f):.2f}°C")
print()

# Usar función universal
print("Usando convertir_temperatura():")
print(f"100°C = {convertir_temperatura(100, 'C', 'F'):.2f}°F")
print(f"32°F = {convertir_temperatura(32, 'F', 'C'):.2f}°C")
print(f"0°C = {convertir_temperatura(0, 'C', 'K'):.2f}K")

print("\n" + "="*70 + "\n")

# ============================================================================
# EJERCICIOS PARA PRACTICAR
# ============================================================================
print("EJERCICIOS PARA PRACTICAR:")
print("="*70)
print("""
1. Función es_primo(numero):
   - Retorna True si el número es primo, False si no
   - Prueba con: 7, 10, 13, 15

2. Función calcular_imc(peso, altura):
   - Calcula el IMC (peso / altura²)
   - Retorna el IMC y la categoría (bajo peso, normal, sobrepeso, obesidad)

3. Función contar_vocales(texto):
   - Cuenta cuántas vocales tiene un texto
   - Retorna la cantidad total

4. Función invertir_cadena(texto):
   - Retorna el texto invertido
   - Ejemplo: "Python" → "nohtyP"

5. Función fibonacci(n):
   - Retorna los primeros n números de la secuencia Fibonacci
   - Ejemplo: fibonacci(7) → [0, 1, 1, 2, 3, 5, 8]

6. Función calcular_factura(**items):
   - Recibe items con sus precios como kwargs
   - Retorna el total con IVA incluido (16%)

7. Función mayor_de_tres(a, b, c):
   - Retorna el mayor de tres números

8. Función es_palindromo(texto):
   - Verifica si un texto es palíndromo
   - Ejemplo: "anilina" → True

¡Practica creando estas funciones!
""")
