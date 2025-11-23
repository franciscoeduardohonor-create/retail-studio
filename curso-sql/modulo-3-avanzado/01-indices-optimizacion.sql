-- ============================================
-- MÓDULO 3: SQL AVANZADO
-- LECCIÓN 1: ÍNDICES Y OPTIMIZACIÓN
-- ============================================

USE tienda_online;

/*
Los índices son estructuras de datos que mejoran la velocidad
de recuperación de datos en una tabla, similar a un índice en un libro.

Ventajas:
- Consultas SELECT mucho más rápidas
- Mejor rendimiento en JOINs y WHERE

Desventajas:
- Ocupan espacio en disco
- Hacen más lentos los INSERT, UPDATE, DELETE
- Necesitan mantenimiento
*/


-- ==========================================
-- 1. CREAR ÍNDICES
-- ==========================================

-- Ver índices actuales de una tabla
SHOW INDEX FROM clientes;

-- Crear índice simple en una columna
CREATE INDEX idx_clientes_email ON clientes(email);

-- Crear índice en múltiples columnas (índice compuesto)
CREATE INDEX idx_clientes_nombre_apellido ON clientes(nombre, apellido);

-- Crear índice único (valores deben ser únicos)
CREATE UNIQUE INDEX idx_clientes_email_unico ON clientes(email);

-- Crear índice al crear la tabla
CREATE TABLE IF NOT EXISTS ejemplo_indices (
    id INT PRIMARY KEY,              -- Automáticamente crea un índice
    codigo VARCHAR(50) UNIQUE,       -- Automáticamente crea un índice único
    nombre VARCHAR(100),
    categoria VARCHAR(50),
    precio DECIMAL(10, 2),

    INDEX idx_nombre (nombre),       -- Índice explícito
    INDEX idx_categoria_precio (categoria, precio)  -- Índice compuesto
);

-- Índice en tabla de productos
CREATE INDEX idx_productos_categoria ON productos(categoria);
CREATE INDEX idx_productos_precio ON productos(precio);
CREATE INDEX idx_productos_activo ON productos(activo);

-- Índice compuesto útil para consultas que filtran por ambas
CREATE INDEX idx_productos_categoria_activo ON productos(categoria, activo);


-- ==========================================
-- 2. TIPOS DE ÍNDICES
-- ==========================================

/*
1. PRIMARY KEY:
   - Índice único y no nulo
   - Solo puede haber uno por tabla
   - Identifica únicamente cada fila

2. UNIQUE:
   - Garantiza valores únicos
   - Permite NULL (generalmente solo uno)
   - Puede haber múltiples en una tabla

3. INDEX (o KEY):
   - Índice regular
   - Permite duplicados
   - Mejora velocidad de búsqueda

4. FULLTEXT:
   - Para búsquedas de texto completo
   - Solo en columnas CHAR, VARCHAR, TEXT

5. SPATIAL:
   - Para datos geográficos
   - Requiere tipos de datos espaciales
*/

-- Ejemplo de índice FULLTEXT
ALTER TABLE productos ADD FULLTEXT INDEX idx_fulltext_nombre_desc (nombre, descripcion);

-- Búsqueda con FULLTEXT
SELECT nombre, descripcion
FROM productos
WHERE MATCH(nombre, descripcion) AGAINST('laptop ultradelgada');

-- Búsqueda con modo booleano
SELECT nombre, descripcion
FROM productos
WHERE MATCH(nombre, descripcion) AGAINST('+laptop -apple' IN BOOLEAN MODE);


-- ==========================================
-- 3. ELIMINAR ÍNDICES
-- ==========================================

-- Eliminar índice por nombre
DROP INDEX idx_clientes_nombre_apellido ON clientes;

-- Eliminar usando ALTER TABLE
ALTER TABLE clientes DROP INDEX idx_clientes_email;

-- Ver qué índices quedan
SHOW INDEX FROM clientes;


-- ==========================================
-- 4. EXPLAIN - Analizar consultas
-- ==========================================

/*
EXPLAIN muestra cómo MySQL ejecuta una consulta.
Es fundamental para optimización.
*/

-- Consulta sin índice (table scan completo)
EXPLAIN SELECT * FROM productos WHERE precio > 5000;

-- Crear índice en precio
CREATE INDEX idx_precio ON productos(precio);

-- Misma consulta con índice (más eficiente)
EXPLAIN SELECT * FROM productos WHERE precio > 5000;

-- EXPLAIN con JOIN
EXPLAIN
SELECT c.nombre, p.total
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id
WHERE c.email = 'juan.perez@email.com';

-- EXPLAIN ANALYZE (más detallado, ejecuta la consulta)
EXPLAIN ANALYZE
SELECT nombre, precio FROM productos WHERE categoria = 'Electrónica';

/*
Columnas importantes en EXPLAIN:
- type: Tipo de acceso (ALL es el peor, const/eq_ref es el mejor)
  * ALL: Escaneo completo de tabla (lento)
  * index: Escaneo completo de índice
  * range: Búsqueda por rango en índice
  * ref: Búsqueda por referencia en índice
  * eq_ref: Una fila del índice (muy eficiente)
  * const: Una constante (lo más rápido)

- possible_keys: Índices que podría usar
- key: Índice que realmente usa
- rows: Estimación de filas examinadas
- Extra: Información adicional
*/


-- ==========================================
-- 5. OPTIMIZACIÓN DE CONSULTAS
-- ==========================================

-- MAL: SELECT *
-- Trae todas las columnas aunque no las necesites
SELECT * FROM productos WHERE categoria = 'Electrónica';

-- BIEN: Seleccionar solo columnas necesarias
SELECT id, nombre, precio FROM productos WHERE categoria = 'Electrónica';

-- MAL: Función en columna indexada (no usa índice)
SELECT * FROM clientes WHERE YEAR(fecha_registro) = 2024;

-- BIEN: Comparar con rango (usa índice si existe)
SELECT * FROM clientes
WHERE fecha_registro >= '2024-01-01' AND fecha_registro < '2025-01-01';

-- MAL: OR con diferentes columnas
SELECT * FROM productos WHERE nombre LIKE '%laptop%' OR descripcion LIKE '%laptop%';

-- BIEN: Usar UNION o índice FULLTEXT
SELECT * FROM productos WHERE MATCH(nombre, descripcion) AGAINST('laptop');

-- MAL: NOT IN con subconsulta grande
SELECT * FROM productos
WHERE id NOT IN (SELECT producto_id FROM detalle_pedidos);

-- BIEN: LEFT JOIN con IS NULL
SELECT p.*
FROM productos p
LEFT JOIN detalle_pedidos dp ON p.id = dp.producto_id
WHERE dp.producto_id IS NULL;

-- Usar LIMIT cuando sea posible
SELECT * FROM productos ORDER BY precio DESC LIMIT 10;

-- Índice covering: índice que contiene todas las columnas necesarias
CREATE INDEX idx_covering_productos ON productos(categoria, nombre, precio);

-- Esta consulta puede satisfacerse solo con el índice (muy rápido)
SELECT nombre, precio FROM productos WHERE categoria = 'Electrónica';


-- ==========================================
-- 6. QUERY CACHE (en versiones antiguas)
-- ==========================================

/*
MySQL 8.0+ ya no tiene query cache, pero en versiones anteriores:
- Cachea resultados de SELECT
- Se invalida al modificar las tablas involucradas
*/

-- Ver configuración de cache (MySQL < 8.0)
-- SHOW VARIABLES LIKE 'query_cache%';

-- Deshabilitar cache para una consulta específica
SELECT SQL_NO_CACHE nombre, precio FROM productos;


-- ==========================================
-- 7. PARTICIONAMIENTO (Avanzado)
-- ==========================================

/*
Particionar divide una tabla grande en partes más pequeñas
para mejorar rendimiento y mantenimiento.
*/

-- Crear tabla particionada por rango (por año)
CREATE TABLE IF NOT EXISTS logs_acceso (
    id INT AUTO_INCREMENT,
    usuario_id INT,
    accion VARCHAR(100),
    fecha DATETIME,
    PRIMARY KEY (id, fecha)  -- La clave de partición debe estar en PK
)
PARTITION BY RANGE (YEAR(fecha)) (
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);

-- Insertar datos de prueba
INSERT INTO logs_acceso (usuario_id, accion, fecha) VALUES
(1, 'login', '2022-06-15 10:30:00'),
(2, 'compra', '2023-03-20 14:45:00'),
(3, 'logout', '2024-01-10 16:20:00');

-- Consulta sobre partición específica (más rápida)
SELECT * FROM logs_acceso WHERE YEAR(fecha) = 2024;

-- Ver particiones
SELECT TABLE_NAME, PARTITION_NAME, TABLE_ROWS
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE TABLE_NAME = 'logs_acceso';


-- ==========================================
-- 8. ANÁLISIS Y MANTENIMIENTO DE TABLAS
-- ==========================================

-- Analizar tabla (actualiza estadísticas para el optimizador)
ANALYZE TABLE productos;

-- Optimizar tabla (reorganiza y desfragmenta)
OPTIMIZE TABLE productos;

-- Verificar integridad de tabla
CHECK TABLE productos;

-- Reparar tabla (si está corrupta)
-- REPAIR TABLE productos;

-- Ver estadísticas de tabla
SHOW TABLE STATUS LIKE 'productos';

-- Ver tamaño de tablas
SELECT
    TABLE_NAME,
    ROUND((DATA_LENGTH + INDEX_LENGTH) / 1024 / 1024, 2) AS size_mb
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'tienda_online'
ORDER BY (DATA_LENGTH + INDEX_LENGTH) DESC;


-- ==========================================
-- 9. MEJORES PRÁCTICAS
-- ==========================================

/*
1. ÍNDICES:
   - Crear índices en columnas de JOIN, WHERE, ORDER BY
   - No crear demasiados índices (afecta escritura)
   - Índices compuestos: orden importa (más selectivo primero)
   - Eliminar índices no usados

2. CONSULTAS:
   - Evitar SELECT *
   - Usar LIMIT cuando sea posible
   - No usar funciones en columnas indexadas en WHERE
   - Preferir INNER JOIN sobre subconsultas cuando sea posible
   - Usar EXISTS en lugar de IN para subconsultas grandes

3. DISEÑO DE TABLAS:
   - Normalizar adecuadamente (evitar redundancia)
   - Pero desnormalizar estratégicamente si es necesario
   - Tipos de datos apropiados (no VARCHAR(255) para todo)
   - NOT NULL cuando sea posible

4. MONITOREO:
   - Usar EXPLAIN regularmente
   - Monitorear slow query log
   - Revisar estadísticas periódicamente
*/


-- ==========================================
-- 10. EJEMPLOS PRÁCTICOS DE OPTIMIZACIÓN
-- ==========================================

-- ANTES: Consulta lenta
SELECT
    c.nombre,
    c.apellido,
    (SELECT COUNT(*) FROM pedidos WHERE cliente_id = c.id) AS num_pedidos,
    (SELECT SUM(total) FROM pedidos WHERE cliente_id = c.id) AS total_gastado
FROM clientes c;

-- DESPUÉS: Optimizado con JOIN
SELECT
    c.nombre,
    c.apellido,
    COUNT(p.id) AS num_pedidos,
    COALESCE(SUM(p.total), 0) AS total_gastado
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre, c.apellido;

-- Crear índices apropiados para reportes frecuentes
CREATE INDEX idx_pedidos_cliente_fecha ON pedidos(cliente_id, fecha_pedido);
CREATE INDEX idx_detalle_pedido_producto ON detalle_pedidos(pedido_id, producto_id);

-- Consulta optimizada de productos más vendidos
SELECT
    p.id,
    p.nombre,
    COUNT(dp.id) AS veces_vendido,
    SUM(dp.cantidad) AS unidades
FROM productos p
INNER JOIN detalle_pedidos dp ON p.id = dp.producto_id
GROUP BY p.id, p.nombre
HAVING unidades > 5
ORDER BY unidades DESC
LIMIT 10;


-- ==========================================
-- EJERCICIOS PRÁCTICOS
-- ==========================================

/*
EJERCICIO 1: Usa EXPLAIN para analizar esta consulta y propón
             cómo optimizarla:
             SELECT * FROM productos WHERE precio > 1000 AND categoria = 'Electrónica';

EJERCICIO 2: Crea índices apropiados para estas consultas frecuentes:
             a) Buscar clientes por email
             b) Listar productos activos por categoría
             c) Buscar pedidos de un cliente por fecha

EJERCICIO 3: Compara el rendimiento de estas dos consultas con EXPLAIN:
             - Clientes sin pedidos usando NOT IN
             - Clientes sin pedidos usando LEFT JOIN + IS NULL

EJERCICIO 4: Optimiza esta consulta:
             SELECT * FROM productos
             WHERE UPPER(nombre) LIKE '%LAPTOP%';

EJERCICIO 5: Crea un índice compuesto óptimo para:
             SELECT nombre, precio FROM productos
             WHERE categoria = 'Electrónica' AND activo = TRUE
             ORDER BY precio DESC;

EJERCICIO 6: Analiza el tamaño de todas las tablas de tu base de datos.

EJERCICIO 7: Encuentra y elimina índices duplicados o innecesarios.

EJERCICIO 8: Convierte esta consulta con subconsultas a JOINs:
             SELECT p.* FROM productos p
             WHERE p.id IN (SELECT producto_id FROM detalle_pedidos
                           WHERE pedido_id IN (SELECT id FROM pedidos
                                              WHERE cliente_id = 1));

EJERCICIO 9: Optimiza una consulta que calcule las ventas totales
             por mes del último año.

EJERCICIO 10: Ejecuta ANALYZE y OPTIMIZE en todas las tablas
              y documenta los resultados.
*/

-- Escribe tus soluciones aquí:
