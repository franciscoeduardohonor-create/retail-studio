"""
===============================================================================
CURSO PYTHON - NIVEL INTERMEDIO
Módulo 1: Programación Orientada a Objetos (POO)
===============================================================================
En este módulo aprenderás:
- Clases y objetos
- Atributos y métodos
- Constructor __init__
- Métodos especiales (__str__, __repr__)
- Herencia
- Encapsulamiento
- Polimorfismo
===============================================================================
"""

# ============================================================================
# 1. INTRODUCCIÓN A POO
# ============================================================================
print("=== PROGRAMACIÓN ORIENTADA A OBJETOS ===\n")

print("""
La POO es un paradigma de programación que organiza el código en "objetos"
que contienen datos (atributos) y comportamiento (métodos).

Conceptos principales:
• Clase: Plantilla o molde para crear objetos
• Objeto: Instancia de una clase
• Atributos: Variables dentro de una clase
• Métodos: Funciones dentro de una clase
""")

print("="*70 + "\n")

# ============================================================================
# 2. CREAR UNA CLASE BÁSICA
# ============================================================================
print("=== CLASE BÁSICA ===\n")

# Definir una clase
class Perro:
    """Clase que representa un perro"""

    # Constructor - se ejecuta al crear un objeto
    def __init__(self, nombre, edad):
        """Inicializa un nuevo perro"""
        self.nombre = nombre  # Atributo de instancia
        self.edad = edad

    # Método
    def ladrar(self):
        """El perro ladra"""
        print(f"{self.nombre} dice: ¡Guau guau!")

    def cumplir_años(self):
        """El perro cumple un año más"""
        self.edad += 1
        print(f"{self.nombre} ahora tiene {self.edad} años")

# Crear objetos (instancias)
perro1 = Perro("Max", 3)
perro2 = Perro("Luna", 5)

print("--- Crear y usar objetos ---")
print(f"Perro 1: {perro1.nombre}, {perro1.edad} años")
print(f"Perro 2: {perro2.nombre}, {perro2.edad} años")

print()
perro1.ladrar()
perro2.ladrar()

print()
perro1.cumplir_años()

print("\n" + "="*70 + "\n")

# ============================================================================
# 3. ATRIBUTOS DE CLASE VS INSTANCIA
# ============================================================================
print("=== ATRIBUTOS DE CLASE VS INSTANCIA ===\n")

class Gato:
    """Clase que representa un gato"""

    # Atributo de clase (compartido por todas las instancias)
    especie = "Felis catus"
    total_gatos = 0

    def __init__(self, nombre, color):
        # Atributos de instancia (únicos para cada objeto)
        self.nombre = nombre
        self.color = color
        Gato.total_gatos += 1  # Incrementar contador de clase

    def maullar(self):
        print(f"{self.nombre} dice: ¡Miau!")

# Crear gatos
gato1 = Gato("Pelusa", "Blanco")
gato2 = Gato("Manchas", "Naranja")
gato3 = Gato("Sombra", "Negro")

print(f"Especie de {gato1.nombre}: {gato1.especie}")  # Atributo de clase
print(f"Color de {gato1.nombre}: {gato1.color}")  # Atributo de instancia
print(f"\nTotal de gatos creados: {Gato.total_gatos}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 4. MÉTODOS ESPECIALES
# ============================================================================
print("=== MÉTODOS ESPECIALES ===\n")

class Libro:
    """Clase que representa un libro"""

    def __init__(self, titulo, autor, paginas):
        self.titulo = titulo
        self.autor = autor
        self.paginas = paginas

    # Método __str__ - representación "legible" del objeto
    def __str__(self):
        return f"'{self.titulo}' por {self.autor}"

    # Método __repr__ - representación "oficial" del objeto
    def __repr__(self):
        return f"Libro(titulo='{self.titulo}', autor='{self.autor}', paginas={self.paginas})"

    # Método __len__ - permite usar len() con el objeto
    def __len__(self):
        return self.paginas

    # Método __eq__ - permite comparar objetos con ==
    def __eq__(self, otro):
        return (self.titulo == otro.titulo and
                self.autor == otro.autor)

# Crear libros
libro1 = Libro("Cien años de soledad", "Gabriel García Márquez", 432)
libro2 = Libro("Don Quijote", "Miguel de Cervantes", 863)

print("--- Métodos especiales ---")
print(f"str(libro1): {str(libro1)}")
print(f"repr(libro1): {repr(libro1)}")
print(f"len(libro1): {len(libro1)} páginas")

libro3 = Libro("Cien años de soledad", "Gabriel García Márquez", 432)
print(f"\nlibro1 == libro3: {libro1 == libro3}")
print(f"libro1 == libro2: {libro1 == libro2}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 5. HERENCIA
# ============================================================================
print("=== HERENCIA ===\n")

# Clase padre (base)
class Vehiculo:
    """Clase base para vehículos"""

    def __init__(self, marca, modelo, año):
        self.marca = marca
        self.modelo = modelo
        self.año = año

    def descripcion(self):
        return f"{self.marca} {self.modelo} ({self.año})"

    def arrancar(self):
        print(f"{self.descripcion()} está arrancando...")

# Clase hija (hereda de Vehiculo)
class Auto(Vehiculo):
    """Clase que representa un automóvil"""

    def __init__(self, marca, modelo, año, num_puertas):
        super().__init__(marca, modelo, año)  # Llamar al constructor padre
        self.num_puertas = num_puertas

    def tocar_claxon(self):
        print(f"{self.descripcion()} hace: ¡Beep beep!")

# Otra clase hija
class Motocicleta(Vehiculo):
    """Clase que representa una motocicleta"""

    def __init__(self, marca, modelo, año, cilindrada):
        super().__init__(marca, modelo, año)
        self.cilindrada = cilindrada

    def hacer_caballito(self):
        print(f"{self.descripcion()} está haciendo un caballito!")

# Crear objetos
print("--- Usando herencia ---")
auto = Auto("Toyota", "Corolla", 2023, 4)
moto = Motocicleta("Honda", "CBR", 2022, 600)

print(auto.descripcion())
auto.arrancar()  # Método heredado
auto.tocar_claxon()  # Método propio

print()
print(moto.descripcion())
moto.arrancar()  # Método heredado
moto.hacer_caballito()  # Método propio

print("\n" + "="*70 + "\n")

# ============================================================================
# 6. ENCAPSULAMIENTO
# ============================================================================
print("=== ENCAPSULAMIENTO ===\n")

class CuentaBancaria:
    """Clase que representa una cuenta bancaria"""

    def __init__(self, titular, saldo_inicial=0):
        self.titular = titular
        self.__saldo = saldo_inicial  # Atributo privado (__)

    # Getter - obtener saldo
    @property
    def saldo(self):
        """Obtiene el saldo actual"""
        return self.__saldo

    # Setter - modificar saldo (con validación)
    @saldo.setter
    def saldo(self, cantidad):
        """Modifica el saldo con validación"""
        if cantidad < 0:
            print("⚠️ El saldo no puede ser negativo")
        else:
            self.__saldo = cantidad

    def depositar(self, cantidad):
        """Deposita dinero en la cuenta"""
        if cantidad > 0:
            self.__saldo += cantidad
            print(f"✓ Depósito: ${cantidad:,.2f}")
            print(f"  Nuevo saldo: ${self.__saldo:,.2f}")
        else:
            print("⚠️ La cantidad debe ser positiva")

    def retirar(self, cantidad):
        """Retira dinero de la cuenta"""
        if cantidad > self.__saldo:
            print("⚠️ Saldo insuficiente")
        elif cantidad <= 0:
            print("⚠️ La cantidad debe ser positiva")
        else:
            self.__saldo -= cantidad
            print(f"✓ Retiro: ${cantidad:,.2f}")
            print(f"  Nuevo saldo: ${self.__saldo:,.2f}")

    def __str__(self):
        return f"Cuenta de {self.titular} - Saldo: ${self.__saldo:,.2f}"

# Usar la clase
print("--- Encapsulamiento ---")
cuenta = CuentaBancaria("Juan Pérez", 1000)

print(cuenta)
print()

cuenta.depositar(500)
print()

cuenta.retirar(300)
print()

cuenta.retirar(2000)  # Intento inválido

# Acceder al saldo (mediante property)
print(f"\nSaldo actual: ${cuenta.saldo:,.2f}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 7. POLIMORFISMO
# ============================================================================
print("=== POLIMORFISMO ===\n")

class Animal:
    """Clase base para animales"""

    def __init__(self, nombre):
        self.nombre = nombre

    def hacer_sonido(self):
        """Método que será sobrescrito por las clases hijas"""
        pass

class Perro_Poly(Animal):
    def hacer_sonido(self):
        return f"{self.nombre} dice: ¡Guau guau!"

class Gato_Poly(Animal):
    def hacer_sonido(self):
        return f"{self.nombre} dice: ¡Miau!"

class Vaca(Animal):
    def hacer_sonido(self):
        return f"{self.nombre} dice: ¡Muuu!"

class Pato(Animal):
    def hacer_sonido(self):
        return f"{self.nombre} dice: ¡Cuac cuac!"

# Polimorfismo en acción
print("--- Polimorfismo ---")
animales = [
    Perro_Poly("Rex"),
    Gato_Poly("Michi"),
    Vaca("Lola"),
    Pato("Donald")
]

# Mismo método, diferentes comportamientos
for animal in animales:
    print(animal.hacer_sonido())

print("\n" + "="*70 + "\n")

# ============================================================================
# 8. EJEMPLO PRÁCTICO: SISTEMA DE EMPLEADOS
# ============================================================================
print("=== EJEMPLO PRÁCTICO: SISTEMA DE EMPLEADOS ===\n")

class Empleado:
    """Clase base para empleados"""

    contador_empleados = 0

    def __init__(self, nombre, salario_base):
        self.nombre = nombre
        self.salario_base = salario_base
        Empleado.contador_empleados += 1
        self.id_empleado = Empleado.contador_empleados

    def calcular_salario(self):
        """Calcula el salario (será sobrescrito)"""
        return self.salario_base

    def __str__(self):
        return f"Empleado #{self.id_empleado}: {self.nombre}"

class Desarrollador(Empleado):
    """Clase para desarrolladores"""

    def __init__(self, nombre, salario_base, lenguajes):
        super().__init__(nombre, salario_base)
        self.lenguajes = lenguajes

    def calcular_salario(self):
        # Bonus por cada lenguaje
        bonus = len(self.lenguajes) * 2000
        return self.salario_base + bonus

    def __str__(self):
        return (f"{super().__str__()} - Desarrollador\n"
                f"  Lenguajes: {', '.join(self.lenguajes)}")

class Gerente(Empleado):
    """Clase para gerentes"""

    def __init__(self, nombre, salario_base, empleados_a_cargo):
        super().__init__(nombre, salario_base)
        self.empleados_a_cargo = empleados_a_cargo

    def calcular_salario(self):
        # Bonus por empleado a cargo
        bonus = self.empleados_a_cargo * 3000
        return self.salario_base + bonus

    def __str__(self):
        return (f"{super().__str__()} - Gerente\n"
                f"  Empleados a cargo: {self.empleados_a_cargo}")

class Vendedor(Empleado):
    """Clase para vendedores"""

    def __init__(self, nombre, salario_base, ventas_mes):
        super().__init__(nombre, salario_base)
        self.ventas_mes = ventas_mes

    def calcular_salario(self):
        # Comisión del 5% sobre ventas
        comision = self.ventas_mes * 0.05
        return self.salario_base + comision

    def __str__(self):
        return (f"{super().__str__()} - Vendedor\n"
                f"  Ventas del mes: ${self.ventas_mes:,.2f}")

# Crear empleados
empleados = [
    Desarrollador("Ana García", 40000, ["Python", "JavaScript", "SQL"]),
    Gerente("Carlos López", 60000, 10),
    Vendedor("María Rodríguez", 25000, 150000),
    Desarrollador("Juan Martínez", 38000, ["Java", "C++"]),
]

print("REPORTE DE NÓMINA")
print("=" * 70)

total_nomina = 0

for empleado in empleados:
    salario = empleado.calcular_salario()
    total_nomina += salario

    print(f"\n{empleado}")
    print(f"  Salario base: ${empleado.salario_base:,.2f}")
    print(f"  Salario total: ${salario:,.2f}")

print("\n" + "=" * 70)
print(f"TOTAL NÓMINA: ${total_nomina:,.2f}")
print(f"Total de empleados: {Empleado.contador_empleados}")

print("\n" + "="*70 + "\n")

# ============================================================================
# 9. EJEMPLO PRÁCTICO: SISTEMA DE FIGURAS GEOMÉTRICAS
# ============================================================================
print("=== EJEMPLO PRÁCTICO: FIGURAS GEOMÉTRICAS ===\n")

import math

class Figura:
    """Clase base para figuras geométricas"""

    def area(self):
        """Calcula el área (debe ser implementado por hijas)"""
        raise NotImplementedError("Debe implementar el método area()")

    def perimetro(self):
        """Calcula el perímetro (debe ser implementado por hijas)"""
        raise NotImplementedError("Debe implementar el método perimetro()")

class Rectangulo(Figura):
    """Clase para rectángulos"""

    def __init__(self, base, altura):
        self.base = base
        self.altura = altura

    def area(self):
        return self.base * self.altura

    def perimetro(self):
        return 2 * (self.base + self.altura)

    def __str__(self):
        return f"Rectángulo({self.base}×{self.altura})"

class Circulo(Figura):
    """Clase para círculos"""

    def __init__(self, radio):
        self.radio = radio

    def area(self):
        return math.pi * (self.radio ** 2)

    def perimetro(self):
        return 2 * math.pi * self.radio

    def __str__(self):
        return f"Círculo(radio={self.radio})"

class Triangulo(Figura):
    """Clase para triángulos"""

    def __init__(self, lado1, lado2, lado3):
        self.lado1 = lado1
        self.lado2 = lado2
        self.lado3 = lado3

    def area(self):
        # Fórmula de Herón
        s = self.perimetro() / 2
        return math.sqrt(s * (s - self.lado1) * (s - self.lado2) * (s - self.lado3))

    def perimetro(self):
        return self.lado1 + self.lado2 + self.lado3

    def __str__(self):
        return f"Triángulo({self.lado1}, {self.lado2}, {self.lado3})"

# Crear figuras
figuras = [
    Rectangulo(5, 3),
    Circulo(4),
    Triangulo(3, 4, 5),
    Rectangulo(10, 2),
]

print("CÁLCULOS DE FIGURAS GEOMÉTRICAS")
print("=" * 70)

for figura in figuras:
    print(f"\n{figura}")
    print(f"  Área: {figura.area():.2f}")
    print(f"  Perímetro: {figura.perimetro():.2f}")

print("\n" + "="*70 + "\n")

# ============================================================================
# EJERCICIOS PARA PRACTICAR
# ============================================================================
print("EJERCICIOS PARA PRACTICAR:")
print("="*70)
print("""
1. Clase Estudiante:
   - Atributos: nombre, edad, calificaciones (lista)
   - Métodos: agregar_calificacion(), calcular_promedio(), aprobo()
   - Crea 3 estudiantes y muestra quién tiene el mejor promedio

2. Sistema de Productos:
   - Clase Producto: nombre, precio, stock
   - Clase ProductoElectronico(Producto): + garantia
   - Clase ProductoAlimenticio(Producto): + fecha_vencimiento
   - Métodos: vender(), reabastecer(), __str__

3. Clase Vector2D:
   - Atributos: x, y
   - Métodos especiales: __add__ (suma), __mul__ (multiplicación)
   - Métodos: magnitud(), normalizar()

4. Sistema de Biblioteca:
   - Clase Libro: titulo, autor, isbn, prestado
   - Clase Biblioteca: coleccion de libros
   - Métodos: agregar_libro(), prestar_libro(), devolver_libro()
   - Método: buscar_por_autor()

5. Jerarquía de Formas 3D:
   - Clase base: Forma3D con métodos volumen() y superficie()
   - Clases hijas: Cubo, Esfera, Cilindro
   - Implementa los cálculos matemáticos

6. Sistema de Vehículos de Alquiler:
   - Clase base: VehiculoAlquiler
   - Hijas: Auto, Camioneta, Motocicleta
   - Cada una con tarifa diferente
   - Método: calcular_costo(dias)

¡Practica POO con estos ejercicios!
""")
