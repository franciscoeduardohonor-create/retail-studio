"""
===============================================================================
CURSO PYTHON - NIVEL INTERMEDIO
Módulo 3: Manejo de Excepciones
===============================================================================
En este módulo aprenderás:
- Try-except
- Múltiples excepciones
- Finally y else
- Crear excepciones personalizadas
- Buenas prácticas
===============================================================================
"""

# ============================================================================
# 1. INTRODUCCIÓN A EXCEPCIONES
# ============================================================================
print("=== MANEJO DE EXCEPCIONES ===\n")

print("""
Las excepciones son errores que ocurren durante la ejecución del programa.
Python permite "capturar" estos errores para manejarlos apropiadamente.

Excepciones comunes:
• ValueError: Valor incorrecto
• TypeError: Tipo de dato incorrecto
• KeyError: Clave no existe en diccionario
• IndexError: Índice fuera de rango
• FileNotFoundError: Archivo no encontrado
• ZeroDivisionError: División por cero
""")

print("="*70 + "\n")

# ============================================================================
# 2. TRY-EXCEPT BÁSICO
# ============================================================================
print("=== TRY-EXCEPT BÁSICO ===\n")

# Sin manejo de excepción (causaría error)
# numero = int("abc")  # ValueError!

# Con manejo de excepción
print("--- Ejemplo 1: Convertir a número ---")
try:
    numero = int("abc")
    print(f"Número: {numero}")
except ValueError:
    print("⚠️ Error: No se puede convertir 'abc' a número")

print()

# División por cero
print("--- Ejemplo 2: División por cero ---")
try:
    resultado = 10 / 0
    print(f"Resultado: {resultado}")
except ZeroDivisionError:
    print("⚠️ Error: No se puede dividir por cero")

print("\n" + "="*70 + "\n")

# ============================================================================
# 3. CAPTURAR MÚLTIPLES EXCEPCIONES
# ============================================================================
print("=== MÚLTIPLES EXCEPCIONES ===\n")

def dividir_numeros(a, b):
    """Divide dos números con manejo de errores"""
    try:
        resultado = a / b
        return resultado
    except ZeroDivisionError:
        print("⚠️ Error: División por cero")
        return None
    except TypeError:
        print("⚠️ Error: Los valores deben ser números")
        return None

print("--- Probar división ---")
print(f"10 / 2 = {dividir_numeros(10, 2)}")
print(f"10 / 0 = {dividir_numeros(10, 0)}")
print(f"10 / 'a' = {dividir_numeros(10, 'a')}")

print()

# Capturar múltiples excepciones en un bloque
print("--- Capturar varias excepciones juntas ---")
def convertir_y_sumar(texto1, texto2):
    try:
        num1 = int(texto1)
        num2 = int(texto2)
        return num1 + num2
    except (ValueError, TypeError) as e:
        print(f"⚠️ Error al convertir: {e}")
        return None

print(f"Resultado: {convertir_y_sumar('10', '20')}")
print(f"Resultado: {convertir_y_sumar('10', 'abc')}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 4. TRY-EXCEPT-ELSE-FINALLY
# ============================================================================
print("=== TRY-EXCEPT-ELSE-FINALLY ===\n")

def leer_archivo_seguro(nombre_archivo):
    """Lee un archivo con manejo completo de errores"""
    try:
        archivo = open(nombre_archivo, 'r')
        contenido = archivo.read()
    except FileNotFoundError:
        print(f"⚠️ Error: Archivo '{nombre_archivo}' no encontrado")
    except PermissionError:
        print(f"⚠️ Error: No tienes permiso para leer '{nombre_archivo}'")
    else:
        # Se ejecuta solo si NO hubo excepción
        print(f"✓ Archivo leído exitosamente")
        print(f"Contenido ({len(contenido)} caracteres)")
    finally:
        # Se ejecuta SIEMPRE, haya o no excepción
        try:
            archivo.close()
            print("✓ Archivo cerrado")
        except:
            print("⚠️ No había archivo que cerrar")

# Crear archivo de prueba
with open("prueba.txt", "w") as f:
    f.write("Contenido de prueba")

print("--- Intentar leer archivo existente ---")
leer_archivo_seguro("prueba.txt")

print()

print("--- Intentar leer archivo inexistente ---")
leer_archivo_seguro("no_existe.txt")

# Limpiar
import os
os.remove("prueba.txt")

print("\n" + "="*70 + "\n")

# ============================================================================
# 5. OBTENER INFORMACIÓN DEL ERROR
# ============================================================================
print("=== OBTENER INFORMACIÓN DEL ERROR ===\n")

def procesar_lista(lista, indice):
    """Procesa un elemento de lista con información de error"""
    try:
        elemento = lista[indice]
        return elemento * 2
    except IndexError as e:
        print(f"⚠️ IndexError: {e}")
        print(f"   Lista tiene {len(lista)} elementos, índice {indice} es inválido")
        return None
    except TypeError as e:
        print(f"⚠️ TypeError: {e}")
        return None

numeros = [1, 2, 3, 4, 5]

print(f"Procesar índice 2: {procesar_lista(numeros, 2)}")
print(f"Procesar índice 10: {procesar_lista(numeros, 10)}")
print(f"Procesar 'abc': {procesar_lista(['a', 'b'], 0)}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 6. EXCEPCIONES PERSONALIZADAS
# ============================================================================
print("=== EXCEPCIONES PERSONALIZADAS ===\n")

# Definir excepción personalizada
class SaldoInsuficienteError(Exception):
    """Excepción cuando no hay suficiente saldo"""
    pass

class MontoInvalidoError(Exception):
    """Excepción cuando el monto es inválido"""
    pass

class CuentaBancaria:
    """Cuenta bancaria con excepciones personalizadas"""

    def __init__(self, titular, saldo=0):
        self.titular = titular
        self.saldo = saldo

    def depositar(self, monto):
        if monto <= 0:
            raise MontoInvalidoError("El monto debe ser mayor a cero")
        self.saldo += monto
        print(f"✓ Depósito: ${monto:,.2f} - Nuevo saldo: ${self.saldo:,.2f}")

    def retirar(self, monto):
        if monto <= 0:
            raise MontoInvalidoError("El monto debe ser mayor a cero")
        if monto > self.saldo:
            raise SaldoInsuficienteError(
                f"Saldo insuficiente. Saldo: ${self.saldo:,.2f}, Intentó retirar: ${monto:,.2f}"
            )
        self.saldo -= monto
        print(f"✓ Retiro: ${monto:,.2f} - Nuevo saldo: ${self.saldo:,.2f}")

# Usar la cuenta
cuenta = CuentaBancaria("Juan Pérez", 1000)

try:
    cuenta.depositar(500)
    cuenta.retirar(300)
    cuenta.retirar(2000)  # Esto lanzará SaldoInsuficienteError
except SaldoInsuficienteError as e:
    print(f"⚠️ Error: {e}")
except MontoInvalidoError as e:
    print(f"⚠️ Error: {e}")

print()

try:
    cuenta.depositar(-100)  # Esto lanzará MontoInvalidoError
except MontoInvalidoError as e:
    print(f"⚠️ Error: {e}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 7. EJEMPLO PRÁCTICO: VALIDADOR DE DATOS
# ============================================================================
print("=== EJEMPLO PRÁCTICO: VALIDADOR DE DATOS ===\n")

class ValidacionError(Exception):
    """Error de validación"""
    pass

class ValidadorDatos:
    """Validador de datos con excepciones"""

    @staticmethod
    def validar_email(email):
        """Valida formato de email"""
        if not isinstance(email, str):
            raise TypeError("El email debe ser una cadena de texto")
        if "@" not in email or "." not in email:
            raise ValidacionError(f"Email inválido: {email}")
        return True

    @staticmethod
    def validar_edad(edad):
        """Valida edad"""
        if not isinstance(edad, int):
            raise TypeError("La edad debe ser un número entero")
        if edad < 0 or edad > 150:
            raise ValidacionError(f"Edad inválida: {edad}")
        return True

    @staticmethod
    def validar_telefono(telefono):
        """Valida teléfono"""
        if not isinstance(telefono, str):
            raise TypeError("El teléfono debe ser una cadena de texto")
        # Eliminar espacios y guiones
        tel_limpio = telefono.replace(" ", "").replace("-", "")
        if not tel_limpio.isdigit():
            raise ValidacionError(f"Teléfono inválido: {telefono}")
        if len(tel_limpio) != 10:
            raise ValidacionError(f"Teléfono debe tener 10 dígitos: {telefono}")
        return True

def registrar_usuario(email, edad, telefono):
    """Registra un usuario validando sus datos"""
    try:
        ValidadorDatos.validar_email(email)
        ValidadorDatos.validar_edad(edad)
        ValidadorDatos.validar_telefono(telefono)

        print("✓ Usuario registrado exitosamente")
        print(f"  Email: {email}")
        print(f"  Edad: {edad}")
        print(f"  Teléfono: {telefono}")
        return True

    except (TypeError, ValidacionError) as e:
        print(f"⚠️ Error de validación: {e}")
        return False

print("--- Registro válido ---")
registrar_usuario("juan@email.com", 30, "5512345678")

print()

print("--- Registros inválidos ---")
registrar_usuario("email_invalido", 30, "5512345678")
registrar_usuario("juan@email.com", 200, "5512345678")
registrar_usuario("juan@email.com", 30, "123")

print("\n" + "="*70 + "\n")

# ============================================================================
# 8. RAISE - LANZAR EXCEPCIONES
# ============================================================================
print("=== RAISE - LANZAR EXCEPCIONES ===\n")

def calcular_descuento(precio, porcentaje):
    """Calcula descuento con validaciones"""
    if precio < 0:
        raise ValueError("El precio no puede ser negativo")
    if porcentaje < 0 or porcentaje > 100:
        raise ValueError("El porcentaje debe estar entre 0 y 100")

    descuento = precio * (porcentaje / 100)
    precio_final = precio - descuento

    return precio_final, descuento

# Uso normal
try:
    precio, desc = calcular_descuento(100, 20)
    print(f"✓ Precio final: ${precio:.2f}, Descuento: ${desc:.2f}")
except ValueError as e:
    print(f"⚠️ Error: {e}")

# Con errores
print()
try:
    precio, desc = calcular_descuento(-100, 20)
except ValueError as e:
    print(f"⚠️ Error: {e}")

try:
    precio, desc = calcular_descuento(100, 150)
except ValueError as e:
    print(f"⚠️ Error: {e}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 9. ASSERT - VERIFICACIONES
# ============================================================================
print("=== ASSERT - VERIFICACIONES ===\n")

def calcular_promedio(calificaciones):
    """Calcula el promedio de calificaciones"""
    # Verificar que la lista no esté vacía
    assert len(calificaciones) > 0, "La lista no puede estar vacía"

    # Verificar que todas sean números
    assert all(isinstance(c, (int, float)) for c in calificaciones), \
        "Todas las calificaciones deben ser números"

    # Verificar rango 0-100
    assert all(0 <= c <= 100 for c in calificaciones), \
        "Las calificaciones deben estar entre 0 y 100"

    return sum(calificaciones) / len(calificaciones)

# Uso correcto
try:
    prom = calcular_promedio([85, 90, 78, 95])
    print(f"✓ Promedio: {prom:.2f}")
except AssertionError as e:
    print(f"⚠️ Assertion Error: {e}")

# Con errores
print()
try:
    prom = calcular_promedio([])
except AssertionError as e:
    print(f"⚠️ Assertion Error: {e}")

try:
    prom = calcular_promedio([85, 150, 78])
except AssertionError as e:
    print(f"⚠️ Assertion Error: {e}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 10. BUENAS PRÁCTICAS
# ============================================================================
print("=== BUENAS PRÁCTICAS ===\n")

print("""
✓ HACER:
• Capturar excepciones específicas (ValueError, KeyError, etc.)
• Usar finally para limpieza (cerrar archivos, conexiones)
• Crear excepciones personalizadas para lógica de negocio
• Loggear errores para debugging
• Proveer mensajes de error claros

✗ EVITAR:
• Usar except genérico sin especificar excepción
• Capturar excepciones y no hacer nada (pass)
• Usar excepciones para control de flujo normal
• Capturar Exception o BaseException a menos que sea necesario
• Silenciar errores importantes

Ejemplo MALO:
try:
    # código
    pass
except:  # Demasiado genérico
    pass  # Ignora el error

Ejemplo BUENO:
try:
    resultado = int(input("Número: "))
except ValueError as e:
    print(f"Error: {e}")
    logging.error(f"Conversión fallida: {e}")
""")

print("="*70 + "\n")

# ============================================================================
# EJERCICIOS PARA PRACTICAR
# ============================================================================
print("EJERCICIOS PARA PRACTICAR:")
print("="*70)
print("""
1. Calculadora segura:
   - Crea una calculadora que maneje divisiones por cero
   - Valida que los inputs sean números
   - Maneja todas las excepciones apropiadamente

2. Lector de archivo robusto:
   - Función que lea un archivo
   - Maneje archivo no encontrado
   - Maneje errores de permisos
   - Use finally para cerrar archivos

3. Validador de formulario:
   - Valida: nombre (no vacío), email (formato), edad (18-100)
   - Crea excepciones personalizadas
   - Retorna lista de errores

4. Sistema de login:
   - Excepciones: UsuarioNoExiste, PasswordIncorrecto
   - Límite de 3 intentos (lanza MaximosIntentosExcedido)

5. Conversor de JSON:
   - Lee archivo JSON
   - Maneja archivo no encontrado
   - Maneja JSON malformado
   - Retorna None en caso de error

6. API de productos:
   - get_producto(id): puede no existir (ProductoNoEncontrado)
   - update_stock(id, cantidad): valida stock >= 0
   - Maneja todos los errores apropiadamente

¡Practica el manejo de excepciones con estos ejercicios!
""")
