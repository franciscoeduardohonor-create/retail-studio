# 🚀 Curso Práctico de Lenguaje Ensamblador (Assembly)
## De Principiante a Experto

¡Bienvenido al curso más completo de lenguaje ensamblador en español! Este curso te llevará desde cero hasta niveles avanzados con ejemplos prácticos, código comentado y ejercicios para practicar.

## 📋 Requisitos Previos

- Conocimientos básicos de programación
- Sistema operativo Linux (recomendado) o Windows con WSL
- NASM (Netwide Assembler) instalado
- GCC para enlazar programas

## 🛠️ Instalación de Herramientas

### En Linux (Ubuntu/Debian):
```bash
sudo apt update
sudo apt install nasm gcc gdb
```

### En macOS:
```bash
brew install nasm
```

### En Windows:
Usa WSL (Windows Subsystem for Linux) y sigue las instrucciones de Linux.

## 📚 Estructura del Curso

### **Módulo 1: Fundamentos de Assembly** (Principiante)
- ¿Qué es Assembly?
- Arquitectura x86-64
- Registros básicos
- Sintaxis NASM

### **Módulo 2: Primeros Programas** (Principiante)
- Hello World
- Operaciones aritméticas básicas
- Syscalls en Linux

### **Módulo 3: Registros y Memoria** (Principiante-Intermedio)
- Tipos de registros
- Direccionamiento de memoria
- Segmentos de memoria

### **Módulo 4: Control de Flujo** (Intermedio)
- Comparaciones y saltos
- Estructuras condicionales (if/else)
- Bucles (for, while)

### **Módulo 5: Funciones y Stack** (Intermedio)
- Convenciones de llamada
- El stack pointer
- Paso de parámetros
- Variables locales

### **Módulo 6: Arrays y Strings** (Intermedio-Avanzado)
- Manipulación de arrays
- Operaciones con strings
- Búsqueda y ordenamiento

### **Módulo 7: Operaciones Avanzadas** (Avanzado)
- Manipulación de bits
- Operaciones SIMD (SSE)
- Punto flotante (FPU)

### **Módulo 8: Programación Experta** (Avanzado)
- Macros y directivas
- Optimización de código
- Interfaz con C
- Técnicas avanzadas

## 🔨 Cómo Compilar y Ejecutar

### Compilar un programa (.asm):
```bash
# Ensamblar el código
nasm -f elf64 archivo.asm -o archivo.o

# Enlazar
ld archivo.o -o archivo

# Ejecutar
./archivo
```

### Con funciones de C:
```bash
# Ensamblar
nasm -f elf64 archivo.asm -o archivo.o

# Enlazar con gcc
gcc archivo.o -o archivo -no-pie

# Ejecutar
./archivo
```

## 📖 Cómo Usar Este Curso

1. **Lee la teoría** en el archivo `README.md` de cada módulo
2. **Estudia los ejemplos** en la carpeta `ejemplos/` con código comentado
3. **Practica con los ejercicios** en la carpeta `ejercicios/`
4. **Compara tus soluciones** con las de la carpeta `soluciones/`

## 🎯 Consejos para Aprender Assembly

1. **Practica mucho** - Assembly se aprende haciéndolo
2. **Usa un debugger** - GDB es tu mejor amigo
3. **Dibuja diagramas** - Visualiza la memoria y los registros
4. **Paciencia** - Assembly es de bajo nivel, toma tiempo
5. **Compara con C** - Ver el Assembly generado por C ayuda mucho

## 🔍 Herramientas Útiles

```bash
# Ver el código assembly de un programa C
gcc -S -masm=intel archivo.c

# Debuggear con GDB
gdb ./programa
(gdb) break _start
(gdb) run
(gdb) info registers
(gdb) x/10x $rsp  # Ver memoria del stack

# Desensamblador
objdump -d -M intel archivo
```

## 📝 Convenciones Usadas en Este Curso

- Usamos **sintaxis Intel** (destino, origen)
- Plataforma: **Linux x86-64**
- Ensamblador: **NASM**
- Todos los ejemplos están **ampliamente comentados**

## 🚦 Comienza Aquí

Dirígete al **Módulo 1** para comenzar tu viaje en Assembly:
```bash
cd modulo1-fundamentos
cat README.md
```

## 📞 Recursos Adicionales

- [NASM Documentation](https://www.nasm.us/doc/)
- [Intel Software Developer Manuals](https://software.intel.com/content/www/us/en/develop/articles/intel-sdm.html)
- [Linux System Call Table](https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/)

---

**¡Buena suerte en tu aprendizaje! El Assembly es un lenguaje poderoso que te dará un entendimiento profundo de cómo funcionan las computadoras.**
