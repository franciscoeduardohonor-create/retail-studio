-- ============================================
-- LECCIÓN 3: FUNCIONES Y GROUP BY
-- ============================================

USE tienda_online;

-- ==========================================
-- 1. FUNCIONES DE AGREGACIÓN
-- ==========================================

/*
Las funciones de agregación operan sobre conjuntos
de filas y devuelven un solo valor.
*/

-- COUNT: Contar registros
SELECT COUNT(*) AS total_productos FROM productos;
SELECT COUNT(DISTINCT categoria) AS categorias_unicas FROM productos;
SELECT COUNT(telefono) AS clientes_con_telefono FROM clientes;  -- No cuenta NULL

-- SUM: Sumar valores
SELECT SUM(stock) AS inventario_total FROM productos;
SELECT SUM(precio * stock) AS valor_inventario FROM productos;

-- AVG: Promedio
SELECT AVG(precio) AS precio_promedio FROM productos;
SELECT AVG(total) AS ticket_promedio FROM pedidos;

-- MIN y MAX: Valores mínimo y máximo
SELECT MIN(precio) AS producto_mas_barato FROM productos;
SELECT MAX(precio) AS producto_mas_caro FROM productos;
SELECT MIN(fecha_registro) AS primer_cliente FROM clientes;

-- Combinando varias agregaciones
SELECT
    COUNT(*) AS total_productos,
    SUM(stock) AS stock_total,
    AVG(precio) AS precio_promedio,
    MIN(precio) AS precio_minimo,
    MAX(precio) AS precio_maximo,
    SUM(precio * stock) AS valor_total_inventario
FROM productos
WHERE activo = TRUE;


-- ==========================================
-- 2. GROUP BY - Agrupar datos
-- ==========================================

/*
GROUP BY agrupa filas que tienen valores iguales
en columnas específicas.
*/

-- Contar productos por categoría
SELECT
    categoria,
    COUNT(*) AS total_productos
FROM productos
GROUP BY categoria;

-- Estadísticas de precio por categoría
SELECT
    categoria,
    COUNT(*) AS num_productos,
    AVG(precio) AS precio_promedio,
    MIN(precio) AS precio_min,
    MAX(precio) AS precio_max,
    SUM(stock) AS stock_total
FROM productos
GROUP BY categoria
ORDER BY precio_promedio DESC;

-- Ventas por cliente
SELECT
    cliente_id,
    COUNT(*) AS num_pedidos,
    SUM(total) AS total_gastado,
    AVG(total) AS ticket_promedio,
    MIN(total) AS compra_minima,
    MAX(total) AS compra_maxima
FROM pedidos
GROUP BY cliente_id
ORDER BY total_gastado DESC;

-- Agrupar por múltiples columnas
SELECT
    categoria,
    activo,
    COUNT(*) AS cantidad,
    AVG(precio) AS precio_promedio
FROM productos
GROUP BY categoria, activo
ORDER BY categoria, activo;


-- ==========================================
-- 3. HAVING - Filtrar grupos
-- ==========================================

/*
HAVING es como WHERE pero para grupos.
WHERE filtra filas, HAVING filtra grupos.
*/

-- Categorías con más de 2 productos
SELECT
    categoria,
    COUNT(*) AS num_productos
FROM productos
GROUP BY categoria
HAVING COUNT(*) > 2;

-- Clientes que han gastado más de 10000
SELECT
    c.nombre,
    c.apellido,
    COUNT(p.id) AS num_pedidos,
    SUM(p.total) AS total_gastado
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre, c.apellido
HAVING SUM(p.total) > 10000
ORDER BY total_gastado DESC;

-- Productos con precio promedio mayor a 5000 por categoría
SELECT
    categoria,
    COUNT(*) AS productos,
    AVG(precio) AS precio_promedio
FROM productos
WHERE activo = TRUE
GROUP BY categoria
HAVING AVG(precio) > 5000;

-- Diferencia entre WHERE y HAVING
-- WHERE se ejecuta ANTES de agrupar
-- HAVING se ejecuta DESPUÉS de agrupar

SELECT
    categoria,
    COUNT(*) AS productos_activos,
    AVG(precio) AS precio_promedio
FROM productos
WHERE activo = TRUE          -- Filtrar ANTES de agrupar
GROUP BY categoria
HAVING COUNT(*) > 1          -- Filtrar DESPUÉS de agrupar
ORDER BY precio_promedio DESC;


-- ==========================================
-- 4. FUNCIONES DE CADENAS (STRING)
-- ==========================================

-- CONCAT: Concatenar cadenas
SELECT
    CONCAT(nombre, ' ', apellido) AS nombre_completo,
    email
FROM clientes;

-- CONCAT_WS: Concatenar con separador
SELECT
    CONCAT_WS(' - ', nombre, categoria, CONCAT('$', precio)) AS descripcion
FROM productos;

-- UPPER y LOWER: Mayúsculas y minúsculas
SELECT
    UPPER(nombre) AS nombre_mayusculas,
    LOWER(email) AS email_minusculas
FROM clientes;

-- LENGTH: Longitud de la cadena
SELECT
    nombre,
    LENGTH(nombre) AS caracteres
FROM productos
ORDER BY caracteres DESC;

-- SUBSTRING: Extraer parte de una cadena
SELECT
    nombre,
    SUBSTRING(nombre, 1, 10) AS primeros_10_chars
FROM productos;

-- LEFT y RIGHT: Caracteres desde la izquierda/derecha
SELECT
    email,
    LEFT(email, 5) AS primeros_5,
    RIGHT(email, 8) AS ultimos_8
FROM clientes;

-- REPLACE: Reemplazar texto
SELECT
    nombre,
    REPLACE(nombre, 'RGB', 'Multicolor') AS nombre_modificado
FROM productos;

-- TRIM, LTRIM, RTRIM: Eliminar espacios
SELECT
    TRIM('  espacios  ') AS sin_espacios,
    LTRIM('  izquierda') AS sin_izq,
    RTRIM('derecha  ') AS sin_der;

-- LOCATE: Encontrar posición de subcadena
SELECT
    email,
    LOCATE('@', email) AS posicion_arroba
FROM clientes;

-- SUBSTRING_INDEX: Extraer hasta un delimitador
SELECT
    email,
    SUBSTRING_INDEX(email, '@', 1) AS usuario,
    SUBSTRING_INDEX(email, '@', -1) AS dominio
FROM clientes;


-- ==========================================
-- 5. FUNCIONES NUMÉRICAS
-- ==========================================

-- ROUND: Redondear
SELECT
    nombre,
    precio,
    ROUND(precio, 0) AS precio_redondeado,
    ROUND(precio, 1) AS un_decimal
FROM productos;

-- CEIL y FLOOR: Redondeo hacia arriba/abajo
SELECT
    nombre,
    precio,
    CEIL(precio) AS redondeo_arriba,
    FLOOR(precio) AS redondeo_abajo
FROM productos;

-- ABS: Valor absoluto
SELECT ABS(-100) AS valor_absoluto;

-- POWER: Potencia
SELECT
    nombre,
    precio,
    POWER(precio, 2) AS precio_al_cuadrado
FROM productos
LIMIT 3;

-- SQRT: Raíz cuadrada
SELECT SQRT(144) AS raiz_cuadrada;

-- MOD: Módulo (resto de división)
SELECT
    id,
    nombre,
    MOD(id, 2) AS es_par_o_impar  -- 0 = par, 1 = impar
FROM productos
LIMIT 10;

-- RAND: Número aleatorio
SELECT
    nombre,
    precio
FROM productos
ORDER BY RAND()  -- Ordenar aleatoriamente
LIMIT 5;


-- ==========================================
-- 6. FUNCIONES DE FECHA Y HORA
-- ==========================================

-- Fecha y hora actual
SELECT
    NOW() AS fecha_hora_actual,
    CURDATE() AS fecha_actual,
    CURTIME() AS hora_actual;

-- YEAR, MONTH, DAY: Extraer partes de fecha
SELECT
    nombre,
    fecha_registro,
    YEAR(fecha_registro) AS año,
    MONTH(fecha_registro) AS mes,
    DAY(fecha_registro) AS dia,
    DAYNAME(fecha_registro) AS dia_semana
FROM clientes;

-- DATE_FORMAT: Formatear fechas
SELECT
    nombre,
    DATE_FORMAT(fecha_registro, '%d/%m/%Y') AS fecha_formato_1,
    DATE_FORMAT(fecha_registro, '%W, %M %d, %Y') AS fecha_formato_2,
    DATE_FORMAT(fecha_registro, '%d-%b-%Y %H:%i') AS fecha_formato_3
FROM clientes;

-- DATEDIFF: Diferencia entre fechas en días
SELECT
    nombre,
    fecha_registro,
    DATEDIFF(NOW(), fecha_registro) AS dias_registrado
FROM clientes;

-- DATE_ADD y DATE_SUB: Sumar/restar tiempo
SELECT
    nombre,
    fecha_registro,
    DATE_ADD(fecha_registro, INTERVAL 30 DAY) AS mas_30_dias,
    DATE_SUB(fecha_registro, INTERVAL 1 YEAR) AS menos_1_año
FROM clientes;

-- TIMESTAMPDIFF: Diferencia entre fechas en unidades específicas
SELECT
    nombre,
    fecha_registro,
    TIMESTAMPDIFF(DAY, fecha_registro, NOW()) AS dias,
    TIMESTAMPDIFF(MONTH, fecha_registro, NOW()) AS meses,
    TIMESTAMPDIFF(YEAR, fecha_registro, NOW()) AS años
FROM clientes;

-- Extraer información de fechas
SELECT
    QUARTER(NOW()) AS trimestre_actual,
    WEEK(NOW()) AS semana_del_año,
    DAYOFYEAR(NOW()) AS dia_del_año,
    DAYOFWEEK(NOW()) AS dia_semana_numero;  -- 1=Domingo, 7=Sábado


-- ==========================================
-- 7. FUNCIONES CONDICIONALES
-- ==========================================

-- IF: Condicional simple
SELECT
    nombre,
    stock,
    IF(stock > 20, 'Stock Alto', 'Stock Bajo') AS nivel_stock
FROM productos;

-- CASE: Condicional múltiple
SELECT
    nombre,
    precio,
    CASE
        WHEN precio < 1000 THEN 'Económico'
        WHEN precio < 5000 THEN 'Medio'
        WHEN precio < 15000 THEN 'Alto'
        ELSE 'Premium'
    END AS rango_precio
FROM productos;

-- CASE con múltiples condiciones
SELECT
    nombre,
    stock,
    activo,
    CASE
        WHEN NOT activo THEN 'Descontinuado'
        WHEN stock = 0 THEN 'Agotado'
        WHEN stock < 10 THEN 'Stock Crítico'
        WHEN stock < 20 THEN 'Stock Bajo'
        ELSE 'Disponible'
    END AS estado
FROM productos;

-- IFNULL y COALESCE: Manejar valores NULL
SELECT
    nombre,
    telefono,
    IFNULL(telefono, 'Sin teléfono') AS telefono_mostrar,
    COALESCE(telefono, email, 'Sin contacto') AS contacto
FROM clientes;

-- NULLIF: Devuelve NULL si dos valores son iguales
SELECT
    NULLIF(10, 10) AS resultado1,  -- NULL
    NULLIF(10, 5) AS resultado2;   -- 10


-- ==========================================
-- 8. FUNCIONES DE CONVERSIÓN
-- ==========================================

-- CAST y CONVERT: Convertir tipos de datos
SELECT
    CAST('123' AS SIGNED) AS texto_a_numero,
    CAST(123.45 AS CHAR) AS numero_a_texto,
    CONVERT('2024-01-15', DATE) AS texto_a_fecha;

-- FORMAT: Formatear números
SELECT
    nombre,
    precio,
    FORMAT(precio, 2) AS precio_formateado,  -- 2 decimales con comas
    CONCAT('$', FORMAT(precio, 2)) AS precio_moneda
FROM productos;


-- ==========================================
-- 9. FUNCIONES DE VENTANA (WINDOW FUNCTIONS)
-- ==========================================

/*
Las funciones de ventana permiten realizar cálculos
a través de filas relacionadas sin colapsar los resultados
como hace GROUP BY.
*/

-- ROW_NUMBER: Numerar filas
SELECT
    nombre,
    categoria,
    precio,
    ROW_NUMBER() OVER (ORDER BY precio DESC) AS ranking_precio
FROM productos;

-- RANK y DENSE_RANK: Ranking con empates
SELECT
    nombre,
    precio,
    RANK() OVER (ORDER BY precio DESC) AS rank,
    DENSE_RANK() OVER (ORDER BY precio DESC) AS dense_rank
FROM productos;

-- PARTITION BY: Ranking por grupo
SELECT
    nombre,
    categoria,
    precio,
    ROW_NUMBER() OVER (PARTITION BY categoria ORDER BY precio DESC) AS rank_en_categoria
FROM productos;

-- Funciones de agregación como funciones de ventana
SELECT
    nombre,
    categoria,
    precio,
    AVG(precio) OVER (PARTITION BY categoria) AS promedio_categoria,
    precio - AVG(precio) OVER (PARTITION BY categoria) AS diferencia_promedio
FROM productos;

-- LEAD y LAG: Acceder a filas siguientes/anteriores
SELECT
    nombre,
    precio,
    LAG(precio, 1) OVER (ORDER BY precio) AS precio_anterior,
    LEAD(precio, 1) OVER (ORDER BY precio) AS precio_siguiente,
    precio - LAG(precio, 1) OVER (ORDER BY precio) AS diferencia
FROM productos;


-- ==========================================
-- 10. EJEMPLOS PRÁCTICOS COMPLETOS
-- ==========================================

-- Dashboard de ventas por mes
SELECT
    DATE_FORMAT(fecha_pedido, '%Y-%m') AS mes,
    COUNT(*) AS num_pedidos,
    COUNT(DISTINCT cliente_id) AS clientes_unicos,
    SUM(total) AS ingresos,
    AVG(total) AS ticket_promedio,
    MIN(total) AS pedido_minimo,
    MAX(total) AS pedido_maximo
FROM pedidos
GROUP BY DATE_FORMAT(fecha_pedido, '%Y-%m')
ORDER BY mes DESC;

-- Análisis de inventario
SELECT
    categoria,
    COUNT(*) AS productos,
    SUM(stock) AS unidades_total,
    SUM(precio * stock) AS valor_inventario,
    AVG(precio) AS precio_promedio,
    CONCAT('$', FORMAT(AVG(precio), 2)) AS precio_promedio_fmt,
    SUM(CASE WHEN stock < 10 THEN 1 ELSE 0 END) AS con_stock_bajo,
    ROUND(100.0 * SUM(CASE WHEN stock < 10 THEN 1 ELSE 0 END) / COUNT(*), 1) AS porc_stock_bajo
FROM productos
WHERE activo = TRUE
GROUP BY categoria
ORDER BY valor_inventario DESC;

-- Top clientes con segmentación
SELECT
    CONCAT(c.nombre, ' ', c.apellido) AS cliente,
    COUNT(p.id) AS pedidos,
    SUM(p.total) AS total_gastado,
    AVG(p.total) AS ticket_promedio,
    MAX(p.fecha_pedido) AS ultima_compra,
    DATEDIFF(NOW(), MAX(p.fecha_pedido)) AS dias_sin_comprar,
    CASE
        WHEN SUM(p.total) > 30000 THEN 'VIP'
        WHEN SUM(p.total) > 15000 THEN 'Premium'
        WHEN COUNT(p.id) > 2 THEN 'Frecuente'
        ELSE 'Regular'
    END AS segmento,
    CASE
        WHEN DATEDIFF(NOW(), MAX(p.fecha_pedido)) > 90 THEN 'En riesgo'
        WHEN DATEDIFF(NOW(), MAX(p.fecha_pedido)) > 30 THEN 'Atención'
        ELSE 'Activo'
    END AS estado_recencia
FROM clientes c
INNER JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre, c.apellido
ORDER BY total_gastado DESC;

-- Reporte de productos best sellers
SELECT
    prod.nombre,
    prod.categoria,
    CONCAT('$', FORMAT(prod.precio, 2)) AS precio,
    prod.stock,
    COUNT(dp.id) AS veces_vendido,
    SUM(dp.cantidad) AS unidades_vendidas,
    SUM(dp.cantidad * dp.precio_unitario) AS ingresos_generados,
    RANK() OVER (ORDER BY SUM(dp.cantidad) DESC) AS ranking_ventas,
    RANK() OVER (PARTITION BY prod.categoria ORDER BY SUM(dp.cantidad) DESC) AS ranking_en_categoria
FROM productos prod
LEFT JOIN detalle_pedidos dp ON prod.id = dp.producto_id
GROUP BY prod.id, prod.nombre, prod.categoria, prod.precio, prod.stock
ORDER BY unidades_vendidas DESC;


-- ==========================================
-- EJERCICIOS PRÁCTICOS
-- ==========================================

/*
EJERCICIO 1: Calcula el total de stock y valor de inventario
             por cada categoría.

EJERCICIO 2: Encuentra cuántos clientes se registraron por mes.
             Muestra: mes, año, cantidad de clientes.

EJERCICIO 3: Lista productos con su precio y la diferencia
             con respecto al precio promedio de su categoría.

EJERCICIO 4: Cuenta cuántos pedidos hay en cada estado
             (Pendiente, Procesando, Enviado, Entregado).

EJERCICIO 5: Crea un reporte de clientes mostrando:
             - Nombre completo (en mayúsculas)
             - Email (dominio solamente)
             - Días desde el registro

EJERCICIO 6: Encuentra la categoría con mayor valor total de inventario.

EJERCICIO 7: Lista productos con un campo que indique si su precio
             está por encima o debajo del promedio general.

EJERCICIO 8: Calcula las ventas totales por día de la semana
             (Lunes, Martes, etc.).

EJERCICIO 9: Crea un ranking de productos por ventas,
             mostrando el top 5 de cada categoría.

EJERCICIO 10: Genera un reporte mensual de ventas que incluya:
              - Mes/Año
              - Total de ventas
              - Crecimiento vs mes anterior (usa LAG)
*/

-- Escribe tus soluciones aquí:
