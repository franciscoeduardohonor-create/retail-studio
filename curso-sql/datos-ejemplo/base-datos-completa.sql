-- ============================================
-- BASE DE DATOS COMPLETA DE EJEMPLO
-- Tienda Online - Curso SQL
-- ============================================

-- Eliminar base de datos si existe (para empezar limpio)
DROP DATABASE IF EXISTS tienda_online;

-- Crear base de datos
CREATE DATABASE tienda_online CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE tienda_online;


-- ==========================================
-- CREAR TABLAS
-- ==========================================

-- Tabla de clientes
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    ciudad VARCHAR(100),
    pais VARCHAR(50) DEFAULT 'México',
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    es_vip BOOLEAN DEFAULT FALSE,

    INDEX idx_email (email),
    INDEX idx_nombre_apellido (nombre, apellido)
) ENGINE=InnoDB;


-- Tabla de productos
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10, 2) NOT NULL CHECK (precio >= 0),
    stock INT DEFAULT 0 CHECK (stock >= 0),
    categoria VARCHAR(50) NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_categoria (categoria),
    INDEX idx_precio (precio),
    INDEX idx_activo (activo),
    INDEX idx_categoria_activo (categoria, activo)
) ENGINE=InnoDB;


-- Tabla de pedidos
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    fecha_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10, 2) NOT NULL CHECK (total >= 0),
    estado ENUM('Pendiente', 'Procesando', 'Enviado', 'Entregado', 'Cancelado') DEFAULT 'Pendiente',

    FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX idx_cliente (cliente_id),
    INDEX idx_fecha (fecha_pedido),
    INDEX idx_estado (estado)
) ENGINE=InnoDB;


-- Tabla de detalle de pedidos
CREATE TABLE detalle_pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10, 2) NOT NULL CHECK (precio_unitario >= 0),

    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX idx_pedido (pedido_id),
    INDEX idx_producto (producto_id)
) ENGINE=InnoDB;


-- Tabla de categorías (opcional, para normalización avanzada)
CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL,
    descripcion TEXT,
    activa BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB;


-- Tabla de direcciones de envío
CREATE TABLE direcciones_envio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    calle VARCHAR(200) NOT NULL,
    numero VARCHAR(20),
    colonia VARCHAR(100),
    ciudad VARCHAR(100) NOT NULL,
    estado VARCHAR(100) NOT NULL,
    codigo_postal VARCHAR(10) NOT NULL,
    pais VARCHAR(50) DEFAULT 'México',
    es_principal BOOLEAN DEFAULT FALSE,

    FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE CASCADE ON UPDATE CASCADE,
    INDEX idx_cliente (cliente_id)
) ENGINE=InnoDB;


-- ==========================================
-- INSERTAR DATOS DE EJEMPLO
-- ==========================================

-- Insertar clientes
INSERT INTO clientes (nombre, apellido, email, telefono, ciudad, pais) VALUES
('Juan', 'Pérez', 'juan.perez@email.com', '5551234567', 'Ciudad de México', 'México'),
('María', 'García', 'maria.garcia@email.com', '5552345678', 'Guadalajara', 'México'),
('Carlos', 'López', 'carlos.lopez@email.com', '5553456789', 'Monterrey', 'México'),
('Ana', 'Martínez', 'ana.martinez@email.com', '5554567890', 'Puebla', 'México'),
('Luis', 'Rodríguez', 'luis.rodriguez@email.com', '5555678901', 'Tijuana', 'México'),
('Elena', 'Fernández', 'elena.fernandez@email.com', '5556789012', 'Querétaro', 'México'),
('Pedro', 'Sánchez', 'pedro.sanchez@email.com', '5557890123', 'León', 'México'),
('Laura', 'Ramírez', 'laura.ramirez@email.com', '5558901234', 'Ciudad de México', 'México'),
('Roberto', 'Díaz', 'roberto.diaz@email.com', '5559012345', 'Cancún', 'México'),
('Sofia', 'Torres', 'sofia.torres@email.com', '5550123456', 'Mérida', 'México'),
('Diego', 'Morales', 'diego.morales@email.com', NULL, 'Toluca', 'México'),
('Carmen', 'Ruiz', 'carmen.ruiz@email.com', '5552234567', 'Aguascalientes', 'México'),
('Javier', 'Castro', 'javier.castro@email.com', NULL, 'Morelia', 'México'),
('Andrea', 'Vargas', 'andrea.vargas@email.com', '5553345678', 'San Luis Potosí', 'México'),
('Fernando', 'Ortiz', 'fernando.ortiz@email.com', '5554456789', 'Hermosillo', 'México');


-- Insertar categorías
INSERT INTO categorias (nombre, descripcion) VALUES
('Electrónica', 'Dispositivos electrónicos y tecnología'),
('Muebles', 'Mobiliario para oficina y hogar'),
('Accesorios', 'Accesorios y periféricos'),
('Audio', 'Equipos de audio y sonido'),
('Video', 'Equipos de video y streaming');


-- Insertar productos
INSERT INTO productos (nombre, descripcion, precio, stock, categoria) VALUES
-- Electrónica
('Laptop Dell XPS 13', 'Laptop ultradelgada con procesador Intel i7, 16GB RAM, 512GB SSD', 25999.99, 15, 'Electrónica'),
('iPhone 14 Pro', 'Smartphone Apple última generación, 256GB, cámara ProRAW', 28999.00, 25, 'Electrónica'),
('iPad Air M1', 'Tablet Apple con chip M1, pantalla Liquid Retina 10.9"', 14999.00, 20, 'Electrónica'),
('MacBook Pro 14"', 'Laptop profesional Apple con chip M2 Pro, 16GB RAM', 48999.00, 8, 'Electrónica'),
('Monitor LG 27" 4K', 'Monitor UltraHD IPS para diseño profesional', 8999.00, 12, 'Electrónica'),
('Samsung Galaxy S23', 'Smartphone Android flagship, 256GB, cámara 50MP', 19999.00, 18, 'Electrónica'),
('Dell UltraSharp 24"', 'Monitor Full HD profesional con USB-C', 6499.00, 22, 'Electrónica'),

-- Muebles
('Escritorio Ergonómico', 'Escritorio ajustable en altura, 140x70cm, roble', 4599.50, 10, 'Muebles'),
('Silla Gamer RGB', 'Silla ergonómica con iluminación LED, soporte lumbar', 3299.00, 8, 'Muebles'),
('Librero Moderno', 'Estante 5 repisas, madera MDF, color blanco', 2199.00, 15, 'Muebles'),
('Mesa de Juntas', 'Mesa rectangular 200x100cm para 8 personas', 8999.00, 5, 'Muebles'),
('Archivero Metálico', 'Archivero 4 gavetas con cerradura, gris', 3499.00, 12, 'Muebles'),

-- Accesorios
('Teclado Mecánico RGB', 'Teclado gamer switches Cherry MX, iluminación personalizable', 1899.00, 30, 'Accesorios'),
('Mouse Logitech MX Master', 'Mouse inalámbrico profesional, ergonómico, 7 botones', 1599.00, 35, 'Accesorios'),
('Webcam HD 1080p', 'Cámara web con micrófono integrado, enfoque automático', 899.00, 50, 'Accesorios'),
('Lámpara LED Escritorio', 'Iluminación ajustable, temperatura color variable', 599.00, 40, 'Accesorios'),
('Hub USB-C 7 puertos', 'Hub multipuerto: HDMI, USB 3.0, lector SD, Ethernet', 1299.00, 45, 'Accesorios'),
('Soporte Laptop Aluminio', 'Soporte ergonómico ajustable, hasta 17 pulgadas', 499.00, 60, 'Accesorios'),
('Cable USB-C 2m', 'Cable de carga rápida, trenzado resistente', 299.99, 100, 'Accesorios'),
('Funda Laptop 15"', 'Funda acolchada resistente al agua', 399.00, 55, 'Accesorios'),
('Mousepad Gaming XL', 'Alfombrilla extendida 90x40cm, superficie suave', 350.00, 70, 'Accesorios'),

-- Audio
('Audífonos Sony WH-1000XM5', 'Audífonos inalámbricos con cancelación de ruido activa', 6499.99, 20, 'Audio'),
('AirPods Pro 2', 'Audífonos Apple con ANC y audio espacial', 5499.00, 30, 'Audio'),
('Bocina Bluetooth JBL', 'Altavoz portátil resistente al agua, 20hrs batería', 2299.00, 25, 'Audio'),
('Micrófono USB Blue Yeti', 'Micrófono condensador profesional para streaming', 2899.00, 15, 'Audio'),
('Barra de Sonido Samsung', 'Sistema 2.1 con subwoofer inalámbrico, 300W', 4999.00, 10, 'Audio'),

-- Video
('Ring Light 18"', 'Aro de luz LED con trípode, 3 modos iluminación', 899.00, 28, 'Video'),
('Trípode Profesional', 'Trípode aluminio 1.8m con cabeza fluida', 1499.00, 20, 'Video'),
('Capturadora HDMI', 'Dispositivo de captura 4K para streaming', 1899.00, 18, 'Video'),
('GoPro Hero 11', 'Cámara de acción 5.3K, estabilización avanzada', 8999.00, 12, 'Video');


-- Insertar pedidos
INSERT INTO pedidos (cliente_id, fecha_pedido, total, estado) VALUES
-- Cliente 1: Juan Pérez
(1, '2024-01-15 10:30:00', 25999.99, 'Entregado'),
(1, '2024-02-20 14:25:00', 6499.99, 'Entregado'),
(1, '2024-03-10 09:15:00', 1898.00, 'Entregado'),

-- Cliente 2: María García
(2, '2024-01-20 11:45:00', 32998.00, 'Entregado'),
(2, '2024-03-15 16:30:00', 5998.00, 'Entregado'),

-- Cliente 3: Carlos López
(3, '2024-02-01 13:20:00', 4599.50, 'Entregado'),
(3, '2024-03-25 10:00:00', 12598.00, 'Enviado'),

-- Cliente 4: Ana Martínez
(4, '2024-01-25 15:40:00', 10497.00, 'Entregado'),
(4, '2024-02-28 12:10:00', 2899.00, 'Entregado'),

-- Cliente 5: Luis Rodríguez
(5, '2024-03-01 09:30:00', 1599.00, 'Entregado'),

-- Cliente 6: Elena Fernández
(6, '2024-03-05 14:15:00', 8999.00, 'Procesando'),

-- Cliente 7: Pedro Sánchez
(7, '2024-03-12 11:20:00', 15998.00, 'Pendiente'),

-- Cliente 8: Laura Ramírez
(8, '2024-03-18 16:45:00', 3498.00, 'Procesando');


-- Insertar detalles de pedidos
INSERT INTO detalle_pedidos (pedido_id, producto_id, cantidad, precio_unitario) VALUES
-- Pedido 1 (Juan - Laptop)
(1, 1, 1, 25999.99),

-- Pedido 2 (Juan - Audífonos Sony)
(2, 21, 1, 6499.99),

-- Pedido 3 (Juan - Teclado + Mouse)
(3, 13, 1, 1899.00),
(3, 14, 1, 1599.00),

-- Pedido 4 (María - iPhone + Teclado x2)
(4, 2, 1, 28999.00),
(4, 13, 2, 1999.00),

-- Pedido 5 (María - Bocina + AirPods)
(5, 23, 1, 2299.00),
(5, 22, 1, 5499.00),

-- Pedido 6 (Carlos - Escritorio)
(6, 8, 1, 4599.50),

-- Pedido 7 (Carlos - Monitor LG + Silla Gamer)
(7, 5, 1, 8999.00),
(7, 9, 1, 3299.00),

-- Pedido 8 (Ana - Webcams x7 + Mouse + Teclado)
(8, 15, 7, 899.00),
(8, 14, 1, 1599.00),
(8, 13, 1, 1999.00),

-- Pedido 9 (Ana - Micrófono USB)
(9, 24, 1, 2899.00),

-- Pedido 10 (Luis - Mouse)
(10, 14, 1, 1599.00),

-- Pedido 11 (Elena - Monitor LG)
(11, 5, 1, 8999.00),

-- Pedido 12 (Pedro - iPad Air + AirPods Pro)
(12, 3, 1, 14999.00),
(12, 22, 1, 5499.00),

-- Pedido 13 (Laura - Silla Gamer + Lámpara LED)
(13, 9, 1, 3299.00),
(13, 16, 1, 599.00);


-- Insertar direcciones de envío
INSERT INTO direcciones_envio (cliente_id, calle, numero, colonia, ciudad, estado, codigo_postal, es_principal) VALUES
(1, 'Av. Reforma', '123', 'Centro', 'Ciudad de México', 'CDMX', '06000', TRUE),
(2, 'Calle Juárez', '456', 'Americana', 'Guadalajara', 'Jalisco', '44100', TRUE),
(3, 'Av. Constitución', '789', 'Centro', 'Monterrey', 'Nuevo León', '64000', TRUE),
(4, 'Calle 5 de Mayo', '321', 'Centro Histórico', 'Puebla', 'Puebla', '72000', TRUE),
(5, 'Av. Revolución', '654', 'Zona Río', 'Tijuana', 'Baja California', '22010', TRUE);


-- ==========================================
-- ACTUALIZAR CLIENTES VIP
-- ==========================================

UPDATE clientes c
SET es_vip = TRUE
WHERE (
    SELECT COALESCE(SUM(total), 0)
    FROM pedidos p
    WHERE p.cliente_id = c.id
) > 20000;


-- ==========================================
-- CREAR VISTAS ÚTILES
-- ==========================================

-- Vista de productos activos
CREATE VIEW v_productos_activos AS
SELECT id, nombre, descripcion, precio, stock, categoria
FROM productos
WHERE activo = TRUE;


-- Vista de resumen de clientes
CREATE VIEW v_resumen_clientes AS
SELECT
    c.id,
    CONCAT(c.nombre, ' ', c.apellido) AS nombre_completo,
    c.email,
    c.ciudad,
    c.es_vip,
    COUNT(p.id) AS total_pedidos,
    COALESCE(SUM(p.total), 0) AS total_gastado,
    COALESCE(AVG(p.total), 0) AS ticket_promedio,
    MAX(p.fecha_pedido) AS ultima_compra
FROM clientes c
LEFT JOIN pedidos p ON c.id = p.cliente_id
GROUP BY c.id, c.nombre, c.apellido, c.email, c.ciudad, c.es_vip;


-- Vista de productos más vendidos
CREATE VIEW v_productos_populares AS
SELECT
    p.id,
    p.nombre,
    p.categoria,
    p.precio,
    p.stock,
    COALESCE(SUM(dp.cantidad), 0) AS unidades_vendidas,
    COALESCE(SUM(dp.cantidad * dp.precio_unitario), 0) AS ingresos_generados,
    COUNT(DISTINCT dp.pedido_id) AS num_pedidos
FROM productos p
LEFT JOIN detalle_pedidos dp ON p.id = dp.producto_id
GROUP BY p.id, p.nombre, p.categoria, p.precio, p.stock;


-- ==========================================
-- ESTADÍSTICAS INICIALES
-- ==========================================

SELECT '=== ESTADÍSTICAS DE LA BASE DE DATOS ===' AS '';

SELECT 'CLIENTES' AS tabla, COUNT(*) AS registros FROM clientes
UNION ALL
SELECT 'PRODUCTOS', COUNT(*) FROM productos
UNION ALL
SELECT 'PEDIDOS', COUNT(*) FROM pedidos
UNION ALL
SELECT 'DETALLES PEDIDOS', COUNT(*) FROM detalle_pedidos;

SELECT '=== TOP 5 PRODUCTOS MÁS VENDIDOS ===' AS '';
SELECT nombre, unidades_vendidas, ingresos_generados
FROM v_productos_populares
ORDER BY unidades_vendidas DESC
LIMIT 5;

SELECT '=== TOP 5 CLIENTES VIP ===' AS '';
SELECT nombre_completo, total_pedidos, total_gastado, es_vip
FROM v_resumen_clientes
ORDER BY total_gastado DESC
LIMIT 5;

SELECT '=== VENTAS POR CATEGORÍA ===' AS '';
SELECT
    p.categoria,
    COUNT(DISTINCT dp.pedido_id) AS num_pedidos,
    SUM(dp.cantidad) AS unidades_vendidas,
    SUM(dp.cantidad * dp.precio_unitario) AS ingresos
FROM productos p
INNER JOIN detalle_pedidos dp ON p.id = dp.producto_id
GROUP BY p.categoria
ORDER BY ingresos DESC;

SELECT '¡Base de datos creada exitosamente!' AS mensaje;
