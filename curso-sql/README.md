# 🎓 Curso Completo de SQL - De Principiante a Avanzado

> Un curso práctico y completo para aprender SQL desde cero hasta nivel avanzado, con cientos de ejemplos comentados y ejercicios prácticos.

---

## 📋 Tabla de Contenidos

1. [Introducción](#introducción)
2. [Requisitos Previos](#requisitos-previos)
3. [Estructura del Curso](#estructura-del-curso)
4. [Cómo Usar Este Curso](#cómo-usar-este-curso)
5. [Instalación y Configuración](#instalación-y-configuración)
6. [Contenido del Curso](#contenido-del-curso)
7. [Recursos Adicionales](#recursos-adicionales)

---

## 🎯 Introducción

Este curso te llevará desde los fundamentos de SQL hasta técnicas avanzadas de optimización y programación de bases de datos. Está diseñado para ser **100% práctico**, con:

- ✅ **Más de 500 ejemplos de código comentados**
- ✅ **115+ ejercicios prácticos**
- ✅ **5 proyectos integradores completos**
- ✅ **Base de datos de ejemplo realista**
- ✅ **Explicaciones detalladas paso a paso**
- ✅ **Best practices de la industria**

### ¿Para quién es este curso?

- **Principiantes absolutos** que nunca han usado SQL
- **Desarrolladores** que quieren dominar bases de datos
- **Analistas de datos** que necesitan consultas avanzadas
- **Administradores de BD** que buscan optimización
- **Estudiantes** de informática o carreras afines

### ¿Qué aprenderás?

Al finalizar este curso, serás capaz de:

1. Crear y gestionar bases de datos complejas
2. Escribir consultas SQL eficientes y optimizadas
3. Realizar análisis de datos avanzados
4. Implementar procedimientos y funciones almacenadas
5. Optimizar el rendimiento de bases de datos
6. Diseñar sistemas de auditoría y seguridad
7. Aplicar mejores prácticas de la industria

---

## 🔧 Requisitos Previos

### Conocimientos
- **Ninguno requerido** - empezamos desde cero
- Conocimientos básicos de informática son útiles
- Lógica básica de programación es un plus (opcional)

### Software Necesario

1. **MySQL 8.0 o superior** (o MariaDB 10.5+)
   - Descarga: https://dev.mysql.com/downloads/mysql/

2. **Cliente SQL** (elige uno):
   - MySQL Workbench (recomendado para principiantes)
   - DBeaver (gratuito, multiplataforma)
   - phpMyAdmin (web)
   - HeidiSQL (Windows)
   - Sequel Pro (Mac)
   - Línea de comandos MySQL

3. **Editor de texto** (opcional pero recomendado):
   - Visual Studio Code con extensión SQL
   - Sublime Text
   - Atom

---

## 📚 Estructura del Curso

El curso está organizado en 3 módulos principales:

```
curso-sql/
│
├── modulo-1-principiante/          # Nivel Básico
│   ├── 01-introduccion-sql.md
│   ├── 02-crear-bases-datos-tablas.sql
│   ├── 03-select-basico.sql
│   └── 04-insert-update-delete.sql
│
├── modulo-2-intermedio/            # Nivel Intermedio
│   ├── 01-joins.sql
│   ├── 02-subconsultas.sql
│   └── 03-funciones-group-by.sql
│
├── modulo-3-avanzado/              # Nivel Avanzado
│   ├── 01-indices-optimizacion.sql
│   └── 02-vistas-procedimientos-triggers.sql
│
├── datos-ejemplo/                  # Base de datos de práctica
│   └── base-datos-completa.sql
│
├── ejercicios/                     # Ejercicios prácticos
│   └── guia-ejercicios-completa.md
│
└── README.md                       # Este archivo
```

---

## 🚀 Cómo Usar Este Curso

### Método de Estudio Recomendado

#### **Fase 1: Configuración** (30 minutos)
1. Instala MySQL y un cliente SQL
2. Carga la base de datos de ejemplo
3. Familiarízate con tu herramienta

#### **Fase 2: Aprendizaje por Módulos** (20-40 horas)

**Para cada lección:**

1. **LEE** la explicación teórica
2. **EJECUTA** cada ejemplo en tu base de datos
3. **EXPERIMENTA** modificando los ejemplos
4. **PRACTICA** con los ejercicios propuestos
5. **VERIFICA** tus resultados

**Tiempo sugerido por módulo:**
- Módulo 1 (Principiante): 8-12 horas
- Módulo 2 (Intermedio): 10-15 horas
- Módulo 3 (Avanzado): 12-18 horas

#### **Fase 3: Proyectos Finales** (10-20 horas)
- Completa al menos 2 proyectos integradores
- Aplica todo lo aprendido
- Crea tu portafolio

### Consejos de Estudio

✅ **SÍ hacer:**
- Escribir cada consulta manualmente (no copiar-pegar)
- Experimentar con variaciones de los ejemplos
- Cometer errores y aprender de ellos
- Practicar regularmente (mejor 1 hora diaria que 7 horas un día)
- Consultar la documentación oficial
- Tomar notas de conceptos importantes

❌ **NO hacer:**
- Saltar lecciones (cada una construye sobre la anterior)
- Solo leer sin practicar
- Frustrarte con ejercicios difíciles (pide ayuda)
- Memorizar sin entender
- Avanzar sin dominar lo básico

---

## ⚙️ Instalación y Configuración

### Opción 1: MySQL en tu computadora (Recomendado)

#### Windows
```bash
# 1. Descarga el instalador de MySQL
# https://dev.mysql.com/downloads/installer/

# 2. Ejecuta el instalador y sigue el asistente
# - Elige "Developer Default"
# - Configura una contraseña para root
# - Instala MySQL Workbench

# 3. Abre MySQL Workbench y crea una conexión
```

#### macOS
```bash
# Usando Homebrew
brew install mysql
brew services start mysql
mysql_secure_installation

# Instalar Workbench
brew install --cask mysqlworkbench
```

#### Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install mysql-server
sudo mysql_secure_installation

# Cliente
sudo apt install mysql-workbench
```

### Opción 2: Docker (Avanzado)

```bash
# Ejecutar MySQL en contenedor
docker run --name mysql-curso \
  -e MYSQL_ROOT_PASSWORD=miclave123 \
  -p 3306:3306 \
  -d mysql:8.0

# Conectarse
docker exec -it mysql-curso mysql -uroot -p
```

### Cargar la Base de Datos de Ejemplo

#### Método 1: MySQL Workbench
1. Abre MySQL Workbench
2. Conecta a tu servidor
3. File → Open SQL Script
4. Selecciona `datos-ejemplo/base-datos-completa.sql`
5. Ejecuta el script (⚡ icono de rayo)

#### Método 2: Línea de comandos
```bash
mysql -u root -p < datos-ejemplo/base-datos-completa.sql
```

#### Método 3: Copiar y pegar
1. Abre el archivo `base-datos-completa.sql`
2. Copia todo el contenido
3. Pégalo en tu cliente SQL
4. Ejecuta

### Verificar la Instalación

```sql
-- Conectar a la base de datos
USE tienda_online;

-- Verificar tablas
SHOW TABLES;

-- Verificar datos
SELECT COUNT(*) AS total_clientes FROM clientes;
SELECT COUNT(*) AS total_productos FROM productos;
SELECT COUNT(*) AS total_pedidos FROM pedidos;

-- Deberías ver:
-- total_clientes: 15
-- total_productos: 29
-- total_pedidos: 13
```

---

## 📖 Contenido del Curso

### 📘 Módulo 1: SQL Principiante

#### Lección 1: Introducción a SQL
- ¿Qué es SQL y para qué sirve?
- Conceptos básicos: bases de datos, tablas, filas, columnas
- Tipos de comandos SQL (DDL, DML, DCL, TCL)
- Sintaxis básica y convenciones

#### Lección 2: Crear Bases de Datos y Tablas
- CREATE DATABASE y USE
- Tipos de datos (numéricos, texto, fecha, booleanos)
- CREATE TABLE con restricciones
- Claves primarias y foráneas
- ALTER TABLE (modificar estructura)
- DROP TABLE (eliminar tablas)

#### Lección 3: Consultas SELECT Básicas
- SELECT * y selección de columnas específicas
- WHERE: filtrar resultados
- Operadores de comparación (=, !=, >, <, >=, <=)
- Operadores lógicos (AND, OR, NOT)
- BETWEEN, IN, LIKE
- ORDER BY (ordenar resultados)
- LIMIT (limitar resultados)
- DISTINCT (eliminar duplicados)

#### Lección 4: Insertar, Actualizar y Eliminar
- INSERT INTO (simple y múltiple)
- UPDATE con WHERE
- DELETE con WHERE
- TRUNCATE vs DELETE
- Transacciones básicas (START TRANSACTION, COMMIT, ROLLBACK)
- Buenas prácticas de seguridad

**Ejercicios:** 30 ejercicios prácticos (básicos)

---

### 📗 Módulo 2: SQL Intermedio

#### Lección 5: JOINS - Unir Tablas
- INNER JOIN (intersección)
- LEFT JOIN (todos de la izquierda)
- RIGHT JOIN (todos de la derecha)
- FULL OUTER JOIN (simulado con UNION)
- CROSS JOIN (producto cartesiano)
- SELF JOIN (unir tabla consigo misma)
- Múltiples JOINs en una consulta
- JOINs con agregaciones

#### Lección 6: Subconsultas
- Subconsultas en WHERE
- Subconsultas en FROM (tablas derivadas)
- Subconsultas en SELECT
- Subconsultas correlacionadas
- EXISTS y NOT EXISTS
- IN y NOT IN con subconsultas
- ANY y ALL
- Common Table Expressions (WITH / CTE)

#### Lección 7: Funciones y GROUP BY
- Funciones de agregación (COUNT, SUM, AVG, MIN, MAX)
- GROUP BY (agrupar datos)
- HAVING (filtrar grupos)
- Funciones de cadenas (CONCAT, UPPER, LOWER, SUBSTRING, etc.)
- Funciones numéricas (ROUND, CEIL, FLOOR, etc.)
- Funciones de fecha (NOW, DATE_FORMAT, DATEDIFF, etc.)
- Funciones condicionales (IF, CASE)
- Window Functions (ROW_NUMBER, RANK, LAG, LEAD)

**Ejercicios:** 40 ejercicios prácticos (intermedios)

---

### 📕 Módulo 3: SQL Avanzado

#### Lección 8: Índices y Optimización
- ¿Qué son los índices?
- Tipos de índices (PRIMARY, UNIQUE, INDEX, FULLTEXT)
- CREATE INDEX y DROP INDEX
- Índices compuestos
- EXPLAIN y análisis de consultas
- Optimización de consultas
- Mejores prácticas
- ANALYZE TABLE y OPTIMIZE TABLE
- Particionamiento de tablas

#### Lección 9: Vistas, Procedimientos y Triggers
- **Vistas (Views)**
  - CREATE VIEW
  - Vistas actualizables
  - WITH CHECK OPTION

- **Procedimientos Almacenados**
  - CREATE PROCEDURE
  - Parámetros IN, OUT, INOUT
  - Variables y control de flujo
  - Cursores y bucles
  - Manejo de errores

- **Funciones Almacenadas**
  - CREATE FUNCTION
  - RETURNS y DETERMINISTIC

- **Triggers**
  - BEFORE y AFTER
  - INSERT, UPDATE, DELETE
  - OLD y NEW
  - Auditoría automática

- **Eventos (Events)**
  - Tareas programadas
  - CREATE EVENT

**Ejercicios:** 45 ejercicios prácticos (avanzados)

---

## 🎯 Proyectos Finales

### Proyecto 1: Sistema de Reportes Completo
Diseña e implementa un sistema completo de reportes para la tienda online.

**Entregables:**
- 10+ vistas para diferentes reportes
- 5+ procedimientos almacenados
- Dashboard ejecutivo con KPIs
- Documentación completa

### Proyecto 2: Sistema de Auditoría
Implementa un sistema robusto de auditoría y trazabilidad.

**Entregables:**
- Tablas de auditoría
- Triggers automáticos
- Reportes de cambios
- Sistema de alertas

### Proyecto 3: Optimización de Performance
Analiza y optimiza el rendimiento de la base de datos.

**Entregables:**
- Análisis de consultas lentas
- Índices optimizados
- Procedimientos refactorizados
- Reporte de mejoras

### Proyecto 4: API de Base de Datos
Crea una API completa usando solo SQL.

**Entregables:**
- CRUD completo via procedimientos
- Sistema de autenticación
- Validación de datos
- Documentación de API

### Proyecto 5: Mini E-commerce
Expande la base de datos con funcionalidades completas.

**Entregables:**
- Carritos de compra
- Sistema de cupones
- Reseñas de productos
- Sistema de recomendaciones

---

## 📊 Base de Datos de Ejemplo

### Descripción

La base de datos `tienda_online` simula una tienda de electrónica con:

- **15 clientes** con información realista
- **29 productos** en 5 categorías
- **13 pedidos** con múltiples detalles
- **Relaciones complejas** entre tablas
- **Datos variados** para practicar todo tipo de consultas

### Diagrama de Tablas

```
clientes (15 registros)
├── id (PK)
├── nombre, apellido, email
├── telefono, ciudad, pais
├── fecha_registro
└── es_vip

productos (29 registros)
├── id (PK)
├── nombre, descripcion
├── precio, stock
├── categoria
└── activo

pedidos (13 registros)
├── id (PK)
├── cliente_id (FK → clientes)
├── fecha_pedido
├── total
└── estado

detalle_pedidos (múltiples registros)
├── id (PK)
├── pedido_id (FK → pedidos)
├── producto_id (FK → productos)
├── cantidad
└── precio_unitario
```

---

## 📝 Evaluación y Certificación

### Sistema de Progreso

Lleva un registro de tu progreso:

- [ ] Módulo 1 completado (30 ejercicios)
- [ ] Módulo 2 completado (40 ejercicios)
- [ ] Módulo 3 completado (45 ejercicios)
- [ ] Proyecto 1 completado
- [ ] Proyecto 2 completado
- [ ] Proyecto 3 completado
- [ ] Proyecto 4 completado
- [ ] Proyecto 5 completado

### Niveles de Dominio

- **Principiante:** 0-30 ejercicios completados
- **Intermedio:** 31-70 ejercicios completados
- **Avanzado:** 71-115 ejercicios completados
- **Experto:** 115+ ejercicios + 2 proyectos completados
- **Maestro:** Todos los ejercicios + todos los proyectos

---

## 🌟 Recursos Adicionales

### Documentación Oficial
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [MySQL Tutorial](https://dev.mysql.com/doc/refman/8.0/en/tutorial.html)
- [SQL Standard](https://www.iso.org/standard/63555.html)

### Sitios de Práctica
- [SQLZoo](https://sqlzoo.net/) - Tutoriales interactivos
- [HackerRank SQL](https://www.hackerrank.com/domains/sql) - Desafíos
- [LeetCode Database](https://leetcode.com/problemset/database/) - Problemas
- [SQL Fiddle](http://sqlfiddle.com/) - Probar consultas online

### Libros Recomendados
- "SQL in 10 Minutes" - Ben Forta (principiantes)
- "Learning SQL" - Alan Beaulieu (intermedio)
- "High Performance MySQL" - Baron Schwartz (avanzado)
- "SQL Performance Explained" - Markus Winand (optimización)

### Canales de YouTube
- FreeCodeCamp SQL Tutorial
- Programming with Mosh
- Traversy Media
- The Net Ninja

### Comunidades
- Stack Overflow (etiqueta: mysql, sql)
- Reddit: r/SQL, r/mysql
- Discord: SQL & Databases servers
- MySQL Forums

---

## 💡 Consejos de Expertos

### Para Principiantes

1. **No te apresures** - SQL se aprende haciendo, no leyendo
2. **Escribe todo manualmente** - no copies y pegues
3. **Entiende, no memorices** - comprende el porqué
4. **Empieza simple** - complejidad viene con la práctica
5. **Usa comentarios** - documenta tus consultas

### Para Intermedios

1. **Domina los JOINs** - son fundamentales
2. **Aprende a leer EXPLAIN** - optimización comienza aquí
3. **Practica subconsultas** - son poderosas pero complejas
4. **Conoce las funciones** - amplían tus posibilidades
5. **Diseña bien** - normalización y desnormalización

### Para Avanzados

1. **Optimiza siempre** - rendimiento es crítico
2. **Seguridad primero** - valida y sanitiza datos
3. **Documenta todo** - tu yo futuro te lo agradecerá
4. **Testea exhaustivamente** - especialmente procedimientos
5. **Mantente actualizado** - SQL evoluciona constantemente

---

## ❓ Preguntas Frecuentes

**P: ¿Cuánto tiempo toma completar el curso?**
R: Depende de tu dedicación. Con 1-2 horas diarias, puedes completarlo en 4-6 semanas.

**P: ¿Necesito saber programación?**
R: No es necesario, pero ayuda. El curso empieza desde cero.

**P: ¿MySQL o PostgreSQL?**
R: El curso usa MySQL, pero los conceptos aplican a cualquier SQL. PostgreSQL es muy similar.

**P: ¿Puedo usar este curso para aprender SQL Server?**
R: Sí, el 90% del contenido es aplicable. Solo hay diferencias menores en sintaxis.

**P: ¿Los ejercicios tienen soluciones?**
R: Los ejercicios están diseñados para que los resuelvas tú. Si te atascas, revisa las lecciones o busca ayuda en comunidades.

**P: ¿Qué hago después de completar el curso?**
R: Construye proyectos propios, contribuye a proyectos open source, o busca posiciones junior de DB.

---

## 🤝 Contribuciones

Este curso es open source. Si encuentras errores o quieres agregar contenido:

1. Reporta issues
2. Sugiere mejoras
3. Comparte tu experiencia
4. Ayuda a otros estudiantes

---

## 📜 Licencia

Este curso es de uso libre para aprendizaje personal y educación.

---

## 👨‍💻 Autor

Creado con ❤️ para la comunidad de desarrolladores en español.

---

## 🎓 Conclusión

SQL es una habilidad fundamental en el mundo de la tecnología. Este curso te proporciona todas las herramientas necesarias para dominarla. Recuerda:

> "La única manera de aprender SQL es escribiendo SQL"

**¡Comienza ahora y feliz aprendizaje!** 🚀

---

## 📞 Soporte

Si tienes preguntas o necesitas ayuda:
- Revisa la documentación oficial de MySQL
- Busca en Stack Overflow
- Únete a comunidades de SQL
- Practica, practica, practica

**¡Éxito en tu viaje de aprendizaje SQL!** 💪
