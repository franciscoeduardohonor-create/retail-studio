# Módulo 1: SQL Principiante

## Lección 1: Introducción a SQL

### ¿Qué es SQL?

**SQL (Structured Query Language)** es el lenguaje estándar para gestionar y manipular bases de datos relacionales. Con SQL puedes:
- Crear y modificar estructuras de bases de datos
- Insertar, actualizar y eliminar datos
- Consultar información de manera eficiente
- Controlar el acceso a los datos

### Conceptos Básicos

**Base de Datos**: Colección organizada de datos estructurados.

**Tabla**: Estructura que organiza datos en filas y columnas (como una hoja de Excel).

**Fila (Registro)**: Cada entrada individual en una tabla.

**Columna (Campo)**: Cada atributo de los datos.

**Ejemplo visual de una tabla:**

```
Tabla: empleados
+----+----------+-----------+--------+--------+
| id | nombre   | apellido  | puesto | salario|
+----+----------+-----------+--------+--------+
| 1  | Juan     | Pérez     | Analista| 45000 |
| 2  | María    | García    | Gerente | 65000 |
| 3  | Carlos   | López     | Analista| 47000 |
+----+----------+-----------+--------+--------+
```

### Tipos de Comandos SQL

SQL se divide en varios sublenguajes:

1. **DDL (Data Definition Language)** - Definición de datos
   - CREATE, ALTER, DROP

2. **DML (Data Manipulation Language)** - Manipulación de datos
   - SELECT, INSERT, UPDATE, DELETE

3. **DCL (Data Control Language)** - Control de datos
   - GRANT, REVOKE

4. **TCL (Transaction Control Language)** - Control de transacciones
   - COMMIT, ROLLBACK

### Sintaxis Básica

SQL no distingue entre mayúsculas y minúsculas para las palabras clave, pero es una convención escribir los comandos en MAYÚSCULAS.

```sql
-- Esto es un comentario de una línea

/*
  Esto es un comentario
  de múltiples líneas
*/

-- Ejemplo de consulta básica
SELECT nombre, apellido
FROM empleados;
```

### Puntos Clave

✓ SQL es declarativo: describes QUÉ quieres, no CÓMO obtenerlo
✓ Cada instrucción SQL termina con punto y coma (;)
✓ SQL es case-insensitive, pero los datos sí distinguen mayúsculas/minúsculas
✓ Los espacios en blanco y saltos de línea son ignorados

---

**Siguiente lección**: Creación de bases de datos y tablas
