      ******************************************************************
      * EJEMPLO 10: ARCHIVO INDEXADO - CRUD COMPLETO
      * Descripción: Operaciones completas con archivo indexado (VSAM)
      * Conceptos: INDEXED, RECORD KEY, RANDOM ACCESS, CRUD
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. ARCHIVO-INDEXADO.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *    Archivo indexado de productos
           SELECT ARCHIVO-PRODUCTOS
               ASSIGN TO "productos.dat"
               ORGANIZATION IS INDEXED
               ACCESS MODE IS DYNAMIC
               RECORD KEY IS PROD-CODIGO
               ALTERNATE RECORD KEY IS PROD-NOMBRE
                   WITH DUPLICATES
               FILE STATUS IS WS-FILE-STATUS.

       DATA DIVISION.

       FILE SECTION.
       FD  ARCHIVO-PRODUCTOS.
       01  REG-PRODUCTO.
           05  PROD-CODIGO       PIC X(10).
           05  PROD-NOMBRE       PIC X(50).
           05  PROD-CATEGORIA    PIC X(20).
           05  PROD-PRECIO       PIC 9(6)V99.
           05  PROD-STOCK        PIC 9(5).
           05  PROD-ACTIVO       PIC X.

       WORKING-STORAGE SECTION.

       01  WS-FILE-STATUS        PIC XX.
           88  WS-OK             VALUE "00".
           88  WS-EOF            VALUE "10".
           88  WS-DUPLICADO      VALUE "22".
           88  WS-NO-ENCONTRADO  VALUE "23".
           88  WS-NO-EXISTE      VALUE "35".

       01  WS-OPCION             PIC 99.
       01  WS-CONTINUAR          PIC X VALUE 'S'.
       01  WS-CONFIRMA           PIC X.
       01  WS-FIN-ARCHIVO        PIC X VALUE 'N'.
       01  WS-CONTADOR           PIC 9999 VALUE ZEROS.

      *--- Buffer de trabajo ---*
       01  WS-PRODUCTO.
           05  WS-CODIGO         PIC X(10).
           05  WS-NOMBRE         PIC X(50).
           05  WS-CATEGORIA      PIC X(20).
           05  WS-PRECIO         PIC 9(6)V99.
           05  WS-STOCK          PIC 9(5).
           05  WS-ACTIVO         PIC X.
               88  WS-PROD-ACTIVO   VALUE 'S'.
               88  WS-PROD-INACTIVO VALUE 'N'.

       PROCEDURE DIVISION.

       MAIN-LOGIC.
           PERFORM MOSTRAR-BIENVENIDA.

           PERFORM UNTIL WS-CONTINUAR = 'N' OR WS-CONTINUAR = 'n'
               PERFORM MOSTRAR-MENU
               PERFORM SOLICITAR-OPCION
               PERFORM PROCESAR-OPCION
           END-PERFORM.

           DISPLAY "¡Hasta luego!".
           STOP RUN.

       MOSTRAR-BIENVENIDA.
           DISPLAY " ".
           DISPLAY "╔═══════════════════════════════════════════════╗".
           DISPLAY "║   SISTEMA DE INVENTARIO - ARCHIVO INDEXADO   ║".
           DISPLAY "║   CRUD Completo con VSAM                     ║".
           DISPLAY "╚═══════════════════════════════════════════════╝".
           DISPLAY " ".

       MOSTRAR-MENU.
           DISPLAY "┌───────────────────────────────────────────────┐".
           DISPLAY "│  1. ➕ Crear producto (CREATE)                │".
           DISPLAY "│  2. 🔍 Buscar producto (READ)                 │".
           DISPLAY "│  3. ✏️  Actualizar producto (UPDATE)           │".
           DISPLAY "│  4. ❌ Eliminar producto (DELETE)              │".
           DISPLAY "│  5. 📋 Listar todos los productos             │".
           DISPLAY "│  6. 📊 Estadísticas                           │".
           DISPLAY "│  7. 🚪 Salir                                  │".
           DISPLAY "└───────────────────────────────────────────────┘".
           DISPLAY " ".

       SOLICITAR-OPCION.
           DISPLAY "Opción: " WITH NO ADVANCING.
           ACCEPT WS-OPCION.
           DISPLAY " ".

       PROCESAR-OPCION.
           EVALUATE WS-OPCION
               WHEN 1
                   PERFORM CREAR-PRODUCTO
               WHEN 2
                   PERFORM BUSCAR-PRODUCTO
               WHEN 3
                   PERFORM ACTUALIZAR-PRODUCTO
               WHEN 4
                   PERFORM ELIMINAR-PRODUCTO
               WHEN 5
                   PERFORM LISTAR-PRODUCTOS
               WHEN 6
                   PERFORM MOSTRAR-ESTADISTICAS
               WHEN 7
                   MOVE 'N' TO WS-CONTINUAR
               WHEN OTHER
                   DISPLAY "❌ Opción inválida."
                   DISPLAY " "
           END-EVALUATE.

      *-----------------------------------------------------------------*
      * CREATE - Agregar nuevo producto
      *-----------------------------------------------------------------*
       CREAR-PRODUCTO.
           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY "  ➕ CREAR NUEVO PRODUCTO".
           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY " ".

      *    Solicitar datos
           DISPLAY "Código (10 caracteres): " WITH NO ADVANCING.
           ACCEPT WS-CODIGO.

           DISPLAY "Nombre del producto: " WITH NO ADVANCING.
           ACCEPT WS-NOMBRE.

           DISPLAY "Categoría: " WITH NO ADVANCING.
           ACCEPT WS-CATEGORIA.

           DISPLAY "Precio: $" WITH NO ADVANCING.
           ACCEPT WS-PRECIO.

           DISPLAY "Stock inicial: " WITH NO ADVANCING.
           ACCEPT WS-STOCK.

           SET WS-PROD-ACTIVO TO TRUE.

      *    Abrir archivo en modo I-O (lectura/escritura)
           OPEN I-O ARCHIVO-PRODUCTOS.

      *    Si no existe, crear nuevo
           IF WS-NO-EXISTE THEN
               OPEN OUTPUT ARCHIVO-PRODUCTOS
               CLOSE ARCHIVO-PRODUCTOS
               OPEN I-O ARCHIVO-PRODUCTOS
           END-IF.

           IF NOT WS-OK THEN
               DISPLAY " "
               DISPLAY "❌ Error abriendo archivo: " WS-FILE-STATUS
               DISPLAY " "
               CLOSE ARCHIVO-PRODUCTOS
               PERFORM PAUSAR
               GO TO CREAR-PRODUCTO-FIN
           END-IF.

      *    Copiar datos al registro
           MOVE WS-CODIGO TO PROD-CODIGO.
           MOVE WS-NOMBRE TO PROD-NOMBRE.
           MOVE WS-CATEGORIA TO PROD-CATEGORIA.
           MOVE WS-PRECIO TO PROD-PRECIO.
           MOVE WS-STOCK TO PROD-STOCK.
           MOVE WS-ACTIVO TO PROD-ACTIVO.

      *    Escribir registro
           WRITE REG-PRODUCTO
               INVALID KEY
                   IF WS-DUPLICADO THEN
                       DISPLAY " "
                       DISPLAY "❌ Error: Ya existe producto con ese código"
                   ELSE
                       DISPLAY " "
                       DISPLAY "❌ Error escribiendo: " WS-FILE-STATUS
                   END-IF
               NOT INVALID KEY
                   DISPLAY " "
                   DISPLAY "✅ Producto creado exitosamente!"
                   DISPLAY " "
                   PERFORM MOSTRAR-PRODUCTO
           END-WRITE.

           CLOSE ARCHIVO-PRODUCTOS.
           DISPLAY " ".
           PERFORM PAUSAR.

       CREAR-PRODUCTO-FIN.
           EXIT.

      *-----------------------------------------------------------------*
      * READ - Buscar producto por código
      *-----------------------------------------------------------------*
       BUSCAR-PRODUCTO.
           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY "  🔍 BUSCAR PRODUCTO".
           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY " ".

           DISPLAY "Código del producto: " WITH NO ADVANCING.
           ACCEPT WS-CODIGO.

      *    Abrir archivo
           OPEN INPUT ARCHIVO-PRODUCTOS.

           IF NOT WS-OK THEN
               IF WS-NO-EXISTE THEN
                   DISPLAY " "
                   DISPLAY "⚠️  No hay productos registrados."
               ELSE
                   DISPLAY " "
                   DISPLAY "❌ Error: " WS-FILE-STATUS
               END-IF
               DISPLAY " "
               CLOSE ARCHIVO-PRODUCTOS
               PERFORM PAUSAR
               GO TO BUSCAR-PRODUCTO-FIN
           END-IF.

      *    Buscar por clave
           MOVE WS-CODIGO TO PROD-CODIGO.

           READ ARCHIVO-PRODUCTOS
               INVALID KEY
                   DISPLAY " "
                   DISPLAY "❌ Producto no encontrado: " WS-CODIGO
                   DISPLAY " "
               NOT INVALID KEY
                   DISPLAY " "
                   DISPLAY "✅ Producto encontrado:"
                   DISPLAY " "
                   PERFORM MOSTRAR-PRODUCTO
           END-READ.

           CLOSE ARCHIVO-PRODUCTOS.
           PERFORM PAUSAR.

       BUSCAR-PRODUCTO-FIN.
           EXIT.

      *-----------------------------------------------------------------*
      * UPDATE - Actualizar producto existente
      *-----------------------------------------------------------------*
       ACTUALIZAR-PRODUCTO.
           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY "  ✏️  ACTUALIZAR PRODUCTO".
           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY " ".

           DISPLAY "Código del producto: " WITH NO ADVANCING.
           ACCEPT WS-CODIGO.

      *    Abrir archivo I-O
           OPEN I-O ARCHIVO-PRODUCTOS.

           IF NOT WS-OK THEN
               DISPLAY " "
               DISPLAY "❌ Error: " WS-FILE-STATUS
               DISPLAY " "
               CLOSE ARCHIVO-PRODUCTOS
               PERFORM PAUSAR
               GO TO ACTUALIZAR-PRODUCTO-FIN
           END-IF.

      *    Primero leer el producto actual
           MOVE WS-CODIGO TO PROD-CODIGO.

           READ ARCHIVO-PRODUCTOS
               INVALID KEY
                   DISPLAY " "
                   DISPLAY "❌ Producto no encontrado"
                   DISPLAY " "
                   CLOSE ARCHIVO-PRODUCTOS
                   PERFORM PAUSAR
                   GO TO ACTUALIZAR-PRODUCTO-FIN
           END-READ.

      *    Mostrar datos actuales
           DISPLAY " ".
           DISPLAY "DATOS ACTUALES:".
           PERFORM MOSTRAR-PRODUCTO.
           DISPLAY " ".

      *    Pedir nuevos datos
           DISPLAY "NUEVOS DATOS (Enter para mantener actual):".
           DISPLAY " ".

           DISPLAY "Nuevo precio (" PROD-PRECIO "): $"
               WITH NO ADVANCING.
           ACCEPT WS-PRECIO.
           IF WS-PRECIO NOT = ZEROS THEN
               MOVE WS-PRECIO TO PROD-PRECIO
           END-IF.

           DISPLAY "Nuevo stock (" PROD-STOCK "): "
               WITH NO ADVANCING.
           ACCEPT WS-STOCK.
           IF WS-STOCK NOT = ZEROS THEN
               MOVE WS-STOCK TO PROD-STOCK
           END-IF.

      *    Actualizar registro
           REWRITE REG-PRODUCTO
               INVALID KEY
                   DISPLAY " "
                   DISPLAY "❌ Error actualizando: " WS-FILE-STATUS
               NOT INVALID KEY
                   DISPLAY " "
                   DISPLAY "✅ Producto actualizado exitosamente!"
                   DISPLAY " "
                   PERFORM MOSTRAR-PRODUCTO
           END-REWRITE.

           CLOSE ARCHIVO-PRODUCTOS.
           DISPLAY " ".
           PERFORM PAUSAR.

       ACTUALIZAR-PRODUCTO-FIN.
           EXIT.

      *-----------------------------------------------------------------*
      * DELETE - Eliminar producto
      *-----------------------------------------------------------------*
       ELIMINAR-PRODUCTO.
           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY "  ❌ ELIMINAR PRODUCTO".
           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY " ".

           DISPLAY "Código del producto: " WITH NO ADVANCING.
           ACCEPT WS-CODIGO.

           OPEN I-O ARCHIVO-PRODUCTOS.

           IF NOT WS-OK THEN
               DISPLAY " "
               DISPLAY "❌ Error: " WS-FILE-STATUS
               DISPLAY " "
               CLOSE ARCHIVO-PRODUCTOS
               PERFORM PAUSAR
               GO TO ELIMINAR-PRODUCTO-FIN
           END-IF.

      *    Primero leer para confirmar
           MOVE WS-CODIGO TO PROD-CODIGO.

           READ ARCHIVO-PRODUCTOS
               INVALID KEY
                   DISPLAY " "
                   DISPLAY "❌ Producto no encontrado"
                   DISPLAY " "
                   CLOSE ARCHIVO-PRODUCTOS
                   PERFORM PAUSAR
                   GO TO ELIMINAR-PRODUCTO-FIN
           END-READ.

      *    Mostrar y confirmar
           DISPLAY " ".
           PERFORM MOSTRAR-PRODUCTO.
           DISPLAY " ".
           DISPLAY "¿Confirmas eliminación? (S/N): "
               WITH NO ADVANCING.
           ACCEPT WS-CONFIRMA.

           IF WS-CONFIRMA = 'S' OR WS-CONFIRMA = 's' THEN
               DELETE ARCHIVO-PRODUCTOS
                   INVALID KEY
                       DISPLAY " "
                       DISPLAY "❌ Error eliminando: " WS-FILE-STATUS
                   NOT INVALID KEY
                       DISPLAY " "
                       DISPLAY "✅ Producto eliminado exitosamente!"
               END-DELETE
           ELSE
               DISPLAY " "
               DISPLAY "Eliminación cancelada."
           END-IF.

           CLOSE ARCHIVO-PRODUCTOS.
           DISPLAY " ".
           PERFORM PAUSAR.

       ELIMINAR-PRODUCTO-FIN.
           EXIT.

      *--- Listar todos los productos ---*
       LISTAR-PRODUCTOS.
           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY "  📋 LISTADO DE PRODUCTOS".
           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY " ".

           OPEN INPUT ARCHIVO-PRODUCTOS.

           IF NOT WS-OK THEN
               DISPLAY "⚠️  No hay productos."
               DISPLAY " "
               PERFORM PAUSAR
               GO TO LISTAR-PRODUCTOS-FIN
           END-IF.

           DISPLAY "CÓDIGO     | NOMBRE                 | PRECIO    ".
           DISPLAY "-----------+------------------------+-----------".

           MOVE 'N' TO WS-FIN-ARCHIVO.
           MOVE ZEROS TO WS-CONTADOR.

           PERFORM UNTIL WS-FIN-ARCHIVO = 'S'
               READ ARCHIVO-PRODUCTOS NEXT
                   AT END
                       MOVE 'S' TO WS-FIN-ARCHIVO
                   NOT AT END
                       ADD 1 TO WS-CONTADOR
                       DISPLAY PROD-CODIGO " | " PROD-NOMBRE " | $"
                               PROD-PRECIO
               END-READ
           END-PERFORM.

           DISPLAY " ".
           DISPLAY "Total: " WS-CONTADOR " productos.".

           CLOSE ARCHIVO-PRODUCTOS.
           DISPLAY " ".
           PERFORM PAUSAR.

       LISTAR-PRODUCTOS-FIN.
           EXIT.

      *--- Estadísticas ---*
       MOSTRAR-ESTADISTICAS.
           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY "  📊 ESTADÍSTICAS DEL INVENTARIO".
           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY " ".

      *    Implementación similar a LISTAR-PRODUCTOS
      *    pero calculando totales y promedios

           DISPLAY "⚠️  Función en desarrollo.".
           DISPLAY " ".
           PERFORM PAUSAR.

      *--- Muestra datos del producto actual ---*
       MOSTRAR-PRODUCTO.
           DISPLAY "┌───────────────────────────────────────────────┐".
           DISPLAY "│  Código:    " PROD-CODIGO.
           DISPLAY "│  Nombre:    " PROD-NOMBRE.
           DISPLAY "│  Categoría: " PROD-CATEGORIA.
           DISPLAY "│  Precio:    $" PROD-PRECIO.
           DISPLAY "│  Stock:     " PROD-STOCK " unidades".
           DISPLAY "│  Estado:    " WITH NO ADVANCING.
           IF PROD-ACTIVO = 'S' THEN
               DISPLAY "Activo"
           ELSE
               DISPLAY "Inactivo"
           END-IF.
           DISPLAY "└───────────────────────────────────────────────┘".

       PAUSAR.
           DISPLAY "Presiona ENTER..." WITH NO ADVANCING.
           ACCEPT WS-CONFIRMA.
           DISPLAY " ".

      *----------------------------------------------------------------*
      * EXPLICACIÓN DETALLADA:
      *
      * ORGANIZATION IS INDEXED:
      *   - Permite acceso directo por clave
      *   - También permite acceso secuencial
      *   - Más eficiente para búsquedas
      *
      * ACCESS MODE IS DYNAMIC:
      *   - Combina SEQUENTIAL y RANDOM
      *   - READ con clave = acceso directo
      *   - READ NEXT = acceso secuencial
      *
      * RECORD KEY:
      *   - Clave primaria del archivo
      *   - Debe ser única
      *   - Se usa para READ, REWRITE, DELETE
      *
      * ALTERNATE RECORD KEY:
      *   - Claves secundarias (índices adicionales)
      *   - WITH DUPLICATES permite valores repetidos
      *   - Útil para búsquedas por otros campos
      *
      * INVALID KEY:
      *   - Ejecuta cuando operación falla por problema de clave
      *   - Código 22 = duplicado en WRITE
      *   - Código 23 = no encontrado en READ/REWRITE/DELETE
      *
      * CRUD COMPLETO:
      *   CREATE  - WRITE con verificación de INVALID KEY
      *   READ    - READ con clave específica
      *   UPDATE  - READ seguido de REWRITE
      *   DELETE  - READ seguido de DELETE
      *
      * REWRITE:
      *   - Actualiza registro existente
      *   - Debe hacer READ primero
      *   - No puede cambiar la RECORD KEY
      *   - Solo en archivos I-O
      *
      * DELETE:
      *   - Elimina registro actual
      *   - Debe hacer READ primero
      *   - Marca como eliminado (no libera espacio inmediatamente)
      *
      * READ NEXT:
      *   - Lee siguiente registro en orden de clave
      *   - Útil para listar todos los registros
      *   - Funciona con ACCESS DYNAMIC o SEQUENTIAL
      *
      * PARA COMPILAR Y EJECUTAR:
      * cobc -x -free ejemplo-10-archivo-indexado.cob
      * ./ejemplo-10-archivo-indexado
      *
      * NOTA: El archivo .dat será binario, no legible con editores
      *
      * EJERCICIO:
      * Completa las estadísticas para calcular:
      * 1. Valor total del inventario (precio × stock)
      * 2. Productos con bajo stock (menos de 10)
      * 3. Categoría con más productos
      * 4. Precio promedio
      *----------------------------------------------------------------*
