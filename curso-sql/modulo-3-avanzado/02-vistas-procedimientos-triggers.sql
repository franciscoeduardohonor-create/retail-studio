-- ============================================
-- LECCIÓN 2: VISTAS, PROCEDIMIENTOS Y TRIGGERS
-- ============================================

USE tienda_online;

-- ==========================================
-- 1. VISTAS (VIEWS)
-- ==========================================

/*
Una vista es una consulta almacenada que actúa como una tabla virtual.
No almacena datos, solo la definición de la consulta.

Ventajas:
- Simplifica consultas complejas
- Seguridad (oculta columnas sensibles)
- Abstracción (cambias la vista sin cambiar el código que la usa)
- Reutilización de código
*/

-- Crear vista simple
CREATE VIEW vista_productos_activos AS
SELECT id, nombre, precio, stock, categoria
FROM productos
WHERE activo = TRUE;

-- Usar la vista como una tabla
SELECT * FROM vista_productos_activos;

SELECT * FROM vista_productos_activos
WHERE categoria = 'Electrónica';


-- Vista con JOIN
CREATE VIEW vista_pedidos_clientes AS
SELECT
    p.id AS pedido_id,
    p.fecha_pedido,
    p.total,
    p.estado,
    c.id AS cliente_id,
    CONCAT(c.nombre, ' ', c.apellido) AS cliente_nombre,
    c.email AS cliente_email
FROM pedidos p
INNER JOIN clientes c ON p.cliente_id = c.id;

-- Usar vista
SELECT * FROM vista_pedidos_clientes
WHERE estado = 'Pendiente';


-- Vista con agregaciones
CREATE VIEW vista_resumen_clientes AS
SELECT
    c.id,
    CONCAT(c.nombre, ' ', c.apellido) AS nombre_completo,
    c.email,
    COUNT(p.id) AS total_pedidos,
    COALESCE(SUM(p.total), 0) AS total_gastado,
    COALESCE(AVG(p.total), 0) AS ticket_promedio,
    MAX(p.fecha_pedido) AS ultima_compra
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre, c.apellido, c.email;

-- Consultar vista
SELECT * FROM vista_resumen_clientes
WHERE total_gastado > 10000
ORDER BY total_gastado DESC;


-- Vista con subconsultas
CREATE VIEW vista_productos_populares AS
SELECT
    p.id,
    p.nombre,
    p.categoria,
    p.precio,
    p.stock,
    COALESCE(ventas.total_vendido, 0) AS unidades_vendidas,
    COALESCE(ventas.ingresos, 0) AS ingresos_generados
FROM productos p
LEFT JOIN (
    SELECT
        producto_id,
        SUM(cantidad) AS total_vendido,
        SUM(cantidad * precio_unitario) AS ingresos
    FROM detalle_pedidos
    GROUP BY producto_id
) AS ventas ON p.id = ventas.producto_id;

SELECT * FROM vista_productos_populares
ORDER BY unidades_vendidas DESC
LIMIT 5;


-- Ver definición de una vista
SHOW CREATE VIEW vista_productos_activos;

-- Modificar una vista
CREATE OR REPLACE VIEW vista_productos_activos AS
SELECT id, nombre, precio, stock, categoria, descripcion
FROM productos
WHERE activo = TRUE AND stock > 0;

-- Eliminar una vista
-- DROP VIEW IF EXISTS vista_productos_activos;


-- ==========================================
-- 2. VISTAS ACTUALIZABLES
-- ==========================================

/*
Algunas vistas permiten INSERT, UPDATE, DELETE.
Condiciones:
- Una sola tabla en FROM
- Sin GROUP BY, DISTINCT, agregaciones
- Sin UNION, subconsultas en SELECT
*/

-- Crear vista simple actualizable
CREATE OR REPLACE VIEW vista_clientes_basico AS
SELECT id, nombre, apellido, email, telefono
FROM clientes;

-- Actualizar a través de vista
UPDATE vista_clientes_basico
SET telefono = '5559999999'
WHERE id = 1;

-- Insertar a través de vista
INSERT INTO vista_clientes_basico (nombre, apellido, email)
VALUES ('Vista', 'Test', 'vista.test@email.com');


-- Vista con WITH CHECK OPTION
-- Evita que se inserten/actualicen datos que no cumplan la condición de la vista
CREATE OR REPLACE VIEW vista_productos_electronicos AS
SELECT id, nombre, precio, stock
FROM productos
WHERE categoria = 'Electrónica'
WITH CHECK OPTION;

-- Esto funcionará
UPDATE vista_productos_electronicos SET precio = 30000 WHERE id = 1;

-- Esto fallará (intenta cambiar categoría)
-- UPDATE vista_productos_electronicos SET categoria = 'Muebles' WHERE id = 1;


-- ==========================================
-- 3. PROCEDIMIENTOS ALMACENADOS (STORED PROCEDURES)
-- ==========================================

/*
Un procedimiento almacenado es un conjunto de instrucciones SQL
que se guardan y pueden ejecutarse múltiples veces.

Ventajas:
- Reutilización de código
- Mejor rendimiento (precompilados)
- Seguridad (usuarios ejecutan sin ver el código)
- Lógica de negocio centralizada
*/

-- Cambiar delimitador (necesario para procedimientos)
DELIMITER //

-- Procedimiento simple sin parámetros
CREATE PROCEDURE sp_listar_productos()
BEGIN
    SELECT id, nombre, precio, stock
    FROM productos
    WHERE activo = TRUE
    ORDER BY nombre;
END //

DELIMITER ;

-- Ejecutar procedimiento
CALL sp_listar_productos();


-- Procedimiento con parámetros IN
DELIMITER //

CREATE PROCEDURE sp_buscar_productos_por_categoria(
    IN p_categoria VARCHAR(50)
)
BEGIN
    SELECT id, nombre, precio, stock
    FROM productos
    WHERE categoria = p_categoria AND activo = TRUE
    ORDER BY precio DESC;
END //

DELIMITER ;

-- Ejecutar con parámetro
CALL sp_buscar_productos_por_categoria('Electrónica');


-- Procedimiento con parámetros OUT
DELIMITER //

CREATE PROCEDURE sp_contar_productos_categoria(
    IN p_categoria VARCHAR(50),
    OUT p_total INT
)
BEGIN
    SELECT COUNT(*) INTO p_total
    FROM productos
    WHERE categoria = p_categoria;
END //

DELIMITER ;

-- Ejecutar y obtener valor OUT
CALL sp_contar_productos_categoria('Electrónica', @total);
SELECT @total AS total_productos_electronicos;


-- Procedimiento con parámetros INOUT
DELIMITER //

CREATE PROCEDURE sp_aplicar_descuento(
    INOUT p_precio DECIMAL(10,2),
    IN p_porcentaje INT
)
BEGIN
    SET p_precio = p_precio * (1 - p_porcentaje / 100);
END //

DELIMITER ;

-- Ejecutar
SET @precio = 1000.00;
CALL sp_aplicar_descuento(@precio, 15);  -- 15% descuento
SELECT @precio AS precio_con_descuento;


-- Procedimiento con lógica condicional
DELIMITER //

CREATE PROCEDURE sp_clasificar_cliente(
    IN p_cliente_id INT,
    OUT p_clasificacion VARCHAR(20)
)
BEGIN
    DECLARE v_total DECIMAL(10,2);

    SELECT COALESCE(SUM(total), 0) INTO v_total
    FROM pedidos
    WHERE cliente_id = p_cliente_id;

    IF v_total > 30000 THEN
        SET p_clasificacion = 'VIP';
    ELSEIF v_total > 15000 THEN
        SET p_clasificacion = 'Premium';
    ELSEIF v_total > 5000 THEN
        SET p_clasificacion = 'Regular';
    ELSE
        SET p_clasificacion = 'Nuevo';
    END IF;
END //

DELIMITER ;

-- Ejecutar
CALL sp_clasificar_cliente(1, @clasificacion);
SELECT @clasificacion;


-- Procedimiento con bucle
DELIMITER //

CREATE PROCEDURE sp_generar_reporte_categorias()
BEGIN
    DECLARE v_done INT DEFAULT FALSE;
    DECLARE v_categoria VARCHAR(50);
    DECLARE v_total INT;

    DECLARE cur CURSOR FOR
        SELECT DISTINCT categoria FROM productos;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = TRUE;

    -- Crear tabla temporal para resultados
    DROP TEMPORARY TABLE IF EXISTS temp_reporte;
    CREATE TEMPORARY TABLE temp_reporte (
        categoria VARCHAR(50),
        total_productos INT
    );

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_categoria;

        IF v_done THEN
            LEAVE read_loop;
        END IF;

        SELECT COUNT(*) INTO v_total
        FROM productos
        WHERE categoria = v_categoria;

        INSERT INTO temp_reporte VALUES (v_categoria, v_total);
    END LOOP;

    CLOSE cur;

    SELECT * FROM temp_reporte ORDER BY total_productos DESC;
END //

DELIMITER ;

-- Ejecutar
CALL sp_generar_reporte_categorias();


-- Procedimiento con manejo de errores
DELIMITER //

CREATE PROCEDURE sp_crear_pedido(
    IN p_cliente_id INT,
    IN p_total DECIMAL(10,2),
    OUT p_pedido_id INT,
    OUT p_mensaje VARCHAR(200)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET p_mensaje = 'Error al crear pedido';
        SET p_pedido_id = -1;
        ROLLBACK;
    END;

    START TRANSACTION;

    -- Verificar que el cliente existe
    IF NOT EXISTS (SELECT 1 FROM clientes WHERE id = p_cliente_id) THEN
        SET p_mensaje = 'Cliente no existe';
        SET p_pedido_id = -1;
        ROLLBACK;
    ELSE
        INSERT INTO pedidos (cliente_id, total, estado)
        VALUES (p_cliente_id, p_total, 'Pendiente');

        SET p_pedido_id = LAST_INSERT_ID();
        SET p_mensaje = 'Pedido creado exitosamente';

        COMMIT;
    END IF;
END //

DELIMITER ;

-- Ejecutar
CALL sp_crear_pedido(1, 5000.00, @pedido_id, @mensaje);
SELECT @pedido_id, @mensaje;


-- Ver procedimientos almacenados
SHOW PROCEDURE STATUS WHERE Db = 'tienda_online';

-- Ver código de un procedimiento
SHOW CREATE PROCEDURE sp_listar_productos;

-- Eliminar procedimiento
-- DROP PROCEDURE IF EXISTS sp_listar_productos;


-- ==========================================
-- 4. FUNCIONES ALMACENADAS (STORED FUNCTIONS)
-- ==========================================

/*
Similar a procedimientos pero:
- Devuelven un solo valor
- Se usan en expresiones (como funciones nativas)
- Más restricciones (no pueden modificar datos)
*/

DELIMITER //

CREATE FUNCTION fn_calcular_descuento(
    p_precio DECIMAL(10,2),
    p_porcentaje INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN p_precio * (1 - p_porcentaje / 100);
END //

DELIMITER ;

-- Usar función
SELECT
    nombre,
    precio,
    fn_calcular_descuento(precio, 10) AS precio_con_10_descuento,
    fn_calcular_descuento(precio, 20) AS precio_con_20_descuento
FROM productos
LIMIT 5;


-- Función que consulta datos
DELIMITER //

CREATE FUNCTION fn_total_pedidos_cliente(p_cliente_id INT)
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE v_total INT;

    SELECT COUNT(*) INTO v_total
    FROM pedidos
    WHERE cliente_id = p_cliente_id;

    RETURN v_total;
END //

DELIMITER ;

-- Usar función
SELECT
    nombre,
    apellido,
    fn_total_pedidos_cliente(id) AS num_pedidos
FROM clientes
LIMIT 5;


-- ==========================================
-- 5. TRIGGERS (DISPARADORES)
-- ==========================================

/*
Los triggers son procedimientos que se ejecutan automáticamente
cuando ocurren eventos (INSERT, UPDATE, DELETE) en una tabla.

Timing: BEFORE o AFTER
Event: INSERT, UPDATE, DELETE
*/

-- Tabla para auditoría
CREATE TABLE IF NOT EXISTS auditoria_productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT,
    accion VARCHAR(20),
    precio_anterior DECIMAL(10,2),
    precio_nuevo DECIMAL(10,2),
    usuario VARCHAR(100),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Trigger AFTER UPDATE
DELIMITER //

CREATE TRIGGER trg_auditoria_precio_producto
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
    IF OLD.precio != NEW.precio THEN
        INSERT INTO auditoria_productos
            (producto_id, accion, precio_anterior, precio_nuevo, usuario)
        VALUES
            (NEW.id, 'UPDATE', OLD.precio, NEW.precio, USER());
    END IF;
END //

DELIMITER ;

-- Probar trigger
UPDATE productos SET precio = 26000.00 WHERE id = 1;
SELECT * FROM auditoria_productos;


-- Trigger BEFORE INSERT (validación)
DELIMITER //

CREATE TRIGGER trg_validar_precio_producto
BEFORE INSERT ON productos
FOR EACH ROW
BEGIN
    IF NEW.precio < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El precio no puede ser negativo';
    END IF;

    IF NEW.stock < 0 THEN
        SET NEW.stock = 0;
    END IF;
END //

DELIMITER ;

-- Probar (fallará)
-- INSERT INTO productos (nombre, precio, stock, categoria)
-- VALUES ('Test', -100, 10, 'Test');


-- Trigger para actualizar stock automáticamente
CREATE TABLE IF NOT EXISTS historial_stock (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT,
    stock_anterior INT,
    stock_nuevo INT,
    diferencia INT,
    motivo VARCHAR(100),
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

CREATE TRIGGER trg_historial_stock
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
    IF OLD.stock != NEW.stock THEN
        INSERT INTO historial_stock
            (producto_id, stock_anterior, stock_nuevo, diferencia, motivo)
        VALUES
            (NEW.id, OLD.stock, NEW.stock, NEW.stock - OLD.stock,
             IF(NEW.stock > OLD.stock, 'Reabastecimiento', 'Venta'));
    END IF;
END //

DELIMITER ;

-- Probar
UPDATE productos SET stock = stock - 3 WHERE id = 1;
SELECT * FROM historial_stock;


-- Trigger BEFORE DELETE (prevenir eliminación)
DELIMITER //

CREATE TRIGGER trg_prevenir_eliminar_cliente_con_pedidos
BEFORE DELETE ON clientes
FOR EACH ROW
BEGIN
    DECLARE v_num_pedidos INT;

    SELECT COUNT(*) INTO v_num_pedidos
    FROM pedidos
    WHERE cliente_id = OLD.id;

    IF v_num_pedidos > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede eliminar cliente con pedidos';
    END IF;
END //

DELIMITER ;


-- Ver triggers
SHOW TRIGGERS FROM tienda_online;

-- Ver código de un trigger
SHOW CREATE TRIGGER trg_auditoria_precio_producto;

-- Eliminar trigger
-- DROP TRIGGER IF EXISTS trg_auditoria_precio_producto;


-- ==========================================
-- 6. EVENTOS (EVENTS)
-- ==========================================

/*
Los eventos son tareas programadas que se ejecutan automáticamente
en intervalos definidos.
*/

-- Habilitar el programador de eventos
SET GLOBAL event_scheduler = ON;

-- Evento que se ejecuta una vez
DELIMITER //

CREATE EVENT IF NOT EXISTS evt_limpiar_logs_antiguos
ON SCHEDULE AT CURRENT_TIMESTAMP + INTERVAL 1 DAY
DO
BEGIN
    DELETE FROM auditoria_productos
    WHERE fecha < DATE_SUB(NOW(), INTERVAL 1 YEAR);
END //

DELIMITER ;


-- Evento recurrente (cada día a las 2 AM)
DELIMITER //

CREATE EVENT IF NOT EXISTS evt_reporte_diario
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP + INTERVAL 1 DAY
DO
BEGIN
    -- Aquí iría la lógica del reporte
    INSERT INTO auditoria_productos (producto_id, accion, usuario)
    VALUES (0, 'REPORTE_DIARIO', 'SYSTEM');
END //

DELIMITER ;


-- Ver eventos
SHOW EVENTS FROM tienda_online;

-- Deshabilitar evento
-- ALTER EVENT evt_reporte_diario DISABLE;

-- Eliminar evento
-- DROP EVENT IF EXISTS evt_reporte_diario;


-- ==========================================
-- EJERCICIOS PRÁCTICOS
-- ==========================================

/*
EJERCICIO 1: Crea una vista que muestre productos con bajo stock
             (menos de 10 unidades) incluyendo su categoría y precio.

EJERCICIO 2: Crea una vista de "clientes VIP" (más de $20,000 gastados)
             con su información de contacto y estadísticas de compra.

EJERCICIO 3: Crea un procedimiento almacenado que reciba un cliente_id
             y devuelva su historial completo de pedidos.

EJERCICIO 4: Crea un procedimiento que aplique un descuento del X%
             a todos los productos de una categoría específica.

EJERCICIO 5: Crea una función que calcule el total gastado por un cliente.

EJERCICIO 6: Crea un trigger que automáticamente actualice el campo
             'es_vip' de un cliente cuando su gasto total supere $20,000.

EJERCICIO 7: Crea un trigger que prevenga la venta de productos
             con stock = 0 (antes de insertar en detalle_pedidos).

EJERCICIO 8: Crea una tabla de auditoría y un trigger que registre
             todos los cambios en la tabla clientes.

EJERCICIO 9: Crea un procedimiento que genere un reporte de ventas
             mensuales de un año específico.

EJERCICIO 10: Crea un evento que marque como inactivos los productos
              con stock = 0, ejecutándose cada semana.
*/

-- Escribe tus soluciones aquí:
