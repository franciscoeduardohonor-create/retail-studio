      ******************************************************************
      * EJEMPLO 8: BUCLES Y PROCESAMIENTO DE LOTES
      * Descripción: Diferentes tipos de bucles en COBOL
      * Conceptos: PERFORM TIMES, PERFORM UNTIL, PERFORM VARYING
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. PROCESAMIENTO-LOTES.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *--- Variables de control de bucles ---*
       01  WS-CONTADOR           PIC 999 VALUE ZEROS.
       01  WS-INDICE             PIC 999 VALUE ZEROS.
       01  WS-FILA               PIC 99 VALUE ZEROS.
       01  WS-COLUMNA            PIC 99 VALUE ZEROS.

      *--- Datos para procesamiento ---*
       01  WS-NUMERO             PIC 999 VALUE ZEROS.
       01  WS-SUMA               PIC 9(6) VALUE ZEROS.
       01  WS-PRODUCTO           PIC 9(8) VALUE 1.
       01  WS-PROMEDIO           PIC 9(4)V99 VALUE ZEROS.

      *--- Datos de ventas para ejemplo ---*
       01  WS-VENTA-DIA          PIC 9(6)V99 VALUE ZEROS.
       01  WS-TOTAL-VENTAS       PIC 9(8)V99 VALUE ZEROS.
       01  WS-VENTA-MAYOR        PIC 9(6)V99 VALUE ZEROS.
       01  WS-VENTA-MENOR        PIC 9(6)V99 VALUE 999999.99.
       01  WS-DIA-MAYOR          PIC 99 VALUE ZEROS.
       01  WS-DIA-MENOR          PIC 99 VALUE ZEROS.
       01  WS-NUM-DIAS           PIC 99 VALUE 7.

      *--- Tabla de multiplicar ---*
       01  WS-TABLA-NUMERO       PIC 99 VALUE ZEROS.
       01  WS-RESULTADO          PIC 9(6) VALUE ZEROS.

       PROCEDURE DIVISION.

       MAIN-LOGIC.
           PERFORM MOSTRAR-INTRODUCCION.
           PERFORM EJEMPLO-PERFORM-TIMES.
           PERFORM EJEMPLO-PERFORM-UNTIL.
           PERFORM EJEMPLO-PERFORM-VARYING.
           PERFORM EJEMPLO-BUCLE-ANIDADO.
           PERFORM EJEMPLO-PROCESAMIENTO-VENTAS.
           STOP RUN.

      *--- Introducción ---*
       MOSTRAR-INTRODUCCION.
           DISPLAY " ".
           DISPLAY "╔═══════════════════════════════════════════════╗".
           DISPLAY "║   EJEMPLOS DE BUCLES EN COBOL                ║".
           DISPLAY "║   Aprende PERFORM en todas sus formas        ║".
           DISPLAY "╚═══════════════════════════════════════════════╝".
           DISPLAY " ".

      *-----------------------------------------------------------------*
      * EJEMPLO 1: PERFORM ... TIMES
      * Ejecuta un bloque N veces
      *-----------------------------------------------------------------*
       EJEMPLO-PERFORM-TIMES.
           DISPLAY "════════════════════════════════════════════════".
           DISPLAY "EJEMPLO 1: PERFORM ... TIMES".
           DISPLAY "════════════════════════════════════════════════".
           DISPLAY " ".
           DISPLAY "Contando del 1 al 10:".
           DISPLAY " ".

           MOVE 0 TO WS-CONTADOR.

      *    Ejecuta el párrafo INCREMENTAR-CONTADOR 10 veces
           PERFORM INCREMENTAR-CONTADOR 10 TIMES.

           DISPLAY " ".
           DISPLAY "Valor final del contador: " WS-CONTADOR.
           DISPLAY " ".
           PERFORM PAUSAR.

       INCREMENTAR-CONTADOR.
           ADD 1 TO WS-CONTADOR.
           DISPLAY "  Iteración " WS-CONTADOR.

      *-----------------------------------------------------------------*
      * EJEMPLO 2: PERFORM UNTIL
      * Ejecuta hasta que se cumpla una condición
      *-----------------------------------------------------------------*
       EJEMPLO-PERFORM-UNTIL.
           DISPLAY "════════════════════════════════════════════════".
           DISPLAY "EJEMPLO 2: PERFORM UNTIL".
           DISPLAY "════════════════════════════════════════════════".
           DISPLAY " ".
           DISPLAY "Suma de números del 1 al 100:".
           DISPLAY " ".

           MOVE 1 TO WS-NUMERO.
           MOVE 0 TO WS-SUMA.

      *    Bucle que suma números del 1 al 100
           PERFORM UNTIL WS-NUMERO > 100
               ADD WS-NUMERO TO WS-SUMA
               ADD 1 TO WS-NUMERO
           END-PERFORM.

           DISPLAY "  Suma total: " WS-SUMA.
           DISPLAY "  (Fórmula: n*(n+1)/2 = 100*101/2 = 5050)".
           DISPLAY " ".

      *    Ejemplo 2b: Factorial
           DISPLAY "Calculando factorial de 10:".
           MOVE 1 TO WS-NUMERO.
           MOVE 1 TO WS-PRODUCTO.

           PERFORM UNTIL WS-NUMERO > 10
               MULTIPLY WS-NUMERO BY WS-PRODUCTO
               ADD 1 TO WS-NUMERO
           END-PERFORM.

           DISPLAY "  10! = " WS-PRODUCTO.
           DISPLAY " ".
           PERFORM PAUSAR.

      *-----------------------------------------------------------------*
      * EJEMPLO 3: PERFORM VARYING
      * Bucle con variable de control (como FOR en otros lenguajes)
      *-----------------------------------------------------------------*
       EJEMPLO-PERFORM-VARYING.
           DISPLAY "════════════════════════════════════════════════".
           DISPLAY "EJEMPLO 3: PERFORM VARYING (como FOR loop)".
           DISPLAY "════════════════════════════════════════════════".
           DISPLAY " ".
           DISPLAY "Ingresa un número para ver su tabla de".
           DISPLAY "multiplicar (1-20): " WITH NO ADVANCING.
           ACCEPT WS-TABLA-NUMERO.

           IF WS-TABLA-NUMERO >= 1 AND WS-TABLA-NUMERO <= 20 THEN
               DISPLAY " "
               DISPLAY "TABLA DEL " WS-TABLA-NUMERO ":"
               DISPLAY "────────────────────────────"

      *        VARYING: desde 1, incrementando de 1 en 1, hasta 12
               PERFORM VARYING WS-INDICE FROM 1 BY 1 UNTIL WS-INDICE > 12
                   COMPUTE WS-RESULTADO = WS-TABLA-NUMERO * WS-INDICE
                   DISPLAY "  " WS-TABLA-NUMERO " × "
                           WS-INDICE " = " WS-RESULTADO
               END-PERFORM
           ELSE
               DISPLAY " "
               DISPLAY "  ❌ Número fuera de rango (1-20)"
           END-IF.

           DISPLAY " ".
           PERFORM PAUSAR.

      *-----------------------------------------------------------------*
      * EJEMPLO 4: BUCLES ANIDADOS
      * Un bucle dentro de otro
      *-----------------------------------------------------------------*
       EJEMPLO-BUCLE-ANIDADO.
           DISPLAY "════════════════════════════════════════════════".
           DISPLAY "EJEMPLO 4: BUCLES ANIDADOS (Matriz de asteriscos)".
           DISPLAY "════════════════════════════════════════════════".
           DISPLAY " ".
           DISPLAY "Patrón de 5x5:".
           DISPLAY " ".

      *    Bucle externo: filas
           PERFORM VARYING WS-FILA FROM 1 BY 1 UNTIL WS-FILA > 5
               DISPLAY "  " WITH NO ADVANCING

      *        Bucle interno: columnas
               PERFORM VARYING WS-COLUMNA FROM 1 BY 1
                   UNTIL WS-COLUMNA > 5
                   DISPLAY "* " WITH NO ADVANCING
               END-PERFORM

               DISPLAY " "  *> Salto de línea después de cada fila
           END-PERFORM.

           DISPLAY " ".

      *    Patrón triangular
           DISPLAY "Patrón triangular:".
           DISPLAY " ".

           PERFORM VARYING WS-FILA FROM 1 BY 1 UNTIL WS-FILA > 5
               DISPLAY "  " WITH NO ADVANCING

               PERFORM VARYING WS-COLUMNA FROM 1 BY 1
                   UNTIL WS-COLUMNA > WS-FILA
                   DISPLAY "* " WITH NO ADVANCING
               END-PERFORM

               DISPLAY " "
           END-PERFORM.

           DISPLAY " ".
           PERFORM PAUSAR.

      *-----------------------------------------------------------------*
      * EJEMPLO 5: PROCESAMIENTO DE VENTAS SEMANALES
      * Caso práctico: análisis de datos
      *-----------------------------------------------------------------*
       EJEMPLO-PROCESAMIENTO-VENTAS.
           DISPLAY "════════════════════════════════════════════════".
           DISPLAY "EJEMPLO 5: PROCESAMIENTO DE VENTAS SEMANALES".
           DISPLAY "════════════════════════════════════════════════".
           DISPLAY " ".
           DISPLAY "Ingresa las ventas de cada día de la semana:".
           DISPLAY " ".

           MOVE ZEROS TO WS-TOTAL-VENTAS.
           MOVE ZEROS TO WS-VENTA-MAYOR.
           MOVE 999999.99 TO WS-VENTA-MENOR.

      *    Recolectar ventas de 7 días
           PERFORM VARYING WS-INDICE FROM 1 BY 1
               UNTIL WS-INDICE > WS-NUM-DIAS

               EVALUATE WS-INDICE
                   WHEN 1
                       DISPLAY "  Lunes:    $" WITH NO ADVANCING
                   WHEN 2
                       DISPLAY "  Martes:   $" WITH NO ADVANCING
                   WHEN 3
                       DISPLAY "  Miércoles: $" WITH NO ADVANCING
                   WHEN 4
                       DISPLAY "  Jueves:   $" WITH NO ADVANCING
                   WHEN 5
                       DISPLAY "  Viernes:  $" WITH NO ADVANCING
                   WHEN 6
                       DISPLAY "  Sábado:   $" WITH NO ADVANCING
                   WHEN 7
                       DISPLAY "  Domingo:  $" WITH NO ADVANCING
               END-EVALUATE

               ACCEPT WS-VENTA-DIA

      *        Acumular total
               ADD WS-VENTA-DIA TO WS-TOTAL-VENTAS

      *        Encontrar venta mayor
               IF WS-VENTA-DIA > WS-VENTA-MAYOR THEN
                   MOVE WS-VENTA-DIA TO WS-VENTA-MAYOR
                   MOVE WS-INDICE TO WS-DIA-MAYOR
               END-IF

      *        Encontrar venta menor
               IF WS-VENTA-DIA < WS-VENTA-MENOR THEN
                   MOVE WS-VENTA-DIA TO WS-VENTA-MENOR
                   MOVE WS-INDICE TO WS-DIA-MENOR
               END-IF

           END-PERFORM.

      *    Calcular promedio
           COMPUTE WS-PROMEDIO = WS-TOTAL-VENTAS / WS-NUM-DIAS.

      *    Mostrar reporte
           DISPLAY " ".
           DISPLAY "╔════════════════════════════════════════════╗".
           DISPLAY "║      REPORTE DE VENTAS SEMANAL            ║".
           DISPLAY "╚════════════════════════════════════════════╝".
           DISPLAY " ".
           DISPLAY "📊 ESTADÍSTICAS:".
           DISPLAY "────────────────────────────────────────────".
           DISPLAY "  Total ventas:      $" WS-TOTAL-VENTAS.
           DISPLAY "  Promedio diario:   $" WS-PROMEDIO.
           DISPLAY " ".
           DISPLAY "  Mejor día:  " WITH NO ADVANCING.
           PERFORM MOSTRAR-NOMBRE-DIA-MAYOR.
           DISPLAY " ($" WS-VENTA-MAYOR ")".
           DISPLAY " ".
           DISPLAY "  Peor día:   " WITH NO ADVANCING.
           PERFORM MOSTRAR-NOMBRE-DIA-MENOR.
           DISPLAY " ($" WS-VENTA-MENOR ")".
           DISPLAY " ".

      *--- Muestra el nombre del día con más ventas ---*
       MOSTRAR-NOMBRE-DIA-MAYOR.
           EVALUATE WS-DIA-MAYOR
               WHEN 1
                   DISPLAY "Lunes" WITH NO ADVANCING
               WHEN 2
                   DISPLAY "Martes" WITH NO ADVANCING
               WHEN 3
                   DISPLAY "Miércoles" WITH NO ADVANCING
               WHEN 4
                   DISPLAY "Jueves" WITH NO ADVANCING
               WHEN 5
                   DISPLAY "Viernes" WITH NO ADVANCING
               WHEN 6
                   DISPLAY "Sábado" WITH NO ADVANCING
               WHEN 7
                   DISPLAY "Domingo" WITH NO ADVANCING
           END-EVALUATE.

      *--- Muestra el nombre del día con menos ventas ---*
       MOSTRAR-NOMBRE-DIA-MENOR.
           EVALUATE WS-DIA-MENOR
               WHEN 1
                   DISPLAY "Lunes" WITH NO ADVANCING
               WHEN 2
                   DISPLAY "Martes" WITH NO ADVANCING
               WHEN 3
                   DISPLAY "Miércoles" WITH NO ADVANCING
               WHEN 4
                   DISPLAY "Jueves" WITH NO ADVANCING
               WHEN 5
                   DISPLAY "Viernes" WITH NO ADVANCING
               WHEN 6
                   DISPLAY "Sábado" WITH NO ADVANCING
               WHEN 7
                   DISPLAY "Domingo" WITH NO ADVANCING
           END-EVALUATE.

      *--- Pausa para leer ---*
       PAUSAR.
           DISPLAY "Presiona ENTER para continuar..."
               WITH NO ADVANCING.
           ACCEPT WS-NUMERO.
           DISPLAY " ".

      *----------------------------------------------------------------*
      * EXPLICACIÓN DETALLADA:
      *
      * TIPOS DE BUCLES EN COBOL:
      *
      * 1. PERFORM párrafo N TIMES
      *    - Ejecuta un párrafo exactamente N veces
      *    - N debe ser un número o variable numérica
      *    - Simple y directo
      *
      * 2. PERFORM UNTIL condición
      *    - Se ejecuta mientras la condición sea FALSA
      *    - Se detiene cuando la condición es VERDADERA
      *    - Puede no ejecutarse nunca si la condición ya es verdadera
      *
      * 3. PERFORM VARYING variable FROM inicio BY incremento
      *                     UNTIL condición
      *    - Similar al FOR de otros lenguajes
      *    - FROM: valor inicial
      *    - BY: incremento (puede ser negativo para decrementar)
      *    - UNTIL: condición de parada
      *
      * BUCLES ANIDADOS:
      *   - Un PERFORM dentro de otro
      *   - El interno se ejecuta completamente por cada iteración del externo
      *   - Útil para matrices, tablas, patrones
      *   - Cuidado con el rendimiento (O(n²) o peor)
      *
      * ACUMULADORES:
      *   - Variables que suman valores en cada iteración
      *   - Inicializar en ZEROS antes del bucle
      *   - Usar ADD ... TO dentro del bucle
      *
      * CONTADORES:
      *   - Variables que cuentan iteraciones o elementos
      *   - Incrementar con ADD 1 TO variable
      *   - Útil para estadísticas y control
      *
      * ENCONTRAR MÁXIMO Y MÍNIMO:
      *   - Inicializar máximo en 0 o valor muy bajo
      *   - Inicializar mínimo en valor muy alto
      *   - Comparar en cada iteración con IF
      *   - Guardar también el índice si es relevante
      *
      * BUENAS PRÁCTICAS:
      *   1. Inicializar variables antes del bucle
      *   2. Asegurar que el bucle termine (evitar infinitos)
      *   3. Usar nombres descriptivos para contadores
      *   4. Modularizar bucles complejos en párrafos
      *   5. Comentar la lógica de bucles anidados
      *
      * ERRORES COMUNES:
      *   1. Olvidar incrementar el contador en PERFORM UNTIL
      *   2. Condición que nunca se cumple (bucle infinito)
      *   3. No inicializar acumuladores
      *   4. Confundir UNTIL con WHILE (es lo opuesto)
      *   5. Modificar la variable de control dentro de VARYING
      *
      * PARA COMPILAR Y EJECUTAR:
      * cobc -x -free ejemplo-08-bucles.cob
      * ./ejemplo-08-bucles
      *
      * EJERCICIOS:
      * 1. Crear un programa que calcule números primos del 1-100
      * 2. Generar la serie de Fibonacci con N términos
      * 3. Crear un patrón de pirámide con asteriscos
      * 4. Procesar calificaciones de N estudiantes
      * 5. Buscar un número en una lista
      *----------------------------------------------------------------*
