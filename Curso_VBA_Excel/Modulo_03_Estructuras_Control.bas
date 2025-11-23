Attribute VB_Name = "Modulo_03_Estructuras_Control"
'===============================================================================
' MÓDULO 3: ESTRUCTURAS DE CONTROL
'===============================================================================
' Este módulo cubre las estructuras de control de flujo en VBA
' Incluye: If/Then/Else, Select Case, bucles For/While/Do, manejo de errores
'===============================================================================

'-------------------------------------------------------------------------------
' SECCIÓN 3.1: CONDICIONAL IF...THEN...ELSE
'-------------------------------------------------------------------------------

Sub EstructuraIfBasica()
    Dim edad As Integer

    edad = InputBox("¿Cuál es tu edad?")

    ' IF SIMPLE (una línea)
    If edad >= 18 Then MsgBox "Eres mayor de edad"

    ' IF CON BLOQUE (múltiples líneas)
    If edad >= 18 Then
        MsgBox "Eres mayor de edad"
        Range("A1").Value = "Mayor de edad"
    End If

    ' IF...ELSE
    If edad >= 18 Then
        MsgBox "Puedes votar"
    Else
        MsgBox "No puedes votar aún"
    End If

    ' IF...ELSEIF...ELSE (múltiples condiciones)
    If edad < 13 Then
        MsgBox "Eres un niño"
    ElseIf edad < 18 Then
        MsgBox "Eres un adolescente"
    ElseIf edad < 65 Then
        MsgBox "Eres un adulto"
    Else
        MsgBox "Eres un adulto mayor"
    End If
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 3.2: OPERADORES LÓGICOS EN CONDICIONALES
'-------------------------------------------------------------------------------

Sub CondicionalesConOperadoresLogicos()
    Dim edad As Integer
    Dim tieneLicencia As Boolean

    edad = InputBox("¿Cuál es tu edad?")
    tieneLicencia = MsgBox("¿Tienes licencia de conducir?", vbYesNo) = vbYes

    ' AND - Ambas condiciones deben cumplirse
    If edad >= 18 And tieneLicencia Then
        MsgBox "Puedes conducir legalmente"
    Else
        MsgBox "No puedes conducir"
    End If

    ' OR - Al menos una condición debe cumplirse
    Dim esEstudiante As Boolean
    Dim esProfesor As Boolean

    esEstudiante = MsgBox("¿Eres estudiante?", vbYesNo) = vbYes
    esProfesor = MsgBox("¿Eres profesor?", vbYesNo) = vbYes

    If esEstudiante Or esProfesor Then
        MsgBox "Tienes descuento en la biblioteca"
    End If

    ' NOT - Invierte la condición
    If Not esEstudiante Then
        MsgBox "No eres estudiante"
    End If

    ' COMBINACIONES
    If (edad >= 18 And tieneLicencia) Or esProfesor Then
        MsgBox "Puedes rentar un auto"
    End If
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 3.3: SELECT CASE (Switch)
'-------------------------------------------------------------------------------

Sub EstructuraSelectCase()
    Dim dia As Integer

    dia = InputBox("Ingresa un número del 1 al 7:")

    ' SELECT CASE es más limpio que múltiples IF/ELSEIF
    Select Case dia
        Case 1
            MsgBox "Lunes - Inicio de semana"

        Case 2
            MsgBox "Martes"

        Case 3
            MsgBox "Miércoles - Mitad de semana"

        Case 4
            MsgBox "Jueves"

        Case 5
            MsgBox "Viernes - ¡Casi fin de semana!"

        Case 6, 7  ' Múltiples valores
            MsgBox "¡Fin de semana!"

        Case Else  ' Si no coincide con ninguno
            MsgBox "Número no válido. Ingresa del 1 al 7"
    End Select
End Sub

Sub SelectCaseConRangos()
    Dim calificacion As Integer

    calificacion = InputBox("Ingresa tu calificación (0-100):")

    ' SELECT CASE con rangos
    Select Case calificacion
        Case 90 To 100
            MsgBox "Excelente - A"
            Range("A1").Value = "A"
            Range("A1").Interior.Color = RGB(0, 255, 0)

        Case 80 To 89
            MsgBox "Muy Bueno - B"
            Range("A1").Value = "B"
            Range("A1").Interior.Color = RGB(144, 238, 144)

        Case 70 To 79
            MsgBox "Bueno - C"
            Range("A1").Value = "C"
            Range("A1").Interior.Color = RGB(255, 255, 0)

        Case 60 To 69
            MsgBox "Suficiente - D"
            Range("A1").Value = "D"
            Range("A1").Interior.Color = RGB(255, 165, 0)

        Case 0 To 59
            MsgBox "Reprobado - F"
            Range("A1").Value = "F"
            Range("A1").Interior.Color = RGB(255, 0, 0)

        Case Else
            MsgBox "Calificación no válida"
    End Select
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 3.4: BUCLE FOR...NEXT
'-------------------------------------------------------------------------------

Sub BucleForBasico()
    Dim i As Integer

    ' Bucle simple del 1 al 10
    For i = 1 To 10
        Cells(i, 1).Value = i
        Cells(i, 2).Value = i * i  ' Cuadrado
        Cells(i, 3).Value = i * i * i  ' Cubo
    Next i

    ' Formato
    Range("A1:C1").Value = Array("Número", "Cuadrado", "Cubo")
    Range("A1:C1").Font.Bold = True
    Columns("A:C").AutoFit
End Sub

Sub BucleForConStep()
    Dim i As Integer

    ' Limpiar
    Range("A1:B20").Clear

    ' STEP positivo (incremento)
    Range("A1").Value = "Números pares:"
    For i = 2 To 20 Step 2  ' Incrementa de 2 en 2
        Cells(i / 2 + 1, 1).Value = i
    Next i

    ' STEP negativo (decremento)
    Range("B1").Value = "Cuenta regresiva:"
    Dim fila As Integer
    fila = 2
    For i = 10 To 1 Step -1  ' Decrementa de 1 en 1
        Cells(fila, 2).Value = i
        fila = fila + 1
    Next i
End Sub

Sub BucleForAnidado()
    ' Bucles dentro de bucles
    Dim fila As Integer
    Dim columna As Integer

    ' Limpiar
    Range("A1:J10").Clear

    ' Crear una tabla de multiplicar 10×10
    For fila = 1 To 10
        For columna = 1 To 10
            Cells(fila, columna).Value = fila * columna

            ' Formato alternado
            If (fila + columna) Mod 2 = 0 Then
                Cells(fila, columna).Interior.Color = RGB(240, 240, 240)
            End If
        Next columna
    Next fila

    ' Resaltar diagonal
    For i = 1 To 10
        Cells(i, i).Font.Bold = True
        Cells(i, i).Font.Color = RGB(255, 0, 0)
    Next i

    ' Ajustar columnas
    Columns("A:J").AutoFit
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 3.5: BUCLE FOR EACH
'-------------------------------------------------------------------------------

Sub BucleForEach()
    ' FOR EACH itera sobre cada elemento de una colección
    Dim celda As Range
    Dim rango As Range

    ' Preparar datos
    Range("A1:E1").Value = Array(10, 20, 30, 40, 50)

    ' Definir el rango
    Set rango = Range("A1:E1")

    ' Iterar sobre cada celda
    For Each celda In rango
        celda.Value = celda.Value * 2  ' Duplicar cada valor
        celda.Font.Bold = True
    Next celda
End Sub

Sub ForEachConHojas()
    ' Iterar sobre todas las hojas del libro
    Dim hoja As Worksheet

    For Each hoja In ThisWorkbook.Worksheets
        ' Escribir el nombre de la hoja en su celda A1
        hoja.Range("A1").Value = "Esta es la hoja: " & hoja.Name
        hoja.Range("A1").Font.Bold = True
    Next hoja

    MsgBox "Se procesaron " & ThisWorkbook.Worksheets.Count & " hojas"
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 3.6: BUCLE DO...LOOP
'-------------------------------------------------------------------------------

Sub BucleDoWhile()
    ' DO WHILE - Se ejecuta mientras la condición sea verdadera
    Dim contador As Integer
    Dim suma As Integer

    contador = 1
    suma = 0

    ' La condición se evalúa AL INICIO
    Do While contador <= 10
        suma = suma + contador
        Cells(contador, 1).Value = contador
        Cells(contador, 2).Value = suma
        contador = contador + 1
    Loop

    MsgBox "La suma de 1 a 10 es: " & suma
End Sub

Sub BucleDoUntil()
    ' DO UNTIL - Se ejecuta hasta que la condición sea verdadera
    Dim numero As Integer
    Dim fila As Integer

    numero = 1
    fila = 1

    ' Se ejecuta hasta que numero sea mayor a 100
    Do Until numero > 100
        Cells(fila, 1).Value = numero
        numero = numero * 2  ' Duplicar
        fila = fila + 1
    Loop

    MsgBox "Potencias de 2 generadas hasta " & numero / 2
End Sub

Sub BucleDoLoopValidacion()
    ' Usar DO LOOP para validar entrada del usuario
    Dim edad As Integer

    Do
        edad = InputBox("Ingresa tu edad (debe ser entre 1 y 120):")

        If edad < 1 Or edad > 120 Then
            MsgBox "Edad no válida. Intenta de nuevo.", vbExclamation
        End If
    Loop Until edad >= 1 And edad <= 120

    MsgBox "Edad válida ingresada: " & edad, vbInformation
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 3.7: EXIT Y CONTROL DE BUCLES
'-------------------------------------------------------------------------------

Sub UsarExitFor()
    ' EXIT FOR sale del bucle prematuramente
    Dim i As Integer

    For i = 1 To 100
        Cells(i, 1).Value = i

        ' Si encontramos un múltiplo de 7 mayor a 50, salir
        If i > 50 And i Mod 7 = 0 Then
            MsgBox "Encontrado: " & i & " (múltiplo de 7 mayor a 50)"
            Cells(i, 1).Interior.Color = RGB(255, 255, 0)
            Exit For  ' Sale del bucle inmediatamente
        End If
    Next i
End Sub

Sub UsarExitDo()
    ' EXIT DO sale del bucle Do prematuramente
    Dim numero As Integer
    Dim fila As Integer

    fila = 1

    Do
        numero = Int(Rnd() * 100) + 1  ' Número aleatorio 1-100
        Cells(fila, 1).Value = numero

        ' Si encontramos un número mayor a 90, salir
        If numero > 90 Then
            Cells(fila, 1).Interior.Color = RGB(0, 255, 0)
            MsgBox "Número encontrado: " & numero
            Exit Do
        End If

        fila = fila + 1
    Loop

    MsgBox "Se generaron " & fila & " números aleatorios"
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 3.8: MANEJO BÁSICO DE ERRORES
'-------------------------------------------------------------------------------

Sub ManejoErroresBasico()
    ' ON ERROR RESUME NEXT - Ignora errores y continúa
    On Error Resume Next

    Dim numero As Double
    numero = Range("A1").Value

    ' Si A1 no es un número, habrá un error pero continuará
    Range("B1").Value = numero * 2

    ' Verificar si hubo error
    If Err.Number <> 0 Then
        MsgBox "Hubo un error: " & Err.Description
        Err.Clear  ' Limpiar el error
    End If

    On Error GoTo 0  ' Desactivar manejo de errores
End Sub

Sub ManejoErroresConGoto()
    ' ON ERROR GOTO etiqueta - Va a una etiqueta cuando hay error
    On Error GoTo ManejadorError

    Dim divisor As Double
    Dim resultado As Double

    divisor = InputBox("Ingresa un número divisor:")
    resultado = 100 / divisor  ' Error si divisor es 0

    MsgBox "100 / " & divisor & " = " & resultado

    Exit Sub  ' Salir antes del manejador de errores

ManejadorError:
    MsgBox "Error: " & Err.Description & vbCrLf & _
           "Número de error: " & Err.Number, vbCritical
    ' No dividir entre cero
End Sub

Sub ManejoErroresCompleto()
    On Error GoTo ErrorHandler

    Dim hoja As Worksheet
    Dim nombreHoja As String

    nombreHoja = InputBox("Ingresa el nombre de la hoja a buscar:")

    ' Esto causará error si la hoja no existe
    Set hoja = ThisWorkbook.Worksheets(nombreHoja)

    MsgBox "Hoja encontrada: " & hoja.Name
    hoja.Activate

    Exit Sub

ErrorHandler:
    Select Case Err.Number
        Case 9  ' Subscript out of range (hoja no existe)
            MsgBox "La hoja '" & nombreHoja & "' no existe", vbExclamation

        Case Else
            MsgBox "Error inesperado: " & Err.Description, vbCritical
    End Select
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 3.9: EJEMPLO PRÁCTICO - BUSCAR Y RESALTAR
'-------------------------------------------------------------------------------

Sub BuscarYResaltar()
    Dim textoBuscar As String
    Dim celda As Range
    Dim contador As Integer

    ' Limpiar formato previo
    Cells.Interior.ColorIndex = xlNone

    ' Pedir texto a buscar
    textoBuscar = InputBox("¿Qué texto deseas buscar?", "Buscar")

    If textoBuscar = "" Then
        MsgBox "No ingresaste ningún texto"
        Exit Sub
    End If

    ' Buscar en toda la hoja usada
    contador = 0

    For Each celda In ActiveSheet.UsedRange
        ' Verificar si el texto está contenido en la celda
        If InStr(1, celda.Value, textoBuscar, vbTextCompare) > 0 Then
            ' Resaltar
            celda.Interior.Color = RGB(255, 255, 0)
            celda.Font.Bold = True
            contador = contador + 1
        End If
    Next celda

    If contador > 0 Then
        MsgBox "Se encontraron " & contador & " coincidencias", vbInformation
    Else
        MsgBox "No se encontró '" & textoBuscar & "'", vbExclamation
    End If
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 3.10: EJEMPLO PRÁCTICO - VALIDADOR DE DATOS
'-------------------------------------------------------------------------------

Sub ValidadorDatos()
    Dim fila As Long
    Dim ultimaFila As Long
    Dim errores As Integer

    ' Supongamos que tenemos datos en columnas A (Nombre), B (Edad), C (Email)
    ' Y queremos validar que estén completos

    ultimaFila = Cells(Rows.Count, 1).End(xlUp).Row

    If ultimaFila < 2 Then
        MsgBox "No hay datos para validar", vbExclamation
        Exit Sub
    End If

    errores = 0

    ' Limpiar formato previo
    Range("A2:C" & ultimaFila).Interior.ColorIndex = xlNone

    For fila = 2 To ultimaFila
        ' Validar nombre (columna A)
        If Cells(fila, 1).Value = "" Or Len(Cells(fila, 1).Value) < 3 Then
            Cells(fila, 1).Interior.Color = RGB(255, 200, 200)
            errores = errores + 1
        End If

        ' Validar edad (columna B) - debe ser número entre 18 y 100
        If Not IsNumeric(Cells(fila, 2).Value) Or _
           Cells(fila, 2).Value < 18 Or _
           Cells(fila, 2).Value > 100 Then
            Cells(fila, 2).Interior.Color = RGB(255, 200, 200)
            errores = errores + 1
        End If

        ' Validar email (columna C) - debe contener @
        If InStr(Cells(fila, 3).Value, "@") = 0 Then
            Cells(fila, 3).Interior.Color = RGB(255, 200, 200)
            errores = errores + 1
        End If

        ' Resaltar toda la fila si tiene errores
        If Cells(fila, 1).Interior.Color = RGB(255, 200, 200) Or _
           Cells(fila, 2).Interior.Color = RGB(255, 200, 200) Or _
           Cells(fila, 3).Interior.Color = RGB(255, 200, 200) Then
            Range(Cells(fila, 1), Cells(fila, 3)).Font.Color = RGB(255, 0, 0)
        Else
            ' Marcar como válido
            Range(Cells(fila, 1), Cells(fila, 3)).Interior.Color = RGB(200, 255, 200)
        End If
    Next fila

    If errores > 0 Then
        MsgBox "Se encontraron " & errores & " errores (resaltados en rojo)", vbExclamation
    Else
        MsgBox "¡Todos los datos son válidos!", vbInformation
    End If
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 3.11: EJEMPLO PRÁCTICO - GENERADOR DE SERIE FIBONACCI
'-------------------------------------------------------------------------------

Sub SerieFibonacci()
    Dim n As Integer
    Dim i As Integer
    Dim fib1 As Long
    Dim fib2 As Long
    Dim siguiente As Long

    ' Pedir cantidad de números
    n = InputBox("¿Cuántos números de Fibonacci quieres generar?", "Fibonacci", 10)

    If n < 1 Or n > 50 Then
        MsgBox "Por favor ingresa un número entre 1 y 50"
        Exit Sub
    End If

    ' Limpiar
    Range("A:C").Clear

    ' Encabezados
    Range("A1:C1").Value = Array("Posición", "Fibonacci", "Descripción")
    Range("A1:C1").Font.Bold = True
    Range("A1:C1").Interior.Color = RGB(200, 200, 200)

    ' Inicializar
    fib1 = 0
    fib2 = 1

    ' Generar serie
    For i = 1 To n
        Cells(i + 1, 1).Value = i

        If i = 1 Then
            Cells(i + 1, 2).Value = fib1
            Cells(i + 1, 3).Value = "Primer número"
        ElseIf i = 2 Then
            Cells(i + 1, 2).Value = fib2
            Cells(i + 1, 3).Value = "Segundo número"
        Else
            siguiente = fib1 + fib2
            Cells(i + 1, 2).Value = siguiente
            Cells(i + 1, 3).Value = fib1 & " + " & fib2 & " = " & siguiente
            fib1 = fib2
            fib2 = siguiente
        End If

        ' Formato alternado
        If i Mod 2 = 0 Then
            Range(Cells(i + 1, 1), Cells(i + 1, 3)).Interior.Color = RGB(240, 240, 240)
        End If
    Next i

    ' Bordes
    Range("A1:C" & n + 1).Borders.LineStyle = xlContinuous

    ' Ajustar columnas
    Columns("A:C").AutoFit

    MsgBox "Serie de Fibonacci generada con éxito", vbInformation
End Sub

'===============================================================================
' RESUMEN DEL MÓDULO 3
'===============================================================================
' ✓ Dominas las estructuras If/Then/Else
' ✓ Sabes usar Select Case para múltiples condiciones
' ✓ Conoces los bucles For...Next (con Step)
' ✓ Entiendes For Each para iterar colecciones
' ✓ Sabes usar Do While y Do Until
' ✓ Puedes salir de bucles con Exit For/Exit Do
' ✓ Comprendes el manejo básico de errores (On Error)
' ✓ Creaste ejemplos prácticos (buscar, validar, Fibonacci)
'
' SIGUIENTE PASO: Módulo 4 - Funciones y Procedimientos
'===============================================================================
