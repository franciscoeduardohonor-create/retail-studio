-- ============================================
-- LECCIÓN 3: SELECT - CONSULTAS BÁSICAS
-- ============================================

-- Primero, asegurarnos de estar en la base de datos correcta
USE tienda_online;

-- ==========================================
-- PREPARACIÓN: Insertar datos de ejemplo
-- ==========================================

-- Insertar clientes de ejemplo
INSERT INTO clientes (nombre, apellido, email, telefono) VALUES
('Juan', 'Pérez', 'juan.perez@email.com', '5551234567'),
('María', 'García', 'maria.garcia@email.com', '5552345678'),
('Carlos', 'López', 'carlos.lopez@email.com', '5553456789'),
('Ana', 'Martínez', 'ana.martinez@email.com', '5554567890'),
('Luis', 'Rodríguez', 'luis.rodriguez@email.com', '5555678901'),
('Elena', 'Fernández', 'elena.fernandez@email.com', '5556789012'),
('Pedro', 'Sánchez', 'pedro.sanchez@email.com', '5557890123'),
('Laura', 'Ramírez', 'laura.ramirez@email.com', '5558901234');

-- Insertar productos de ejemplo
INSERT INTO productos (nombre, descripcion, precio, stock, categoria, activo) VALUES
('Laptop Dell XPS 13', 'Laptop ultradelgada con procesador Intel i7', 25999.99, 15, 'Electrónica', TRUE),
('iPhone 14 Pro', 'Smartphone Apple última generación', 28999.00, 25, 'Electrónica', TRUE),
('Escritorio Ergonómico', 'Escritorio ajustable en altura', 4599.50, 10, 'Muebles', TRUE),
('Silla Gamer RGB', 'Silla ergonómica con iluminación', 3299.00, 8, 'Muebles', TRUE),
('Audífonos Sony WH-1000XM5', 'Audífonos con cancelación de ruido', 6499.99, 20, 'Electrónica', TRUE),
('Teclado Mecánico RGB', 'Teclado gamer switches cherry', 1899.00, 30, 'Accesorios', TRUE),
('Mouse Logitech MX Master', 'Mouse inalámbrico profesional', 1599.00, 35, 'Accesorios', TRUE),
('Monitor LG 27" 4K', 'Monitor ultraHD para diseño', 8999.00, 12, 'Electrónica', TRUE),
('Webcam HD 1080p', 'Cámara web para videollamadas', 899.00, 50, 'Accesorios', TRUE),
('Lámpara LED Escritorio', 'Iluminación ajustable', 599.00, 40, 'Accesorios', FALSE);


-- ==========================================
-- 1. SELECT - SELECCIONAR DATOS
-- ==========================================

-- Seleccionar TODAS las columnas de TODOS los registros
SELECT * FROM clientes;

-- Seleccionar columnas específicas
SELECT nombre, apellido, email FROM clientes;

-- Seleccionar con alias (renombrar columnas en el resultado)
SELECT
    nombre AS primer_nombre,
    apellido AS apellido_paterno,
    email AS correo_electronico
FROM clientes;

-- Concatenar campos
SELECT
    CONCAT(nombre, ' ', apellido) AS nombre_completo,
    email
FROM clientes;


-- ==========================================
-- 2. WHERE - FILTRAR RESULTADOS
-- ==========================================

-- Filtrar por un valor específico
SELECT * FROM productos
WHERE categoria = 'Electrónica';

-- Filtrar por precio
SELECT nombre, precio FROM productos
WHERE precio > 5000;

-- Filtrar por múltiples condiciones con AND
SELECT nombre, precio, stock FROM productos
WHERE precio > 1000 AND stock > 20;

-- Filtrar con OR
SELECT nombre, precio, categoria FROM productos
WHERE categoria = 'Electrónica' OR categoria = 'Accesorios';

-- Filtrar con NOT
SELECT nombre, precio FROM productos
WHERE NOT categoria = 'Muebles';

-- Filtrar por rango de valores con BETWEEN
SELECT nombre, precio FROM productos
WHERE precio BETWEEN 1000 AND 5000;

-- Filtrar por lista de valores con IN
SELECT nombre, categoria FROM productos
WHERE categoria IN ('Electrónica', 'Accesorios');

-- Filtrar valores NULL
SELECT nombre, telefono FROM clientes
WHERE telefono IS NULL;

-- Filtrar valores NO NULL
SELECT nombre, telefono FROM clientes
WHERE telefono IS NOT NULL;


-- ==========================================
-- 3. LIKE - BÚSQUEDA DE PATRONES
-- ==========================================

-- Buscar clientes cuyo nombre empieza con 'M'
-- % = cualquier cantidad de caracteres
SELECT nombre, apellido FROM clientes
WHERE nombre LIKE 'M%';

-- Buscar clientes cuyo apellido termina con 'ez'
SELECT nombre, apellido FROM clientes
WHERE apellido LIKE '%ez';

-- Buscar productos que contengan 'RGB' en cualquier parte del nombre
SELECT nombre, precio FROM productos
WHERE nombre LIKE '%RGB%';

-- Buscar nombres que tengan exactamente 4 caracteres
-- _ = exactamente un carácter
SELECT nombre FROM clientes
WHERE nombre LIKE '____';

-- Buscar emails de Gmail
SELECT nombre, email FROM clientes
WHERE email LIKE '%@gmail.com';

-- Buscar productos que NO contengan 'LED'
SELECT nombre FROM productos
WHERE nombre NOT LIKE '%LED%';


-- ==========================================
-- 4. ORDER BY - ORDENAR RESULTADOS
-- ==========================================

-- Ordenar clientes por nombre (ascendente por defecto)
SELECT nombre, apellido FROM clientes
ORDER BY nombre;

-- Ordenar clientes por nombre ascendente (explícito)
SELECT nombre, apellido FROM clientes
ORDER BY nombre ASC;

-- Ordenar clientes por apellido descendente
SELECT nombre, apellido FROM clientes
ORDER BY apellido DESC;

-- Ordenar productos por precio (menor a mayor)
SELECT nombre, precio FROM productos
ORDER BY precio ASC;

-- Ordenar por múltiples columnas
SELECT nombre, categoria, precio FROM productos
ORDER BY categoria ASC, precio DESC;

-- Ordenar por columna calculada
SELECT
    nombre,
    precio,
    stock,
    (precio * stock) AS valor_inventario
FROM productos
ORDER BY valor_inventario DESC;


-- ==========================================
-- 5. LIMIT - LIMITAR RESULTADOS
-- ==========================================

-- Obtener solo los primeros 5 clientes
SELECT * FROM clientes
LIMIT 5;

-- Obtener los 3 productos más caros
SELECT nombre, precio FROM productos
ORDER BY precio DESC
LIMIT 3;

-- Obtener los 3 productos más baratos
SELECT nombre, precio FROM productos
ORDER BY precio ASC
LIMIT 3;

-- LIMIT con OFFSET (saltar registros)
-- Saltar los primeros 3 y obtener los siguientes 5
SELECT nombre, email FROM clientes
LIMIT 5 OFFSET 3;

-- Sintaxis alternativa: LIMIT offset, cantidad
SELECT nombre, email FROM clientes
LIMIT 3, 5;  -- Saltar 3, obtener 5


-- ==========================================
-- 6. DISTINCT - ELIMINAR DUPLICADOS
-- ==========================================

-- Obtener todas las categorías sin duplicados
SELECT DISTINCT categoria FROM productos;

-- Contar cuántas categorías únicas hay
SELECT COUNT(DISTINCT categoria) AS total_categorias
FROM productos;

-- Obtener combinaciones únicas de categoría y activo
SELECT DISTINCT categoria, activo FROM productos;


-- ==========================================
-- 7. OPERADORES DE COMPARACIÓN
-- ==========================================

-- Igual a
SELECT nombre, precio FROM productos WHERE precio = 1599.00;

-- Diferente de
SELECT nombre, precio FROM productos WHERE precio != 1599.00;
-- o también:
SELECT nombre, precio FROM productos WHERE precio <> 1599.00;

-- Mayor que
SELECT nombre, stock FROM productos WHERE stock > 20;

-- Mayor o igual que
SELECT nombre, stock FROM productos WHERE stock >= 20;

-- Menor que
SELECT nombre, precio FROM productos WHERE precio < 2000;

-- Menor o igual que
SELECT nombre, precio FROM productos WHERE precio <= 2000;


-- ==========================================
-- 8. FUNCIONES AGREGADAS BÁSICAS
-- ==========================================

-- Contar todos los clientes
SELECT COUNT(*) AS total_clientes FROM clientes;

-- Contar productos activos
SELECT COUNT(*) AS productos_activos FROM productos
WHERE activo = TRUE;

-- Suma total del inventario (precio * stock)
SELECT SUM(precio * stock) AS valor_total_inventario
FROM productos;

-- Precio promedio de productos
SELECT AVG(precio) AS precio_promedio FROM productos;

-- Precio mínimo
SELECT MIN(precio) AS precio_minimo FROM productos;

-- Precio máximo
SELECT MAX(precio) AS precio_maximo FROM productos;

-- Múltiples agregaciones en una consulta
SELECT
    COUNT(*) AS total_productos,
    AVG(precio) AS precio_promedio,
    MIN(precio) AS precio_minimo,
    MAX(precio) AS precio_maximo,
    SUM(stock) AS stock_total
FROM productos
WHERE activo = TRUE;


-- ==========================================
-- 9. COMBINANDO TODO
-- ==========================================

-- Ejemplo completo: Encontrar productos electrónicos con stock bajo
SELECT
    nombre AS producto,
    precio AS precio_unitario,
    stock AS unidades_disponibles,
    (precio * stock) AS valor_inventario,
    categoria
FROM productos
WHERE
    categoria = 'Electrónica'
    AND stock < 20
    AND activo = TRUE
ORDER BY stock ASC, precio DESC
LIMIT 5;


-- ==========================================
-- 10. EJEMPLOS PRÁCTICOS DEL MUNDO REAL
-- ==========================================

-- Buscar clientes con Gmail
SELECT
    CONCAT(nombre, ' ', apellido) AS cliente,
    email
FROM clientes
WHERE email LIKE '%@gmail.com'
ORDER BY nombre;

-- Top 5 productos más costosos en stock
SELECT
    nombre,
    CONCAT('$', FORMAT(precio, 2)) AS precio_formateado,
    stock
FROM productos
WHERE stock > 0 AND activo = TRUE
ORDER BY precio DESC
LIMIT 5;

-- Productos que necesitan reabastecimiento (stock bajo)
SELECT
    nombre,
    stock,
    categoria,
    CASE
        WHEN stock = 0 THEN 'AGOTADO'
        WHEN stock < 10 THEN 'STOCK CRÍTICO'
        WHEN stock < 20 THEN 'STOCK BAJO'
        ELSE 'STOCK OK'
    END AS estado_inventario
FROM productos
WHERE stock < 20
ORDER BY stock ASC;


-- ==========================================
-- EJERCICIOS PRÁCTICOS
-- ==========================================

/*
EJERCICIO 1: Obtén todos los clientes ordenados por apellido de A-Z

EJERCICIO 2: Encuentra todos los productos de la categoría 'Accesorios'
             que cuesten menos de $2000

EJERCICIO 3: Lista los 3 productos con mayor stock

EJERCICIO 4: Busca todos los clientes cuyo nombre termine en 'a'

EJERCICIO 5: Calcula el precio promedio de los productos electrónicos

EJERCICIO 6: Lista todos los productos cuyo nombre contenga 'Logitech' o 'Sony'

EJERCICIO 7: Encuentra productos con precio entre $1000 y $7000,
             ordenados por precio descendente

EJERCICIO 8: Cuenta cuántos productos hay en cada categoría
             (pista: necesitarás GROUP BY, lo veremos más adelante,
             pero intenta investigarlo)

EJERCICIO 9: Muestra el nombre completo de los clientes (nombre + apellido)
             y su email, solo de aquellos cuyo apellido empiece con 'R'

EJERCICIO 10: Lista los productos inactivos (activo = FALSE)
*/

-- Escribe tus soluciones aquí:
