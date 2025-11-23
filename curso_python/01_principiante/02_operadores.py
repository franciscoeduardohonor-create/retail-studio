"""
===============================================================================
CURSO PYTHON - NIVEL PRINCIPIANTE
Módulo 2: Operadores
===============================================================================
En este módulo aprenderás:
- Operadores aritméticos
- Operadores de comparación
- Operadores lógicos
- Operadores de asignación
- Precedencia de operadores
===============================================================================
"""

# ============================================================================
# 1. OPERADORES ARITMÉTICOS
# ============================================================================
print("=== OPERADORES ARITMÉTICOS ===\n")

# Definir números para ejemplos
a = 15
b = 4

print(f"a = {a}, b = {b}\n")

# Suma (+)
suma = a + b
print(f"Suma: {a} + {b} = {suma}")

# Resta (-)
resta = a - b
print(f"Resta: {a} - {b} = {resta}")

# Multiplicación (*)
multiplicacion = a * b
print(f"Multiplicación: {a} * {b} = {multiplicacion}")

# División (/) - Siempre devuelve float
division = a / b
print(f"División: {a} / {b} = {division}")

# División entera (//) - Devuelve solo la parte entera
division_entera = a // b
print(f"División entera: {a} // {b} = {division_entera}")

# Módulo (%) - Devuelve el residuo de la división
modulo = a % b
print(f"Módulo (residuo): {a} % {b} = {modulo}")

# Potencia (**)
potencia = a ** b
print(f"Potencia: {a} ** {b} = {potencia}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 2. EJEMPLO PRÁCTICO: CALCULADORA BÁSICA
# ============================================================================
print("=== EJEMPLO PRÁCTICO: CALCULADORA ===\n")

numero1 = 25
numero2 = 7

print(f"Número 1: {numero1}")
print(f"Número 2: {numero2}\n")

print(f"{numero1} + {numero2} = {numero1 + numero2}")
print(f"{numero1} - {numero2} = {numero1 - numero2}")
print(f"{numero1} × {numero2} = {numero1 * numero2}")
print(f"{numero1} ÷ {numero2} = {numero1 / numero2:.2f}")
print(f"{numero1} elevado a {numero2} = {numero1 ** numero2}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 3. OPERADORES DE COMPARACIÓN
# ============================================================================
print("=== OPERADORES DE COMPARACIÓN ===\n")
print("Los operadores de comparación devuelven True o False\n")

x = 10
y = 20
z = 10

print(f"x = {x}, y = {y}, z = {z}\n")

# Igual a (==)
print(f"x == y: {x == y}  (¿{x} es igual a {y}?)")
print(f"x == z: {x == z}  (¿{x} es igual a {z}?)")

# Diferente de (!=)
print(f"x != y: {x != y}  (¿{x} es diferente de {y}?)")

# Mayor que (>)
print(f"x > y: {x > y}  (¿{x} es mayor que {y}?)")
print(f"y > x: {y > x}  (¿{y} es mayor que {x}?)")

# Menor que (<)
print(f"x < y: {x < y}  (¿{x} es menor que {y}?)")

# Mayor o igual que (>=)
print(f"x >= z: {x >= z}  (¿{x} es mayor o igual que {z}?)")
print(f"x >= y: {x >= y}  (¿{x} es mayor o igual que {y}?)")

# Menor o igual que (<=)
print(f"x <= y: {x <= y}  (¿{x} es menor o igual que {y}?)")

print("\n" + "="*70 + "\n")

# ============================================================================
# 4. OPERADORES LÓGICOS
# ============================================================================
print("=== OPERADORES LÓGICOS ===\n")
print("Operadores: and, or, not\n")

# Variables para ejemplos
edad = 25
tiene_licencia = True
tiene_auto = False

# Operador AND - Todas las condiciones deben ser True
print("--- Operador AND ---")
print(f"edad >= 18 and tiene_licencia: {edad >= 18 and tiene_licencia}")
print(f"edad >= 18 and tiene_auto: {edad >= 18 and tiene_auto}")
print()

# Operador OR - Al menos una condición debe ser True
print("--- Operador OR ---")
print(f"tiene_licencia or tiene_auto: {tiene_licencia or tiene_auto}")
print(f"edad < 18 or tiene_licencia: {edad < 18 or tiene_licencia}")
print()

# Operador NOT - Invierte el valor booleano
print("--- Operador NOT ---")
print(f"tiene_licencia: {tiene_licencia}")
print(f"not tiene_licencia: {not tiene_licencia}")
print(f"tiene_auto: {tiene_auto}")
print(f"not tiene_auto: {not tiene_auto}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 5. EJEMPLO PRÁCTICO: SISTEMA DE ACCESO
# ============================================================================
print("=== EJEMPLO PRÁCTICO: SISTEMA DE ACCESO ===\n")

# Datos del usuario
edad_usuario = 20
es_miembro = True
tiene_invitacion = False

# Verificar acceso (debe ser mayor de 18 Y ser miembro O tener invitación)
puede_entrar = edad_usuario >= 18 and (es_miembro or tiene_invitacion)

print(f"Edad: {edad_usuario}")
print(f"Es miembro: {es_miembro}")
print(f"Tiene invitación: {tiene_invitacion}")
print(f"¿Puede entrar?: {puede_entrar}")
print()

# Otro ejemplo
edad_usuario2 = 17
es_miembro2 = True
puede_entrar2 = edad_usuario2 >= 18 and es_miembro2

print(f"Usuario 2 - Edad: {edad_usuario2}, Es miembro: {es_miembro2}")
print(f"¿Puede entrar?: {puede_entrar2}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 6. OPERADORES DE ASIGNACIÓN
# ============================================================================
print("=== OPERADORES DE ASIGNACIÓN ===\n")

# Asignación simple (=)
contador = 10
print(f"contador = {contador}")

# Suma y asigna (+=)
contador += 5  # Equivale a: contador = contador + 5
print(f"contador += 5 → {contador}")

# Resta y asigna (-=)
contador -= 3  # Equivale a: contador = contador - 3
print(f"contador -= 3 → {contador}")

# Multiplica y asigna (*=)
contador *= 2  # Equivale a: contador = contador * 2
print(f"contador *= 2 → {contador}")

# Divide y asigna (/=)
contador /= 4  # Equivale a: contador = contador / 4
print(f"contador /= 4 → {contador}")

# División entera y asigna (//=)
numero = 17
numero //= 5
print(f"numero = 17, numero //= 5 → {numero}")

# Módulo y asigna (%=)
numero = 17
numero %= 5
print(f"numero = 17, numero %= 5 → {numero}")

# Potencia y asigna (**=)
base = 2
base **= 3
print(f"base = 2, base **= 3 → {base}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 7. EJEMPLO PRÁCTICO: CONTADOR DE PUNTOS
# ============================================================================
print("=== EJEMPLO PRÁCTICO: CONTADOR DE PUNTOS DE JUEGO ===\n")

puntos = 0
print(f"Puntos iniciales: {puntos}")

# El jugador completa nivel 1
puntos += 100
print(f"Completó nivel 1: +100 puntos → Total: {puntos}")

# El jugador encuentra un tesoro
puntos += 50
print(f"Encontró tesoro: +50 puntos → Total: {puntos}")

# El jugador pierde una vida
puntos -= 25
print(f"Perdió una vida: -25 puntos → Total: {puntos}")

# Bonus de multiplicador x2
puntos *= 2
print(f"Bonus multiplicador x2 → Total: {puntos}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 8. PRECEDENCIA DE OPERADORES
# ============================================================================
print("=== PRECEDENCIA DE OPERADORES ===\n")
print("La precedencia determina el orden en que se evalúan las operaciones\n")

# Ejemplo sin paréntesis
resultado1 = 5 + 3 * 2
print(f"5 + 3 * 2 = {resultado1}")
print("Se multiplica primero (3*2=6), luego se suma (5+6=11)\n")

# Ejemplo con paréntesis
resultado2 = (5 + 3) * 2
print(f"(5 + 3) * 2 = {resultado2}")
print("Los paréntesis tienen mayor prioridad (5+3=8), luego se multiplica (8*2=16)\n")

# Ejemplo complejo
resultado3 = 10 + 5 * 2 ** 2 - 8 / 4
print(f"10 + 5 * 2 ** 2 - 8 / 4 = {resultado3}")
print("Orden: 1) 2**2=4, 2) 5*4=20, 3) 8/4=2, 4) 10+20-2=28\n")

print("Orden de precedencia (de mayor a menor):")
print("1. Paréntesis ()")
print("2. Potencia **")
print("3. Multiplicación *, División /, División entera //, Módulo %")
print("4. Suma +, Resta -")
print("5. Comparaciones <, >, <=, >=, ==, !=")
print("6. not")
print("7. and")
print("8. or")

print("\n" + "="*70 + "\n")

# ============================================================================
# 9. OPERADORES CON STRINGS
# ============================================================================
print("=== OPERADORES CON STRINGS ===\n")

# Concatenación con +
nombre = "Juan"
apellido = "Pérez"
nombre_completo = nombre + " " + apellido
print(f"Concatenación: '{nombre}' + ' ' + '{apellido}' = '{nombre_completo}'")

# Repetición con *
linea = "=" * 30
print(f"Repetición: '=' * 30 = {linea}")

simbolo = "★"
estrellas = simbolo * 5
print(f"Repetición: '★' * 5 = {estrellas}")

# Comparación de strings
texto1 = "Python"
texto2 = "Python"
texto3 = "python"

print(f"\n'{texto1}' == '{texto2}': {texto1 == texto2}")
print(f"'{texto1}' == '{texto3}': {texto1 == texto3} (Python es case-sensitive)")

print("\n" + "="*70 + "\n")

# ============================================================================
# 10. EJEMPLO PRÁCTICO FINAL: CÁLCULO DE DESCUENTO
# ============================================================================
print("=== EJEMPLO PRÁCTICO: SISTEMA DE DESCUENTOS ===\n")

# Datos de la compra
precio_original = 1500.00
cantidad = 3
es_cliente_vip = True
tiene_cupon = True

print(f"Precio por producto: ${precio_original}")
print(f"Cantidad: {cantidad}")
print(f"Cliente VIP: {es_cliente_vip}")
print(f"Tiene cupón: {tiene_cupon}\n")

# Calcular subtotal
subtotal = precio_original * cantidad
print(f"Subtotal: ${subtotal}")

# Aplicar descuento VIP (10%)
descuento_vip = 0
if es_cliente_vip:
    descuento_vip = subtotal * 0.10
    print(f"Descuento VIP (10%): -${descuento_vip}")

# Aplicar cupón adicional (5%)
descuento_cupon = 0
if tiene_cupon:
    descuento_cupon = subtotal * 0.05
    print(f"Descuento cupón (5%): -${descuento_cupon}")

# Calcular total con descuentos
total = subtotal - descuento_vip - descuento_cupon
print(f"\nTotal a pagar: ${total:.2f}")

# Calcular ahorro total
ahorro_total = descuento_vip + descuento_cupon
porcentaje_ahorro = (ahorro_total / subtotal) * 100
print(f"Ahorro total: ${ahorro_total:.2f} ({porcentaje_ahorro:.1f}%)")

print("\n" + "="*70 + "\n")

# ============================================================================
# EJERCICIOS PARA PRACTICAR
# ============================================================================
print("EJERCICIOS PARA PRACTICAR:")
print("="*70)
print("""
1. Calculadora de IMC (Índice de Masa Corporal):
   - peso = 70 (kg)
   - altura = 1.75 (metros)
   - Fórmula: IMC = peso / (altura ** 2)
   - Imprime el resultado

2. Conversor de moneda:
   - dolares = 100
   - tipo_cambio = 17.50 (pesos por dólar)
   - Calcula cuántos pesos son
   - Calcula cuántos dólares son 500 pesos

3. Verificador de número par o impar:
   - numero = 27
   - Usa el operador módulo (%) para verificar si es par o impar
   - Si numero % 2 == 0, es par; si no, es impar

4. Calculadora de propina compartida:
   - cuenta_total = 850
   - numero_personas = 4
   - propina_porcentaje = 15
   - Calcula: propina total, total con propina, cuánto paga cada persona

5. Comparador de precios:
   - precio_tienda_a = 299.99
   - precio_tienda_b = 315.00
   - Usa operadores de comparación para determinar cuál es más barato
   - Calcula la diferencia de precio

6. Sistema de calificaciones:
   - calificacion = 85
   - asistencia_porcentaje = 90
   - Verifica si aprueba: calificacion >= 70 and asistencia_porcentaje >= 80

¡Intenta resolver estos ejercicios! La práctica es clave para aprender.
""")
