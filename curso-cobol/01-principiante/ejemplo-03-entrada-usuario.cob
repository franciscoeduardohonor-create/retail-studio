      ******************************************************************
      * EJEMPLO 3: ENTRADA DE USUARIO
      * Descripción: Cómo obtener datos del usuario con ACCEPT
      * Conceptos: ACCEPT, interacción usuario, validación básica
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. ENTRADA-USUARIO.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *--- Variables para entrada del usuario ---*
       01  WS-NOMBRE-USUARIO   PIC X(40) VALUE SPACES.
       01  WS-EDAD-USUARIO     PIC 99    VALUE ZEROS.
       01  WS-CIUDAD           PIC X(30) VALUE SPACES.
       01  WS-PAIS             PIC X(30) VALUE SPACES.

      *--- Variables para cálculos ---*
       01  WS-ANIO-ACTUAL      PIC 9999  VALUE 2024.
       01  WS-ANIO-NACIMIENTO  PIC 9999  VALUE ZEROS.

      *--- Variables para mensajes ---*
       01  WS-MENSAJE          PIC X(60) VALUE SPACES.

       PROCEDURE DIVISION.

       MAIN-LOGIC.
           PERFORM MOSTRAR-BIENVENIDA.
           PERFORM SOLICITAR-DATOS.
           PERFORM CALCULAR-INFO.
           PERFORM MOSTRAR-RESUMEN.
           STOP RUN.

      *--- Muestra mensaje de bienvenida ---*
       MOSTRAR-BIENVENIDA.
           DISPLAY " ".
           DISPLAY "╔══════════════════════════════════════════╗".
           DISPLAY "║    PROGRAMA INTERACTIVO - COBOL         ║".
           DISPLAY "║    Aprende a usar ACCEPT                ║".
           DISPLAY "╚══════════════════════════════════════════╝".
           DISPLAY " ".

      *--- Solicita datos al usuario ---*
       SOLICITAR-DATOS.
           DISPLAY "Por favor, ingresa los siguientes datos:".
           DISPLAY " ".

      *    Solicitar nombre
           DISPLAY "► Tu nombre completo: " WITH NO ADVANCING.
           ACCEPT WS-NOMBRE-USUARIO.

      *    Solicitar edad
           DISPLAY "► Tu edad: " WITH NO ADVANCING.
           ACCEPT WS-EDAD-USUARIO.

      *    Solicitar ciudad
           DISPLAY "► Tu ciudad: " WITH NO ADVANCING.
           ACCEPT WS-CIUDAD.

      *    Solicitar país
           DISPLAY "► Tu país: " WITH NO ADVANCING.
           ACCEPT WS-PAIS.

           DISPLAY " ".

      *--- Realiza cálculos basados en los datos ---*
       CALCULAR-INFO.
      *    Calcula el año aproximado de nacimiento
           COMPUTE WS-ANIO-NACIMIENTO = WS-ANIO-ACTUAL - WS-EDAD-USUARIO.

      *--- Muestra resumen personalizado ---*
       MOSTRAR-RESUMEN.
           DISPLAY "╔══════════════════════════════════════════╗".
           DISPLAY "║         RESUMEN DE TU INFORMACIÓN       ║".
           DISPLAY "╚══════════════════════════════════════════╝".
           DISPLAY " ".
           DISPLAY "👤 Nombre: " WS-NOMBRE-USUARIO.
           DISPLAY "🎂 Edad: " WS-EDAD-USUARIO " años".
           DISPLAY "📅 Año de nacimiento (aprox): " WS-ANIO-NACIMIENTO.
           DISPLAY "🏙️  Ciudad: " WS-CIUDAD.
           DISPLAY "🌍 País: " WS-PAIS.
           DISPLAY " ".

      *    Mensaje personalizado según edad
           IF WS-EDAD-USUARIO < 18 THEN
               DISPLAY "¡Eres menor de edad! Aprende COBOL desde joven."
           ELSE IF WS-EDAD-USUARIO >= 18 AND WS-EDAD-USUARIO < 65 THEN
               DISPLAY "¡Edad perfecta para dominar COBOL!"
           ELSE
               DISPLAY "¡La experiencia es invaluable en COBOL!"
           END-IF.

           DISPLAY " ".
           DISPLAY "Gracias por usar este programa, "
                   WS-NOMBRE-USUARIO "!".
           DISPLAY " ".

      *----------------------------------------------------------------*
      * EXPLICACIÓN DETALLADA:
      *
      * ACCEPT - Lee entrada del usuario:
      *   ACCEPT nombre-variable
      *   - Lee desde teclado (stdin)
      *   - Espera que el usuario presione ENTER
      *   - Guarda el valor en la variable especificada
      *
      * WITH NO ADVANCING:
      *   - Mantiene el cursor en la misma línea
      *   - Útil para que el usuario escriba en la misma línea
      *   - Sin esto, el cursor bajaría a la siguiente línea
      *
      * SPACES:
      *   - Constante figurativa que representa espacios
      *   - Inicializa la variable con espacios en blanco
      *   - Otras constantes: ZEROS, HIGH-VALUES, LOW-VALUES
      *
      * IF anidados:
      *   - IF condición THEN
      *       sentencias
      *   - ELSE IF otra-condición THEN
      *       sentencias
      *   - ELSE
      *       sentencias
      *   - END-IF (cierra el IF)
      *
      * Operadores de comparación:
      *   <  menor que
      *   >  mayor que
      *   =  igual a
      *   <= menor o igual
      *   >= mayor o igual
      *   <> diferente de
      *
      * Operadores lógicos:
      *   AND  - Y lógico
      *   OR   - O lógico
      *   NOT  - Negación
      *
      * BUENAS PRÁCTICAS:
      *   1. Inicializa variables (VALUE SPACES, VALUE ZEROS)
      *   2. Valida entrada del usuario cuando sea crítico
      *   3. Da feedback claro al usuario
      *   4. Usa mensajes descriptivos en DISPLAY
      *
      * PARA COMPILAR Y EJECUTAR:
      * cobc -x -free ejemplo-03-entrada-usuario.cob
      * ./ejemplo-03-entrada-usuario
      *
      * EJERCICIO:
      * Modifica el programa para que también pregunte:
      * - Profesión
      * - Lenguaje de programación favorito
      * Y muestre esa información en el resumen
      *----------------------------------------------------------------*
