      ******************************************************************
      * EJEMPLO 13: TABLAS - GESTIÓN DE CALIFICACIONES
      * Descripción: Uso de tablas (arreglos) para almacenar datos
      * Conceptos: OCCURS, índices, búsqueda, estadísticas
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. TABLAS-CALIFICACIONES.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *--- Tabla de estudiantes ---*
       01  WS-CLASE.
           05  WS-ESTUDIANTE OCCURS 10 TIMES INDEXED BY WS-IDX.
               10  WS-EST-NOMBRE       PIC X(30).
               10  WS-EST-MATRICULA    PIC 9(6).
               10  WS-EST-CALIF1       PIC 999V99.
               10  WS-EST-CALIF2       PIC 999V99.
               10  WS-EST-CALIF3       PIC 999V99.
               10  WS-EST-PROMEDIO     PIC 999V99.

      *--- Variables de control ---*
       01  WS-NUM-ESTUDIANTES          PIC 99 VALUE 0.
       01  WS-CONTADOR                 PIC 99 VALUE 0.
       01  WS-OPCION                   PIC 9.
       01  WS-CONTINUAR                PIC X VALUE 'S'.

      *--- Variables para búsqueda ---*
       01  WS-BUSCAR-NOMBRE            PIC X(30).
       01  WS-ENCONTRADO               PIC X VALUE 'N'.

      *--- Variables para estadísticas ---*
       01  WS-PROMEDIO-CLASE           PIC 999V99.
       01  WS-SUMA-PROMEDIOS           PIC 9999V99 VALUE 0.
       01  WS-MEJOR-PROMEDIO           PIC 999V99 VALUE 0.
       01  WS-PEOR-PROMEDIO            PIC 999V99 VALUE 999.99.
       01  WS-POS-MEJOR                PIC 99.
       01  WS-POS-PEOR                 PIC 99.

       PROCEDURE DIVISION.

       MAIN-LOGIC.
           PERFORM MOSTRAR-BIENVENIDA.

           PERFORM UNTIL WS-CONTINUAR = 'N' OR WS-CONTINUAR = 'n'
               PERFORM MOSTRAR-MENU
               PERFORM SOLICITAR-OPCION
               PERFORM PROCESAR-OPCION
           END-PERFORM.

           STOP RUN.

       MOSTRAR-BIENVENIDA.
           DISPLAY " ".
           DISPLAY "╔═══════════════════════════════════════════════╗".
           DISPLAY "║   GESTIÓN DE CALIFICACIONES CON TABLAS       ║".
           DISPLAY "║   Aprende OCCURS en COBOL                    ║".
           DISPLAY "╚═══════════════════════════════════════════════╝".
           DISPLAY " ".

       MOSTRAR-MENU.
           DISPLAY "┌───────────────────────────────────────────────┐".
           DISPLAY "│  1. Agregar estudiante                        │".
           DISPLAY "│  2. Mostrar todos los estudiantes             │".
           DISPLAY "│  3. Buscar estudiante por nombre              │".
           DISPLAY "│  4. Calcular promedios                        │".
           DISPLAY "│  5. Mostrar estadísticas                      │".
           DISPLAY "│  6. Salir                                     │".
           DISPLAY "└───────────────────────────────────────────────┘".
           DISPLAY " ".

       SOLICITAR-OPCION.
           DISPLAY "Opción: " WITH NO ADVANCING.
           ACCEPT WS-OPCION.
           DISPLAY " ".

       PROCESAR-OPCION.
           EVALUATE WS-OPCION
               WHEN 1
                   PERFORM AGREGAR-ESTUDIANTE
               WHEN 2
                   PERFORM MOSTRAR-ESTUDIANTES
               WHEN 3
                   PERFORM BUSCAR-ESTUDIANTE
               WHEN 4
                   PERFORM CALCULAR-PROMEDIOS
               WHEN 5
                   PERFORM MOSTRAR-ESTADISTICAS
               WHEN 6
                   MOVE 'N' TO WS-CONTINUAR
               WHEN OTHER
                   DISPLAY "❌ Opción inválida"
                   DISPLAY " "
           END-EVALUATE.

      *--- Agregar estudiante a la tabla ---*
       AGREGAR-ESTUDIANTE.
           IF WS-NUM-ESTUDIANTES >= 10 THEN
               DISPLAY "⚠️  La clase está llena (máximo 10 estudiantes)"
               DISPLAY " "
               PERFORM PAUSAR
               GO TO AGREGAR-ESTUDIANTE-FIN
           END-IF.

           ADD 1 TO WS-NUM-ESTUDIANTES.
           SET WS-IDX TO WS-NUM-ESTUDIANTES.

           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY "  AGREGAR ESTUDIANTE #" WS-NUM-ESTUDIANTES.
           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY " ".

           DISPLAY "Nombre: " WITH NO ADVANCING.
           ACCEPT WS-EST-NOMBRE(WS-IDX).

           DISPLAY "Matrícula: " WITH NO ADVANCING.
           ACCEPT WS-EST-MATRICULA(WS-IDX).

           DISPLAY "Calificación 1: " WITH NO ADVANCING.
           ACCEPT WS-EST-CALIF1(WS-IDX).

           DISPLAY "Calificación 2: " WITH NO ADVANCING.
           ACCEPT WS-EST-CALIF2(WS-IDX).

           DISPLAY "Calificación 3: " WITH NO ADVANCING.
           ACCEPT WS-EST-CALIF3(WS-IDX).

      *    Calcular promedio automáticamente
           COMPUTE WS-EST-PROMEDIO(WS-IDX) =
               (WS-EST-CALIF1(WS-IDX) +
                WS-EST-CALIF2(WS-IDX) +
                WS-EST-CALIF3(WS-IDX)) / 3.

           DISPLAY " ".
           DISPLAY "✅ Estudiante agregado con promedio: "
                   WS-EST-PROMEDIO(WS-IDX).
           DISPLAY " ".
           PERFORM PAUSAR.

       AGREGAR-ESTUDIANTE-FIN.
           EXIT.

      *--- Mostrar todos los estudiantes ---*
       MOSTRAR-ESTUDIANTES.
           IF WS-NUM-ESTUDIANTES = 0 THEN
               DISPLAY "⚠️  No hay estudiantes registrados"
               DISPLAY " "
               PERFORM PAUSAR
               GO TO MOSTRAR-ESTUDIANTES-FIN
           END-IF.

           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY "  LISTADO DE ESTUDIANTES".
           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY " ".

           DISPLAY "# | NOMBRE              | MATR.  | PROM.".
           DISPLAY "--+---------------------+--------+--------".

      *    Recorrer la tabla con PERFORM VARYING
           PERFORM VARYING WS-CONTADOR FROM 1 BY 1
               UNTIL WS-CONTADOR > WS-NUM-ESTUDIANTES

               SET WS-IDX TO WS-CONTADOR

               DISPLAY WS-CONTADOR " | "
                       WS-EST-NOMBRE(WS-IDX) " | "
                       WS-EST-MATRICULA(WS-IDX) " | "
                       WS-EST-PROMEDIO(WS-IDX)
           END-PERFORM.

           DISPLAY " ".
           DISPLAY "Total: " WS-NUM-ESTUDIANTES " estudiantes".
           DISPLAY " ".
           PERFORM PAUSAR.

       MOSTRAR-ESTUDIANTES-FIN.
           EXIT.

      *--- Buscar estudiante por nombre ---*
       BUSCAR-ESTUDIANTE.
           IF WS-NUM-ESTUDIANTES = 0 THEN
               DISPLAY "⚠️  No hay estudiantes registrados"
               DISPLAY " "
               PERFORM PAUSAR
               GO TO BUSCAR-ESTUDIANTE-FIN
           END-IF.

           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY "  BUSCAR ESTUDIANTE".
           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY " ".

           DISPLAY "Nombre a buscar: " WITH NO ADVANCING.
           ACCEPT WS-BUSCAR-NOMBRE.

           MOVE 'N' TO WS-ENCONTRADO.

      *    Búsqueda secuencial en la tabla
           PERFORM VARYING WS-CONTADOR FROM 1 BY 1
               UNTIL WS-CONTADOR > WS-NUM-ESTUDIANTES
                  OR WS-ENCONTRADO = 'S'

               SET WS-IDX TO WS-CONTADOR

      *        Comparación case-insensitive
               IF FUNCTION UPPER-CASE(WS-EST-NOMBRE(WS-IDX)) =
                  FUNCTION UPPER-CASE(WS-BUSCAR-NOMBRE) THEN
                   MOVE 'S' TO WS-ENCONTRADO
                   DISPLAY " "
                   DISPLAY "✅ Estudiante encontrado:"
                   DISPLAY " "
                   DISPLAY "  Nombre:         " WS-EST-NOMBRE(WS-IDX)
                   DISPLAY "  Matrícula:      " WS-EST-MATRICULA(WS-IDX)
                   DISPLAY "  Calificación 1: " WS-EST-CALIF1(WS-IDX)
                   DISPLAY "  Calificación 2: " WS-EST-CALIF2(WS-IDX)
                   DISPLAY "  Calificación 3: " WS-EST-CALIF3(WS-IDX)
                   DISPLAY "  Promedio:       " WS-EST-PROMEDIO(WS-IDX)
               END-IF
           END-PERFORM.

           IF WS-ENCONTRADO = 'N' THEN
               DISPLAY " "
               DISPLAY "❌ Estudiante no encontrado"
           END-IF.

           DISPLAY " ".
           PERFORM PAUSAR.

       BUSCAR-ESTUDIANTE-FIN.
           EXIT.

      *--- Calcular todos los promedios ---*
       CALCULAR-PROMEDIOS.
           IF WS-NUM-ESTUDIANTES = 0 THEN
               DISPLAY "⚠️  No hay estudiantes registrados"
               DISPLAY " "
               PERFORM PAUSAR
               GO TO CALCULAR-PROMEDIOS-FIN
           END-IF.

           DISPLAY "Recalculando promedios...".

           PERFORM VARYING WS-CONTADOR FROM 1 BY 1
               UNTIL WS-CONTADOR > WS-NUM-ESTUDIANTES

               SET WS-IDX TO WS-CONTADOR

               COMPUTE WS-EST-PROMEDIO(WS-IDX) =
                   (WS-EST-CALIF1(WS-IDX) +
                    WS-EST-CALIF2(WS-IDX) +
                    WS-EST-CALIF3(WS-IDX)) / 3
           END-PERFORM.

           DISPLAY "✅ Promedios actualizados".
           DISPLAY " ".
           PERFORM PAUSAR.

       CALCULAR-PROMEDIOS-FIN.
           EXIT.

      *--- Mostrar estadísticas de la clase ---*
       MOSTRAR-ESTADISTICAS.
           IF WS-NUM-ESTUDIANTES = 0 THEN
               DISPLAY "⚠️  No hay estudiantes registrados"
               DISPLAY " "
               PERFORM PAUSAR
               GO TO MOSTRAR-ESTADISTICAS-FIN
           END-IF.

      *    Inicializar variables
           MOVE 0 TO WS-SUMA-PROMEDIOS.
           MOVE 0 TO WS-MEJOR-PROMEDIO.
           MOVE 999.99 TO WS-PEOR-PROMEDIO.

      *    Calcular estadísticas
           PERFORM VARYING WS-CONTADOR FROM 1 BY 1
               UNTIL WS-CONTADOR > WS-NUM-ESTUDIANTES

               SET WS-IDX TO WS-CONTADOR

      *        Suma para promedio
               ADD WS-EST-PROMEDIO(WS-IDX) TO WS-SUMA-PROMEDIOS

      *        Buscar mejor
               IF WS-EST-PROMEDIO(WS-IDX) > WS-MEJOR-PROMEDIO THEN
                   MOVE WS-EST-PROMEDIO(WS-IDX) TO WS-MEJOR-PROMEDIO
                   MOVE WS-CONTADOR TO WS-POS-MEJOR
               END-IF

      *        Buscar peor
               IF WS-EST-PROMEDIO(WS-IDX) < WS-PEOR-PROMEDIO THEN
                   MOVE WS-EST-PROMEDIO(WS-IDX) TO WS-PEOR-PROMEDIO
                   MOVE WS-CONTADOR TO WS-POS-PEOR
               END-IF
           END-PERFORM.

      *    Calcular promedio de clase
           COMPUTE WS-PROMEDIO-CLASE =
               WS-SUMA-PROMEDIOS / WS-NUM-ESTUDIANTES.

      *    Mostrar resultados
           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY "  ESTADÍSTICAS DE LA CLASE".
           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY " ".
           DISPLAY "📊 RESUMEN:".
           DISPLAY "  Total estudiantes:  " WS-NUM-ESTUDIANTES.
           DISPLAY "  Promedio de clase:  " WS-PROMEDIO-CLASE.
           DISPLAY " ".
           DISPLAY "🏆 MEJOR ESTUDIANTE:".
           SET WS-IDX TO WS-POS-MEJOR.
           DISPLAY "  " WS-EST-NOMBRE(WS-IDX).
           DISPLAY "  Promedio: " WS-MEJOR-PROMEDIO.
           DISPLAY " ".
           DISPLAY "⚠️  ESTUDIANTE CON PROMEDIO MÁS BAJO:".
           SET WS-IDX TO WS-POS-PEOR.
           DISPLAY "  " WS-EST-NOMBRE(WS-IDX).
           DISPLAY "  Promedio: " WS-PEOR-PROMEDIO.
           DISPLAY " ".
           PERFORM PAUSAR.

       MOSTRAR-ESTADISTICAS-FIN.
           EXIT.

       PAUSAR.
           DISPLAY "Presiona ENTER..." WITH NO ADVANCING.
           ACCEPT WS-OPCION.
           DISPLAY " ".

      *----------------------------------------------------------------*
      * EXPLICACIÓN:
      *
      * OCCURS:
      *   Define una tabla (arreglo) de elementos repetidos
      *   OCCURS 10 TIMES = 10 elementos
      *
      * INDEXED BY:
      *   Define un índice para recorrer la tabla
      *   Más eficiente que subscript numérico
      *
      * SET:
      *   Asigna valor al índice
      *   SET WS-IDX TO 1
      *
      * Acceso a elementos:
      *   Usar paréntesis con índice o subscript
      *   WS-EST-NOMBRE(WS-IDX)
      *   WS-EST-NOMBRE(1)
      *
      * PERFORM VARYING con tablas:
      *   Recorre todos los elementos
      *   FROM inicio BY incremento UNTIL condición
      *
      * PARA COMPILAR Y EJECUTAR:
      * cobc -x -free ejemplo-13-tablas-calificaciones.cob
      * ./ejemplo-13-tablas-calificaciones
      *----------------------------------------------------------------*
