      ******************************************************************
      * EJEMPLO 2: TRABAJANDO CON VARIABLES
      * Descripción: Declaración y uso de variables en COBOL
      * Conceptos: PICTURE, VALUE, DISPLAY
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. VARIABLES-BASICAS.

       ENVIRONMENT DIVISION.

      *----------------------------------------------------------------*
      * DATA DIVISION: Aquí definimos TODAS las variables
      *----------------------------------------------------------------*
       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *--- Variables de texto (alfanuméricas) ---*
       01  WS-NOMBRE           PIC X(30) VALUE "Juan Pérez".
       01  WS-EMPRESA          PIC X(40) VALUE "Banco Nacional".
       01  WS-PAIS             PIC X(20) VALUE "México".

      *--- Variables numéricas ---*
       01  WS-EDAD             PIC 99    VALUE 28.
       01  WS-SALARIO          PIC 9(6)V99 VALUE 50000.00.
       01  WS-ANTIGUEDAD       PIC 99    VALUE 05.

      *--- Variables para cálculos ---*
       01  WS-BONO             PIC 9(6)V99 VALUE ZEROS.
       01  WS-SALARIO-TOTAL    PIC 9(7)V99 VALUE ZEROS.

      *----------------------------------------------------------------*
      * PROCEDURE DIVISION: Lógica del programa
      *----------------------------------------------------------------*
       PROCEDURE DIVISION.

       MAIN-LOGIC.
           PERFORM MOSTRAR-ENCABEZADO.
           PERFORM MOSTRAR-DATOS-EMPLEADO.
           PERFORM CALCULAR-COMPENSACION.
           PERFORM MOSTRAR-COMPENSACION.
           STOP RUN.

      *--- Muestra el encabezado ---*
       MOSTRAR-ENCABEZADO.
           DISPLAY "╔════════════════════════════════════════╗".
           DISPLAY "║  SISTEMA DE RECURSOS HUMANOS - COBOL  ║".
           DISPLAY "╚════════════════════════════════════════╝".
           DISPLAY " ".

      *--- Muestra datos del empleado ---*
       MOSTRAR-DATOS-EMPLEADO.
           DISPLAY "📋 DATOS DEL EMPLEADO:".
           DISPLAY "   Nombre:     " WS-NOMBRE.
           DISPLAY "   Edad:       " WS-EDAD " años".
           DISPLAY "   Empresa:    " WS-EMPRESA.
           DISPLAY "   País:       " WS-PAIS.
           DISPLAY "   Antigüedad: " WS-ANTIGUEDAD " años".
           DISPLAY " ".

      *--- Calcula la compensación total ---*
       CALCULAR-COMPENSACION.
      *    El bono es 10% del salario por cada año de antigüedad
           COMPUTE WS-BONO = WS-SALARIO * 0.10 * WS-ANTIGUEDAD.
           COMPUTE WS-SALARIO-TOTAL = WS-SALARIO + WS-BONO.

      *--- Muestra la compensación ---*
       MOSTRAR-COMPENSACION.
           DISPLAY "💰 COMPENSACIÓN:".
           DISPLAY "   Salario base:    $" WS-SALARIO.
           DISPLAY "   Bono antigüedad: $" WS-BONO.
           DISPLAY "   ─────────────────────────────".
           DISPLAY "   TOTAL:           $" WS-SALARIO-TOTAL.
           DISPLAY " ".

      *----------------------------------------------------------------*
      * EXPLICACIÓN DETALLADA:
      *
      * PICTURE (PIC) - Define el tipo y tamaño de la variable:
      *   X     - Un carácter alfanumérico (letra, número, símbolo)
      *   X(30) - 30 caracteres alfanuméricos
      *   9     - Un dígito numérico (0-9)
      *   99    - Dos dígitos
      *   9(6)  - 6 dígitos
      *   V     - Punto decimal implícito (no ocupa espacio)
      *   9(6)V99 - 6 dígitos, punto, 2 decimales (ej: 123456.78)
      *
      * VALUE - Valor inicial de la variable
      *   VALUE "texto"  - Para alfanuméricos
      *   VALUE 25       - Para numéricos
      *   VALUE ZEROS    - Inicializa en ceros
      *   VALUE SPACES   - Inicializa en espacios
      *
      * NIVELES DE DATOS:
      *   01 - Nivel más alto (variable independiente)
      *   02-49 - Subniveles (para estructuras)
      *   77 - Variables elementales (antiguo, menos usado)
      *   88 - Condiciones con nombre (veremos después)
      *
      * WORKING-STORAGE SECTION:
      *   - Variables que mantienen su valor durante la ejecución
      *   - Se inicializan al inicio del programa
      *   - Similar a variables globales en otros lenguajes
      *
      * PERFORM:
      *   - Llama a un párrafo (subrutina)
      *   - Ejecuta el código y retorna
      *   - Útil para organizar el código
      *
      * COMPUTE:
      *   - Realiza operaciones aritméticas
      *   - Puede usar +, -, *, /, ** (potencia)
      *   - Más legible que ADD, SUBTRACT, etc.
      *
      * PARA COMPILAR Y EJECUTAR:
      * cobc -x -free ejemplo-02-variables.cob
      * ./ejemplo-02-variables
      *----------------------------------------------------------------*
