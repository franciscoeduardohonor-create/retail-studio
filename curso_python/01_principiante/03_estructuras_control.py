"""
===============================================================================
CURSO PYTHON - NIVEL PRINCIPIANTE
Módulo 3: Estructuras de Control (Condicionales)
===============================================================================
En este módulo aprenderás:
- Estructura if
- Estructura if-else
- Estructura if-elif-else
- Condicionales anidados
- Operador ternario
- Expresiones booleanas
===============================================================================
"""

# ============================================================================
# 1. ESTRUCTURA IF BÁSICA
# ============================================================================
print("=== ESTRUCTURA IF BÁSICA ===\n")

# El if ejecuta código solo si la condición es True
edad = 20

print(f"Edad: {edad}")
if edad >= 18:
    print("✓ Eres mayor de edad")
    print("✓ Puedes votar")

print()  # Línea en blanco

# Ejemplo 2
temperatura = 30
print(f"Temperatura: {temperatura}°C")
if temperatura > 25:
    print("🌡️ Hace calor, usa ropa ligera")

print("\n" + "="*70 + "\n")

# ============================================================================
# 2. ESTRUCTURA IF-ELSE
# ============================================================================
print("=== ESTRUCTURA IF-ELSE ===\n")

# if-else: ejecuta un bloque si es True, otro si es False
edad = 15

print(f"Edad: {edad}")
if edad >= 18:
    print("✓ Eres mayor de edad")
    print("✓ Puedes entrar al evento")
else:
    print("✗ Eres menor de edad")
    print("✗ No puedes entrar al evento")

print()

# Ejemplo 2: Verificar si un número es par o impar
numero = 17
print(f"Número: {numero}")

if numero % 2 == 0:
    print(f"{numero} es PAR")
else:
    print(f"{numero} es IMPAR")

print("\n" + "="*70 + "\n")

# ============================================================================
# 3. ESTRUCTURA IF-ELIF-ELSE
# ============================================================================
print("=== ESTRUCTURA IF-ELIF-ELSE ===\n")

# elif (else if): permite evaluar múltiples condiciones
calificacion = 85

print(f"Calificación: {calificacion}")

if calificacion >= 90:
    print("📚 Excelente - A")
elif calificacion >= 80:
    print("📗 Muy bien - B")
elif calificacion >= 70:
    print("📘 Bien - C")
elif calificacion >= 60:
    print("📙 Suficiente - D")
else:
    print("📕 Reprobado - F")

print()

# Ejemplo 2: Categorías de edad
edad = 35
print(f"Edad: {edad}")

if edad < 13:
    print("Categoría: Niño")
elif edad < 18:
    print("Categoría: Adolescente")
elif edad < 65:
    print("Categoría: Adulto")
else:
    print("Categoría: Adulto mayor")

print("\n" + "="*70 + "\n")

# ============================================================================
# 4. CONDICIONES MÚLTIPLES (AND, OR)
# ============================================================================
print("=== CONDICIONES MÚLTIPLES ===\n")

# Usando AND - Todas las condiciones deben ser True
print("--- Ejemplo con AND ---")
edad = 25
tiene_credencial = True

print(f"Edad: {edad}, Tiene credencial: {tiene_credencial}")

if edad >= 18 and tiene_credencial:
    print("✓ Puede entrar al club")
else:
    print("✗ No puede entrar")

print()

# Usando OR - Al menos una condición debe ser True
print("--- Ejemplo con OR ---")
es_socio = False
tiene_invitacion = True

print(f"Es socio: {es_socio}, Tiene invitación: {tiene_invitacion}")

if es_socio or tiene_invitacion:
    print("✓ Acceso permitido")
else:
    print("✗ Acceso denegado")

print()

# Combinando AND y OR
print("--- Combinando AND y OR ---")
edad = 20
es_estudiante = True
tiene_descuento = False

print(f"Edad: {edad}, Estudiante: {es_estudiante}, Tiene descuento: {tiene_descuento}")

if (edad < 25 and es_estudiante) or tiene_descuento:
    print("✓ Tiene derecho a descuento del 20%")
else:
    print("✗ No tiene descuento")

print("\n" + "="*70 + "\n")

# ============================================================================
# 5. CONDICIONALES ANIDADOS
# ============================================================================
print("=== CONDICIONALES ANIDADOS ===\n")

# Un if dentro de otro if
usuario = "premium"
saldo = 5000

print(f"Tipo de usuario: {usuario}")
print(f"Saldo: ${saldo}")
print()

if usuario == "premium":
    print("Usuario premium detectado")
    if saldo >= 1000:
        print("✓ Puede realizar la transferencia")
        print("✓ Sin comisión por ser premium")
    else:
        print("✗ Saldo insuficiente")
else:
    print("Usuario regular")
    if saldo >= 1000:
        print("✓ Puede realizar la transferencia")
        print("ℹ️ Se aplicará comisión del 2%")
    else:
        print("✗ Saldo insuficiente")

print("\n" + "="*70 + "\n")

# ============================================================================
# 6. OPERADOR TERNARIO (IF EN UNA LÍNEA)
# ============================================================================
print("=== OPERADOR TERNARIO ===\n")

# Sintaxis: valor_si_true if condicion else valor_si_false
edad = 20

# Forma tradicional
if edad >= 18:
    mensaje = "Mayor de edad"
else:
    mensaje = "Menor de edad"
print(f"Forma tradicional: {mensaje}")

# Forma ternaria (en una línea)
mensaje = "Mayor de edad" if edad >= 18 else "Menor de edad"
print(f"Forma ternaria: {mensaje}")

print()

# Más ejemplos de operador ternario
numero = 10
tipo = "Par" if numero % 2 == 0 else "Impar"
print(f"El número {numero} es: {tipo}")

temperatura = 28
estado = "Calor" if temperatura > 25 else "Frío"
print(f"Temperatura {temperatura}°C: {estado}")

precio = 100
descuento = precio * 0.2 if precio > 50 else 0
print(f"Precio: ${precio}, Descuento: ${descuento}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 7. EJEMPLO PRÁCTICO: CALCULADORA DE IMC
# ============================================================================
print("=== EJEMPLO PRÁCTICO: CALCULADORA DE IMC ===\n")

# Datos
peso = 70  # kg
altura = 1.75  # metros

# Calcular IMC
imc = peso / (altura ** 2)

print(f"Peso: {peso} kg")
print(f"Altura: {altura} m")
print(f"IMC: {imc:.2f}")
print()

# Interpretar resultado
if imc < 18.5:
    print("📊 Clasificación: Bajo peso")
    print("💡 Recomendación: Consulta a un nutricionista")
elif imc < 25:
    print("📊 Clasificación: Peso normal")
    print("💡 Recomendación: Mantén tu estilo de vida saludable")
elif imc < 30:
    print("📊 Clasificación: Sobrepeso")
    print("💡 Recomendación: Considera hacer más ejercicio")
else:
    print("📊 Clasificación: Obesidad")
    print("💡 Recomendación: Consulta a un médico")

print("\n" + "="*70 + "\n")

# ============================================================================
# 8. EJEMPLO PRÁCTICO: SISTEMA DE LOGIN
# ============================================================================
print("=== EJEMPLO PRÁCTICO: SISTEMA DE LOGIN ===\n")

# Credenciales correctas (en un sistema real, nunca hagas esto)
usuario_correcto = "admin"
password_correcta = "1234"

# Intento de login
usuario_ingresado = "admin"
password_ingresada = "1234"

print(f"Intentando login con usuario: {usuario_ingresado}")

if usuario_ingresado == usuario_correcto and password_ingresada == password_correcta:
    print("✓ Login exitoso")
    print("✓ Bienvenido al sistema")
elif usuario_ingresado == usuario_correcto:
    print("✗ Contraseña incorrecta")
elif password_ingresada == password_correcta:
    print("✗ Usuario incorrecto")
else:
    print("✗ Usuario y contraseña incorrectos")

print("\n" + "="*70 + "\n")

# ============================================================================
# 9. EJEMPLO PRÁCTICO: CALCULADORA DE ENVÍO
# ============================================================================
print("=== EJEMPLO PRÁCTICO: CALCULADORA DE ENVÍO ===\n")

# Datos de la compra
total_compra = 800
destino = "nacional"  # "nacional" o "internacional"
peso = 3  # kg
es_cliente_premium = True

print(f"Total de compra: ${total_compra}")
print(f"Destino: {destino}")
print(f"Peso: {peso} kg")
print(f"Cliente premium: {es_cliente_premium}")
print()

# Calcular costo de envío
if es_cliente_premium:
    costo_envio = 0
    print("🎁 Envío GRATIS por ser cliente premium")
elif total_compra >= 500:
    costo_envio = 0
    print("🎁 Envío GRATIS por compra mayor a $500")
else:
    if destino == "nacional":
        costo_envio = peso * 50  # $50 por kg
    else:  # internacional
        costo_envio = peso * 200  # $200 por kg

    print(f"💰 Costo de envío: ${costo_envio}")

# Total final
total_final = total_compra + costo_envio
print(f"\n📦 Total final (compra + envío): ${total_final}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 10. EJEMPLO PRÁCTICO: APROBACIÓN DE PRÉSTAMO
# ============================================================================
print("=== EJEMPLO PRÁCTICO: SISTEMA DE APROBACIÓN DE PRÉSTAMO ===\n")

# Datos del solicitante
edad = 30
ingreso_mensual = 15000
historial_crediticio = "bueno"  # "excelente", "bueno", "regular", "malo"
tiene_deudas = False
monto_solicitado = 50000

print(f"Edad: {edad} años")
print(f"Ingreso mensual: ${ingreso_mensual}")
print(f"Historial crediticio: {historial_crediticio}")
print(f"Tiene deudas: {tiene_deudas}")
print(f"Monto solicitado: ${monto_solicitado}")
print()

# Evaluar solicitud
if edad < 18:
    print("✗ RECHAZADO: Debe ser mayor de edad")
elif edad > 70:
    print("✗ RECHAZADO: Edad máxima excedida")
elif ingreso_mensual < 10000:
    print("✗ RECHAZADO: Ingreso mensual insuficiente")
elif tiene_deudas and historial_crediticio == "malo":
    print("✗ RECHAZADO: Mal historial crediticio y deudas pendientes")
elif monto_solicitado > (ingreso_mensual * 12 * 3):
    print("✗ RECHAZADO: Monto solicitado muy alto para su ingreso")
else:
    # Aprobado - determinar tasa de interés
    print("✓ PRÉSTAMO APROBADO")

    if historial_crediticio == "excelente":
        tasa_interes = 8.5
    elif historial_crediticio == "bueno":
        tasa_interes = 12.0
    else:
        tasa_interes = 18.0

    print(f"💰 Monto aprobado: ${monto_solicitado}")
    print(f"📊 Tasa de interés: {tasa_interes}%")

    # Calcular pago mensual (simplificado a 12 meses)
    pago_mensual = (monto_solicitado * (1 + tasa_interes/100)) / 12
    print(f"💳 Pago mensual: ${pago_mensual:.2f}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 11. VERIFICACIÓN DE PERTENENCIA (IN, NOT IN)
# ============================================================================
print("=== OPERADORES IN y NOT IN ===\n")

# Verificar si un valor está en una secuencia
fruta = "manzana"
frutas_disponibles = ["manzana", "pera", "naranja", "uva"]

print(f"Frutas disponibles: {frutas_disponibles}")
print(f"Fruta buscada: {fruta}")

if fruta in frutas_disponibles:
    print(f"✓ {fruta} está disponible")
else:
    print(f"✗ {fruta} no está disponible")

print()

# Ejemplo con strings
email = "usuario@gmail.com"
print(f"Email: {email}")

if "@" in email and "." in email:
    print("✓ Formato de email válido (verificación básica)")
else:
    print("✗ Formato de email inválido")

print()

# NOT IN
dia = "lunes"
dias_libres = ["sábado", "domingo"]

print(f"Día: {dia}")
print(f"Días libres: {dias_libres}")

if dia not in dias_libres:
    print("💼 Es día laboral")
else:
    print("🎉 Es día libre")

print("\n" + "="*70 + "\n")

# ============================================================================
# EJERCICIOS PARA PRACTICAR
# ============================================================================
print("EJERCICIOS PARA PRACTICAR:")
print("="*70)
print("""
1. Verificador de edad para película:
   - edad = 16
   - clasificacion_pelicula = "R" (requiere 18+)
   - Determina si puede ver la película

2. Calculadora de descuento por temporada:
   - precio = 1000
   - mes = "diciembre"
   - Si es noviembre o diciembre: 20% descuento
   - Si es enero a marzo: 10% descuento
   - Resto del año: sin descuento

3. Verificador de número positivo/negativo/cero:
   - numero = -5
   - Determina si es positivo, negativo o cero

4. Sistema de notas con asistencia:
   - calificacion = 75
   - asistencia = 85
   - Aprueba si: calificacion >= 70 AND asistencia >= 80
   - Si no cumple asistencia pero tiene calificacion >= 90, también aprueba

5. Calculadora de categoría de producto:
   - precio = 150
   - categoria = "electrónica"
   - Si electrónica y precio > 100: "Premium"
   - Si electrónica y precio <= 100: "Estándar"
   - Si ropa: siempre "Fashion"
   - Otros: "General"

6. Sistema de bonificación:
   - ventas = 50000
   - años_empresa = 3
   - Bonificación:
     * ventas >= 100000: 15% de bonificación
     * ventas >= 50000 and años >= 2: 10%
     * ventas >= 30000: 5%
     * resto: sin bonificación

¡Practica estos ejercicios para dominar las estructuras condicionales!
""")
