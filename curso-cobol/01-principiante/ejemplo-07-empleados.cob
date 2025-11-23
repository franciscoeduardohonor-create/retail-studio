      ******************************************************************
      * EJEMPLO 7: GESTIÓN DE EMPLEADOS CON ESTRUCTURAS
      * Descripción: Demuestra estructuras jerárquicas y nivel 88
      * Conceptos: Grupos de datos, REDEFINES, condiciones 88
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. GESTION-EMPLEADOS.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *--- Estructura completa del empleado ---*
       01  WS-EMPLEADO.
      *    Datos personales
           05  WS-EMP-PERSONAL.
               10  WS-EMP-ID         PIC 9(6).
               10  WS-EMP-NOMBRE.
                   15  WS-EMP-NOMBRE-P   PIC X(20).
                   15  WS-EMP-APELLIDO-P PIC X(20).
                   15  WS-EMP-APELLIDO-M PIC X(20).
               10  WS-EMP-EDAD       PIC 99.
               10  WS-EMP-GENERO     PIC X.
                   88  EMP-MASCULINO     VALUE 'M'.
                   88  EMP-FEMENINO      VALUE 'F'.
                   88  EMP-OTRO          VALUE 'O'.

      *    Dirección
           05  WS-EMP-DIRECCION.
               10  WS-EMP-CALLE      PIC X(40).
               10  WS-EMP-NUMERO     PIC X(10).
               10  WS-EMP-COLONIA    PIC X(30).
               10  WS-EMP-CIUDAD     PIC X(30).
               10  WS-EMP-ESTADO     PIC X(30).
               10  WS-EMP-CP         PIC X(5).

      *    Información laboral
           05  WS-EMP-LABORAL.
               10  WS-EMP-PUESTO     PIC X(30).
               10  WS-EMP-DEPTO      PIC X(20).
                   88  DEPTO-VENTAS      VALUE 'VENTAS'.
                   88  DEPTO-SISTEMAS    VALUE 'SISTEMAS'.
                   88  DEPTO-RRHH        VALUE 'RRHH'.
                   88  DEPTO-FINANZAS    VALUE 'FINANZAS'.
                   88  DEPTO-MARKETING   VALUE 'MARKETING'.
               10  WS-EMP-NIVEL      PIC 9.
                   88  NIVEL-JUNIOR      VALUE 1.
                   88  NIVEL-SEMI-SR     VALUE 2.
                   88  NIVEL-SENIOR      VALUE 3.
                   88  NIVEL-LIDER       VALUE 4.
                   88  NIVEL-GERENTE     VALUE 5.
               10  WS-EMP-SALARIO    PIC 9(6)V99.
               10  WS-EMP-ANTIGUEDAD PIC 99.

      *    Estado del empleado
           05  WS-EMP-ESTADO-CIVIL   PIC X.
               88  EMP-SOLTERO       VALUE 'S'.
               88  EMP-CASADO        VALUE 'C'.
               88  EMP-DIVORCIADO    VALUE 'D'.
               88  EMP-VIUDO         VALUE 'V'.

           05  WS-EMP-ACTIVO         PIC X.
               88  EMP-ACTIVO        VALUE 'S'.
               88  EMP-INACTIVO      VALUE 'N'.

      *--- Variables calculadas ---*
       01  WS-NOMBRE-COMPLETO      PIC X(62).
       01  WS-DIRECCION-COMPLETA   PIC X(150).
       01  WS-BONO-ANUAL           PIC 9(6)V99.
       01  WS-SALARIO-TOTAL        PIC 9(7)V99.

       PROCEDURE DIVISION.

       MAIN-LOGIC.
           PERFORM INICIALIZAR-DATOS.
           PERFORM MOSTRAR-ENCABEZADO.
           PERFORM CALCULAR-COMPENSACION.
           PERFORM MOSTRAR-DATOS-COMPLETOS.
           PERFORM MODIFICAR-DATOS.
           PERFORM MOSTRAR-DATOS-ACTUALIZADOS.
           STOP RUN.

      *--- Inicializa datos de ejemplo ---*
       INICIALIZAR-DATOS.
      *    Datos personales
           MOVE 100234 TO WS-EMP-ID.
           MOVE "María" TO WS-EMP-NOMBRE-P.
           MOVE "González" TO WS-EMP-APELLIDO-P.
           MOVE "Rodríguez" TO WS-EMP-APELLIDO-M.
           MOVE 32 TO WS-EMP-EDAD.
           SET EMP-FEMENINO TO TRUE.

      *    Dirección
           MOVE "Av. Insurgentes" TO WS-EMP-CALLE.
           MOVE "1234" TO WS-EMP-NUMERO.
           MOVE "Del Valle" TO WS-EMP-COLONIA.
           MOVE "Ciudad de México" TO WS-EMP-CIUDAD.
           MOVE "CDMX" TO WS-EMP-ESTADO.
           MOVE "03100" TO WS-EMP-CP.

      *    Información laboral
           MOVE "Desarrolladora Senior" TO WS-EMP-PUESTO.
           SET DEPTO-SISTEMAS TO TRUE.
           SET NIVEL-SENIOR TO TRUE.
           MOVE 45000.00 TO WS-EMP-SALARIO.
           MOVE 05 TO WS-EMP-ANTIGUEDAD.

      *    Estado
           SET EMP-CASADO TO TRUE.
           SET EMP-ACTIVO TO TRUE.

      *--- Encabezado ---*
       MOSTRAR-ENCABEZADO.
           DISPLAY " ".
           DISPLAY "╔══════════════════════════════════════════════╗".
           DISPLAY "║   SISTEMA DE GESTIÓN DE EMPLEADOS - COBOL   ║".
           DISPLAY "║   Empresa: TechCorp Internacional           ║".
           DISPLAY "╚══════════════════════════════════════════════╝".
           DISPLAY " ".

      *--- Calcula compensación total ---*
       CALCULAR-COMPENSACION.
      *    Bono base: 10% del salario
           COMPUTE WS-BONO-ANUAL = WS-EMP-SALARIO * 0.10.

      *    Bono adicional por antigüedad: 2% por año
           COMPUTE WS-BONO-ANUAL = WS-BONO-ANUAL +
               (WS-EMP-SALARIO * 0.02 * WS-EMP-ANTIGUEDAD).

      *    Bono por nivel
           IF NIVEL-GERENTE THEN
               COMPUTE WS-BONO-ANUAL = WS-BONO-ANUAL + 10000
           ELSE IF NIVEL-LIDER THEN
               COMPUTE WS-BONO-ANUAL = WS-BONO-ANUAL + 5000
           ELSE IF NIVEL-SENIOR THEN
               COMPUTE WS-BONO-ANUAL = WS-BONO-ANUAL + 2000
           END-IF.

      *    Total anual
           COMPUTE WS-SALARIO-TOTAL = (WS-EMP-SALARIO * 12) +
               WS-BONO-ANUAL.

      *--- Muestra todos los datos ---*
       MOSTRAR-DATOS-COMPLETOS.
      *    Construir nombre completo
           STRING WS-EMP-NOMBRE-P DELIMITED BY "  "
                  " " DELIMITED BY SIZE
                  WS-EMP-APELLIDO-P DELIMITED BY "  "
                  " " DELIMITED BY SIZE
                  WS-EMP-APELLIDO-M DELIMITED BY "  "
                  INTO WS-NOMBRE-COMPLETO
           END-STRING.

      *    Construir dirección completa
           STRING WS-EMP-CALLE DELIMITED BY "  "
                  " " DELIMITED BY SIZE
                  WS-EMP-NUMERO DELIMITED BY "  "
                  ", " DELIMITED BY SIZE
                  WS-EMP-COLONIA DELIMITED BY "  "
                  ", " DELIMITED BY SIZE
                  WS-EMP-CIUDAD DELIMITED BY "  "
                  ", " DELIMITED BY SIZE
                  WS-EMP-ESTADO DELIMITED BY "  "
                  " " DELIMITED BY SIZE
                  WS-EMP-CP DELIMITED BY "  "
                  INTO WS-DIRECCION-COMPLETA
           END-STRING.

           DISPLAY "┌──────────────────────────────────────────────┐".
           DISPLAY "│           DATOS PERSONALES                   │".
           DISPLAY "├──────────────────────────────────────────────┤".
           DISPLAY "│  ID:     " WS-EMP-ID.
           DISPLAY "│  Nombre: " WS-NOMBRE-COMPLETO.
           DISPLAY "│  Edad:   " WS-EMP-EDAD " años".

           DISPLAY "│  Género: " WITH NO ADVANCING.
           IF EMP-MASCULINO THEN
               DISPLAY "Masculino"
           ELSE IF EMP-FEMENINO THEN
               DISPLAY "Femenino"
           ELSE IF EMP-OTRO THEN
               DISPLAY "Otro"
           END-IF.

           DISPLAY "│  Estado civil: " WITH NO ADVANCING.
           EVALUATE TRUE
               WHEN EMP-SOLTERO
                   DISPLAY "Soltero/a"
               WHEN EMP-CASADO
                   DISPLAY "Casado/a"
               WHEN EMP-DIVORCIADO
                   DISPLAY "Divorciado/a"
               WHEN EMP-VIUDO
                   DISPLAY "Viudo/a"
           END-EVALUATE.

           DISPLAY "└──────────────────────────────────────────────┘".
           DISPLAY " ".

           DISPLAY "┌──────────────────────────────────────────────┐".
           DISPLAY "│           DIRECCIÓN                          │".
           DISPLAY "├──────────────────────────────────────────────┤".
           DISPLAY "│  " WS-DIRECCION-COMPLETA.
           DISPLAY "└──────────────────────────────────────────────┘".
           DISPLAY " ".

           DISPLAY "┌──────────────────────────────────────────────┐".
           DISPLAY "│        INFORMACIÓN LABORAL                   │".
           DISPLAY "├──────────────────────────────────────────────┤".
           DISPLAY "│  Puesto:      " WS-EMP-PUESTO.
           DISPLAY "│  Departamento: " WS-EMP-DEPTO.
           DISPLAY "│  Nivel:       " WITH NO ADVANCING.

           EVALUATE TRUE
               WHEN NIVEL-JUNIOR
                   DISPLAY "Junior (1)"
               WHEN NIVEL-SEMI-SR
                   DISPLAY "Semi-Senior (2)"
               WHEN NIVEL-SENIOR
                   DISPLAY "Senior (3)"
               WHEN NIVEL-LIDER
                   DISPLAY "Líder (4)"
               WHEN NIVEL-GERENTE
                   DISPLAY "Gerente (5)"
           END-EVALUATE.

           DISPLAY "│  Antigüedad:  " WS-EMP-ANTIGUEDAD " años".
           DISPLAY "│  Status:      " WITH NO ADVANCING.
           IF EMP-ACTIVO THEN
               DISPLAY "✅ Activo"
           ELSE
               DISPLAY "❌ Inactivo"
           END-IF.
           DISPLAY "└──────────────────────────────────────────────┘".
           DISPLAY " ".

           DISPLAY "┌──────────────────────────────────────────────┐".
           DISPLAY "│          COMPENSACIÓN                        │".
           DISPLAY "├──────────────────────────────────────────────┤".
           DISPLAY "│  Salario mensual:  $" WS-EMP-SALARIO.
           DISPLAY "│  Bono anual:       $" WS-BONO-ANUAL.
           DISPLAY "│  ──────────────────────────────────────────  │".
           DISPLAY "│  Total anual:      $" WS-SALARIO-TOTAL.
           DISPLAY "└──────────────────────────────────────────────┘".
           DISPLAY " ".

      *--- Simula modificación de datos ---*
       MODIFICAR-DATOS.
           DISPLAY "──────────────────────────────────────────────".
           DISPLAY "  PROMOCIÓN APROBADA".
           DISPLAY "──────────────────────────────────────────────".
           DISPLAY " ".

      *    Promover a Líder de Equipo
           SET NIVEL-LIDER TO TRUE.
           MOVE "Líder de Desarrollo" TO WS-EMP-PUESTO.
           COMPUTE WS-EMP-SALARIO = WS-EMP-SALARIO * 1.15.

           DISPLAY "Se ha aplicado una promoción:".
           DISPLAY "  ✓ Nuevo puesto: " WS-EMP-PUESTO.
           DISPLAY "  ✓ Nuevo nivel: Líder (4)".
           DISPLAY "  ✓ Incremento salarial: 15%".
           DISPLAY "  ✓ Nuevo salario: $" WS-EMP-SALARIO.
           DISPLAY " ".

      *--- Muestra datos actualizados ---*
       MOSTRAR-DATOS-ACTUALIZADOS.
      *    Recalcular compensación
           PERFORM CALCULAR-COMPENSACION.

           DISPLAY "╔══════════════════════════════════════════════╗".
           DISPLAY "║      DATOS ACTUALIZADOS POST-PROMOCIÓN      ║".
           DISPLAY "╚══════════════════════════════════════════════╝".
           DISPLAY " ".
           DISPLAY "Puesto actual:       " WS-EMP-PUESTO.
           DISPLAY "Nivel actual:        Líder (4)".
           DISPLAY "Salario mensual:     $" WS-EMP-SALARIO.
           DISPLAY "Bono anual:          $" WS-BONO-ANUAL.
           DISPLAY "Compensación total:  $" WS-SALARIO-TOTAL.
           DISPLAY " ".

      *----------------------------------------------------------------*
      * EXPLICACIÓN DETALLADA:
      *
      * ESTRUCTURAS JERÁRQUICAS:
      *   01 - Nivel raíz (estructura completa)
      *   05 - Sub-grupos principales
      *   10 - Campos dentro de sub-grupos
      *   15 - Sub-campos dentro de campos
      *
      *   Permite organizar datos relacionados lógicamente
      *   Facilita el mantenimiento y comprensión del código
      *
      * NIVEL 88 - CONDICIONES CON NOMBRE:
      *   - Define valores constantes con nombres significativos
      *   - Hace el código más legible
      *   - Se usa con IF o EVALUATE
      *
      *   Sintaxis:
      *   01  VARIABLE   PIC X.
      *       88  NOMBRE-CONDICION  VALUE 'valor'.
      *
      *   Uso:
      *   IF NOMBRE-CONDICION THEN...
      *   SET NOMBRE-CONDICION TO TRUE (asigna el valor)
      *
      * SET TO TRUE:
      *   - Asigna el valor definido en el nivel 88
      *   - SET EMP-ACTIVO TO TRUE
      *   - Equivale a: MOVE 'S' TO WS-EMP-ACTIVO
      *   - Más legible y menos propenso a errores
      *
      * STRING:
      *   - Concatena múltiples valores en uno
      *   - DELIMITED BY especifica dónde terminar cada campo
      *   - "  " (dos espacios) ignora espacios trailing
      *   - SIZE usa el tamaño completo del campo
      *   - INTO especifica la variable destino
      *
      * EVALUATE TRUE:
      *   - Permite evaluar múltiples condiciones nivel 88
      *   - Más limpio que múltiples IFs
      *   - Similar a switch con condiciones booleanas
      *
      * VENTAJAS DE ESTRUCTURAS:
      *   1. Organización lógica de datos
      *   2. Fácil de entender y mantener
      *   3. Se puede pasar toda la estructura a subprogramas
      *   4. Refleja el modelo de datos del negocio
      *
      * BUENAS PRÁCTICAS:
      *   1. Usar nombres descriptivos para grupos
      *   2. Agrupar datos relacionados
      *   3. Usar nivel 88 para constantes
      *   4. Prefijos consistentes (WS-EMP-)
      *   5. Documentar la estructura de datos
      *
      * PARA COMPILAR Y EJECUTAR:
      * cobc -x -free ejemplo-07-empleados.cob
      * ./ejemplo-07-empleados
      *
      * EJERCICIO:
      * Extiende el programa para:
      * 1. Agregar dependientes del empleado
      * 2. Calcular deducciones de impuestos
      * 3. Agregar historial de promociones
      * 4. Permitir modificar múltiples campos interactivamente
      * 5. Validar cambios antes de aplicarlos
      *----------------------------------------------------------------*
