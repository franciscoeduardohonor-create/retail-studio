# Curso Práctico de C++
## De Principiante a Avanzado

¡Bienvenido al curso más completo y práctico de C++ en español! Este curso te llevará desde los conceptos más básicos hasta temas avanzados, con ejemplos comentados y ejercicios prácticos.

---

## 📋 Índice del Curso

### 🟢 [Módulo 1: Fundamentos Básicos](./modulo-01-fundamentos/)
**Nivel:** Principiante | **Duración estimada:** 1-2 semanas

Aprende los conceptos fundamentales de C++:
- Estructura básica de un programa
- Variables y tipos de datos
- Operadores (aritméticos, lógicos, comparación)
- Entrada y salida de datos
- Constantes y literales

**Ejemplos incluidos:**
- `01_hola_mundo.cpp` - Tu primer programa
- `02_variables_tipos.cpp` - Tipos de datos y variables
- `03_operadores.cpp` - Todos los operadores
- `04_entrada_usuario.cpp` - Interacción con el usuario

**Ejercicios:** 8 ejercicios prácticos con soluciones

---

### 🟡 [Módulo 2: Control de Flujo y Funciones](./modulo-02-control-flujo/)
**Nivel:** Principiante-Intermedio | **Duración estimada:** 2-3 semanas

Domina las estructuras de control y funciones:
- Condicionales (if, else, else if, operador ternario)
- Switch-case
- Bucles (for, while, do-while)
- Break y continue
- Funciones (declaración, definición, parámetros)
- Sobrecarga de funciones
- Paso por valor vs paso por referencia
- Recursión

**Ejemplos incluidos:**
- `01_if_else.cpp` - Estructuras condicionales
- `02_switch.cpp` - Switch-case y menús
- `03_loops.cpp` - Todos los tipos de bucles
- `04_funciones.cpp` - Funciones básicas
- `05_funciones_avanzadas.cpp` - Sobrecarga y referencias

**Ejercicios:** 17 ejercicios progresivos con proyecto integrador

---

### 🟠 [Módulo 3: Arreglos, Punteros y Referencias](./modulo-03-punteros-arreglos/)
**Nivel:** Intermedio | **Duración estimada:** 2-3 semanas

Comprende la gestión de memoria en C++:
- Arreglos unidimensionales y multidimensionales
- Punteros (concepto, declaración, operadores)
- Aritmética de punteros
- Punteros y arreglos
- Referencias
- Memoria dinámica (new/delete)
- Memory leaks y cómo evitarlos

**Ejemplos incluidos:**
- `01_arreglos.cpp` - Arrays estáticos
- `02_punteros.cpp` - Fundamentos de punteros
- `03_memoria_dinamica.cpp` - Gestión de memoria

**Ejercicios:** Ejercicios prácticos con arrays y punteros

---

### 🔵 [Módulo 4: Programación Orientada a Objetos](./modulo-04-poo/)
**Nivel:** Intermedio-Avanzado | **Duración estimada:** 3-4 semanas

Domina la POO en C++:
- Clases y objetos
- Atributos y métodos
- Encapsulamiento (public, private, protected)
- Constructores y destructores
- Getters y setters
- Herencia
- Polimorfismo
- Funciones virtuales
- Clases abstractas
- Composición vs herencia

**Ejemplos incluidos:**
- `01_clases_objetos.cpp` - Fundamentos de POO
- `02_herencia_polimorfismo.cpp` - Herencia y polimorfismo

**Ejercicios:** Proyectos de POO (sistema bancario, biblioteca, etc.)

---

### 🟣 [Módulo 5: Templates y STL](./modulo-05-templates-stl/)
**Nivel:** Avanzado | **Duración estimada:** 2-3 semanas

Aprovecha el poder de la programación genérica:
- Templates de funciones
- Templates de clases
- Contenedores STL:
  - vector (arreglo dinámico)
  - map (diccionario)
  - set (conjunto)
  - list, deque, stack, queue
- Iteradores
- Algoritmos STL (sort, find, etc.)
- Lambda expressions

**Ejemplos incluidos:**
- `01_stl_containers.cpp` - Contenedores principales
- `02_templates.cpp` - Programación genérica

**Ejercicios:** Implementación de estructuras de datos genéricas

---

### 🔴 [Módulo 6: Temas Avanzados](./modulo-06-avanzado/)
**Nivel:** Avanzado | **Duración estimada:** 2-3 semanas

Conceptos avanzados de C++ moderno:
- Smart pointers (unique_ptr, shared_ptr, weak_ptr)
- RAII (Resource Acquisition Is Initialization)
- Move semantics
- Manejo de excepciones
- Multithreading básico
- File I/O
- Buenas prácticas y patrones de diseño

**Ejemplos incluidos:**
- `01_smart_pointers.cpp` - Gestión moderna de memoria

**Ejercicios:** Proyectos avanzados y optimización

---

## 🚀 Cómo Usar Este Curso

### 1. **Sigue el Orden**
Los módulos están diseñados para construir conocimiento progresivamente. Empieza por el Módulo 1 aunque tengas algo de experiencia.

### 2. **Lee el Código**
Cada ejemplo está **altamente comentado**. Lee los comentarios con cuidado, explican el "por qué", no solo el "qué".

### 3. **Escribe el Código Tú Mismo**
No copies y pegues. Escribe cada programa a mano. Esto desarrolla memoria muscular y comprensión profunda.

### 4. **Compila y Ejecuta**
```bash
# Compilar
g++ archivo.cpp -o programa

# Ejecutar
./programa
```

### 5. **Experimenta**
- Modifica los valores
- Cambia la lógica
- Rompe el código para ver qué pasa
- Arregla los errores

### 6. **Haz los Ejercicios**
Cada módulo tiene ejercicios prácticos. Intenta resolverlos sin ver las soluciones primero.

### 7. **Revisa las Soluciones**
Compara tu solución con la proporcionada. Hay muchas formas correctas de resolver un problema.

---

## 💻 Configuración del Entorno

### Opción 1: Linux/Mac
Ya tienes g++ instalado o puedes instalarlo:

```bash
# Ubuntu/Debian
sudo apt-get install g++

# Mac
xcode-select --install
```

### Opción 2: Windows

**MinGW-w64:**
1. Descarga desde [mingw-w64.org](https://www.mingw-w64.org/)
2. Instala y agrega al PATH
3. Verifica: `g++ --version`

**Visual Studio:**
1. Descarga Visual Studio Community
2. Instala "Desarrollo de escritorio con C++"

### Opción 3: IDE Recomendados
- **VS Code** (con extensión C++)
- **CLion** (JetBrains)
- **Code::Blocks**
- **Dev-C++**

---

## 📚 Comandos Básicos de Compilación

```bash
# Compilación básica
g++ programa.cpp -o programa

# Con warnings (recomendado)
g++ -Wall programa.cpp -o programa

# Con C++11
g++ -std=c++11 programa.cpp -o programa

# Con C++14
g++ -std=c++14 programa.cpp -o programa

# Con C++17
g++ -std=c++17 programa.cpp -o programa

# Optimización
g++ -O2 programa.cpp -o programa

# Debug
g++ -g programa.cpp -o programa
```

---

## 🎯 Metodología de Aprendizaje

### Para Cada Módulo:

1. **Día 1-2: Lectura y Comprensión**
   - Lee el README del módulo
   - Estudia los ejemplos
   - Ejecuta cada ejemplo
   - Toma notas

2. **Día 3-4: Experimentación**
   - Modifica los ejemplos
   - Crea variaciones
   - Prueba casos límite

3. **Día 5-7: Ejercicios**
   - Intenta resolver ejercicios sin ayuda
   - Si te atoras más de 30 min, ve pistas
   - Compara con soluciones

4. **Día 8: Revisión**
   - Repasa conceptos difíciles
   - Crea tu propio proyecto pequeño
   - Documenta lo aprendido

---

## ✅ Checklist de Progreso

Marca tu progreso:

- [ ] Módulo 1: Fundamentos Básicos
  - [ ] Ejemplos completados
  - [ ] Ejercicios resueltos
  - [ ] Proyecto personal del módulo

- [ ] Módulo 2: Control de Flujo y Funciones
  - [ ] Ejemplos completados
  - [ ] Ejercicios resueltos
  - [ ] Proyecto personal del módulo

- [ ] Módulo 3: Arreglos, Punteros y Referencias
  - [ ] Ejemplos completados
  - [ ] Ejercicios resueltos
  - [ ] Proyecto personal del módulo

- [ ] Módulo 4: Programación Orientada a Objetos
  - [ ] Ejemplos completados
  - [ ] Ejercicios resueltos
  - [ ] Proyecto personal del módulo

- [ ] Módulo 5: Templates y STL
  - [ ] Ejemplos completados
  - [ ] Ejercicios resueltos
  - [ ] Proyecto personal del módulo

- [ ] Módulo 6: Temas Avanzados
  - [ ] Ejemplos completados
  - [ ] Ejercicios resueltos
  - [ ] Proyecto final integrador

---

## 🛠️ Proyectos Sugeridos

A medida que avances, crea estos proyectos:

**Nivel Principiante:**
- Calculadora de consola
- Conversor de unidades
- Juego de adivinanza de números
- Calculadora de IMC

**Nivel Intermedio:**
- Sistema de gestión de estudiantes
- Juego de Ahorcado
- Agenda de contactos
- Calculadora científica

**Nivel Avanzado:**
- Sistema de gestión de biblioteca
- Juego de Snake/Tetris (consola)
- Analizador de archivos CSV
- Mini base de datos

---

## 📖 Recursos Adicionales

### Documentación Oficial
- [cppreference.com](https://en.cppreference.com/) - Referencia completa
- [cplusplus.com](http://www.cplusplus.com/) - Tutoriales y referencia

### Libros Recomendados
- "C++ Primer" - Stanley Lippman
- "Effective C++" - Scott Meyers
- "The C++ Programming Language" - Bjarne Stroustrup

### Comunidades
- Stack Overflow (en español)
- Reddit: r/cpp_questions
- Discord: C++ Hispano

---

## 🐛 Errores Comunes y Soluciones

### Error de Compilación
```
error: expected ';' before '}'
```
**Solución:** Olvidaste un punto y coma

### Segmentation Fault
```
Segmentation fault (core dumped)
```
**Solución:** Acceso a memoria inválida (punteros, arrays)

### Undefined Reference
```
undefined reference to 'funcion'
```
**Solución:** Olvidaste compilar un archivo o falta la definición

---

## 💡 Consejos para el Éxito

1. **Consistencia > Intensidad**
   - Mejor 30 minutos diarios que 5 horas un día

2. **Escribe Código a Mano**
   - No solo copies y pegues
   - La práctica hace al maestro

3. **Lee Errores Cuidadosamente**
   - Los mensajes de error son tus amigos
   - Aprende a interpretarlos

4. **Comenta Tu Código**
   - Explica el "por qué", no solo el "qué"
   - Tu yo futuro te lo agradecerá

5. **Debugging es Aprendizaje**
   - Los bugs son oportunidades de aprender
   - Usa print statements o debugger

6. **Practica con Proyectos Reales**
   - Crea algo que te interese
   - Resuelve problemas reales

7. **No Te Compares**
   - Todos aprendemos a diferente velocidad
   - Enfócate en tu progreso personal

---

## 🤝 Contribuir

¿Encontraste un error? ¿Tienes una sugerencia?
- Reporta issues
- Envía pull requests
- Comparte tus proyectos

---

## 📜 Licencia

Este curso es de código abierto y gratuito para uso educativo.

---

## 🎓 Certificación

Al completar todos los módulos y ejercicios, habrás desarrollado:
- ✅ Sólidas bases en C++
- ✅ Capacidad de crear programas complejos
- ✅ Comprensión de POO
- ✅ Conocimiento de la STL
- ✅ Buenas prácticas de programación

---

## 🚀 ¡Comienza Ahora!

**[👉 Empieza con el Módulo 1: Fundamentos Básicos](./modulo-01-fundamentos/)**

---

**¿Listo para dominar C++?** ¡Vamos! 💪

*"El código es como el humor. Cuando tienes que explicarlo, es malo." - Cory House*

---

## 📞 Contacto

¿Preguntas o comentarios?
- Abre un issue en GitHub
- Únete a las discusiones

**¡Feliz aprendizaje!** 🎉
