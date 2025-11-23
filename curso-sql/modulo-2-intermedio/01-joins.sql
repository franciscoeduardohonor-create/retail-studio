-- ============================================
-- MÓDULO 2: SQL INTERMEDIO
-- LECCIÓN 1: JOINS - UNIR TABLAS
-- ============================================

USE tienda_online;

-- ==========================================
-- PREPARACIÓN: Insertar datos relacionados
-- ==========================================

-- Insertar pedidos de ejemplo
INSERT INTO pedidos (cliente_id, total, estado) VALUES
(1, 25999.99, 'Entregado'),
(1, 6499.99, 'Entregado'),
(2, 32998.00, 'Procesando'),
(3, 4599.50, 'Enviado'),
(4, 10497.00, 'Entregado'),
(5, 1599.00, 'Pendiente'),
(6, 8999.00, 'Procesando');

-- Insertar detalles de pedidos
INSERT INTO detalle_pedidos (pedido_id, producto_id, cantidad, precio_unitario) VALUES
-- Pedido 1 (Juan Pérez)
(1, 1, 1, 25999.99),  -- Laptop
-- Pedido 2 (Juan Pérez)
(2, 5, 1, 6499.99),   -- Audífonos Sony
-- Pedido 3 (María García)
(3, 2, 1, 28999.00),  -- iPhone
(3, 6, 2, 1899.00),   -- Teclado x2
-- Pedido 4 (Carlos López)
(4, 3, 1, 4599.50),   -- Escritorio
-- Pedido 5 (Ana Martínez)
(5, 7, 1, 1599.00),   -- Mouse Logitech
(5, 6, 1, 1899.00),   -- Teclado
(5, 9, 7, 899.00),    -- Webcam x7
-- Pedido 6 (Luis Rodríguez)
(6, 7, 1, 1599.00),   -- Mouse
-- Pedido 7 (Elena Fernández)
(7, 8, 1, 8999.00);   -- Monitor LG


-- ==========================================
-- 1. INNER JOIN - Intersección de tablas
-- ==========================================

/*
INNER JOIN devuelve solo los registros que tienen coincidencias
en AMBAS tablas.

Diagrama conceptual:
  Tabla A       Tabla B
    ○             ○
     ╲           ╱
      ╲         ╱
       ●●●●●●●  ← INNER JOIN (solo coincidencias)
      ╱         ╲
     ╱           ╲
*/

-- Ejemplo básico: Pedidos con información del cliente
SELECT
    pedidos.id AS pedido_id,
    clientes.nombre,
    clientes.apellido,
    pedidos.total,
    pedidos.estado
FROM pedidos
INNER JOIN clientes ON pedidos.cliente_id = clientes.id;

-- Usando alias de tabla (más limpio y corto)
SELECT
    p.id AS pedido_id,
    c.nombre,
    c.apellido,
    p.total,
    p.estado,
    p.fecha_pedido
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id;

-- INNER JOIN con múltiples tablas
-- Obtener detalles completos de cada línea de pedido
SELECT
    c.nombre AS cliente,
    c.apellido,
    p.id AS pedido_num,
    prod.nombre AS producto,
    dp.cantidad,
    dp.precio_unitario,
    (dp.cantidad * dp.precio_unitario) AS subtotal
FROM detalle_pedidos dp
INNER JOIN pedidos p ON dp.pedido_id = p.id
INNER JOIN clientes c ON p.cliente_id = c.id
INNER JOIN productos prod ON dp.producto_id = prod.id;

-- INNER JOIN con WHERE
-- Pedidos de un cliente específico
SELECT
    p.id AS pedido_id,
    c.nombre,
    c.apellido,
    p.total,
    p.estado
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id
WHERE c.nombre = 'Juan' AND c.apellido = 'Pérez';

-- INNER JOIN con ORDER BY
SELECT
    c.nombre,
    c.apellido,
    p.total,
    p.fecha_pedido
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id
ORDER BY p.total DESC;


-- ==========================================
-- 2. LEFT JOIN (LEFT OUTER JOIN)
-- ==========================================

/*
LEFT JOIN devuelve TODOS los registros de la tabla izquierda
y los coincidentes de la derecha. Si no hay coincidencia,
las columnas de la derecha serán NULL.

Diagrama conceptual:
  Tabla A       Tabla B
  ●●●●○           ○
     ╲           ╱
      ╲         ╱
       ●●●●●●●  ← Coincidencias
      ╱
  ●●●● ← Sin coincidencia (NULL en tabla B)
*/

-- Todos los clientes y sus pedidos (incluye clientes sin pedidos)
SELECT
    c.id,
    c.nombre,
    c.apellido,
    p.id AS pedido_id,
    p.total,
    p.estado
FROM clientes c
LEFT JOIN pedidos p ON c.cliente_id = p.cliente_id
ORDER BY c.id;

-- Encontrar clientes que NO han hecho pedidos
SELECT
    c.nombre,
    c.apellido,
    c.email
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
WHERE p.id IS NULL;

-- Todos los productos y cuántas veces se han vendido
SELECT
    prod.id,
    prod.nombre,
    prod.precio,
    COUNT(dp.id) AS veces_vendido,
    COALESCE(SUM(dp.cantidad), 0) AS unidades_vendidas
FROM productos prod
LEFT JOIN detalle_pedidos dp ON prod.id = dp.producto_id
GROUP BY prod.id, prod.nombre, prod.precio
ORDER BY unidades_vendidas DESC;


-- ==========================================
-- 3. RIGHT JOIN (RIGHT OUTER JOIN)
-- ==========================================

/*
RIGHT JOIN es lo opuesto a LEFT JOIN.
Devuelve TODOS los registros de la tabla derecha
y los coincidentes de la izquierda.

Nota: Raramente se usa porque puedes invertir el orden
y usar LEFT JOIN.
*/

-- Todos los pedidos y sus clientes
SELECT
    c.nombre,
    c.apellido,
    p.id AS pedido_id,
    p.total
FROM clientes c
RIGHT JOIN pedidos p ON c.id = p.cliente_id;

-- Esto es equivalente a:
SELECT
    c.nombre,
    c.apellido,
    p.id AS pedido_id,
    p.total
FROM pedidos p
LEFT JOIN clientes c ON p.cliente_id = c.id;


-- ==========================================
-- 4. FULL OUTER JOIN (Simulado en MySQL)
-- ==========================================

/*
MySQL no soporta FULL OUTER JOIN directamente,
pero se puede simular con UNION de LEFT y RIGHT JOIN.

FULL OUTER JOIN devuelve TODOS los registros de ambas tablas,
con NULL donde no hay coincidencias.
*/

-- Simular FULL OUTER JOIN
SELECT
    c.nombre,
    c.apellido,
    p.id AS pedido_id,
    p.total
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id

UNION

SELECT
    c.nombre,
    c.apellido,
    p.id AS pedido_id,
    p.total
FROM clientes c
RIGHT JOIN pedidos p ON c.id = p.cliente_id
WHERE c.id IS NULL;


-- ==========================================
-- 5. CROSS JOIN (Producto Cartesiano)
-- ==========================================

/*
CROSS JOIN combina cada fila de la primera tabla
con cada fila de la segunda tabla.
Si tabla A tiene 5 filas y tabla B tiene 3,
el resultado tendrá 15 filas (5 × 3).
*/

-- Crear tabla de tallas para ejemplo
CREATE TABLE IF NOT EXISTS tallas (
    id INT PRIMARY KEY,
    talla VARCHAR(10)
);

INSERT INTO tallas VALUES (1, 'S'), (2, 'M'), (3, 'L'), (4, 'XL');

-- Crear tabla de colores
CREATE TABLE IF NOT EXISTS colores (
    id INT PRIMARY KEY,
    color VARCHAR(20)
);

INSERT INTO colores VALUES (1, 'Rojo'), (2, 'Azul'), (3, 'Negro');

-- CROSS JOIN para obtener todas las combinaciones
SELECT
    t.talla,
    c.color
FROM tallas t
CROSS JOIN colores c
ORDER BY t.talla, c.color;

-- Resultado: 12 combinaciones (4 tallas × 3 colores)


-- ==========================================
-- 6. SELF JOIN - Unir tabla consigo misma
-- ==========================================

/*
SELF JOIN es útil para comparar filas dentro
de la misma tabla.
*/

-- Crear tabla de empleados con jerarquía
CREATE TABLE IF NOT EXISTS empleados_empresa (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    jefe_id INT,
    puesto VARCHAR(50)
);

INSERT INTO empleados_empresa VALUES
(1, 'Ana Directora', NULL, 'Director General'),
(2, 'Carlos Manager', 1, 'Gerente de Ventas'),
(3, 'Luis Vendedor', 2, 'Vendedor'),
(4, 'María Vendedora', 2, 'Vendedor'),
(5, 'Pedro Manager', 1, 'Gerente de IT'),
(6, 'Laura Desarrolladora', 5, 'Desarrollador');

-- SELF JOIN para ver empleados con sus jefes
SELECT
    e.nombre AS empleado,
    e.puesto AS puesto_empleado,
    j.nombre AS jefe,
    j.puesto AS puesto_jefe
FROM empleados_empresa e
LEFT JOIN empleados_empresa j ON e.jefe_id = j.id;

-- Encontrar empleados sin jefe (directores)
SELECT
    e.nombre,
    e.puesto
FROM empleados_empresa e
LEFT JOIN empleados_empresa j ON e.jefe_id = j.id
WHERE j.id IS NULL;


-- ==========================================
-- 7. MULTIPLE JOINS - Combinando varios JOINs
-- ==========================================

-- Reporte completo de ventas con toda la información
SELECT
    c.nombre AS cliente_nombre,
    c.apellido AS cliente_apellido,
    c.email,
    p.id AS pedido_numero,
    p.fecha_pedido,
    p.estado AS estado_pedido,
    prod.nombre AS producto,
    prod.categoria,
    dp.cantidad,
    dp.precio_unitario,
    (dp.cantidad * dp.precio_unitario) AS subtotal,
    p.total AS total_pedido
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id
INNER JOIN detalle_pedidos dp ON p.id = dp.pedido_id
INNER JOIN productos prod ON dp.producto_id = prod.id
ORDER BY p.fecha_pedido DESC, p.id, prod.nombre;


-- ==========================================
-- 8. JOINS con GROUP BY y Agregaciones
-- ==========================================

-- Total gastado por cada cliente
SELECT
    c.nombre,
    c.apellido,
    COUNT(p.id) AS total_pedidos,
    COALESCE(SUM(p.total), 0) AS total_gastado,
    COALESCE(AVG(p.total), 0) AS promedio_por_pedido
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre, c.apellido
ORDER BY total_gastado DESC;

-- Productos más vendidos
SELECT
    prod.nombre AS producto,
    prod.categoria,
    COUNT(dp.id) AS veces_pedido,
    SUM(dp.cantidad) AS unidades_vendidas,
    SUM(dp.cantidad * dp.precio_unitario) AS ingresos_generados
FROM productos prod
INNER JOIN detalle_pedidos dp ON prod.id = dp.producto_id
GROUP BY prod.id, prod.nombre, prod.categoria
ORDER BY unidades_vendidas DESC;

-- Ventas por categoría
SELECT
    prod.categoria,
    COUNT(DISTINCT p.id) AS total_pedidos,
    SUM(dp.cantidad) AS unidades_vendidas,
    SUM(dp.cantidad * dp.precio_unitario) AS ingresos
FROM productos prod
INNER JOIN detalle_pedidos dp ON prod.id = dp.producto_id
INNER JOIN pedidos p ON dp.pedido_id = p.id
GROUP BY prod.categoria
ORDER BY ingresos DESC;


-- ==========================================
-- 9. JOINS con condiciones complejas
-- ==========================================

-- Clientes que han gastado más de $10,000
SELECT
    c.nombre,
    c.apellido,
    SUM(p.total) AS total_gastado
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre, c.apellido
HAVING SUM(p.total) > 10000
ORDER BY total_gastado DESC;

-- Productos que se han vendido con otros productos en el mismo pedido
SELECT DISTINCT
    prod1.nombre AS producto_1,
    prod2.nombre AS producto_2,
    p.id AS pedido_num
FROM detalle_pedidos dp1
INNER JOIN detalle_pedidos dp2
    ON dp1.pedido_id = dp2.pedido_id
    AND dp1.producto_id < dp2.producto_id  -- Evitar duplicados
INNER JOIN productos prod1 ON dp1.producto_id = prod1.id
INNER JOIN productos prod2 ON dp2.producto_id = prod2.id
INNER JOIN pedidos p ON dp1.pedido_id = p.id
ORDER BY p.id;


-- ==========================================
-- 10. EJEMPLOS PRÁCTICOS DEL MUNDO REAL
-- ==========================================

-- Dashboard de ventas ejecutivo
SELECT
    DATE(p.fecha_pedido) AS fecha,
    COUNT(DISTINCT p.id) AS num_pedidos,
    COUNT(DISTINCT p.cliente_id) AS clientes_unicos,
    SUM(p.total) AS ingresos_dia,
    AVG(p.total) AS ticket_promedio
FROM pedidos p
GROUP BY DATE(p.fecha_pedido)
ORDER BY fecha DESC;

-- Clientes VIP (más de 2 pedidos y total > 15000)
SELECT
    c.id,
    CONCAT(c.nombre, ' ', c.apellido) AS cliente,
    c.email,
    COUNT(p.id) AS total_pedidos,
    SUM(p.total) AS total_gastado,
    MAX(p.fecha_pedido) AS ultimo_pedido
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre, c.apellido, c.email
HAVING COUNT(p.id) >= 2 AND SUM(p.total) > 15000
ORDER BY total_gastado DESC;

-- Inventario bajo con ventas recientes
SELECT
    prod.nombre,
    prod.stock AS stock_actual,
    COUNT(dp.id) AS veces_vendido_total,
    SUM(dp.cantidad) AS unidades_vendidas,
    ROUND(SUM(dp.cantidad) / COUNT(DISTINCT dp.pedido_id), 2) AS promedio_por_pedido
FROM productos prod
LEFT JOIN detalle_pedidos dp ON prod.id = dp.producto_id
WHERE prod.stock < 20 AND prod.activo = TRUE
GROUP BY prod.id, prod.nombre, prod.stock
HAVING veces_vendido_total > 0
ORDER BY stock_actual ASC;


-- ==========================================
-- EJERCICIOS PRÁCTICOS
-- ==========================================

/*
EJERCICIO 1: Lista todos los clientes con sus pedidos.
             Incluye clientes que no han hecho pedidos.
             Muestra: nombre completo, email, pedido_id, total, estado

EJERCICIO 2: Encuentra qué productos nunca se han vendido.
             Pista: LEFT JOIN y WHERE con IS NULL

EJERCICIO 3: Calcula el total de ingresos por cada categoría de producto.

EJERCICIO 4: Lista los 5 clientes que más han gastado.

EJERCICIO 5: Muestra todos los pedidos con el nombre completo del cliente
             y la cantidad total de productos en cada pedido.

EJERCICIO 6: Encuentra parejas de productos que se han comprado juntos
             (en el mismo pedido) más de una vez.

EJERCICIO 7: Lista todos los productos con su total de ventas,
             incluyendo productos con 0 ventas.

EJERCICIO 8: Calcula el ticket promedio (total promedio de pedido)
             por cliente, solo para clientes con más de 1 pedido.

EJERCICIO 9: Crea un reporte que muestre por cada pedido:
             - Número de pedido
             - Cliente
             - Fecha
             - Cantidad de productos diferentes
             - Total del pedido

EJERCICIO 10: Encuentra qué cliente ha comprado la mayor variedad
              de productos diferentes (no cantidad, sino variedad).
*/

-- Escribe tus soluciones aquí:
