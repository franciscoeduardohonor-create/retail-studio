"""
===============================================================================
CURSO PYTHON - NIVEL AVANZADO
Módulo 1: Decoradores
===============================================================================
En este módulo aprenderás:
- Qué son los decoradores
- Funciones como objetos de primera clase
- Decoradores simples
- Decoradores con argumentos
- Decoradores de clase
- Decoradores útiles (@property, @staticmethod, @classmethod)
===============================================================================
"""

import time
import functools

# ============================================================================
# 1. FUNCIONES COMO OBJETOS
# ============================================================================
print("=== FUNCIONES COMO OBJETOS ===\n")

def saludar(nombre):
    return f"Hola, {nombre}!"

# Las funciones son objetos - pueden asignarse a variables
mi_funcion = saludar
print(mi_funcion("Carlos"))

# Pueden pasarse como argumentos
def ejecutar_funcion(func, argumento):
    return func(argumento)

resultado = ejecutar_funcion(saludar, "María")
print(resultado)

# Pueden retornarse de otras funciones
def crear_saludador(prefijo):
    def saludar_con_prefijo(nombre):
        return f"{prefijo}, {nombre}!"
    return saludar_con_prefijo

saludador_formal = crear_saludador("Buenos días")
print(saludador_formal("Ana"))

print("\n" + "="*70 + "\n")

# ============================================================================
# 2. DECORADOR BÁSICO
# ============================================================================
print("=== DECORADOR BÁSICO ===\n")

def mi_decorador(func):
    """Decorador que envuelve una función"""
    def envoltura():
        print("🔹 Antes de ejecutar la función")
        func()
        print("🔹 Después de ejecutar la función")
    return envoltura

# Forma tradicional
def decir_hola():
    print("¡Hola!")

decir_hola_decorada = mi_decorador(decir_hola)
decir_hola_decorada()

print()

# Usando sintaxis @
@mi_decorador
def decir_adios():
    print("¡Adiós!")

decir_adios()

print("\n" + "="*70 + "\n")

# ============================================================================
# 3. DECORADOR CON FUNCIONES QUE RECIBEN ARGUMENTOS
# ============================================================================
print("=== DECORADOR CON ARGUMENTOS ===\n")

def decorador_con_args(func):
    """Decorador que maneja funciones con argumentos"""
    def envoltura(*args, **kwargs):
        print(f"📝 Argumentos: {args}, {kwargs}")
        resultado = func(*args, **kwargs)
        print(f"✅ Resultado: {resultado}")
        return resultado
    return envoltura

@decorador_con_args
def sumar(a, b):
    return a + b

@decorador_con_args
def saludar_persona(nombre, edad=0):
    return f"Hola {nombre}, tienes {edad} años"

resultado1 = sumar(5, 3)
print()
resultado2 = saludar_persona("Juan", edad=30)

print("\n" + "="*70 + "\n")

# ============================================================================
# 4. DECORADOR PARA MEDIR TIEMPO
# ============================================================================
print("=== DECORADOR DE TIEMPO ===\n")

def medir_tiempo(func):
    """Decorador que mide el tiempo de ejecución"""
    @functools.wraps(func)  # Preserva metadata de la función original
    def envoltura(*args, **kwargs):
        inicio = time.time()
        resultado = func(*args, **kwargs)
        fin = time.time()
        tiempo_total = fin - inicio
        print(f"⏱️ {func.__name__}() ejecutada en {tiempo_total:.4f} segundos")
        return resultado
    return envoltura

@medir_tiempo
def proceso_lento():
    """Simula un proceso que toma tiempo"""
    time.sleep(0.5)
    return "Proceso completado"

@medir_tiempo
def calcular_suma(n):
    """Suma números del 1 al n"""
    return sum(range(n + 1))

resultado = proceso_lento()
print(f"Resultado: {resultado}\n")

resultado = calcular_suma(1000000)
print(f"Suma: {resultado}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 5. DECORADOR DE CACHÉ/MEMORIZACIÓN
# ============================================================================
print("=== DECORADOR DE CACHÉ ===\n")

def cache(func):
    """Decorador que cachea resultados"""
    resultados_cache = {}

    @functools.wraps(func)
    def envoltura(*args):
        if args in resultados_cache:
            print(f"💾 Obteniendo de caché: {args}")
            return resultados_cache[args]

        print(f"🔄 Calculando: {args}")
        resultado = func(*args)
        resultados_cache[args] = resultado
        return resultado

    return envoltura

@cache
def fibonacci(n):
    """Calcula el n-ésimo número de Fibonacci"""
    if n < 2:
        return n
    return fibonacci(n - 1) + fibonacci(n - 2)

print("Calculando fibonacci(10):")
resultado = fibonacci(10)
print(f"Resultado: {resultado}\n")

print("Calculando fibonacci(10) nuevamente:")
resultado = fibonacci(10)
print(f"Resultado: {resultado}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 6. DECORADOR CON PARÁMETROS
# ============================================================================
print("=== DECORADOR CON PARÁMETROS ===\n")

def repetir(veces):
    """Decorador que repite la ejecución de una función"""
    def decorador(func):
        @functools.wraps(func)
        def envoltura(*args, **kwargs):
            for i in range(veces):
                print(f"Ejecución #{i + 1}")
                resultado = func(*args, **kwargs)
            return resultado
        return envoltura
    return decorador

@repetir(veces=3)
def saludar(nombre):
    print(f"  ¡Hola, {nombre}!")

saludar("Carlos")

print()

@repetir(veces=2)
def mostrar_numero(n):
    print(f"  Número: {n}")
    return n * 2

resultado = mostrar_numero(5)

print("\n" + "="*70 + "\n")

# ============================================================================
# 7. DECORADORES ÚTILES: @staticmethod, @classmethod
# ============================================================================
print("=== DECORADORES DE CLASE ===\n")

class Calculadora:
    """Calculadora con diferentes tipos de métodos"""

    pi = 3.14159  # Atributo de clase

    def __init__(self, nombre):
        self.nombre = nombre  # Atributo de instancia

    # Método de instancia (normal)
    def saludar(self):
        return f"Calculadora: {self.nombre}"

    # Método estático - no accede a self ni cls
    @staticmethod
    def sumar(a, b):
        """Suma dos números (no necesita instancia)"""
        return a + b

    # Método de clase - accede a cls (la clase)
    @classmethod
    def crear_cientifica(cls, nombre):
        """Crea una calculadora científica"""
        calc = cls(f"{nombre} - Científica")
        return calc

    @classmethod
    def obtener_pi(cls):
        """Retorna el valor de PI"""
        return cls.pi

# Usar métodos estáticos sin crear instancia
print(f"Suma estática: {Calculadora.sumar(5, 3)}")

# Usar métodos de clase
print(f"PI: {Calculadora.obtener_pi()}")

# Crear instancias
calc1 = Calculadora("Básica")
calc2 = Calculadora.crear_cientifica("Avanzada")

print(calc1.saludar())
print(calc2.saludar())

print("\n" + "="*70 + "\n")

# ============================================================================
# 8. EJEMPLO PRÁCTICO: DECORADOR DE VALIDACIÓN
# ============================================================================
print("=== EJEMPLO PRÁCTICO: VALIDACIÓN ===\n")

def validar_positivo(func):
    """Valida que los argumentos sean positivos"""
    @functools.wraps(func)
    def envoltura(*args, **kwargs):
        for arg in args:
            if isinstance(arg, (int, float)) and arg < 0:
                raise ValueError(f"❌ Todos los argumentos deben ser positivos, recibido: {arg}")
        return func(*args, **kwargs)
    return envoltura

@validar_positivo
def calcular_area_rectangulo(base, altura):
    return base * altura

@validar_positivo
def calcular_promedio(*numeros):
    return sum(numeros) / len(numeros)

# Uso válido
print(f"Área: {calcular_area_rectangulo(5, 3)}")
print(f"Promedio: {calcular_promedio(10, 20, 30)}")

# Uso inválido
try:
    area = calcular_area_rectangulo(-5, 3)
except ValueError as e:
    print(e)

print("\n" + "="*70 + "\n")

# ============================================================================
# 9. EJEMPLO PRÁCTICO: DECORADOR DE LOGGING
# ============================================================================
print("=== EJEMPLO PRÁCTICO: LOGGING ===\n")

def log_llamada(func):
    """Registra llamadas a funciones"""
    @functools.wraps(func)
    def envoltura(*args, **kwargs):
        args_str = ', '.join([repr(a) for a in args])
        kwargs_str = ', '.join([f"{k}={v!r}" for k, v in kwargs.items()])
        todos_args = ', '.join(filter(None, [args_str, kwargs_str]))

        print(f"📞 Llamando a {func.__name__}({todos_args})")

        resultado = func(*args, **kwargs)

        print(f"📤 {func.__name__}() retornó {resultado!r}")

        return resultado
    return envoltura

@log_llamada
def dividir(a, b):
    return a / b

@log_llamada
def crear_usuario(nombre, edad, ciudad="CDMX"):
    return {"nombre": nombre, "edad": edad, "ciudad": ciudad}

resultado1 = dividir(10, 2)
print()
resultado2 = crear_usuario("Ana", 28, ciudad="Guadalajara")

print("\n" + "="*70 + "\n")

# ============================================================================
# 10. COMBINAR MÚLTIPLES DECORADORES
# ============================================================================
print("=== MÚLTIPLES DECORADORES ===\n")

def convertir_mayusculas(func):
    """Convierte el resultado a mayúsculas"""
    @functools.wraps(func)
    def envoltura(*args, **kwargs):
        resultado = func(*args, **kwargs)
        return resultado.upper()
    return envoltura

def agregar_exclamaciones(func):
    """Agrega exclamaciones al resultado"""
    @functools.wraps(func)
    def envoltura(*args, **kwargs):
        resultado = func(*args, **kwargs)
        return f"¡¡{resultado}!!"
    return envoltura

# Los decoradores se aplican de abajo hacia arriba
@agregar_exclamaciones
@convertir_mayusculas
def mensaje(texto):
    return texto

resultado = mensaje("hola mundo")
print(f"Resultado: {resultado}")

print("\n" + "="*70 + "\n")

# ============================================================================
# EJERCICIOS PARA PRACTICAR
# ============================================================================
print("EJERCICIOS PARA PRACTICAR:")
print("="*70)
print("""
1. Decorador contador:
   - Cuenta cuántas veces se llama una función
   - Al llamar imprime: "Llamada #X"

2. Decorador de retry:
   - Si la función falla, reintenta N veces
   - Parámetro: @retry(intentos=3)

3. Decorador de timeout:
   - Si la función tarda más de X segundos, lanza excepción
   - Parámetro: @timeout(segundos=5)

4. Decorador de autenticación:
   - Verifica si usuario está autenticado
   - Si no, lanza excepción o retorna None

5. Decorador de rate limiting:
   - Limita llamadas a X por segundo
   - Si excede, espera antes de ejecutar

6. Decorador de serialización:
   - Convierte el resultado a JSON
   - Guarda en archivo de log

¡Practica creando decoradores útiles!
""")
