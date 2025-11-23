# Curso Práctico de AWK: De Principiante a Avanzado

¡Bienvenido al curso completo de AWK! Este curso te llevará desde los conceptos básicos hasta técnicas avanzadas de programación en AWK, con muchos ejemplos prácticos y ejercicios.

## 📚 Sobre AWK

AWK es un lenguaje de programación diseñado para el procesamiento de texto y extracción de datos. Es una herramienta fundamental en sistemas Unix/Linux y es extremadamente útil para:

- Procesamiento de archivos de texto columnar
- Análisis de logs
- Generación de reportes
- Transformación de datos
- Automatización de tareas de texto

## 🎯 Objetivos del Curso

Al finalizar este curso, serás capaz de:

- ✅ Entender la sintaxis y estructura de AWK
- ✅ Procesar archivos de texto de manera eficiente
- ✅ Usar patrones y expresiones regulares
- ✅ Trabajar con arrays y estructuras de datos
- ✅ Crear funciones personalizadas
- ✅ Aplicar AWK a problemas reales
- ✅ Optimizar scripts AWK para mejor rendimiento

## 📖 Estructura del Curso

El curso está dividido en 6 módulos progresivos:

### Módulo 1: Introducción y Conceptos Básicos
- ¿Qué es AWK?
- Estructura básica de un programa AWK
- Bloques BEGIN y END
- Variables integradas fundamentales: $0, $1, NF, NR
- Operaciones aritméticas básicas
- Uso de print y printf

📁 Archivo: [`modulos/01-introduccion-basicos.md`](modulos/01-introduccion-basicos.md)

### Módulo 2: Patrones, Expresiones y Operadores
- Tipos de patrones
- Operadores de comparación
- Operadores lógicos
- Expresiones regulares
- Rangos de líneas
- Filtrado avanzado de datos

📁 Archivo: [`modulos/02-patrones-operadores.md`](modulos/02-patrones-operadores.md)

### Módulo 3: Variables y Funciones Integradas
- Variables integradas completas
- Funciones de string: length, substr, index, toupper, tolower
- Funciones de sustitución: sub, gsub
- Funciones matemáticas: int, sqrt, rand
- Formateo con sprintf
- Variables de entorno

📁 Archivo: [`modulos/03-variables-funciones.md`](modulos/03-variables-funciones.md)

### Módulo 4: Arrays y Estructuras de Datos
- Arrays asociativos
- Iteración con for-in
- Arrays multidimensionales
- Conteo y agrupación de datos
- Estadísticas con arrays
- Procesamiento de múltiples archivos

📁 Archivo: [`modulos/04-arrays.md`](modulos/04-arrays.md)

### Módulo 5: Control de Flujo y Funciones Personalizadas
- Condicionales: if-else, operador ternario
- Bucles: while, for, do-while
- Control de flujo: break, continue, next, exit
- Definición de funciones
- Variables locales vs globales
- Recursividad

📁 Archivo: [`modulos/05-control-flujo-funciones.md`](modulos/05-control-flujo-funciones.md)

### Módulo 6: Técnicas Avanzadas y Casos de Uso Reales
- Comando getline
- Procesamiento de JSON
- Análisis de logs de servidor
- Generación de SQL y HTML
- Best practices y optimización
- Proyectos reales

📁 Archivo: [`modulos/06-tecnicas-avanzadas.md`](modulos/06-tecnicas-avanzadas.md)

## 🗂️ Estructura de Archivos

```
curso-awk/
├── README.md                          # Este archivo
├── modulos/                           # Módulos del curso
│   ├── 01-introduccion-basicos.md
│   ├── 02-patrones-operadores.md
│   ├── 03-variables-funciones.md
│   ├── 04-arrays.md
│   ├── 05-control-flujo-funciones.md
│   └── 06-tecnicas-avanzadas.md
├── datos-ejemplo/                     # Archivos de datos para práctica
│   ├── empleados.txt
│   ├── ventas.csv
│   ├── logs.txt
│   ├── estudiantes.csv
│   ├── productos.txt
│   └── access.log
├── ejemplos/                          # Scripts de ejemplo
├── ejercicios/                        # Ejercicios propuestos
└── soluciones/                        # Soluciones a ejercicios
```

## 🚀 Cómo Usar Este Curso

### 1. Requisitos Previos

- Un sistema Unix/Linux o macOS (también funciona en Windows con WSL)
- AWK instalado (viene preinstalado en la mayoría de sistemas Unix)
- Un editor de texto
- Terminal/línea de comandos

Para verificar que tienes AWK instalado:
```bash
awk --version
```

### 2. Ruta de Aprendizaje Recomendada

1. **Lee cada módulo en orden**: Los módulos están diseñados para construir conocimiento progresivamente
2. **Ejecuta todos los ejemplos**: Cada ejemplo incluye el código completo y la salida esperada
3. **Experimenta**: Modifica los ejemplos para ver qué sucede
4. **Haz los ejercicios**: Al final de cada módulo hay ejercicios prácticos
5. **Revisa las soluciones**: Después de intentar los ejercicios, revisa las soluciones
6. **Practica con datos reales**: Aplica lo aprendido a tus propios archivos

### 3. Cómo Ejecutar los Ejemplos

Hay varias formas de ejecutar código AWK:

**Opción 1: Desde la línea de comandos**
```bash
awk '{ print $1 }' archivo.txt
```

**Opción 2: Desde un archivo de script**
```bash
# Crear archivo script.awk
cat > script.awk << 'EOF'
BEGIN { print "Inicio" }
{ print $1 }
END { print "Fin" }
EOF

# Ejecutar
awk -f script.awk archivo.txt
```

**Opción 3: Como script ejecutable**
```bash
# Crear script con shebang
cat > proceso.awk << 'EOF'
#!/usr/bin/awk -f
BEGIN { print "Procesando..." }
{ print NR, $0 }
EOF

# Dar permisos de ejecución
chmod +x proceso.awk

# Ejecutar
./proceso.awk archivo.txt
```

### 4. Archivos de Datos de Ejemplo

El directorio `datos-ejemplo/` contiene archivos listos para usar:

- `empleados.txt` - Datos de empleados (nombre, salario, departamento)
- `ventas.csv` - Datos de ventas en formato CSV
- `logs.txt` - Logs del sistema con diferentes niveles
- `estudiantes.csv` - Calificaciones de estudiantes
- `productos.txt` - Inventario de productos
- `access.log` - Logs de servidor web

Puedes usar estos archivos para practicar los ejemplos del curso.

## 💡 Tips para Aprender AWK

### 1. Practica Regularmente
La mejor manera de aprender AWK es usarlo. Intenta procesar tus propios archivos de datos.

### 2. Empieza Simple
Comienza con comandos simples y ve agregando complejidad gradualmente.

### 3. Lee Código de Otros
Busca scripts AWK en GitHub y trata de entender cómo funcionan.

### 4. Usa la Documentación
El manual de AWK es tu amigo:
```bash
man awk
```

### 5. Combina con Otras Herramientas
AWK es más poderoso cuando se combina con otras herramientas Unix:
```bash
# AWK + grep + sort
cat archivo.txt | grep "patrón" | awk '{ print $2 }' | sort -u
```

## 🔧 Ejemplos Rápidos para Empezar

### Ejemplo 1: Imprimir primera columna
```bash
awk '{ print $1 }' archivo.txt
```

### Ejemplo 2: Sumar valores de la segunda columna
```bash
awk '{ suma += $2 } END { print suma }' archivo.txt
```

### Ejemplo 3: Filtrar líneas que contienen "ERROR"
```bash
awk '/ERROR/ { print }' logs.txt
```

### Ejemplo 4: Contar líneas
```bash
awk 'END { print NR }' archivo.txt
```

### Ejemplo 5: Procesar CSV
```bash
awk -F',' '{ print $1, $3 }' datos.csv
```

## 📊 Proyectos Prácticos

Al finalizar el curso, estarás preparado para realizar proyectos como:

1. **Analizador de Logs**: Procesar logs de Apache/Nginx y generar estadísticas
2. **Procesador de CSV**: Convertir y transformar datos entre formatos
3. **Generador de Reportes**: Crear reportes HTML/SQL desde archivos de texto
4. **Monitor de Sistema**: Procesar salida de comandos del sistema
5. **Validador de Datos**: Verificar y limpiar datos de entrada

## 🎓 Certificación

Al completar todos los módulos y ejercicios, habrás dominado AWK desde nivel principiante hasta avanzado. No hay certificación formal, pero tendrás:

- ✅ Conocimiento sólido de AWK
- ✅ Portafolio de scripts prácticos
- ✅ Habilidad para resolver problemas reales
- ✅ Experiencia con procesamiento de texto

## 📚 Recursos Adicionales

### Documentación
- [GNU AWK Manual](https://www.gnu.org/software/gawk/manual/)
- `man awk` - Manual local de AWK

### Libros Recomendados
- "The AWK Programming Language" por Aho, Weinberger, Kernighan
- "Sed & Awk" por Dale Dougherty y Arnold Robbins

### Comunidades
- Stack Overflow - Tag: [awk]
- Reddit - r/commandline
- Unix & Linux Stack Exchange

### Herramientas Relacionadas
- **sed** - Editor de flujo para filtrado y transformación de texto
- **grep** - Buscar patrones en archivos
- **cut** - Extraer secciones de líneas
- **sort** - Ordenar líneas de texto
- **uniq** - Reportar o filtrar líneas repetidas

## ❓ Preguntas Frecuentes

### ¿Necesito conocimientos previos de programación?
No necesariamente, pero ayuda tener familiaridad básica con la línea de comandos.

### ¿Cuánto tiempo lleva completar el curso?
Depende de tu ritmo, pero puedes completarlo en 1-2 semanas dedicando 1-2 horas diarias.

### ¿AWK sigue siendo relevante hoy en día?
¡Absolutamente! AWK es una herramienta estándar en sistemas Unix/Linux y es extremadamente eficiente para procesamiento de texto.

### ¿Qué diferencia hay entre awk, gawk, mawk y nawk?
- **awk** - Versión original
- **gawk** - GNU AWK, la más común en Linux
- **mawk** - Versión optimizada para velocidad
- **nawk** - New AWK, con mejoras sobre el original

Para este curso, cualquiera funciona, pero se recomienda gawk.

### ¿Debo usar AWK o Python para procesamiento de texto?
Depende del caso:
- **AWK**: Mejor para procesamiento simple y rápido de texto columnar
- **Python**: Mejor para lógica compleja y manipulación avanzada de datos

AWK es más rápido para tareas simples y no requiere instalación de bibliotecas adicionales.

## 🤝 Contribuciones

Este curso es un recurso educativo. Si encuentras errores o tienes sugerencias:

1. Los ejemplos están diseñados para ser claros y didácticos
2. Todos los scripts han sido probados
3. Las explicaciones son progresivas

## 📝 Licencia

Este material educativo es de libre uso para aprendizaje personal.

## 🙏 Agradecimientos

Este curso fue creado para ayudar a desarrolladores, administradores de sistemas y entusiastas de Unix/Linux a dominar AWK.

---

## 🚦 Comienza Ahora

Estás listo para comenzar tu viaje de aprendizaje de AWK:

1. **Lee el [Módulo 1](modulos/01-introduccion-basicos.md)** - Comienza con los fundamentos
2. **Ejecuta los ejemplos** - Practica cada código
3. **Haz los ejercicios** - Refuerza tu aprendizaje
4. **Avanza al siguiente módulo** - Progresa a tu ritmo

---

**¡Feliz programación con AWK!** 🎉

> "AWK is a language for processing text files. It's ideal for data extraction and reporting."
> — Brian Kernighan, creador de AWK
