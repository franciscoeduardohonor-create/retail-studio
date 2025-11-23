# Guía Completa de Ejercicios Prácticos - Curso SQL

Esta guía contiene ejercicios organizados por nivel de dificultad para que practiques todos los conceptos del curso.

---

## 📘 NIVEL PRINCIPIANTE

### Ejercicios de SELECT Básico

**Ejercicio 1:** Lista todos los clientes ordenados alfabéticamente por apellido.

**Ejercicio 2:** Encuentra todos los productos con precio menor a $1000.

**Ejercicio 3:** Muestra los 5 productos más caros.

**Ejercicio 4:** Lista todos los productos de la categoría 'Electrónica'.

**Ejercicio 5:** Encuentra clientes cuyo email termine en '@gmail.com'.

**Ejercicio 6:** Muestra productos cuyo nombre contenga la palabra 'USB'.

**Ejercicio 7:** Lista clientes registrados en marzo de 2024.

**Ejercicio 8:** Encuentra productos con stock entre 10 y 30 unidades.

**Ejercicio 9:** Muestra el nombre completo de cada cliente (nombre + apellido) y su email.

**Ejercicio 10:** Lista productos ordenados por stock (de mayor a menor).

---

### Ejercicios de INSERT, UPDATE, DELETE

**Ejercicio 11:** Inserta un nuevo cliente con tus datos personales.

**Ejercicio 12:** Inserta 3 productos nuevos de la categoría 'Audio'.

**Ejercicio 13:** Actualiza el precio del producto 'Cable USB-C 2m' aumentándolo en 10%.

**Ejercicio 14:** Cambia el estado de todos los pedidos 'Pendiente' a 'Procesando'.

**Ejercicio 15:** Aumenta el stock de todos los productos de 'Accesorios' en 10 unidades.

**Ejercicio 16:** Actualiza el teléfono de un cliente específico.

**Ejercicio 17:** Marca como inactivos todos los productos con stock = 0.

**Ejercicio 18:** Elimina productos inactivos que nunca se han vendido.

**Ejercicio 19:** Actualiza la ciudad de todos los clientes sin ciudad a 'No especificado'.

**Ejercicio 20:** Crea una transacción que inserte un pedido nuevo con sus detalles.

---

### Ejercicios de Funciones y Agregaciones

**Ejercicio 21:** Cuenta cuántos clientes hay en total.

**Ejercicio 22:** Calcula el precio promedio de todos los productos.

**Ejercicio 23:** Encuentra el producto más caro y el más barato.

**Ejercicio 24:** Suma el valor total del inventario (precio × stock de todos los productos).

**Ejercicio 25:** Cuenta cuántos productos hay por cada categoría.

**Ejercicio 26:** Calcula el total de ventas (suma de todos los pedidos).

**Ejercicio 27:** Encuentra el precio promedio por categoría.

**Ejercicio 28:** Cuenta cuántos pedidos hay en cada estado.

**Ejercicio 29:** Calcula cuántos días han pasado desde que cada cliente se registró.

**Ejercicio 30:** Muestra el mes y año de cada pedido en formato 'DD/MM/YYYY'.

---

## 📗 NIVEL INTERMEDIO

### Ejercicios de JOINs

**Ejercicio 31:** Lista todos los pedidos con el nombre completo del cliente.

**Ejercicio 32:** Muestra todos los productos vendidos con el nombre del cliente que los compró.

**Ejercicio 33:** Encuentra clientes que NO han hecho ningún pedido.

**Ejercicio 34:** Lista productos que nunca se han vendido.

**Ejercicio 35:** Muestra el total gastado por cada cliente.

**Ejercicio 36:** Lista los productos más vendidos (por cantidad de unidades).

**Ejercicio 37:** Encuentra qué productos se han comprado juntos (en el mismo pedido).

**Ejercicio 38:** Muestra las ventas totales por categoría de producto.

**Ejercicio 39:** Lista clientes con más de 2 pedidos.

**Ejercicio 40:** Encuentra el cliente que más ha gastado en total.

---

### Ejercicios de Subconsultas

**Ejercicio 41:** Encuentra productos con precio mayor al promedio.

**Ejercicio 42:** Lista clientes que han gastado más que el gasto promedio.

**Ejercicio 43:** Encuentra la categoría con más productos.

**Ejercicio 44:** Muestra productos más caros que todos los productos de 'Accesorios'.

**Ejercicio 45:** Lista pedidos con total mayor al promedio de pedidos.

**Ejercicio 46:** Encuentra el segundo producto más caro.

**Ejercicio 47:** Muestra categorías que tienen al menos un producto con precio > $10,000.

**Ejercicio 48:** Lista clientes que han comprado productos de todas las categorías.

**Ejercicio 49:** Encuentra productos cuyo precio está por encima del promedio de su categoría.

**Ejercicio 50:** Lista los 3 productos menos vendidos (pero que se han vendido al menos una vez).

---

### Ejercicios de GROUP BY y HAVING

**Ejercicio 51:** Cuenta productos por categoría, solo categorías con más de 3 productos.

**Ejercicio 52:** Encuentra clientes con gasto total mayor a $15,000.

**Ejercicio 53:** Categorías con valor de inventario mayor a $50,000.

**Ejercicio 54:** Meses con más de 5 pedidos.

**Ejercicio 55:** Productos vendidos más de 5 veces.

**Ejercicio 56:** Ciudades con más de 2 clientes.

**Ejercicio 57:** Categorías con precio promedio entre $2,000 y $10,000.

**Ejercicio 58:** Clientes con ticket promedio mayor a $5,000.

**Ejercicio 59:** Estados de pedidos con total acumulado mayor a $30,000.

**Ejercicio 60:** Productos con ingresos generados mayores a $20,000.

---

### Ejercicios de Funciones Avanzadas

**Ejercicio 61:** Crea un campo que clasifique productos como 'Barato', 'Medio', 'Caro', 'Premium'.

**Ejercicio 62:** Concatena nombre y apellido de clientes en MAYÚSCULAS.

**Ejercicio 63:** Extrae el dominio de email de cada cliente (después del @).

**Ejercicio 64:** Formatea todos los precios como '$X,XXX.XX'.

**Ejercicio 65:** Calcula la edad en días de cada pedido.

**Ejercicio 66:** Agrupa pedidos por trimestre del año.

**Ejercicio 67:** Crea un ranking de productos por precio dentro de cada categoría.

**Ejercicio 68:** Muestra cada producto con el precio del producto anterior y siguiente.

**Ejercicio 69:** Calcula la diferencia entre el precio de cada producto y el promedio de su categoría.

**Ejercicio 70:** Crea un reporte de ventas por día de la semana.

---

## 📕 NIVEL AVANZADO

### Ejercicios de Optimización

**Ejercicio 71:** Usa EXPLAIN para analizar la consulta de productos por categoría y crea índices apropiados.

**Ejercicio 72:** Optimiza una consulta que busca clientes por email.

**Ejercicio 73:** Crea índices compuestos para consultas frecuentes en pedidos.

**Ejercicio 74:** Compara rendimiento de IN vs EXISTS para encontrar clientes con pedidos.

**Ejercicio 75:** Analiza y optimiza una consulta con múltiples JOINs.

**Ejercicio 76:** Crea un índice FULLTEXT para búsqueda de productos.

**Ejercicio 77:** Revisa y elimina índices no utilizados.

**Ejercicio 78:** Optimiza una consulta que calcula estadísticas de ventas mensuales.

**Ejercicio 79:** Usa ANALYZE TABLE en todas las tablas y compara tiempos de ejecución.

**Ejercicio 80:** Crea un índice covering para una consulta específica.

---

### Ejercicios de Vistas

**Ejercicio 81:** Crea una vista de productos con bajo stock (< 15 unidades).

**Ejercicio 82:** Crea una vista de clientes VIP con sus estadísticas.

**Ejercicio 83:** Crea una vista de pedidos del mes actual.

**Ejercicio 84:** Crea una vista de productos más vendidos por categoría.

**Ejercicio 85:** Crea una vista de resumen de ventas diarias.

**Ejercicio 86:** Crea una vista materializada (tabla) con estadísticas de clientes.

**Ejercicio 87:** Crea una vista actualizable de información básica de clientes.

**Ejercicio 88:** Crea una vista que muestre productos que necesitan reabastecimiento.

**Ejercicio 89:** Crea una vista de análisis de carritos abandonados.

**Ejercicio 90:** Crea una vista de ranking de productos por ingresos.

---

### Ejercicios de Procedimientos Almacenados

**Ejercicio 91:** Crea un procedimiento que liste productos por categoría.

**Ejercicio 92:** Crea un procedimiento que calcule el total gastado por un cliente.

**Ejercicio 93:** Crea un procedimiento que aplique descuento a una categoría.

**Ejercicio 94:** Crea un procedimiento para registrar un nuevo pedido.

**Ejercicio 95:** Crea un procedimiento que genere reporte de ventas mensual.

**Ejercicio 96:** Crea un procedimiento con manejo de errores para transferir stock.

**Ejercicio 97:** Crea un procedimiento que actualice automáticamente el estado VIP de clientes.

**Ejercicio 98:** Crea un procedimiento para procesar devoluciones.

**Ejercicio 99:** Crea un procedimiento que calcule comisiones de ventas.

**Ejercicio 100:** Crea un procedimiento con cursor para enviar recordatorios.

---

### Ejercicios de Triggers

**Ejercicio 101:** Crea un trigger que audite cambios de precio en productos.

**Ejercicio 102:** Crea un trigger que actualice automáticamente el stock al vender.

**Ejercicio 103:** Crea un trigger que valide que el precio nunca sea negativo.

**Ejercicio 104:** Crea un trigger que registre historial de cambios en clientes.

**Ejercicio 105:** Crea un trigger que prevenga eliminar clientes con pedidos.

**Ejercicio 106:** Crea un trigger que actualice el campo fecha_actualizacion.

**Ejercicio 107:** Crea un trigger que valide stock suficiente antes de vender.

**Ejercicio 108:** Crea un trigger que calcule automáticamente el total del pedido.

**Ejercicio 109:** Crea un trigger que marque productos como inactivos si stock = 0.

**Ejercicio 110:** Crea un trigger que envíe alerta cuando stock esté bajo.

---

### Ejercicios de Transacciones

**Ejercicio 111:** Crea una transacción para transferir stock entre productos.

**Ejercicio 112:** Crea una transacción para procesar una venta completa.

**Ejercicio 113:** Crea una transacción con rollback en caso de error.

**Ejercicio 114:** Crea una transacción para actualizar precios de una categoría.

**Ejercicio 115:** Crea una transacción con savepoints para operaciones complejas.

---

### Proyectos Finales Integradores

**Proyecto 1: Sistema de Reportes**
Crea un conjunto completo de vistas y procedimientos para generar:
- Reporte de ventas diario, semanal, mensual, anual
- Análisis de productos más y menos vendidos
- Segmentación de clientes (VIP, Premium, Regular, Nuevo)
- Análisis de inventario y productos críticos
- Dashboard ejecutivo con KPIs principales

**Proyecto 2: Sistema de Auditoría**
Implementa un sistema completo de auditoría que incluya:
- Tablas de auditoría para todas las tablas principales
- Triggers para registrar todos los cambios (INSERT, UPDATE, DELETE)
- Procedimientos para consultar historial de cambios
- Vistas para reportes de auditoría

**Proyecto 3: Sistema de Alertas Automáticas**
Crea un sistema que:
- Detecte productos con stock bajo y genere alertas
- Identifique clientes inactivos (sin compras en 90 días)
- Marque pedidos con retraso en envío
- Genere reportes automáticos de anomalías

**Proyecto 4: Optimización Completa**
Realiza una optimización completa de la base de datos:
- Analiza todas las consultas lentas
- Crea índices óptimos
- Elimina índices redundantes
- Optimiza procedimientos almacenados
- Implementa caching donde sea apropiado
- Documenta todas las mejoras y su impacto

**Proyecto 5: API de Consultas**
Diseña un conjunto de procedimientos almacenados que sirvan como API para:
- CRUD completo de clientes
- CRUD completo de productos
- Procesamiento de pedidos
- Consultas de reportes
- Sistema de búsqueda avanzada

---

## 💡 Consejos para Resolver los Ejercicios

1. **Lee cuidadosamente** el enunciado antes de comenzar.
2. **Planifica** tu consulta antes de escribirla.
3. **Prueba con SELECT** antes de hacer UPDATE o DELETE.
4. **Usa EXPLAIN** para entender cómo se ejecutan tus consultas.
5. **Comenta tu código** para documentar tu razonamiento.
6. **Compara** tu solución con alternativas más eficientes.
7. **Practica regularmente** - la consistencia es clave.
8. **No te frustres** - algunos ejercicios son desafiantes.
9. **Consulta la documentación** cuando tengas dudas.
10. **Experimenta** con variaciones de las soluciones.

---

## 🎯 Sistema de Evaluación

- **Principiante (1-30):** Fundamentos básicos de SQL
- **Intermedio (31-70):** Consultas complejas y análisis de datos
- **Avanzado (71-115):** Optimización, programación y proyectos

**Meta sugerida:**
- Completa al menos 80% de ejercicios de principiante
- Completa al menos 60% de ejercicios de intermedio
- Completa al menos 40% de ejercicios de avanzado
- Completa al menos 2 proyectos finales

---

## 📚 Recursos Adicionales

- Documentación oficial de MySQL: https://dev.mysql.com/doc/
- SQL Tutorial: https://www.sqltutorial.org/
- Práctica en línea: https://sqlzoo.net/
- Ejercicios adicionales: https://www.hackerrank.com/domains/sql

---

¡Mucho éxito en tu aprendizaje de SQL! 🚀
