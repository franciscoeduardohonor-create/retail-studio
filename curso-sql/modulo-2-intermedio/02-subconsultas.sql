-- ============================================
-- LECCIÓN 2: SUBCONSULTAS (SUBQUERYS)
-- ============================================

USE tienda_online;

/*
Una subconsulta es una consulta SQL dentro de otra consulta.
Se utilizan para realizar operaciones complejas que requieren
resultados intermedios.

Tipos de subconsultas:
1. En el WHERE (filtrar con resultados de otra consulta)
2. En el FROM (usar resultado como tabla temporal)
3. En el SELECT (calcular valores por registro)
4. Correlacionadas (dependen de la consulta externa)
*/


-- ==========================================
-- 1. SUBCONSULTAS EN WHERE
-- ==========================================

-- Ejemplo simple: Productos más caros que el promedio
SELECT nombre, precio
FROM productos
WHERE precio > (SELECT AVG(precio) FROM productos);

-- Desglose del ejemplo anterior:
-- 1. Primero se ejecuta: SELECT AVG(precio) FROM productos → resultado: 8000
-- 2. Luego se usa: WHERE precio > 8000

-- Productos de la misma categoría que el producto más caro
SELECT nombre, categoria, precio
FROM productos
WHERE categoria = (
    SELECT categoria
    FROM productos
    ORDER BY precio DESC
    LIMIT 1
);

-- Clientes que han hecho al menos un pedido
SELECT nombre, apellido, email
FROM clientes
WHERE id IN (
    SELECT DISTINCT cliente_id
    FROM pedidos
);

-- Clientes que NO han hecho ningún pedido
SELECT nombre, apellido, email
FROM clientes
WHERE id NOT IN (
    SELECT DISTINCT cliente_id
    FROM pedidos
);

-- Productos que nunca se han vendido
SELECT nombre, categoria, precio, stock
FROM productos
WHERE id NOT IN (
    SELECT DISTINCT producto_id
    FROM detalle_pedidos
);


-- ==========================================
-- 2. SUBCONSULTAS CON OPERADORES DE COMPARACIÓN
-- ==========================================

-- Productos más caros que TODOS los productos de categoría 'Accesorios'
SELECT nombre, categoria, precio
FROM productos
WHERE precio > ALL (
    SELECT precio
    FROM productos
    WHERE categoria = 'Accesorios'
);

-- Productos más baratos que ALGÚN producto de categoría 'Electrónica'
SELECT nombre, categoria, precio
FROM productos
WHERE precio < ANY (
    SELECT precio
    FROM productos
    WHERE categoria = 'Electrónica'
);

-- Clientes con pedidos mayores que el pedido promedio
SELECT
    c.nombre,
    c.apellido,
    p.total
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id
WHERE p.total > (SELECT AVG(total) FROM pedidos);


-- ==========================================
-- 3. SUBCONSULTAS EN FROM (Tablas derivadas)
-- ==========================================

-- Usar el resultado de una consulta como tabla temporal
SELECT
    categoria,
    AVG(precio) AS precio_promedio
FROM (
    SELECT *
    FROM productos
    WHERE activo = TRUE
) AS productos_activos
GROUP BY categoria;

-- Clientes con su total gastado (usando subconsulta en FROM)
SELECT
    c.nombre,
    c.apellido,
    COALESCE(totales.total_gastado, 0) AS total_gastado
FROM clientes c
LEFT JOIN (
    SELECT
        cliente_id,
        SUM(total) AS total_gastado
    FROM pedidos
    GROUP BY cliente_id
) AS totales ON c.id = totales.cliente_id
ORDER BY total_gastado DESC;

-- Top 3 categorías con más ingresos y sus productos
SELECT
    p.nombre,
    p.categoria,
    p.precio,
    tc.ingresos_categoria
FROM productos p
INNER JOIN (
    SELECT
        prod.categoria,
        SUM(dp.cantidad * dp.precio_unitario) AS ingresos_categoria
    FROM productos prod
    INNER JOIN detalle_pedidos dp ON prod.id = dp.producto_id
    GROUP BY prod.categoria
    ORDER BY ingresos_categoria DESC
    LIMIT 3
) AS tc ON p.categoria = tc.categoria
ORDER BY tc.ingresos_categoria DESC, p.precio DESC;


-- ==========================================
-- 4. SUBCONSULTAS EN SELECT
-- ==========================================

-- Cada producto con el precio promedio de su categoría
SELECT
    nombre,
    categoria,
    precio,
    (
        SELECT AVG(precio)
        FROM productos p2
        WHERE p2.categoria = p1.categoria
    ) AS precio_promedio_categoria,
    precio - (
        SELECT AVG(precio)
        FROM productos p2
        WHERE p2.categoria = p1.categoria
    ) AS diferencia_del_promedio
FROM productos p1
ORDER BY categoria, precio DESC;

-- Clientes con su número total de pedidos
SELECT
    c.nombre,
    c.apellido,
    c.email,
    (
        SELECT COUNT(*)
        FROM pedidos p
        WHERE p.cliente_id = c.id
    ) AS total_pedidos,
    (
        SELECT COALESCE(SUM(total), 0)
        FROM pedidos p
        WHERE p.cliente_id = c.id
    ) AS total_gastado
FROM clientes c
ORDER BY total_gastado DESC;


-- ==========================================
-- 5. SUBCONSULTAS CORRELACIONADAS
-- ==========================================

/*
Una subconsulta correlacionada es aquella que hace referencia
a columnas de la consulta externa. Se ejecuta una vez por
cada fila de la consulta externa.
*/

-- Productos con precio mayor al promedio de su categoría
SELECT
    p1.nombre,
    p1.categoria,
    p1.precio,
    (
        SELECT AVG(p2.precio)
        FROM productos p2
        WHERE p2.categoria = p1.categoria
    ) AS promedio_categoria
FROM productos p1
WHERE p1.precio > (
    SELECT AVG(p2.precio)
    FROM productos p2
    WHERE p2.categoria = p1.categoria
);

-- Última compra de cada cliente
SELECT
    c.nombre,
    c.apellido,
    (
        SELECT p.fecha_pedido
        FROM pedidos p
        WHERE p.cliente_id = c.id
        ORDER BY p.fecha_pedido DESC
        LIMIT 1
    ) AS ultima_compra,
    (
        SELECT p.total
        FROM pedidos p
        WHERE p.cliente_id = c.id
        ORDER BY p.fecha_pedido DESC
        LIMIT 1
    ) AS monto_ultima_compra
FROM clientes c
WHERE EXISTS (
    SELECT 1
    FROM pedidos p
    WHERE p.cliente_id = c.id
);


-- ==========================================
-- 6. EXISTS y NOT EXISTS
-- ==========================================

/*
EXISTS devuelve TRUE si la subconsulta retorna al menos una fila.
Es más eficiente que IN cuando se trabaja con grandes volúmenes.
*/

-- Clientes que han hecho al menos un pedido (usando EXISTS)
SELECT nombre, apellido, email
FROM clientes c
WHERE EXISTS (
    SELECT 1
    FROM pedidos p
    WHERE p.cliente_id = c.id
);

-- Clientes que NO han hecho ningún pedido
SELECT nombre, apellido, email
FROM clientes c
WHERE NOT EXISTS (
    SELECT 1
    FROM pedidos p
    WHERE p.cliente_id = c.id
);

-- Productos que se han vendido
SELECT nombre, categoria, precio
FROM productos prod
WHERE EXISTS (
    SELECT 1
    FROM detalle_pedidos dp
    WHERE dp.producto_id = prod.id
);

-- Categorías que tienen al menos un producto con stock bajo
SELECT DISTINCT categoria
FROM productos p1
WHERE EXISTS (
    SELECT 1
    FROM productos p2
    WHERE p2.categoria = p1.categoria
      AND p2.stock < 10
);


-- ==========================================
-- 7. SUBCONSULTAS CON INSERT
-- ==========================================

-- Crear tabla de resumen de clientes
CREATE TABLE IF NOT EXISTS resumen_clientes (
    cliente_id INT PRIMARY KEY,
    nombre_completo VARCHAR(200),
    total_pedidos INT,
    total_gastado DECIMAL(10, 2),
    promedio_pedido DECIMAL(10, 2),
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insertar datos usando subconsulta
INSERT INTO resumen_clientes (cliente_id, nombre_completo, total_pedidos, total_gastado, promedio_pedido)
SELECT
    c.id,
    CONCAT(c.nombre, ' ', c.apellido),
    COUNT(p.id),
    COALESCE(SUM(p.total), 0),
    COALESCE(AVG(p.total), 0)
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre, c.apellido;

-- Ver resultado
SELECT * FROM resumen_clientes;


-- ==========================================
-- 8. SUBCONSULTAS CON UPDATE
-- ==========================================

-- Actualizar el stock de productos según las ventas
-- (Ejemplo simulado - en realidad se haría al vender)

-- Crear columna temporal para el ejemplo
ALTER TABLE productos ADD COLUMN IF NOT EXISTS total_vendido INT DEFAULT 0;

-- Actualizar con subconsulta
UPDATE productos p
SET total_vendido = (
    SELECT COALESCE(SUM(dp.cantidad), 0)
    FROM detalle_pedidos dp
    WHERE dp.producto_id = p.id
);

-- Ver resultado
SELECT nombre, stock, total_vendido FROM productos;

-- Marcar clientes VIP (más de 20000 gastados)
ALTER TABLE clientes ADD COLUMN IF NOT EXISTS es_vip BOOLEAN DEFAULT FALSE;

UPDATE clientes c
SET es_vip = TRUE
WHERE (
    SELECT COALESCE(SUM(total), 0)
    FROM pedidos p
    WHERE p.cliente_id = c.id
) > 20000;

-- Ver clientes VIP
SELECT nombre, apellido, es_vip FROM clientes WHERE es_vip = TRUE;


-- ==========================================
-- 9. SUBCONSULTAS CON DELETE
-- ==========================================

-- Eliminar productos que nunca se han vendido y tienen stock 0
DELETE FROM productos
WHERE stock = 0
  AND id NOT IN (
    SELECT DISTINCT producto_id
    FROM detalle_pedidos
);


-- ==========================================
-- 10. SUBCONSULTAS ANIDADAS (Múltiples niveles)
-- ==========================================

-- Productos de la categoría del producto más vendido
SELECT nombre, categoria, precio
FROM productos
WHERE categoria = (
    -- Categoría del producto más vendido
    SELECT categoria
    FROM productos
    WHERE id = (
        -- ID del producto más vendido
        SELECT producto_id
        FROM detalle_pedidos
        GROUP BY producto_id
        ORDER BY SUM(cantidad) DESC
        LIMIT 1
    )
);

-- Clientes que han comprado productos de la categoría más cara
SELECT DISTINCT c.nombre, c.apellido
FROM clientes c
WHERE c.id IN (
    SELECT DISTINCT p.cliente_id
    FROM pedidos p
    WHERE p.id IN (
        SELECT dp.pedido_id
        FROM detalle_pedidos dp
        WHERE dp.producto_id IN (
            SELECT prod.id
            FROM productos prod
            WHERE prod.categoria = (
                SELECT categoria
                FROM productos
                GROUP BY categoria
                ORDER BY AVG(precio) DESC
                LIMIT 1
            )
        )
    )
);


-- ==========================================
-- 11. WITH (CTE - Common Table Expressions)
-- ==========================================

/*
Los CTEs (Common Table Expressions) son subconsultas nombradas
que hacen el código más legible. Se definen con WITH.
*/

-- Ejemplo básico de CTE
WITH productos_electronicos AS (
    SELECT *
    FROM productos
    WHERE categoria = 'Electrónica' AND activo = TRUE
)
SELECT nombre, precio, stock
FROM productos_electronicos
WHERE precio > 5000;

-- CTE múltiples
WITH
ventas_por_producto AS (
    SELECT
        producto_id,
        SUM(cantidad) AS total_vendido,
        SUM(cantidad * precio_unitario) AS ingresos
    FROM detalle_pedidos
    GROUP BY producto_id
),
productos_populares AS (
    SELECT producto_id
    FROM ventas_por_producto
    WHERE total_vendido > 2
)
SELECT
    p.nombre,
    p.categoria,
    p.precio,
    v.total_vendido,
    v.ingresos
FROM productos p
INNER JOIN ventas_por_producto v ON p.id = v.producto_id
WHERE p.id IN (SELECT producto_id FROM productos_populares)
ORDER BY v.ingresos DESC;

-- CTE recursivo (ejemplo: jerarquía de empleados)
WITH RECURSIVE jerarquia AS (
    -- Caso base: empleados sin jefe
    SELECT id, nombre, jefe_id, puesto, 0 AS nivel
    FROM empleados_empresa
    WHERE jefe_id IS NULL

    UNION ALL

    -- Caso recursivo: empleados con jefe
    SELECT e.id, e.nombre, e.jefe_id, e.puesto, j.nivel + 1
    FROM empleados_empresa e
    INNER JOIN jerarquia j ON e.jefe_id = j.id
)
SELECT
    REPEAT('  ', nivel) AS indentacion,
    nombre,
    puesto,
    nivel
FROM jerarquia
ORDER BY nivel, nombre;


-- ==========================================
-- 12. EJEMPLOS PRÁCTICOS COMPLEJOS
-- ==========================================

-- Análisis de segmentación de clientes
WITH estadisticas_cliente AS (
    SELECT
        c.id,
        c.nombre,
        c.apellido,
        COUNT(p.id) AS num_pedidos,
        COALESCE(SUM(p.total), 0) AS total_gastado,
        COALESCE(AVG(p.total), 0) AS ticket_promedio
    FROM clientes c
    LEFT JOIN pedidos p ON c.id = p.cliente_id
    GROUP BY c.id, c.nombre, c.apellido
)
SELECT
    nombre,
    apellido,
    num_pedidos,
    total_gastado,
    ticket_promedio,
    CASE
        WHEN num_pedidos = 0 THEN 'Sin compras'
        WHEN total_gastado > 25000 THEN 'VIP'
        WHEN total_gastado > 10000 THEN 'Premium'
        WHEN num_pedidos > 2 THEN 'Frecuente'
        ELSE 'Regular'
    END AS segmento
FROM estadisticas_cliente
ORDER BY total_gastado DESC;

-- Productos recomendados (comprados juntos)
WITH combinaciones_productos AS (
    SELECT
        dp1.producto_id AS producto_1,
        dp2.producto_id AS producto_2,
        COUNT(*) AS veces_juntos
    FROM detalle_pedidos dp1
    INNER JOIN detalle_pedidos dp2
        ON dp1.pedido_id = dp2.pedido_id
        AND dp1.producto_id < dp2.producto_id
    GROUP BY dp1.producto_id, dp2.producto_id
    HAVING COUNT(*) >= 2
)
SELECT
    p1.nombre AS producto,
    p2.nombre AS frecuentemente_comprado_con,
    cp.veces_juntos AS veces
FROM combinaciones_productos cp
INNER JOIN productos p1 ON cp.producto_1 = p1.id
INNER JOIN productos p2 ON cp.producto_2 = p2.id
ORDER BY cp.veces_juntos DESC, p1.nombre;


-- ==========================================
-- EJERCICIOS PRÁCTICOS
-- ==========================================

/*
EJERCICIO 1: Encuentra productos con precio mayor al promedio
             de TODOS los productos.

EJERCICIO 2: Lista clientes que han gastado más que el cliente promedio.

EJERCICIO 3: Encuentra la categoría de productos más vendida
             (por cantidad de unidades) y lista todos sus productos.

EJERCICIO 4: Usando una subconsulta en SELECT, muestra cada producto
             con el número total de veces que se ha vendido.

EJERCICIO 5: Encuentra productos que están por encima del precio
             promedio de su categoría.

EJERCICIO 6: Lista clientes que han hecho más pedidos que el promedio
             de pedidos por cliente.

EJERCICIO 7: Usando EXISTS, encuentra categorías que tienen al menos
             un producto con precio mayor a 10000.

EJERCICIO 8: Crea un CTE que calcule las ventas totales por producto,
             luego úsalo para encontrar productos con ventas mayores
             al promedio de ventas.

EJERCICIO 9: Encuentra el segundo producto más vendido
             (por cantidad de unidades).

EJERCICIO 10: Lista clientes que han comprado todos los productos
              de la categoría 'Accesorios'. (Pista: División relacional,
              usa subconsultas correlacionadas)
*/

-- Escribe tus soluciones aquí:
