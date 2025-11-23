# Ejercicios Prácticos de AWK

Este archivo contiene ejercicios adicionales para practicar tus habilidades en AWK.
Los ejercicios están organizados por nivel de dificultad.

## 🟢 Nivel Principiante

### Ejercicio 1: Manipulación Básica de Datos

Dado el archivo `datos-ejemplo/empleados.txt`:

**Tareas:**
1. Imprime solo los nombres (primera columna)
2. Imprime solo los salarios (segunda columna)
3. Imprime nombre y departamento de cada empleado
4. Cuenta cuántos empleados hay en total
5. Imprime las líneas numeradas (con NR)

### Ejercicio 2: Cálculos Simples

Usando `datos-ejemplo/empleados.txt`:

**Tareas:**
1. Calcula el salario total de todos los empleados
2. Calcula el salario promedio
3. Encuentra el salario más alto
4. Encuentra el salario más bajo
5. Cuenta cuántos empleados ganan más de 2500

### Ejercicio 3: Formateo de Salida

Con `datos-ejemplo/empleados.txt`:

**Tareas:**
1. Crea un reporte formateado con columnas alineadas
2. Agrega un símbolo $ antes de cada salario
3. Crea un encabezado con BEGIN
4. Agrega un pie de página con el total en END
5. Usa printf para formatear montos con 2 decimales

---

## 🟡 Nivel Intermedio

### Ejercicio 4: Trabajo con CSV

Usando `datos-ejemplo/ventas.csv`:

**Tareas:**
1. Calcula el total de cada venta (cantidad × precio)
2. Suma todas las ventas por producto
3. Suma todas las ventas por región
4. Encuentra el producto más vendido (por cantidad)
5. Genera un reporte con subtotales por región

### Ejercicio 5: Análisis de Logs

Con `datos-ejemplo/logs.txt`:

**Tareas:**
1. Cuenta cuántos mensajes de cada tipo hay (ERROR, WARNING, INFO)
2. Extrae solo las líneas de ERROR
3. Muestra los errores con su hora
4. Calcula el porcentaje de cada tipo de mensaje
5. Encuentra la primera y última línea de cada tipo

### Ejercicio 6: Filtrado Avanzado

Usando `datos-ejemplo/empleados.txt`:

**Tareas:**
1. Muestra solo empleados de IT
2. Muestra empleados de IT o Marketing
3. Muestra empleados de Ventas con salario > 2500
4. Cuenta empleados por departamento
5. Calcula salario promedio por departamento

---

## 🔴 Nivel Avanzado

### Ejercicio 7: Arrays y Agrupación

Con `datos-ejemplo/estudiantes.csv`:

**Tareas:**
1. Calcula el promedio de cada estudiante
2. Calcula el promedio de cada materia
3. Encuentra el mejor estudiante (mayor promedio)
4. Encuentra la materia más difícil (menor promedio)
5. Crea una tabla de estudiantes × materias con sus notas

### Ejercicio 8: Análisis Multi-dimensional

Usando `datos-ejemplo/ventas.csv`:

**Tareas:**
1. Crea una matriz de ventas: región × producto
2. Calcula totales por fila (región) y columna (producto)
3. Encuentra la combinación región-producto más rentable
4. Calcula el porcentaje que representa cada región del total
5. Genera un reporte HTML con los resultados

### Ejercicio 9: Procesamiento de Logs Web

Con `datos-ejemplo/access.log`:

**Tareas:**
1. Cuenta requests por IP
2. Cuenta requests por código de estado (200, 404, etc.)
3. Calcula el total de bytes transferidos
4. Encuentra la URL más accedida
5. Lista las IPs que generaron errores 404
6. Calcula el promedio de bytes por request
7. Agrupa requests por hora
8. Identifica posibles ataques (muchos requests de una IP)

---

## 🔥 Proyectos Finales

### Proyecto 1: Sistema de Inventario Completo

**Objetivo:** Crear un sistema completo de análisis de inventario

**Requisitos:**
1. Leer archivo de productos con: código, nombre, precio, stock
2. Generar alertas para productos con stock bajo (< 10 unidades)
3. Calcular el valor total del inventario
4. Generar reporte con:
   - Lista de productos ordenada por valor
   - Productos que necesitan reabastecimiento
   - Estadísticas: total items, valor promedio, etc.
5. Exportar resultados a HTML y SQL

**Archivo de entrada:** Crea tu propio archivo o usa `datos-ejemplo/productos.txt`

### Proyecto 2: Analizador de Rendimiento de Ventas

**Objetivo:** Analizar datos de ventas y generar reportes ejecutivos

**Requisitos:**
1. Procesar ventas de múltiples regiones y productos
2. Calcular:
   - Ventas totales por región
   - Ventas totales por producto
   - Tendencias temporales (si hay fechas)
   - Regiones con mejor rendimiento
   - Productos más rentables
3. Generar gráficos de texto (histogramas)
4. Crear alertas para regiones con bajo rendimiento
5. Exportar a formato CSV y HTML

**Archivo de entrada:** `datos-ejemplo/ventas.csv`

### Proyecto 3: Monitor de Calidad de Código

**Objetivo:** Analizar archivos de código fuente

**Requisitos:**
1. Contar líneas de código, comentarios y líneas en blanco
2. Calcular ratio de comentarios vs código
3. Identificar funciones muy largas (> 50 líneas)
4. Buscar posibles problemas:
   - Líneas muy largas (> 80 caracteres)
   - TODO/FIXME en comentarios
5. Generar reporte de calidad de código

**Archivos de entrada:** Cualquier archivo de código (.py, .js, .sh, etc.)

### Proyecto 4: Procesador Universal de CSV

**Objetivo:** Crear una herramienta genérica para procesar cualquier CSV

**Requisitos:**
1. Detectar automáticamente el separador (,  ; |)
2. Mostrar estadísticas de cada columna numérica:
   - Suma, promedio, min, max
3. Para columnas de texto:
   - Valores únicos
   - Valor más frecuente
4. Generar resumen del dataset
5. Opciones para:
   - Filtrar filas por condiciones
   - Seleccionar columnas específicas
   - Ordenar por columna
   - Exportar a diferentes formatos

---

## 💡 Tips para Resolver los Ejercicios

1. **Lee el módulo relevante primero**: Si tienes dudas, vuelve a los módulos
2. **Empieza simple**: Resuelve casos básicos antes de agregar complejidad
3. **Prueba incrementalmente**: Ejecuta y prueba cada parte de tu código
4. **Usa prints de debug**: Agrega `print` para ver qué está pasando
5. **Consulta la guía rápida**: `GUIA-RAPIDA.md` tiene referencia de sintaxis
6. **Experimenta**: No tengas miedo de probar cosas nuevas

## 📝 Formato de Entrega

Para cada ejercicio, crea un archivo `.awk` con:

```awk
#!/usr/bin/awk -f
# Ejercicio: [Número y nombre]
# Descripción: [Breve descripción]
# Autor: [Tu nombre]
# Fecha: [Fecha]

# Tu código aquí
BEGIN {
    # ...
}

{
    # ...
}

END {
    # ...
}
```

## ✅ Auto-evaluación

Después de completar cada ejercicio, pregúntate:

- [ ] ¿El código produce el resultado correcto?
- [ ] ¿El código es legible y está comentado?
- [ ] ¿Manejé casos especiales (archivos vacíos, datos faltantes)?
- [ ] ¿Podría optimizarse el código?
- [ ] ¿Aprendí algo nuevo?

## 🎯 Desafíos Adicionales

Si terminaste todos los ejercicios, intenta estos desafíos:

1. **Optimización**: Toma un script que hayas escrito y hazlo 2x más rápido
2. **Mini-lenguaje**: Crea un intérprete simple para un lenguaje inventado
3. **Generador de datos**: Crea un generador de datos de prueba aleatorios
4. **Conversor universal**: CSV ↔ JSON ↔ XML ↔ SQL
5. **Juego en AWK**: Crea un juego simple (como adivinar número)

## 📚 Recursos Adicionales

- Ver ejemplos completos en `/ejemplos`
- Consultar `/GUIA-RAPIDA.md` para referencia rápida
- Revisar los módulos para conceptos específicos
- Buscar "awk one-liners" en internet para inspiración

---

**¡Buena suerte con los ejercicios!** 🚀

Recuerda: La práctica es la clave para dominar AWK. Entre más ejercicios resuelvas,
más natural se volverá pensar en términos de patrones y acciones.
