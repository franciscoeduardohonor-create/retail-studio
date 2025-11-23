-- ============================================
-- LECCIÓN 4: INSERT, UPDATE y DELETE
-- ============================================

USE tienda_online;

-- ==========================================
-- 1. INSERT - INSERTAR DATOS
-- ==========================================

-- Sintaxis básica: Insertar especificando todas las columnas
INSERT INTO clientes (nombre, apellido, email, telefono)
VALUES ('Roberto', 'Díaz', 'roberto.diaz@email.com', '5559876543');

-- Insertar sin especificar algunas columnas opcionales
-- (telefono puede ser NULL)
INSERT INTO clientes (nombre, apellido, email)
VALUES ('Sofia', 'Torres', 'sofia.torres@email.com');

-- Insertar múltiples registros a la vez (más eficiente)
INSERT INTO clientes (nombre, apellido, email, telefono) VALUES
('Diego', 'Morales', 'diego.morales@email.com', '5551112222'),
('Carmen', 'Ruiz', 'carmen.ruiz@email.com', '5553334444'),
('Javier', 'Castro', 'javier.castro@email.com', NULL);

-- Ver los clientes recién insertados
SELECT * FROM clientes
ORDER BY id DESC
LIMIT 5;

-- Insertar en tabla productos
INSERT INTO productos (nombre, descripcion, precio, stock, categoria, activo)
VALUES (
    'Cable USB-C 2m',
    'Cable de carga rápida resistente',
    299.99,
    100,
    'Accesorios',
    TRUE
);

-- Insertar producto usando valores por defecto
-- (stock tiene DEFAULT 0, activo tiene DEFAULT TRUE)
INSERT INTO productos (nombre, descripcion, precio, categoria)
VALUES (
    'Funda Laptop 15"',
    'Funda acolchada resistente al agua',
    399.00,
    'Accesorios'
);


-- ==========================================
-- 2. INSERT desde un SELECT
-- ==========================================

-- Primero creamos una tabla temporal para el ejemplo
CREATE TABLE IF NOT EXISTS productos_descontinuados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(200),
    precio DECIMAL(10, 2),
    categoria VARCHAR(50),
    fecha_descontinuado TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Copiar productos inactivos a la tabla de descontinuados
INSERT INTO productos_descontinuados (nombre, precio, categoria)
SELECT nombre, precio, categoria
FROM productos
WHERE activo = FALSE;

-- Ver productos descontinuados
SELECT * FROM productos_descontinuados;


-- ==========================================
-- 3. UPDATE - ACTUALIZAR DATOS
-- ==========================================

-- ¡IMPORTANTE! Siempre usa WHERE en UPDATE, o actualizarás TODOS los registros

-- Actualizar un solo campo
UPDATE productos
SET stock = 45
WHERE id = 1;

-- Actualizar múltiples campos
UPDATE productos
SET
    precio = 24999.99,
    stock = 20,
    descripcion = 'Laptop ultradelgada con procesador Intel i7 - OFERTA'
WHERE id = 1;

-- Actualizar basándose en una condición
-- Aumentar 10% el precio de todos los productos electrónicos
UPDATE productos
SET precio = precio * 1.10
WHERE categoria = 'Electrónica';

-- Actualizar con operaciones aritméticas
-- Reducir el stock en 5 unidades para productos con más de 30 en stock
UPDATE productos
SET stock = stock - 5
WHERE stock > 30;

-- Actualizar usando CASE (condicional)
UPDATE productos
SET stock = CASE
    WHEN categoria = 'Electrónica' THEN stock + 10
    WHEN categoria = 'Accesorios' THEN stock + 20
    ELSE stock + 5
END
WHERE activo = TRUE;

-- Actualizar clientes: cambiar email
UPDATE clientes
SET email = 'juan.perez.nuevo@email.com'
WHERE id = 1;

-- Actualizar múltiples registros con la misma condición
UPDATE productos
SET activo = FALSE
WHERE stock = 0;

-- Ver los cambios
SELECT nombre, precio, stock, activo FROM productos;


-- ==========================================
-- 4. UPDATE con JOIN (avanzado para principiante)
-- ==========================================

-- Ejemplo: actualizar el email de un cliente basándose en su nombre
UPDATE clientes
SET telefono = '5559999999'
WHERE nombre = 'Juan' AND apellido = 'Pérez';


-- ==========================================
-- 5. DELETE - ELIMINAR DATOS
-- ==========================================

-- ¡CUIDADO! DELETE sin WHERE elimina TODOS los registros

-- Eliminar un registro específico por ID
DELETE FROM clientes
WHERE id = 100;  -- Si existe

-- Eliminar basándose en una condición
-- Eliminar productos que nunca han estado en stock y son inactivos
DELETE FROM productos
WHERE stock = 0 AND activo = FALSE;

-- Eliminar usando múltiples condiciones
DELETE FROM clientes
WHERE email LIKE '%@temporal.com'
   AND fecha_registro < DATE_SUB(NOW(), INTERVAL 1 YEAR);

-- Eliminar con subconsulta (veremos más adelante)
-- Por ahora un ejemplo simple
DELETE FROM productos
WHERE precio < (SELECT AVG(precio) FROM (SELECT precio FROM productos) AS p)
  AND stock = 0;


-- ==========================================
-- 6. DELETE vs TRUNCATE vs DROP
-- ==========================================

/*
DELETE:
- Elimina registros fila por fila
- Puede usar WHERE para ser selectivo
- Se puede hacer ROLLBACK (deshacer) si está en una transacción
- Mantiene la estructura de la tabla
- Más lento para eliminar muchos registros

TRUNCATE:
- Elimina TODOS los registros de una vez
- No se puede usar WHERE
- Reinicia los contadores AUTO_INCREMENT
- Más rápido que DELETE
- Mantiene la estructura de la tabla

DROP:
- Elimina la tabla COMPLETA (estructura y datos)
- No se puede recuperar
*/

-- Ejemplo de TRUNCATE (¡CUIDADO!)
CREATE TABLE tabla_ejemplo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    dato VARCHAR(50)
);

INSERT INTO tabla_ejemplo (dato) VALUES ('Dato 1'), ('Dato 2'), ('Dato 3');

-- TRUNCATE elimina todo
-- TRUNCATE TABLE tabla_ejemplo;

-- DROP elimina la tabla completa
DROP TABLE tabla_ejemplo;


-- ==========================================
-- 7. TRANSACCIONES - Seguridad al modificar datos
-- ==========================================

-- Las transacciones permiten agrupar múltiples operaciones
-- y deshacerlas si algo sale mal

-- Iniciar transacción
START TRANSACTION;

-- Realizar operaciones
INSERT INTO clientes (nombre, apellido, email)
VALUES ('Temporal', 'Usuario', 'temporal@test.com');

-- Ver el registro (solo visible en esta sesión por ahora)
SELECT * FROM clientes WHERE email = 'temporal@test.com';

-- Si todo está bien, confirmar cambios
COMMIT;

-- O si algo salió mal, deshacer
-- ROLLBACK;


-- Ejemplo de transacción con UPDATE
START TRANSACTION;

-- Reducir stock al vender un producto
UPDATE productos
SET stock = stock - 5
WHERE id = 2;

-- Verificar que el stock no quedó negativo
SELECT nombre, stock FROM productos WHERE id = 2;

-- Si el stock es válido (>= 0), confirmar
COMMIT;

-- Si quedó negativo, deshacer
-- ROLLBACK;


-- ==========================================
-- 8. EJEMPLOS PRÁCTICOS COMPLETOS
-- ==========================================

-- ESCENARIO 1: Registrar un nuevo cliente
START TRANSACTION;

INSERT INTO clientes (nombre, apellido, email, telefono)
VALUES ('Andrea', 'Vargas', 'andrea.vargas@email.com', '5551234567');

-- Obtener el ID del cliente recién insertado
SELECT LAST_INSERT_ID() AS nuevo_cliente_id;

COMMIT;


-- ESCENARIO 2: Vender un producto (reducir stock)
START TRANSACTION;

-- Producto a vender
SET @producto_id = 3;
SET @cantidad_venta = 2;

-- Verificar stock disponible
SELECT nombre, stock FROM productos WHERE id = @producto_id;

-- Reducir stock
UPDATE productos
SET stock = stock - @cantidad_venta
WHERE id = @producto_id AND stock >= @cantidad_venta;

-- Verificar que se actualizó (ROW_COUNT() devuelve filas afectadas)
SELECT
    IF(ROW_COUNT() > 0,
       'Venta exitosa',
       'Stock insuficiente') AS resultado;

COMMIT;


-- ESCENARIO 3: Aplicar descuento a categoría
START TRANSACTION;

-- 15% de descuento en todos los accesorios
UPDATE productos
SET precio = precio * 0.85  -- 85% del precio original = 15% descuento
WHERE categoria = 'Accesorios' AND activo = TRUE;

-- Ver productos con descuento
SELECT nombre, precio, categoria FROM productos
WHERE categoria = 'Accesorios';

COMMIT;


-- ESCENARIO 4: Limpiar datos antiguos
START TRANSACTION;

-- Eliminar clientes que nunca han hecho pedidos y se registraron hace más de 2 años
DELETE FROM clientes
WHERE id NOT IN (SELECT DISTINCT cliente_id FROM pedidos)
  AND fecha_registro < DATE_SUB(NOW(), INTERVAL 2 YEAR);

SELECT ROW_COUNT() AS clientes_eliminados;

COMMIT;


-- ==========================================
-- 9. BUENAS PRÁCTICAS
-- ==========================================

/*
1. SIEMPRE usa WHERE en UPDATE y DELETE
   - Verifica primero con un SELECT

2. Usa TRANSACCIONES para operaciones críticas
   - START TRANSACTION ... COMMIT/ROLLBACK

3. Haz respaldo antes de DELETE masivos
   - O prueba primero en una copia de la base de datos

4. Verifica con SELECT antes de ejecutar UPDATE/DELETE
   - Ejemplo:
     SELECT * FROM productos WHERE categoria = 'Electrónica';  -- Verificar
     UPDATE productos SET activo = FALSE WHERE categoria = 'Electrónica';

5. Usa LIMIT en DELETE para ir por partes
   - DELETE FROM logs WHERE fecha < '2020-01-01' LIMIT 1000;

6. No confíes en el orden sin ORDER BY
   - Aunque funcione ahora, el orden puede cambiar
*/


-- ==========================================
-- EJERCICIOS PRÁCTICOS
-- ==========================================

/*
EJERCICIO 1: Inserta 3 nuevos productos con los siguientes datos:
   - Mousepad Gaming XL, precio 350, stock 60, categoría Accesorios
   - Monitor Samsung 24", precio 4500, stock 15, categoría Electrónica
   - Soporte Laptop Aluminio, precio 599, stock 25, categoría Accesorios

EJERCICIO 2: Actualiza el precio del producto 'Cable USB-C 2m' a 249.99

EJERCICIO 3: Aumenta un 20% el precio de todos los productos de categoría 'Muebles'

EJERCICIO 4: Reduce en 10 unidades el stock de todos los productos
             que tengan más de 40 unidades en stock

EJERCICIO 5: Actualiza el teléfono del cliente con email 'maria.garcia@email.com'
             a '5559998888'

EJERCICIO 6: Marca como inactivos (activo = FALSE) todos los productos
             con precio mayor a 25000

EJERCICIO 7: Elimina los productos que tengan stock 0 y sean inactivos

EJERCICIO 8: Crea una transacción que:
             a) Inserte un nuevo cliente
             b) Inserte un nuevo producto
             c) Confirme los cambios

EJERCICIO 9: Actualiza la descripción de todos los productos de 'Accesorios'
             agregando al final: " - Envío gratis"

EJERCICIO 10: Crea una transacción que simule una venta:
              a) Reduce el stock del producto con id 6 en 3 unidades
              b) Si el stock resultante es negativo, deshace la transacción
              c) Si es válido, confirma
*/

-- Escribe tus soluciones aquí:






-- ==========================================
-- VERIFICACIÓN DE DATOS
-- ==========================================

-- Ver todos los clientes
SELECT * FROM clientes ORDER BY id DESC LIMIT 10;

-- Ver todos los productos
SELECT id, nombre, precio, stock, categoria, activo
FROM productos
ORDER BY id;

-- Ver estadísticas de productos
SELECT
    categoria,
    COUNT(*) AS total_productos,
    AVG(precio) AS precio_promedio,
    SUM(stock) AS stock_total
FROM productos
WHERE activo = TRUE
GROUP BY categoria;
