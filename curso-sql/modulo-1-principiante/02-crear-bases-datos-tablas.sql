-- ============================================
-- LECCIÓN 2: CREAR BASES DE DATOS Y TABLAS
-- ============================================

-- ==========================================
-- 1. CREAR UNA BASE DE DATOS
-- ==========================================

-- Sintaxis básica para crear una base de datos
CREATE DATABASE mi_empresa;

-- Verificar si la base de datos existe antes de crearla
CREATE DATABASE IF NOT EXISTS mi_empresa;

-- Eliminar una base de datos (¡CUIDADO! Se pierden todos los datos)
DROP DATABASE IF EXISTS mi_empresa;

-- Crear la base de datos para nuestros ejemplos
CREATE DATABASE IF NOT EXISTS tienda_online;

-- Seleccionar la base de datos con la que vamos a trabajar
USE tienda_online;


-- ==========================================
-- 2. TIPOS DE DATOS MÁS COMUNES
-- ==========================================

/*
NUMÉRICOS:
- INT / INTEGER: Números enteros (-2147483648 a 2147483647)
- BIGINT: Números enteros grandes
- DECIMAL(p,s): Números decimales exactos. Ejemplo: DECIMAL(10,2) = 12345678.90
- FLOAT / DOUBLE: Números decimales aproximados

TEXTO:
- CHAR(n): Cadena de longitud fija. Ejemplo: CHAR(5) siempre ocupa 5 caracteres
- VARCHAR(n): Cadena de longitud variable. Ejemplo: VARCHAR(100) máximo 100 caracteres
- TEXT: Texto largo sin límite específico

FECHA Y HORA:
- DATE: Solo fecha (YYYY-MM-DD)
- TIME: Solo hora (HH:MM:SS)
- DATETIME: Fecha y hora (YYYY-MM-DD HH:MM:SS)
- TIMESTAMP: Marca de tiempo automática

BOOLEANOS:
- BOOLEAN o BOOL: Verdadero/Falso (internamente 1/0)
*/


-- ==========================================
-- 3. CREAR TABLAS
-- ==========================================

-- Tabla simple de clientes
CREATE TABLE clientes (
    -- id: identificador único, auto-incremental, clave primaria
    id INT AUTO_INCREMENT PRIMARY KEY,

    -- nombre: cadena de hasta 100 caracteres, obligatorio
    nombre VARCHAR(100) NOT NULL,

    -- apellido: cadena de hasta 100 caracteres, obligatorio
    apellido VARCHAR(100) NOT NULL,

    -- email: único para cada cliente, obligatorio
    email VARCHAR(150) UNIQUE NOT NULL,

    -- telefono: opcional (puede ser NULL)
    telefono VARCHAR(20),

    -- fecha_registro: se llena automáticamente con la fecha actual
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);


-- Tabla de productos
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    descripcion TEXT,  -- Descripción larga del producto
    precio DECIMAL(10, 2) NOT NULL,  -- Precio con 2 decimales (ej: 1234.56)
    stock INT DEFAULT 0,  -- Cantidad en inventario, por defecto 0
    categoria VARCHAR(50),
    activo BOOLEAN DEFAULT TRUE,  -- Si el producto está disponible para venta
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Tabla de pedidos (relacionada con clientes)
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,  -- ID del cliente que hizo el pedido
    fecha_pedido DATETIME DEFAULT CURRENT_TIMESTAMP,
    total DECIMAL(10, 2) NOT NULL,
    estado VARCHAR(50) DEFAULT 'Pendiente',  -- Pendiente, Procesando, Enviado, Entregado

    -- FOREIGN KEY: Relaciona esta tabla con la tabla clientes
    -- Si se elimina un cliente, no se pueden eliminar sus pedidos (RESTRICT)
    FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE RESTRICT
);


-- Tabla de detalles de pedidos (productos en cada pedido)
CREATE TABLE detalle_pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,  -- Precio al momento de la compra

    -- Relaciones con otras tablas
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,  -- Si se elimina el pedido, se eliminan sus detalles
    FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE RESTRICT
);


-- ==========================================
-- 4. RESTRICCIONES (CONSTRAINTS)
-- ==========================================

-- Tabla con ejemplo de todas las restricciones importantes
CREATE TABLE empleados (
    id INT AUTO_INCREMENT,

    -- NOT NULL: El campo no puede estar vacío
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,

    -- UNIQUE: El valor debe ser único en toda la tabla
    email VARCHAR(150) UNIQUE NOT NULL,
    dni VARCHAR(20) UNIQUE,

    -- CHECK: Validar que el valor cumpla una condición
    edad INT CHECK (edad >= 18 AND edad <= 65),
    salario DECIMAL(10, 2) CHECK (salario > 0),

    -- DEFAULT: Valor por defecto si no se especifica
    departamento VARCHAR(50) DEFAULT 'General',
    activo BOOLEAN DEFAULT TRUE,

    -- PRIMARY KEY: Identificador único de cada registro
    PRIMARY KEY (id)
);


-- ==========================================
-- 5. MODIFICAR TABLAS EXISTENTES
-- ==========================================

-- Agregar una nueva columna
ALTER TABLE clientes
ADD COLUMN ciudad VARCHAR(100);

-- Agregar columna con valor por defecto
ALTER TABLE clientes
ADD COLUMN pais VARCHAR(50) DEFAULT 'México';

-- Modificar una columna existente
ALTER TABLE clientes
MODIFY COLUMN telefono VARCHAR(30);

-- Renombrar una columna
ALTER TABLE clientes
CHANGE COLUMN telefono telefono_movil VARCHAR(30);

-- Eliminar una columna
ALTER TABLE clientes
DROP COLUMN telefono_movil;

-- Renombrar una tabla
ALTER TABLE clientes
RENAME TO clientes_registrados;

-- Volver al nombre original
ALTER TABLE clientes_registrados
RENAME TO clientes;


-- ==========================================
-- 6. ELIMINAR TABLAS
-- ==========================================

-- Crear tabla temporal para ejemplo
CREATE TABLE tabla_temporal (
    id INT PRIMARY KEY,
    dato VARCHAR(50)
);

-- Eliminar tabla
DROP TABLE tabla_temporal;

-- Eliminar tabla solo si existe (evita errores)
DROP TABLE IF EXISTS tabla_temporal;

-- Vaciar todos los datos de una tabla pero mantener su estructura
-- TRUNCATE TABLE clientes;  -- ¡CUIDADO! Elimina todos los registros


-- ==========================================
-- 7. VER INFORMACIÓN DE LA BASE DE DATOS
-- ==========================================

-- Ver todas las bases de datos
SHOW DATABASES;

-- Ver todas las tablas de la base de datos actual
SHOW TABLES;

-- Ver la estructura de una tabla
DESCRIBE clientes;  -- o DESC clientes;

-- Ver el comando CREATE TABLE de una tabla existente
SHOW CREATE TABLE clientes;


-- ==========================================
-- EJERCICIO PRÁCTICO
-- ==========================================

/*
EJERCICIO 1: Crea una base de datos llamada "biblioteca"

EJERCICIO 2: Crea las siguientes tablas:

1. Tabla "autores":
   - id (entero, auto-incremental, clave primaria)
   - nombre (varchar 100, obligatorio)
   - apellido (varchar 100, obligatorio)
   - nacionalidad (varchar 50)
   - fecha_nacimiento (date)

2. Tabla "libros":
   - id (entero, auto-incremental, clave primaria)
   - titulo (varchar 200, obligatorio)
   - isbn (varchar 20, único, obligatorio)
   - autor_id (entero, obligatorio, clave foránea a autores)
   - año_publicacion (entero)
   - precio (decimal 10,2)
   - paginas (entero)
   - disponible (booleano, por defecto verdadero)

3. Tabla "prestamos":
   - id (entero, auto-incremental, clave primaria)
   - libro_id (entero, obligatorio, clave foránea a libros)
   - nombre_usuario (varchar 100, obligatorio)
   - fecha_prestamo (datetime, valor por defecto fecha actual)
   - fecha_devolucion (datetime)
   - devuelto (booleano, por defecto falso)

EJERCICIO 3: Agrega una columna "genero" a la tabla libros (varchar 50)

EJERCICIO 4: Describe la estructura de la tabla "libros" para verificar
*/

-- Escribe tu solución aquí:
