      ******************************************************************
      * EJEMPLO 9: ARCHIVO SECUENCIAL - CREAR Y LEER
      * Descripción: Operaciones básicas con archivo secuencial
      * Conceptos: SELECT, OPEN, WRITE, READ, CLOSE, FILE STATUS
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. ARCHIVO-SECUENCIAL.

      *----------------------------------------------------------------*
      * ENVIRONMENT DIVISION: Configuración de archivos
      *----------------------------------------------------------------*
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      *    Define el archivo de empleados
           SELECT ARCHIVO-EMPLEADOS
               ASSIGN TO "empleados.txt"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS WS-FILE-STATUS.

       DATA DIVISION.

      *----------------------------------------------------------------*
      * FILE SECTION: Estructura del archivo
      *----------------------------------------------------------------*
       FILE SECTION.
       FD  ARCHIVO-EMPLEADOS.
       01  REG-EMPLEADO.
           05  REG-ID            PIC 9(6).
           05  FILLER            PIC X VALUE "|".
           05  REG-NOMBRE        PIC X(40).
           05  FILLER            PIC X VALUE "|".
           05  REG-PUESTO        PIC X(30).
           05  FILLER            PIC X VALUE "|".
           05  REG-SALARIO       PIC 9(6)V99.
           05  FILLER            PIC X VALUE "|".
           05  REG-DEPTO         PIC X(20).

      *----------------------------------------------------------------*
      * WORKING-STORAGE: Variables de trabajo
      *----------------------------------------------------------------*
       WORKING-STORAGE SECTION.

      *--- Estado del archivo ---*
       01  WS-FILE-STATUS        PIC XX.
           88  WS-FILE-OK        VALUE "00".
           88  WS-FILE-EOF       VALUE "10".
           88  WS-FILE-NOT-FOUND VALUE "35".

      *--- Control del programa ---*
       01  WS-OPCION             PIC 9.
       01  WS-CONTINUAR          PIC X VALUE 'S'.
       01  WS-FIN-ARCHIVO        PIC X VALUE 'N'.

      *--- Variables de trabajo ---*
       01  WS-CONTADOR           PIC 9999 VALUE ZEROS.
       01  WS-TOTAL-SALARIOS     PIC 9(8)V99 VALUE ZEROS.
       01  WS-PROMEDIO           PIC 9(6)V99 VALUE ZEROS.

      *--- Buffer para entrada de usuario ---*
       01  WS-EMP.
           05  WS-ID             PIC 9(6).
           05  WS-NOMBRE         PIC X(40).
           05  WS-PUESTO         PIC X(30).
           05  WS-SALARIO        PIC 9(6)V99.
           05  WS-DEPTO          PIC X(20).

       PROCEDURE DIVISION.

       MAIN-LOGIC.
           PERFORM MOSTRAR-BIENVENIDA.

           PERFORM UNTIL WS-CONTINUAR = 'N' OR WS-CONTINUAR = 'n'
               PERFORM MOSTRAR-MENU
               PERFORM SOLICITAR-OPCION
               PERFORM PROCESAR-OPCION
           END-PERFORM.

           DISPLAY " ".
           DISPLAY "¡Hasta luego!".
           STOP RUN.

      *--- Bienvenida ---*
       MOSTRAR-BIENVENIDA.
           DISPLAY " ".
           DISPLAY "╔═══════════════════════════════════════════════╗".
           DISPLAY "║   GESTIÓN DE EMPLEADOS - ARCHIVO SECUENCIAL  ║".
           DISPLAY "╚═══════════════════════════════════════════════╝".
           DISPLAY " ".

      *--- Menú principal ---*
       MOSTRAR-MENU.
           DISPLAY "┌───────────────────────────────────────────────┐".
           DISPLAY "│  1. Agregar empleado                          │".
           DISPLAY "│  2. Listar todos los empleados                │".
           DISPLAY "│  3. Mostrar estadísticas                      │".
           DISPLAY "│  4. Salir                                     │".
           DISPLAY "└───────────────────────────────────────────────┘".
           DISPLAY " ".

      *--- Solicitar opción ---*
       SOLICITAR-OPCION.
           DISPLAY "Opción: " WITH NO ADVANCING.
           ACCEPT WS-OPCION.
           DISPLAY " ".

      *--- Procesar opción ---*
       PROCESAR-OPCION.
           EVALUATE WS-OPCION
               WHEN 1
                   PERFORM AGREGAR-EMPLEADO
               WHEN 2
                   PERFORM LISTAR-EMPLEADOS
               WHEN 3
                   PERFORM MOSTRAR-ESTADISTICAS
               WHEN 4
                   MOVE 'N' TO WS-CONTINUAR
               WHEN OTHER
                   DISPLAY "❌ Opción inválida."
                   DISPLAY " "
           END-EVALUATE.

      *-----------------------------------------------------------------*
      * AGREGAR EMPLEADO
      * Abre archivo en modo EXTEND (agregar al final)
      *-----------------------------------------------------------------*
       AGREGAR-EMPLEADO.
           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY "  AGREGAR NUEVO EMPLEADO".
           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY " ".

      *    Solicitar datos
           DISPLAY "ID (6 dígitos): " WITH NO ADVANCING.
           ACCEPT WS-ID.

           DISPLAY "Nombre completo: " WITH NO ADVANCING.
           ACCEPT WS-NOMBRE.

           DISPLAY "Puesto: " WITH NO ADVANCING.
           ACCEPT WS-PUESTO.

           DISPLAY "Salario mensual: " WITH NO ADVANCING.
           ACCEPT WS-SALARIO.

           DISPLAY "Departamento: " WITH NO ADVANCING.
           ACCEPT WS-DEPTO.

      *    Abrir archivo en modo EXTEND (agregar al final)
           OPEN EXTEND ARCHIVO-EMPLEADOS.

      *    Verificar que se abrió correctamente
           IF NOT WS-FILE-OK THEN
      *        Si no existe, crear nuevo
               IF WS-FILE-NOT-FOUND THEN
                   OPEN OUTPUT ARCHIVO-EMPLEADOS
                   IF NOT WS-FILE-OK THEN
                       DISPLAY " "
                       DISPLAY "❌ Error creando archivo: "
                               WS-FILE-STATUS
                       DISPLAY " "
                       GO TO AGREGAR-EMPLEADO-FIN
                   END-IF
               ELSE
                   DISPLAY " "
                   DISPLAY "❌ Error abriendo archivo: "
                           WS-FILE-STATUS
                   DISPLAY " "
                   GO TO AGREGAR-EMPLEADO-FIN
               END-IF
           END-IF.

      *    Copiar datos al registro del archivo
           MOVE WS-ID TO REG-ID.
           MOVE WS-NOMBRE TO REG-NOMBRE.
           MOVE WS-PUESTO TO REG-PUESTO.
           MOVE WS-SALARIO TO REG-SALARIO.
           MOVE WS-DEPTO TO REG-DEPTO.

      *    Escribir el registro
           WRITE REG-EMPLEADO.

      *    Verificar que se escribió correctamente
           IF WS-FILE-OK THEN
               DISPLAY " "
               DISPLAY "✅ Empleado agregado exitosamente!"
           ELSE
               DISPLAY " "
               DISPLAY "❌ Error escribiendo registro: " WS-FILE-STATUS
           END-IF.

      *    Cerrar archivo
           CLOSE ARCHIVO-EMPLEADOS.

           DISPLAY " ".
           PERFORM PAUSAR.

       AGREGAR-EMPLEADO-FIN.
           EXIT.

      *-----------------------------------------------------------------*
      * LISTAR EMPLEADOS
      * Lee el archivo secuencialmente y muestra todos los registros
      *-----------------------------------------------------------------*
       LISTAR-EMPLEADOS.
           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY "  LISTADO DE EMPLEADOS".
           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY " ".

      *    Abrir archivo para lectura
           OPEN INPUT ARCHIVO-EMPLEADOS.

      *    Verificar apertura
           IF NOT WS-FILE-OK THEN
               IF WS-FILE-NOT-FOUND THEN
                   DISPLAY "⚠️  No hay empleados registrados aún."
               ELSE
                   DISPLAY "❌ Error abriendo archivo: " WS-FILE-STATUS
               END-IF
               DISPLAY " "
               GO TO LISTAR-EMPLEADOS-FIN
           END-IF.

      *    Encabezados de columnas
           DISPLAY "ID     | NOMBRE                  | PUESTO".
           DISPLAY "-------+-------------------------+--------".

      *    Leer y mostrar cada registro
           MOVE 'N' TO WS-FIN-ARCHIVO.
           MOVE ZEROS TO WS-CONTADOR.

           PERFORM UNTIL WS-FIN-ARCHIVO = 'S'
               READ ARCHIVO-EMPLEADOS
                   AT END
                       MOVE 'S' TO WS-FIN-ARCHIVO
                   NOT AT END
                       ADD 1 TO WS-CONTADOR
                       DISPLAY REG-ID " | " REG-NOMBRE " | " REG-PUESTO
               END-READ
           END-PERFORM.

           DISPLAY " ".
           DISPLAY "Total de empleados: " WS-CONTADOR.

      *    Cerrar archivo
           CLOSE ARCHIVO-EMPLEADOS.

           DISPLAY " ".
           PERFORM PAUSAR.

       LISTAR-EMPLEADOS-FIN.
           EXIT.

      *-----------------------------------------------------------------*
      * MOSTRAR ESTADÍSTICAS
      * Calcula y muestra estadísticas del archivo
      *-----------------------------------------------------------------*
       MOSTRAR-ESTADISTICAS.
           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY "  ESTADÍSTICAS DE EMPLEADOS".
           DISPLAY "═══════════════════════════════════════════════".
           DISPLAY " ".

      *    Abrir archivo
           OPEN INPUT ARCHIVO-EMPLEADOS.

           IF NOT WS-FILE-OK THEN
               IF WS-FILE-NOT-FOUND THEN
                   DISPLAY "⚠️  No hay datos para analizar."
               ELSE
                   DISPLAY "❌ Error: " WS-FILE-STATUS
               END-IF
               DISPLAY " "
               GO TO MOSTRAR-ESTADISTICAS-FIN
           END-IF.

      *    Inicializar contadores
           MOVE ZEROS TO WS-CONTADOR.
           MOVE ZEROS TO WS-TOTAL-SALARIOS.
           MOVE 'N' TO WS-FIN-ARCHIVO.

      *    Procesar todos los registros
           PERFORM UNTIL WS-FIN-ARCHIVO = 'S'
               READ ARCHIVO-EMPLEADOS
                   AT END
                       MOVE 'S' TO WS-FIN-ARCHIVO
                   NOT AT END
                       ADD 1 TO WS-CONTADOR
                       ADD REG-SALARIO TO WS-TOTAL-SALARIOS
               END-READ
           END-PERFORM.

      *    Calcular promedio
           IF WS-CONTADOR > 0 THEN
               COMPUTE WS-PROMEDIO = WS-TOTAL-SALARIOS / WS-CONTADOR
           END-IF.

      *    Mostrar resultados
           DISPLAY "📊 ESTADÍSTICAS:".
           DISPLAY "────────────────────────────────────────────".
           DISPLAY "  Total empleados:    " WS-CONTADOR.
           DISPLAY "  Nómina total:       $" WS-TOTAL-SALARIOS.
           DISPLAY "  Salario promedio:   $" WS-PROMEDIO.
           DISPLAY " ".

           CLOSE ARCHIVO-EMPLEADOS.
           PERFORM PAUSAR.

       MOSTRAR-ESTADISTICAS-FIN.
           EXIT.

      *--- Pausa ---*
       PAUSAR.
           DISPLAY "Presiona ENTER para continuar..."
               WITH NO ADVANCING.
           ACCEPT WS-OPCION.
           DISPLAY " ".

      *----------------------------------------------------------------*
      * EXPLICACIÓN DETALLADA:
      *
      * FILE-CONTROL:
      *   SELECT - Nombre lógico del archivo en el programa
      *   ASSIGN - Nombre físico del archivo en disco
      *   ORGANIZATION - Tipo de archivo (LINE SEQUENTIAL para texto)
      *   FILE STATUS - Variable que contiene resultado de operaciones
      *
      * FILE STATUS - Códigos importantes:
      *   "00" - Operación exitosa
      *   "10" - Fin de archivo alcanzado
      *   "35" - Archivo no encontrado
      *   "30" - Error permanente
      *
      * FD (File Description):
      *   Define la estructura del registro en el archivo
      *   FILLER - Campos que no se usan (separadores)
      *   El layout debe coincidir con cómo se escribe/lee
      *
      * OPEN:
      *   INPUT - Solo lectura
      *   OUTPUT - Solo escritura (crea nuevo, sobrescribe existente)
      *   EXTEND - Agregar al final del archivo
      *   I-O - Lectura y escritura (solo archivos indexados)
      *
      * READ:
      *   Lee el siguiente registro del archivo
      *   AT END - Ejecuta cuando llega al final
      *   NOT AT END - Ejecuta cuando la lectura es exitosa
      *   Incrementa puntero automáticamente
      *
      * WRITE:
      *   Escribe un registro al archivo
      *   En secuenciales, siempre al final
      *   El registro debe estar en FD, no en WORKING-STORAGE
      *
      * CLOSE:
      *   Cierra el archivo y libera recursos
      *   SIEMPRE cerrar archivos al terminar
      *   No cerrar = posible pérdida de datos
      *
      * ORGANIZATION IS LINE SEQUENTIAL:
      *   - Archivo de texto con saltos de línea
      *   - Cada WRITE crea una línea nueva
      *   - Legible con editores de texto
      *   - Ideal para archivos simples
      *
      * BUENAS PRÁCTICAS:
      *   1. Siempre verificar FILE STATUS después de operaciones
      *   2. Cerrar archivos en todos los caminos de ejecución
      *   3. Manejar el caso de archivo no encontrado
      *   4. Usar AT END en todos los READs en loops
      *   5. Inicializar variables antes de loops
      *
      * LIMITACIONES DE ARCHIVOS SECUENCIALES:
      *   - No se puede modificar registro (necesitas reescribir todo)
      *   - No se puede buscar por clave directamente
      *   - Debes leer desde el inicio
      *   - Para actualizar, crear archivo temporal
      *
      * PARA COMPILAR Y EJECUTAR:
      * cobc -x -free ejemplo-09-archivo-secuencial.cob
      * ./ejemplo-09-archivo-secuencial
      *
      * EJERCICIO:
      * Agrega las siguientes funcionalidades:
      * 1. Buscar empleado por ID (debe leer todo el archivo)
      * 2. Exportar a CSV
      * 3. Filtrar por departamento
      * 4. Ordenar por salario (crear archivo nuevo ordenado)
      * 5. Eliminar empleado (crear archivo temporal)
      *----------------------------------------------------------------*
