      ******************************************************************
      * EJEMPLO 5: SISTEMA DE CALIFICACIONES
      * Descripción: Calcula promedio y determina si aprueba/reprueba
      * Conceptos: IF anidados, validación, cálculos
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. CALIFICACIONES.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *--- Datos del estudiante ---*
       01  WS-ESTUDIANTE.
           05  WS-NOMBRE         PIC X(40) VALUE SPACES.
           05  WS-MATRICULA      PIC X(10) VALUE SPACES.

      *--- Calificaciones por materia ---*
       01  WS-CALIFICACIONES.
           05  WS-MATEMATICAS    PIC 999V99 VALUE ZEROS.
           05  WS-FISICA         PIC 999V99 VALUE ZEROS.
           05  WS-QUIMICA        PIC 999V99 VALUE ZEROS.
           05  WS-PROGRAMACION   PIC 999V99 VALUE ZEROS.
           05  WS-INGLES         PIC 999V99 VALUE ZEROS.

      *--- Cálculos ---*
       01  WS-TOTAL            PIC 9999V99 VALUE ZEROS.
       01  WS-PROMEDIO         PIC 999V99 VALUE ZEROS.
       01  WS-NUM-MATERIAS     PIC 99 VALUE 5.

      *--- Variables de control ---*
       01  WS-ENTRADA          PIC X(6) VALUE SPACES.
       01  WS-ENTRADA-NUM      PIC 999V99 VALUE ZEROS.
       01  WS-VALIDA           PIC X VALUE 'N'.

       PROCEDURE DIVISION.

       MAIN-LOGIC.
           PERFORM MOSTRAR-ENCABEZADO.
           PERFORM SOLICITAR-DATOS-ESTUDIANTE.
           PERFORM SOLICITAR-CALIFICACIONES.
           PERFORM CALCULAR-PROMEDIO.
           PERFORM MOSTRAR-REPORTE.
           STOP RUN.

      *--- Encabezado del sistema ---*
       MOSTRAR-ENCABEZADO.
           DISPLAY " ".
           DISPLAY "╔══════════════════════════════════════════╗".
           DISPLAY "║   SISTEMA DE CALIFICACIONES - COBOL     ║".
           DISPLAY "║   Universidad Nacional                  ║".
           DISPLAY "╚══════════════════════════════════════════╝".
           DISPLAY " ".

      *--- Solicita datos del estudiante ---*
       SOLICITAR-DATOS-ESTUDIANTE.
           DISPLAY "DATOS DEL ESTUDIANTE:".
           DISPLAY "Nombre completo: " WITH NO ADVANCING.
           ACCEPT WS-NOMBRE.

           DISPLAY "Matrícula: " WITH NO ADVANCING.
           ACCEPT WS-MATRICULA.
           DISPLAY " ".

      *--- Solicita calificaciones con validación ---*
       SOLICITAR-CALIFICACIONES.
           DISPLAY "INGRESA LAS CALIFICACIONES (0-100):".
           DISPLAY " ".

      *    Matemáticas
           PERFORM VALIDAR-CALIFICACION-MAT.

      *    Física
           PERFORM VALIDAR-CALIFICACION-FIS.

      *    Química
           PERFORM VALIDAR-CALIFICACION-QUI.

      *    Programación
           PERFORM VALIDAR-CALIFICACION-PRG.

      *    Inglés
           PERFORM VALIDAR-CALIFICACION-ING.

           DISPLAY " ".

      *--- Validación: Matemáticas ---*
       VALIDAR-CALIFICACION-MAT.
           MOVE 'N' TO WS-VALIDA.
           PERFORM UNTIL WS-VALIDA = 'S'
               DISPLAY "  Matemáticas: " WITH NO ADVANCING
               ACCEPT WS-ENTRADA

               IF FUNCTION NUMVAL(WS-ENTRADA) >= 0 AND
                  FUNCTION NUMVAL(WS-ENTRADA) <= 100 THEN
                   MOVE FUNCTION NUMVAL(WS-ENTRADA) TO WS-MATEMATICAS
                   MOVE 'S' TO WS-VALIDA
               ELSE
                   DISPLAY "  ❌ Calificación inválida. Debe ser 0-100."
               END-IF
           END-PERFORM.

      *--- Validación: Física ---*
       VALIDAR-CALIFICACION-FIS.
           MOVE 'N' TO WS-VALIDA.
           PERFORM UNTIL WS-VALIDA = 'S'
               DISPLAY "  Física: " WITH NO ADVANCING
               ACCEPT WS-ENTRADA

               IF FUNCTION NUMVAL(WS-ENTRADA) >= 0 AND
                  FUNCTION NUMVAL(WS-ENTRADA) <= 100 THEN
                   MOVE FUNCTION NUMVAL(WS-ENTRADA) TO WS-FISICA
                   MOVE 'S' TO WS-VALIDA
               ELSE
                   DISPLAY "  ❌ Calificación inválida. Debe ser 0-100."
               END-IF
           END-PERFORM.

      *--- Validación: Química ---*
       VALIDAR-CALIFICACION-QUI.
           MOVE 'N' TO WS-VALIDA.
           PERFORM UNTIL WS-VALIDA = 'S'
               DISPLAY "  Química: " WITH NO ADVANCING
               ACCEPT WS-ENTRADA

               IF FUNCTION NUMVAL(WS-ENTRADA) >= 0 AND
                  FUNCTION NUMVAL(WS-ENTRADA) <= 100 THEN
                   MOVE FUNCTION NUMVAL(WS-ENTRADA) TO WS-QUIMICA
                   MOVE 'S' TO WS-VALIDA
               ELSE
                   DISPLAY "  ❌ Calificación inválida. Debe ser 0-100."
               END-IF
           END-PERFORM.

      *--- Validación: Programación ---*
       VALIDAR-CALIFICACION-PRG.
           MOVE 'N' TO WS-VALIDA.
           PERFORM UNTIL WS-VALIDA = 'S'
               DISPLAY "  Programación: " WITH NO ADVANCING
               ACCEPT WS-ENTRADA

               IF FUNCTION NUMVAL(WS-ENTRADA) >= 0 AND
                  FUNCTION NUMVAL(WS-ENTRADA) <= 100 THEN
                   MOVE FUNCTION NUMVAL(WS-ENTRADA) TO WS-PROGRAMACION
                   MOVE 'S' TO WS-VALIDA
               ELSE
                   DISPLAY "  ❌ Calificación inválida. Debe ser 0-100."
               END-IF
           END-PERFORM.

      *--- Validación: Inglés ---*
       VALIDAR-CALIFICACION-ING.
           MOVE 'N' TO WS-VALIDA.
           PERFORM UNTIL WS-VALIDA = 'S'
               DISPLAY "  Inglés: " WITH NO ADVANCING
               ACCEPT WS-ENTRADA

               IF FUNCTION NUMVAL(WS-ENTRADA) >= 0 AND
                  FUNCTION NUMVAL(WS-ENTRADA) <= 100 THEN
                   MOVE FUNCTION NUMVAL(WS-ENTRADA) TO WS-INGLES
                   MOVE 'S' TO WS-VALIDA
               ELSE
                   DISPLAY "  ❌ Calificación inválida. Debe ser 0-100."
               END-IF
           END-PERFORM.

      *--- Calcula el promedio ---*
       CALCULAR-PROMEDIO.
           COMPUTE WS-TOTAL = WS-MATEMATICAS + WS-FISICA +
                              WS-QUIMICA + WS-PROGRAMACION +
                              WS-INGLES.
           COMPUTE WS-PROMEDIO = WS-TOTAL / WS-NUM-MATERIAS.

      *--- Muestra reporte completo ---*
       MOSTRAR-REPORTE.
           DISPLAY "╔══════════════════════════════════════════╗".
           DISPLAY "║         REPORTE DE CALIFICACIONES       ║".
           DISPLAY "╚══════════════════════════════════════════╝".
           DISPLAY " ".
           DISPLAY "Estudiante: " WS-NOMBRE.
           DISPLAY "Matrícula:  " WS-MATRICULA.
           DISPLAY " ".
           DISPLAY "CALIFICACIONES POR MATERIA:".
           DISPLAY "──────────────────────────────────────────".
           DISPLAY "  Matemáticas:    " WS-MATEMATICAS.
           DISPLAY "  Física:         " WS-FISICA.
           DISPLAY "  Química:        " WS-QUIMICA.
           DISPLAY "  Programación:   " WS-PROGRAMACION.
           DISPLAY "  Inglés:         " WS-INGLES.
           DISPLAY "──────────────────────────────────────────".
           DISPLAY "  PROMEDIO:       " WS-PROMEDIO.
           DISPLAY " ".

      *    Determinar resultado con IF anidados
           IF WS-PROMEDIO >= 90 THEN
               DISPLAY "🏆 RESULTADO: EXCELENTE"
               DISPLAY "   ¡Felicidades! Rendimiento sobresaliente."
           ELSE IF WS-PROMEDIO >= 80 THEN
               DISPLAY "⭐ RESULTADO: MUY BIEN"
               DISPLAY "   Buen trabajo. Sigue así."
           ELSE IF WS-PROMEDIO >= 70 THEN
               DISPLAY "✓ RESULTADO: BIEN"
               DISPLAY "   Aprobado. Puedes mejorar."
           ELSE IF WS-PROMEDIO >= 60 THEN
               DISPLAY "✓ RESULTADO: SUFICIENTE"
               DISPLAY "   Aprobado por poco. Debes esforzarte más."
           ELSE
               DISPLAY "❌ RESULTADO: REPROBADO"
               DISPLAY "   Necesitas estudiar más."
           END-IF.

           DISPLAY " ".

      *    Verificar si tiene alguna materia reprobada
           PERFORM VERIFICAR-MATERIAS-REPROBADAS.

      *--- Verifica materias reprobadas individualmente ---*
       VERIFICAR-MATERIAS-REPROBADAS.
           IF WS-MATEMATICAS < 60 OR WS-FISICA < 60 OR
              WS-QUIMICA < 60 OR WS-PROGRAMACION < 60 OR
              WS-INGLES < 60 THEN
               DISPLAY "⚠️  ATENCIÓN: Materias reprobadas:"

               IF WS-MATEMATICAS < 60 THEN
                   DISPLAY "   - Matemáticas (" WS-MATEMATICAS ")"
               END-IF

               IF WS-FISICA < 60 THEN
                   DISPLAY "   - Física (" WS-FISICA ")"
               END-IF

               IF WS-QUIMICA < 60 THEN
                   DISPLAY "   - Química (" WS-QUIMICA ")"
               END-IF

               IF WS-PROGRAMACION < 60 THEN
                   DISPLAY "   - Programación (" WS-PROGRAMACION ")"
               END-IF

               IF WS-INGLES < 60 THEN
                   DISPLAY "   - Inglés (" WS-INGLES ")"
               END-IF

               DISPLAY " "
           ELSE
               DISPLAY "✓ Todas las materias aprobadas!"
               DISPLAY " "
           END-IF.

      *----------------------------------------------------------------*
      * EXPLICACIÓN DETALLADA:
      *
      * ESTRUCTURAS JERÁRQUICAS:
      *   01 - Nivel principal (grupo o variable independiente)
      *   05 - Subgrupo o campo dentro del grupo
      *   Se pueden anidar más niveles: 01, 05, 10, 15, etc.
      *
      * VALIDACIÓN DE ENTRADA:
      *   - Usar PERFORM UNTIL para repetir hasta entrada válida
      *   - Verificar rangos con IF
      *   - Dar feedback claro al usuario
      *
      * FUNCTION NUMVAL:
      *   - Convierte string a número
      *   - Útil para validar entrada alfanumérica
      *   - NUMVAL("123.45") devuelve 123.45
      *
      * IF ANIDADOS:
      *   - Se pueden anidar múltiples IFs
      *   - Cada IF debe tener su END-IF
      *   - Usar ELSE IF para rangos de valores
      *
      * OPERADORES LÓGICOS:
      *   AND - Ambas condiciones deben ser verdaderas
      *   OR  - Al menos una debe ser verdadera
      *   NOT - Niega la condición
      *
      * COMPUTE CON MÚLTIPLES VARIABLES:
      *   - Se puede sumar/restar/multiplicar múltiples valores
      *   - Usar paréntesis para orden de operaciones
      *   - Más legible que múltiples ADD/SUBTRACT
      *
      * MOVE:
      *   - Asigna un valor a una variable
      *   - MOVE 'S' TO WS-VALIDA
      *   - MOVE ZEROS TO WS-TOTAL
      *
      * BUENAS PRÁCTICAS:
      *   1. Validar toda entrada del usuario
      *   2. Dar mensajes claros de error
      *   3. Usar nombres descriptivos
      *   4. Modularizar con PERFORM
      *   5. Reportes bien formateados
      *
      * PARA COMPILAR Y EJECUTAR:
      * cobc -x -free ejemplo-05-calificaciones.cob
      * ./ejemplo-05-calificaciones
      *
      * EJERCICIO:
      * Modifica el programa para:
      * 1. Agregar 2 materias más
      * 2. Permitir ponderaciones diferentes por materia
      * 3. Mostrar la materia con mejor y peor calificación
      * 4. Calcular cuánto necesita en un examen final para aprobar
      *----------------------------------------------------------------*
