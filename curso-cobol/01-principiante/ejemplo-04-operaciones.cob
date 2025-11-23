      ******************************************************************
      * EJEMPLO 4: OPERACIONES ARITMÉTICAS
      * Descripción: Calculadora completa con todas las operaciones
      * Conceptos: ADD, SUBTRACT, MULTIPLY, DIVIDE, COMPUTE
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. CALCULADORA.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *--- Variables de entrada ---*
       01  WS-NUM1             PIC 9(5)V99 VALUE ZEROS.
       01  WS-NUM2             PIC 9(5)V99 VALUE ZEROS.

      *--- Variables de resultado ---*
       01  WS-SUMA             PIC 9(6)V99 VALUE ZEROS.
       01  WS-RESTA            PIC S9(6)V99 VALUE ZEROS.
       01  WS-MULTIPLICACION   PIC 9(10)V99 VALUE ZEROS.
       01  WS-DIVISION         PIC 9(6)V99 VALUE ZEROS.
       01  WS-RESIDUO          PIC 9(5)V99 VALUE ZEROS.
       01  WS-PROMEDIO         PIC 9(5)V99 VALUE ZEROS.
       01  WS-POTENCIA         PIC 9(10)V99 VALUE ZEROS.

      *--- Variables de control ---*
       01  WS-OPCION           PIC 9 VALUE ZEROS.
       01  WS-CONTINUAR        PIC X VALUE 'S'.

       PROCEDURE DIVISION.

       MAIN-LOGIC.
           PERFORM UNTIL WS-CONTINUAR = 'N' OR WS-CONTINUAR = 'n'
               PERFORM MOSTRAR-MENU
               PERFORM SOLICITAR-NUMEROS
               PERFORM SOLICITAR-OPERACION
               PERFORM EJECUTAR-OPERACION
               PERFORM PREGUNTAR-CONTINUAR
           END-PERFORM.

           DISPLAY " ".
           DISPLAY "¡Gracias por usar la calculadora COBOL!".
           STOP RUN.

      *--- Muestra el menú ---*
       MOSTRAR-MENU.
           DISPLAY " ".
           DISPLAY "╔═══════════════════════════════════════╗".
           DISPLAY "║    CALCULADORA COBOL - COMPLETA      ║".
           DISPLAY "╚═══════════════════════════════════════╝".
           DISPLAY " ".

      *--- Solicita los números ---*
       SOLICITAR-NUMEROS.
           DISPLAY "Ingresa el primer número: " WITH NO ADVANCING.
           ACCEPT WS-NUM1.

           DISPLAY "Ingresa el segundo número: " WITH NO ADVANCING.
           ACCEPT WS-NUM2.
           DISPLAY " ".

      *--- Muestra opciones y solicita operación ---*
       SOLICITAR-OPERACION.
           DISPLAY "OPERACIONES DISPONIBLES:".
           DISPLAY "  1. Suma".
           DISPLAY "  2. Resta".
           DISPLAY "  3. Multiplicación".
           DISPLAY "  4. División".
           DISPLAY "  5. Todas las operaciones".
           DISPLAY " ".
           DISPLAY "Selecciona una opción (1-5): " WITH NO ADVANCING.
           ACCEPT WS-OPCION.
           DISPLAY " ".

      *--- Ejecuta la operación seleccionada ---*
       EJECUTAR-OPERACION.
           EVALUATE WS-OPCION
               WHEN 1
                   PERFORM HACER-SUMA
               WHEN 2
                   PERFORM HACER-RESTA
               WHEN 3
                   PERFORM HACER-MULTIPLICACION
               WHEN 4
                   PERFORM HACER-DIVISION
               WHEN 5
                   PERFORM HACER-TODAS
               WHEN OTHER
                   DISPLAY "❌ Opción inválida. Intenta de nuevo."
           END-EVALUATE.

      *--- SUMA usando ADD ---*
       HACER-SUMA.
           ADD WS-NUM1 TO WS-NUM2 GIVING WS-SUMA.
           DISPLAY "────────────────────────────────────".
           DISPLAY "➕ SUMA:".
           DISPLAY "   " WS-NUM1 " + " WS-NUM2 " = " WS-SUMA.
           DISPLAY "────────────────────────────────────".

      *--- RESTA usando SUBTRACT ---*
       HACER-RESTA.
           SUBTRACT WS-NUM2 FROM WS-NUM1 GIVING WS-RESTA.
           DISPLAY "────────────────────────────────────".
           DISPLAY "➖ RESTA:".
           DISPLAY "   " WS-NUM1 " - " WS-NUM2 " = " WS-RESTA.
           DISPLAY "────────────────────────────────────".

      *--- MULTIPLICACIÓN usando MULTIPLY ---*
       HACER-MULTIPLICACION.
           MULTIPLY WS-NUM1 BY WS-NUM2 GIVING WS-MULTIPLICACION.
           DISPLAY "────────────────────────────────────".
           DISPLAY "✖️  MULTIPLICACIÓN:".
           DISPLAY "   " WS-NUM1 " × " WS-NUM2 " = "
                   WS-MULTIPLICACION.
           DISPLAY "────────────────────────────────────".

      *--- DIVISIÓN usando DIVIDE ---*
       HACER-DIVISION.
           IF WS-NUM2 = 0 THEN
               DISPLAY "────────────────────────────────────".
               DISPLAY "❌ ERROR: No se puede dividir por cero!".
               DISPLAY "────────────────────────────────────"
           ELSE
               DIVIDE WS-NUM1 BY WS-NUM2 GIVING WS-DIVISION
                   REMAINDER WS-RESIDUO
               DISPLAY "────────────────────────────────────"
               DISPLAY "➗ DIVISIÓN:"
               DISPLAY "   " WS-NUM1 " ÷ " WS-NUM2 " = "
                       WS-DIVISION
               DISPLAY "   Residuo: " WS-RESIDUO
               DISPLAY "────────────────────────────────────"
           END-IF.

      *--- Todas las operaciones ---*
       HACER-TODAS.
      *    Suma
           ADD WS-NUM1 TO WS-NUM2 GIVING WS-SUMA.

      *    Resta
           SUBTRACT WS-NUM2 FROM WS-NUM1 GIVING WS-RESTA.

      *    Multiplicación
           MULTIPLY WS-NUM1 BY WS-NUM2 GIVING WS-MULTIPLICACION.

      *    División (con validación)
           IF WS-NUM2 NOT = 0 THEN
               DIVIDE WS-NUM1 BY WS-NUM2 GIVING WS-DIVISION
                   REMAINDER WS-RESIDUO
           ELSE
               MOVE ZEROS TO WS-DIVISION
               MOVE ZEROS TO WS-RESIDUO
           END-IF.

      *    Promedio usando COMPUTE
           COMPUTE WS-PROMEDIO = (WS-NUM1 + WS-NUM2) / 2.

      *    Potencia (num1 elevado a num2)
           COMPUTE WS-POTENCIA = WS-NUM1 ** 2.

      *    Mostrar todos los resultados
           DISPLAY "╔═══════════════════════════════════════╗".
           DISPLAY "║       TODAS LAS OPERACIONES          ║".
           DISPLAY "╚═══════════════════════════════════════╝".
           DISPLAY " ".
           DISPLAY "Números: " WS-NUM1 " y " WS-NUM2.
           DISPLAY " ".
           DISPLAY "➕ Suma:            " WS-SUMA.
           DISPLAY "➖ Resta:           " WS-RESTA.
           DISPLAY "✖️  Multiplicación:  " WS-MULTIPLICACION.

           IF WS-NUM2 NOT = 0 THEN
               DISPLAY "➗ División:        " WS-DIVISION
               DISPLAY "   Residuo:        " WS-RESIDUO
           ELSE
               DISPLAY "➗ División:        No definida (div/0)"
           END-IF.

           DISPLAY "📊 Promedio:        " WS-PROMEDIO.
           DISPLAY "² Num1 al cuadrado: " WS-POTENCIA.
           DISPLAY " ".

      *--- Pregunta si desea continuar ---*
       PREGUNTAR-CONTINUAR.
           DISPLAY " ".
           DISPLAY "¿Deseas realizar otra operación? (S/N): "
               WITH NO ADVANCING.
           ACCEPT WS-CONTINUAR.

      *----------------------------------------------------------------*
      * EXPLICACIÓN DETALLADA:
      *
      * OPERACIONES ARITMÉTICAS EN COBOL:
      *
      * 1. ADD - Suma:
      *    ADD num1 TO num2 GIVING resultado
      *    ADD num1 num2 GIVING resultado
      *    ADD num1 TO num2  (suma y guarda en num2)
      *
      * 2. SUBTRACT - Resta:
      *    SUBTRACT num2 FROM num1 GIVING resultado
      *    resultado = num1 - num2
      *
      * 3. MULTIPLY - Multiplicación:
      *    MULTIPLY num1 BY num2 GIVING resultado
      *
      * 4. DIVIDE - División:
      *    DIVIDE num1 BY num2 GIVING cociente REMAINDER residuo
      *    DIVIDE num1 BY num2 GIVING resultado
      *
      * 5. COMPUTE - Expresión completa:
      *    COMPUTE resultado = (num1 + num2) / 2
      *    Operadores: + - * / ** (potencia)
      *    Más flexible y legible
      *
      * PICTURE CON SIGNO:
      *    S9(6)V99 - El S indica que puede ser negativo
      *    Necesario para resultados de restas
      *
      * EVALUATE - Similar a switch/case:
      *    EVALUATE variable
      *        WHEN valor1
      *            sentencias
      *        WHEN valor2
      *            sentencias
      *        WHEN OTHER
      *            sentencias
      *    END-EVALUATE
      *
      * PERFORM UNTIL - Bucle:
      *    PERFORM UNTIL condición
      *        sentencias
      *    END-PERFORM
      *    Repite mientras la condición sea verdadera
      *
      * MOVE - Asigna valores:
      *    MOVE valor TO variable
      *    MOVE ZEROS TO variable
      *
      * REMAINDER - Residuo de división:
      *    Obtiene el resto de una división entera
      *    10 / 3 = 3, REMAINDER 1
      *
      * VALIDACIÓN IMPORTANTE:
      *    Siempre valida división por cero antes de dividir
      *    IF denominador NOT = 0 THEN...
      *
      * PARA COMPILAR Y EJECUTAR:
      * cobc -x -free ejemplo-04-operaciones.cob
      * ./ejemplo-04-operaciones
      *
      * EJERCICIO:
      * Agrega las siguientes operaciones:
      * - Raíz cuadrada (investigar función SQRT)
      * - Valor absoluto
      * - Porcentaje (num1 es qué % de num2)
      * - Máximo y mínimo entre los dos números
      *----------------------------------------------------------------*
