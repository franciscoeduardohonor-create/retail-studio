# MÓDULO 1: FUNDAMENTOS BÁSICOS DE C++

## 📚 Contenido del Módulo

En este módulo aprenderás los conceptos fundamentales de C++:

### Temas Cubiertos

1. **Estructura básica de un programa**
   - La función main()
   - Bibliotecas estándar
   - Compilación y ejecución

2. **Variables y tipos de datos**
   - Tipos enteros: int, short, long, long long
   - Tipos decimales: float, double
   - Caracteres: char
   - Booleanos: bool
   - Cadenas de texto: string
   - Constantes

3. **Operadores**
   - Aritméticos: +, -, *, /, %
   - Comparación: ==, !=, <, >, <=, >=
   - Lógicos: &&, ||, !
   - Asignación: =, +=, -=, *=, /=, %=
   - Incremento/Decremento: ++, --

4. **Entrada y salida**
   - std::cout para mostrar datos
   - std::cin para leer datos
   - std::getline para leer líneas completas
   - Formateo básico

## 📂 Estructura de Archivos

```
modulo-01-fundamentos/
├── ejemplos/
│   ├── 01_hola_mundo.cpp          # Tu primer programa
│   ├── 02_variables_tipos.cpp     # Tipos de datos
│   ├── 03_operadores.cpp          # Operadores
│   └── 04_entrada_usuario.cpp     # Interacción con usuario
├── ejercicios/
│   └── ejercicios.md              # 8 ejercicios prácticos
├── soluciones/
│   ├── solucion_ejercicio2.cpp    # Conversor temperatura
│   └── solucion_ejercicio5.cpp    # Calculadora IMC
└── README.md                      # Este archivo
```

## 🚀 Cómo Usar Este Módulo

### 1. Estudia los Ejemplos

Lee y ejecuta cada ejemplo en orden:

```bash
# Compilar
g++ ejemplos/01_hola_mundo.cpp -o hola_mundo

# Ejecutar
./hola_mundo
```

### 2. Experimenta

- Modifica los ejemplos
- Cambia valores
- Prueba diferentes casos
- Rompe el código para entender los errores

### 3. Practica con Ejercicios

Una vez que entiendas los ejemplos, resuelve los ejercicios:

1. Lee el ejercicio en `ejercicios/ejercicios.md`
2. Intenta resolverlo sin ver la solución
3. Compila y prueba tu código
4. Si te atoras, revisa las soluciones

### 4. Compila y Ejecuta

```bash
# Compilar tu ejercicio
g++ mi_ejercicio.cpp -o mi_ejercicio

# Ejecutar
./mi_ejercicio
```

## 💡 Consejos para Principiantes

1. **Escribe el código tú mismo**: No copies y pegues. Escribe cada línea para desarrollar memoria muscular.

2. **Compila frecuentemente**: No esperes a terminar todo. Compila cada pocas líneas.

3. **Lee los mensajes de error**: Al principio pueden ser confusos, pero son tu mejor herramienta.

4. **Experimenta**: La mejor forma de aprender es probando cosas.

5. **Comenta tu código**: Explica qué hace cada parte, esto te ayudará a entender mejor.

## 🐛 Errores Comunes

### Error de compilación
```cpp
// ❌ INCORRECTO
cout << "Hola";  // Falta std::

// ✅ CORRECTO
std::cout << "Hola";
```

### División entera
```cpp
// ❌ INCORRECTO (resultado: 3)
int resultado = 10 / 3;

// ✅ CORRECTO (resultado: 3.333...)
double resultado = 10.0 / 3.0;
```

### Olvidar limpiar el buffer
```cpp
// ❌ PROBLEMA
std::cin >> edad;
std::getline(std::cin, nombre);  // No funcionará bien

// ✅ CORRECTO
std::cin >> edad;
std::cin.ignore();  // Limpiar buffer
std::getline(std::cin, nombre);
```

## 📖 Recursos Adicionales

- [Documentación oficial de C++](https://en.cppreference.com/)
- [Tutorial de C++ (español)](https://www.cplusplus.com/doc/tutorial/)

## ✅ Checklist de Aprendizaje

Antes de pasar al Módulo 2, asegúrate de que puedes:

- [ ] Compilar y ejecutar un programa básico
- [ ] Declarar variables de diferentes tipos
- [ ] Realizar operaciones aritméticas
- [ ] Usar operadores de comparación y lógicos
- [ ] Leer entrada del usuario con cin y getline
- [ ] Mostrar salida formateada con cout
- [ ] Resolver los ejercicios del módulo

## ➡️ Siguiente Paso

Una vez domines estos fundamentos, continúa con:
**[Módulo 2: Control de Flujo y Funciones](../modulo-02-control-flujo/)**

---

¡Feliz aprendizaje! 🎉
