      ******************************************************************
      * EJEMPLO 6: MENÚ INTERACTIVO CON EVALUATE
      * Descripción: Sistema bancario simple con menú de opciones
      * Conceptos: EVALUATE, PERFORM UNTIL, variables de control
      ******************************************************************

       IDENTIFICATION DIVISION.
       PROGRAM-ID. MENU-BANCARIO.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *--- Datos de la cuenta ---*
       01  WS-CUENTA.
           05  WS-NUMERO-CUENTA  PIC X(10) VALUE "0001234567".
           05  WS-TITULAR        PIC X(40) VALUE "Juan García Pérez".
           05  WS-SALDO          PIC 9(8)V99 VALUE 15000.00.

      *--- Variables de transacción ---*
       01  WS-MONTO            PIC 9(8)V99 VALUE ZEROS.
       01  WS-MONTO-TEMP       PIC X(12) VALUE SPACES.

      *--- Control del menú ---*
       01  WS-OPCION           PIC 9 VALUE ZEROS.
       01  WS-CONTINUAR        PIC X VALUE 'S'.

      *--- Contadores ---*
       01  WS-NUM-TRANSACCIONES PIC 999 VALUE ZEROS.
       01  WS-TOTAL-DEPOSITOS   PIC 9(8)V99 VALUE ZEROS.
       01  WS-TOTAL-RETIROS     PIC 9(8)V99 VALUE ZEROS.

       PROCEDURE DIVISION.

       MAIN-LOGIC.
           PERFORM MOSTRAR-BIENVENIDA.

           PERFORM UNTIL WS-CONTINUAR = 'N' OR WS-CONTINUAR = 'n'
               PERFORM MOSTRAR-MENU
               PERFORM SOLICITAR-OPCION
               PERFORM PROCESAR-OPCION
           END-PERFORM.

           PERFORM MOSTRAR-DESPEDIDA.
           STOP RUN.

      *--- Bienvenida ---*
       MOSTRAR-BIENVENIDA.
           DISPLAY " ".
           DISPLAY "╔═══════════════════════════════════════════╗".
           DISPLAY "║      SISTEMA BANCARIO NACIONAL           ║".
           DISPLAY "║      Banca en Línea - COBOL v1.0         ║".
           DISPLAY "╚═══════════════════════════════════════════╝".
           DISPLAY " ".
           DISPLAY "Bienvenido, " WS-TITULAR.
           DISPLAY "Cuenta: " WS-NUMERO-CUENTA.
           DISPLAY " ".

      *--- Muestra el menú de opciones ---*
       MOSTRAR-MENU.
           DISPLAY "┌───────────────────────────────────────────┐".
           DISPLAY "│           MENÚ PRINCIPAL                  │".
           DISPLAY "├───────────────────────────────────────────┤".
           DISPLAY "│  1. Consultar saldo                       │".
           DISPLAY "│  2. Depositar dinero                      │".
           DISPLAY "│  3. Retirar dinero                        │".
           DISPLAY "│  4. Ver resumen de transacciones          │".
           DISPLAY "│  5. Transferencia rápida                  │".
           DISPLAY "│  6. Salir                                 │".
           DISPLAY "└───────────────────────────────────────────┘".
           DISPLAY " ".

      *--- Solicita la opción del usuario ---*
       SOLICITAR-OPCION.
           DISPLAY "Selecciona una opción (1-6): " WITH NO ADVANCING.
           ACCEPT WS-OPCION.
           DISPLAY " ".

      *--- Procesa la opción con EVALUATE ---*
       PROCESAR-OPCION.
           EVALUATE WS-OPCION
               WHEN 1
                   PERFORM CONSULTAR-SALDO
               WHEN 2
                   PERFORM HACER-DEPOSITO
               WHEN 3
                   PERFORM HACER-RETIRO
               WHEN 4
                   PERFORM VER-RESUMEN
               WHEN 5
                   PERFORM TRANSFERENCIA-RAPIDA
               WHEN 6
                   PERFORM CONFIRMAR-SALIDA
               WHEN OTHER
                   DISPLAY "❌ Opción inválida. Intenta de nuevo."
                   DISPLAY " "
           END-EVALUATE.

      *--- Opción 1: Consultar saldo ---*
       CONSULTAR-SALDO.
           DISPLAY "╔═══════════════════════════════════════════╗".
           DISPLAY "║           CONSULTA DE SALDO              ║".
           DISPLAY "╚═══════════════════════════════════════════╝".
           DISPLAY " ".
           DISPLAY "Titular:        " WS-TITULAR.
           DISPLAY "Cuenta:         " WS-NUMERO-CUENTA.
           DISPLAY "Saldo actual:   $" WS-SALDO.
           DISPLAY " ".

      *    Mensaje según el saldo
           IF WS-SALDO >= 50000 THEN
               DISPLAY "💎 Cliente Premium - Saldo excelente"
           ELSE IF WS-SALDO >= 10000 THEN
               DISPLAY "⭐ Cliente Preferente"
           ELSE IF WS-SALDO > 0 THEN
               DISPLAY "✓ Cuenta en orden"
           ELSE IF WS-SALDO = 0 THEN
               DISPLAY "⚠️  Saldo en cero - Considera hacer un depósito"
           ELSE
               DISPLAY "❌ Cuenta sobregira da - Regulariza tu situación"
           END-IF.

           DISPLAY " ".
           PERFORM PAUSAR.

      *--- Opción 2: Depositar ---*
       HACER-DEPOSITO.
           DISPLAY "╔═══════════════════════════════════════════╗".
           DISPLAY "║              DEPÓSITO                    ║".
           DISPLAY "╚═══════════════════════════════════════════╝".
           DISPLAY " ".
           DISPLAY "Saldo actual: $" WS-SALDO.
           DISPLAY " ".
           DISPLAY "Ingresa el monto a depositar: $"
               WITH NO ADVANCING.
           ACCEPT WS-MONTO-TEMP.

           MOVE FUNCTION NUMVAL(WS-MONTO-TEMP) TO WS-MONTO.

           IF WS-MONTO > 0 AND WS-MONTO <= 99999999 THEN
               ADD WS-MONTO TO WS-SALDO
               ADD WS-MONTO TO WS-TOTAL-DEPOSITOS
               ADD 1 TO WS-NUM-TRANSACCIONES
               DISPLAY " "
               DISPLAY "✅ Depósito exitoso!"
               DISPLAY "   Monto depositado: $" WS-MONTO
               DISPLAY "   Nuevo saldo:      $" WS-SALDO
           ELSE
               DISPLAY " "
               DISPLAY "❌ Monto inválido. Intenta de nuevo."
           END-IF.

           DISPLAY " ".
           PERFORM PAUSAR.

      *--- Opción 3: Retirar ---*
       HACER-RETIRO.
           DISPLAY "╔═══════════════════════════════════════════╗".
           DISPLAY "║               RETIRO                     ║".
           DISPLAY "╚═══════════════════════════════════════════╝".
           DISPLAY " ".
           DISPLAY "Saldo disponible: $" WS-SALDO.
           DISPLAY " ".
           DISPLAY "Ingresa el monto a retirar: $"
               WITH NO ADVANCING.
           ACCEPT WS-MONTO-TEMP.

           MOVE FUNCTION NUMVAL(WS-MONTO-TEMP) TO WS-MONTO.

           IF WS-MONTO > 0 AND WS-MONTO <= WS-SALDO THEN
               SUBTRACT WS-MONTO FROM WS-SALDO
               ADD WS-MONTO TO WS-TOTAL-RETIROS
               ADD 1 TO WS-NUM-TRANSACCIONES
               DISPLAY " "
               DISPLAY "✅ Retiro exitoso!"
               DISPLAY "   Monto retirado: $" WS-MONTO
               DISPLAY "   Nuevo saldo:    $" WS-SALDO
           ELSE IF WS-MONTO > WS-SALDO THEN
               DISPLAY " "
               DISPLAY "❌ Fondos insuficientes."
               DISPLAY "   Saldo disponible: $" WS-SALDO
           ELSE
               DISPLAY " "
               DISPLAY "❌ Monto inválido."
           END-IF.

           DISPLAY " ".
           PERFORM PAUSAR.

      *--- Opción 4: Resumen ---*
       VER-RESUMEN.
           DISPLAY "╔═══════════════════════════════════════════╗".
           DISPLAY "║        RESUMEN DE TRANSACCIONES          ║".
           DISPLAY "╚═══════════════════════════════════════════╝".
           DISPLAY " ".
           DISPLAY "Número de cuenta:    " WS-NUMERO-CUENTA.
           DISPLAY "Titular:             " WS-TITULAR.
           DISPLAY " ".
           DISPLAY "────────────────────────────────────────────".
           DISPLAY "Saldo actual:        $" WS-SALDO.
           DISPLAY " ".
           DISPLAY "Total de transacciones: " WS-NUM-TRANSACCIONES.
           DISPLAY "Total depositado:       $" WS-TOTAL-DEPOSITOS.
           DISPLAY "Total retirado:         $" WS-TOTAL-RETIROS.
           DISPLAY "────────────────────────────────────────────".
           DISPLAY " ".
           PERFORM PAUSAR.

      *--- Opción 5: Transferencia rápida ---*
       TRANSFERENCIA-RAPIDA.
           DISPLAY "╔═══════════════════════════════════════════╗".
           DISPLAY "║         TRANSFERENCIA RÁPIDA             ║".
           DISPLAY "╚═══════════════════════════════════════════╝".
           DISPLAY " ".
           DISPLAY "Montos rápidos disponibles:".
           DISPLAY "  1. $500".
           DISPLAY "  2. $1,000".
           DISPLAY "  3. $2,000".
           DISPLAY "  4. $5,000".
           DISPLAY " ".
           DISPLAY "Selecciona monto (1-4): " WITH NO ADVANCING.
           ACCEPT WS-OPCION.

           EVALUATE WS-OPCION
               WHEN 1
                   MOVE 500 TO WS-MONTO
               WHEN 2
                   MOVE 1000 TO WS-MONTO
               WHEN 3
                   MOVE 2000 TO WS-MONTO
               WHEN 4
                   MOVE 5000 TO WS-MONTO
               WHEN OTHER
                   MOVE ZEROS TO WS-MONTO
           END-EVALUATE.

           IF WS-MONTO > 0 THEN
               IF WS-MONTO <= WS-SALDO THEN
                   SUBTRACT WS-MONTO FROM WS-SALDO
                   ADD WS-MONTO TO WS-TOTAL-RETIROS
                   ADD 1 TO WS-NUM-TRANSACCIONES
                   DISPLAY " "
                   DISPLAY "✅ Transferencia exitosa!"
                   DISPLAY "   Monto transferido: $" WS-MONTO
                   DISPLAY "   Nuevo saldo:       $" WS-SALDO
               ELSE
                   DISPLAY " "
                   DISPLAY "❌ Fondos insuficientes."
               END-IF
           ELSE
               DISPLAY " "
               DISPLAY "❌ Opción inválida."
           END-IF.

           DISPLAY " ".
           PERFORM PAUSAR.

      *--- Opción 6: Salir ---*
       CONFIRMAR-SALIDA.
           DISPLAY "¿Estás seguro de salir? (S/N): "
               WITH NO ADVANCING.
           ACCEPT WS-CONTINUAR.

           IF WS-CONTINUAR = 'S' OR WS-CONTINUAR = 's' THEN
               MOVE 'N' TO WS-CONTINUAR
           ELSE
               MOVE 'S' TO WS-CONTINUAR
           END-IF.

      *--- Pausa para que el usuario lea ---*
       PAUSAR.
           DISPLAY "Presiona ENTER para continuar..."
               WITH NO ADVANCING.
           ACCEPT WS-MONTO-TEMP.

      *--- Despedida ---*
       MOSTRAR-DESPEDIDA.
           DISPLAY " ".
           DISPLAY "╔═══════════════════════════════════════════╗".
           DISPLAY "║    Gracias por usar nuestro sistema      ║".
           DISPLAY "║    Vuelve pronto!                        ║".
           DISPLAY "╚═══════════════════════════════════════════╝".
           DISPLAY " ".

      *----------------------------------------------------------------*
      * EXPLICACIÓN DETALLADA:
      *
      * EVALUATE:
      *   Similar a switch/case en otros lenguajes
      *   Más limpio que múltiples IFs para opciones de menú
      *   WHEN OTHER maneja casos no contemplados
      *
      * PERFORM UNTIL:
      *   Crea un bucle que se ejecuta hasta que la condición sea verdadera
      *   Útil para menús que deben repetirse
      *   La condición se evalúa ANTES de ejecutar
      *
      * ESTRUCTURA DE MENÚ:
      *   1. Mostrar opciones
      *   2. Leer opción del usuario
      *   3. Procesar con EVALUATE
      *   4. Ejecutar acción correspondiente
      *   5. Repetir hasta que elija salir
      *
      * VALIDACIÓN EN TRANSACCIONES:
      *   - Verificar que el monto sea positivo
      *   - En retiros, verificar fondos suficientes
      *   - Dar feedback claro de éxito o error
      *
      * ACUMULADORES:
      *   WS-NUM-TRANSACCIONES: cuenta operaciones
      *   WS-TOTAL-DEPOSITOS: suma todos los depósitos
      *   WS-TOTAL-RETIROS: suma todos los retiros
      *   Se incrementan con ADD
      *
      * FUNCIÓN NUMVAL:
      *   Convierte string a número
      *   Útil cuando ACCEPT lee como texto
      *   Permite validar antes de usar
      *
      * MODULARIZACIÓN:
      *   Cada opción del menú es un párrafo separado
      *   Fácil de mantener y extender
      *   Código más legible y organizado
      *
      * INTERFAZ DE USUARIO:
      *   - Mensajes claros y formateados
      *   - Confirmaciones para operaciones importantes
      *   - Feedback visual (✅, ❌, ⚠️)
      *   - Pausas para que el usuario lea
      *
      * PARA COMPILAR Y EJECUTAR:
      * cobc -x -free ejemplo-06-menu.cob
      * ./ejemplo-06-menu
      *
      * EJERCICIO:
      * Agrega las siguientes opciones al menú:
      * 1. Cambiar PIN
      * 2. Ver últimas 5 transacciones (usar tabla)
      * 3. Transferir a otra cuenta
      * 4. Solicitar estado de cuenta por email
      * 5. Calcular intereses ganados
      *----------------------------------------------------------------*
