Attribute VB_Name = "Modulo_04_Funciones_Procedimientos"
'===============================================================================
' MÓDULO 4: FUNCIONES Y PROCEDIMIENTOS
'===============================================================================
' Este módulo cubre la creación de funciones y procedimientos en VBA
' Incluye: Sub vs Function, parámetros, UDF, ByVal vs ByRef, scope de variables
'===============================================================================

'-------------------------------------------------------------------------------
' SECCIÓN 4.1: DIFERENCIA ENTRE SUB Y FUNCTION
'-------------------------------------------------------------------------------

' SUB (Procedimiento) - No devuelve un valor
Sub EjemploSub()
    ' Un Sub realiza acciones pero no devuelve valores
    MsgBox "Esto es un procedimiento Sub"
    Range("A1").Value = "Los Subs no retornan valores"
End Sub

' FUNCTION - Devuelve un valor
Function EjemploFunction() As String
    ' Una Function devuelve un valor
    EjemploFunction = "Las funciones SÍ retornan valores"
    ' El valor se asigna al nombre de la función
End Function

' Usar la función anterior
Sub UsarFunction()
    Dim resultado As String
    resultado = EjemploFunction()  ' Llamar la función
    MsgBox resultado
    Range("B1").Value = resultado
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 4.2: PARÁMETROS EN PROCEDIMIENTOS
'-------------------------------------------------------------------------------

' Sub con parámetros
Sub Saludar(nombre As String)
    MsgBox "Hola, " & nombre & "!"
End Sub

' Llamar el Sub con parámetros
Sub LlamarSaludar()
    Saludar "María"  ' Pasar el parámetro
    Saludar "Carlos"
End Sub

' Sub con múltiples parámetros
Sub CalcularArea(largo As Double, ancho As Double)
    Dim area As Double
    area = largo * ancho
    MsgBox "El área es: " & area & " m²"
    Range("C1").Value = area
End Sub

Sub UsarCalcularArea()
    CalcularArea 5, 3  ' Parámetros posicionales
    CalcularArea ancho:=4, largo:=6  ' Parámetros nombrados
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 4.3: FUNCIONES CON PARÁMETROS Y RETORNO
'-------------------------------------------------------------------------------

' Function simple que suma dos números
Function Sumar(num1 As Double, num2 As Double) As Double
    Sumar = num1 + num2
End Function

' Function que calcula el área de un círculo
Function AreaCirculo(radio As Double) As Double
    Const PI As Double = 3.14159265358979
    AreaCirculo = PI * radio ^ 2
End Function

' Function que determina si un número es par
Function EsPar(numero As Integer) As Boolean
    If numero Mod 2 = 0 Then
        EsPar = True
    Else
        EsPar = False
    End If
End Function

' Usar las funciones anteriores
Sub UsarFunciones()
    Dim resultado As Double
    Dim esPar As Boolean

    resultado = Sumar(10, 20)
    MsgBox "10 + 20 = " & resultado

    resultado = AreaCirculo(5)
    MsgBox "Área de círculo con radio 5: " & resultado

    esPar = EsPar(10)
    MsgBox "¿10 es par? " & esPar  ' True

    esPar = EsPar(7)
    MsgBox "¿7 es par? " & esPar  ' False
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 4.4: PARÁMETROS OPCIONALES
'-------------------------------------------------------------------------------

' Function con parámetros opcionales
Function Saludar2(nombre As String, Optional apellido As String = "", _
                 Optional edad As Integer = 0) As String

    Dim mensaje As String
    mensaje = "Hola, " & nombre

    If apellido <> "" Then
        mensaje = mensaje & " " & apellido
    End If

    If edad > 0 Then
        mensaje = mensaje & ". Tienes " & edad & " años"
    End If

    Saludar2 = mensaje
End Function

Sub UsarParametrosOpcionales()
    ' Llamar con diferentes combinaciones
    MsgBox Saludar2("Juan")  ' Solo nombre
    MsgBox Saludar2("Juan", "Pérez")  ' Nombre y apellido
    MsgBox Saludar2("Juan", "Pérez", 30)  ' Todos los parámetros
    MsgBox Saludar2("María", , 25)  ' Saltar parámetro del medio
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 4.5: BYVAL VS BYREF
'-------------------------------------------------------------------------------

' ByVal - Pasa una COPIA del valor (no modifica el original)
Sub IncrementarByVal(ByVal numero As Integer)
    numero = numero + 10
    MsgBox "Dentro de la función: " & numero
    ' El cambio NO afecta la variable original
End Sub

' ByRef - Pasa una REFERENCIA (modifica el original)
Sub IncrementarByRef(ByRef numero As Integer)
    numero = numero + 10
    MsgBox "Dentro de la función: " & numero
    ' El cambio SÍ afecta la variable original
End Sub

' Demostración de la diferencia
Sub DemostrarByValByRef()
    Dim miNumero As Integer
    miNumero = 5

    ' Usar ByVal
    MsgBox "Antes de ByVal: " & miNumero  ' 5
    IncrementarByVal miNumero
    MsgBox "Después de ByVal: " & miNumero  ' Sigue siendo 5

    ' Usar ByRef
    MsgBox "Antes de ByRef: " & miNumero  ' 5
    IncrementarByRef miNumero
    MsgBox "Después de ByRef: " & miNumero  ' Ahora es 15

    ' Por defecto, VBA usa ByRef si no se especifica
End Sub

' Ejemplo práctico: Intercambiar valores
Sub Intercambiar(ByRef a As Variant, ByRef b As Variant)
    Dim temp As Variant
    temp = a
    a = b
    b = temp
End Sub

Sub UsarIntercambiar()
    Dim x As Integer
    Dim y As Integer
    x = 10
    y = 20

    MsgBox "Antes: x=" & x & ", y=" & y
    Intercambiar x, y
    MsgBox "Después: x=" & x & ", y=" & y
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 4.6: FUNCIONES DEFINIDAS POR EL USUARIO (UDF)
'-------------------------------------------------------------------------------

' Las UDF pueden usarse directamente en celdas de Excel como fórmulas

' UDF: Convertir Celsius a Fahrenheit
Function CelsiusAFahrenheit(celsius As Double) As Double
    CelsiusAFahrenheit = (celsius * 9 / 5) + 32
End Function

' UDF: Calcular IVA
Function CalcularIVA(subtotal As Double, Optional tasaIVA As Double = 0.16) As Double
    CalcularIVA = subtotal * tasaIVA
End Function

' UDF: Obtener iniciales de un nombre
Function ObtenerIniciales(nombreCompleto As String) As String
    Dim palabras() As String
    Dim iniciales As String
    Dim i As Integer

    palabras = Split(nombreCompleto, " ")
    iniciales = ""

    For i = LBound(palabras) To UBound(palabras)
        If Len(palabras(i)) > 0 Then
            iniciales = iniciales & UCase(Left(palabras(i), 1))
        End If
    Next i

    ObtenerIniciales = iniciales
End Function

' UDF: Contar palabras en texto
Function ContarPalabras(texto As String) As Integer
    If Len(Trim(texto)) = 0 Then
        ContarPalabras = 0
    Else
        ContarPalabras = UBound(Split(texto, " ")) + 1
    End If
End Function

' UDF: Calificación en letra
Function CalificacionLetra(nota As Double) As String
    Select Case nota
        Case 90 To 100
            CalificacionLetra = "A - Excelente"
        Case 80 To 89
            CalificacionLetra = "B - Muy Bueno"
        Case 70 To 79
            CalificacionLetra = "C - Bueno"
        Case 60 To 69
            CalificacionLetra = "D - Suficiente"
        Case 0 To 59
            CalificacionLetra = "F - Reprobado"
        Case Else
            CalificacionLetra = "Error"
    End Select
End Function

' Demostrar UDFs en Excel
Sub DemostrarUDFs()
    ' Limpiar
    Cells.Clear

    ' Crear ejemplos de uso
    Range("A1").Value = "Celsius"
    Range("B1").Value = "Fahrenheit"
    Range("A2").Value = 0
    Range("A3").Value = 25
    Range("A4").Value = 100

    ' Usar la UDF en fórmulas
    Range("B2").Formula = "=CelsiusAFahrenheit(A2)"
    Range("B3").Formula = "=CelsiusAFahrenheit(A3)"
    Range("B4").Formula = "=CelsiusAFahrenheit(A4)"

    ' Ejemplo de IVA
    Range("D1").Value = "Subtotal"
    Range("E1").Value = "IVA"
    Range("D2").Value = 1000
    Range("E2").Formula = "=CalcularIVA(D2)"

    ' Ejemplo de iniciales
    Range("G1").Value = "Nombre Completo"
    Range("H1").Value = "Iniciales"
    Range("G2").Value = "Juan Pérez García"
    Range("H2").Formula = "=ObtenerIniciales(G2)"

    ' Formato
    Range("A1:H1").Font.Bold = True
    Columns("A:H").AutoFit

    MsgBox "Funciones UDF aplicadas. Puedes usar estas funciones en cualquier celda.", vbInformation
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 4.7: SCOPE DE VARIABLES (ALCANCE)
'-------------------------------------------------------------------------------

' VARIABLE A NIVEL DE MÓDULO (Private)
' Solo visible en este módulo
Private variableModulo As Integer

' VARIABLE PÚBLICA
' Visible desde cualquier módulo del proyecto
Public variablePublica As String

Sub DemostrarScope()
    ' VARIABLE LOCAL
    ' Solo visible dentro de este procedimiento
    Dim variableLocal As Integer
    variableLocal = 10

    variableModulo = 20
    variablePublica = "Visible en todo el proyecto"

    MsgBox "Variable local: " & variableLocal
    MsgBox "Variable módulo: " & variableModulo
    MsgBox "Variable pública: " & variablePublica
End Sub

Sub OtroProcedimiento()
    ' variableLocal NO es accesible aquí (causaría error)
    ' MsgBox variableLocal  ' ERROR

    ' variableModulo SÍ es accesible
    variableModulo = 30
    MsgBox "Variable módulo modificada: " & variableModulo

    ' variablePublica SÍ es accesible
    MsgBox "Variable pública: " & variablePublica
End Sub

' VARIABLE ESTÁTICA - Mantiene su valor entre llamadas
Sub ContadorEstatico()
    Static contador As Integer  ' Se inicializa solo una vez
    contador = contador + 1
    MsgBox "Esta función ha sido llamada " & contador & " veces"
End Sub

Sub ProbarContador()
    ContadorEstatico  ' 1
    ContadorEstatico  ' 2
    ContadorEstatico  ' 3
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 4.8: RECURSIÓN
'-------------------------------------------------------------------------------

' Función recursiva: Factorial
Function Factorial(n As Long) As Long
    If n <= 1 Then
        Factorial = 1  ' Caso base
    Else
        Factorial = n * Factorial(n - 1)  ' Llamada recursiva
    End If
End Function

' Función recursiva: Fibonacci
Function Fibonacci(n As Integer) As Long
    If n <= 1 Then
        Fibonacci = n
    Else
        Fibonacci = Fibonacci(n - 1) + Fibonacci(n - 2)
    End If
End Function

Sub DemostrarRecursion()
    Dim i As Integer

    ' Factoriales
    Range("A1:B1").Value = Array("n", "Factorial(n)")
    For i = 0 To 10
        Cells(i + 2, 1).Value = i
        Cells(i + 2, 2).Value = Factorial(i)
    Next i

    ' Fibonacci
    Range("D1:E1").Value = Array("n", "Fibonacci(n)")
    For i = 0 To 15
        Cells(i + 2, 4).Value = i
        Cells(i + 2, 5).Value = Fibonacci(i)
    Next i

    Range("A1:E1").Font.Bold = True
    Columns("A:E").AutoFit
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 4.9: EJEMPLO PRÁCTICO - LIBRERÍA DE FUNCIONES ÚTILES
'-------------------------------------------------------------------------------

' Función: Validar si es email
Function EsEmailValido(email As String) As Boolean
    EsEmailValido = (InStr(email, "@") > 0 And InStr(email, ".") > 0)
End Function

' Función: Remover espacios extras
Function LimpiarTexto(texto As String) As String
    Dim resultado As String
    resultado = Trim(texto)  ' Quitar espacios al inicio y final

    ' Reemplazar múltiples espacios por uno solo
    Do While InStr(resultado, "  ") > 0
        resultado = Replace(resultado, "  ", " ")
    Loop

    LimpiarTexto = resultado
End Function

' Función: Capitalizar cada palabra
Function CapitalizarPalabras(texto As String) As String
    Dim palabras() As String
    Dim i As Integer
    Dim resultado As String

    palabras = Split(LCase(texto), " ")

    For i = LBound(palabras) To UBound(palabras)
        If Len(palabras(i)) > 0 Then
            palabras(i) = UCase(Left(palabras(i), 1)) & Mid(palabras(i), 2)
        End If
    Next i

    CapitalizarPalabras = Join(palabras, " ")
End Function

' Función: Generar número aleatorio en rango
Function NumeroAleatorio(minimo As Integer, maximo As Integer) As Integer
    Randomize  ' Inicializar generador aleatorio
    NumeroAleatorio = Int((maximo - minimo + 1) * Rnd + minimo)
End Function

' Función: Calcular edad desde fecha de nacimiento
Function CalcularEdad(fechaNacimiento As Date) As Integer
    CalcularEdad = DateDiff("yyyy", fechaNacimiento, Date)

    ' Ajustar si aún no ha cumplido años este año
    If Date < DateSerial(Year(Date), Month(fechaNacimiento), Day(fechaNacimiento)) Then
        CalcularEdad = CalcularEdad - 1
    End If
End Function

' Función: Convertir número romano a arábigo
Function RomanoADecimal(romano As String) As Integer
    Dim i As Integer
    Dim actual As Integer
    Dim siguiente As Integer
    Dim resultado As Integer

    resultado = 0
    romano = UCase(romano)

    For i = 1 To Len(romano)
        actual = ValorRomano(Mid(romano, i, 1))

        If i < Len(romano) Then
            siguiente = ValorRomano(Mid(romano, i + 1, 1))
            If actual < siguiente Then
                resultado = resultado - actual
            Else
                resultado = resultado + actual
            End If
        Else
            resultado = resultado + actual
        End If
    Next i

    RomanoADecimal = resultado
End Function

' Función auxiliar para RomanoADecimal
Private Function ValorRomano(letra As String) As Integer
    Select Case letra
        Case "I": ValorRomano = 1
        Case "V": ValorRomano = 5
        Case "X": ValorRomano = 10
        Case "L": ValorRomano = 50
        Case "C": ValorRomano = 100
        Case "D": ValorRomano = 500
        Case "M": ValorRomano = 1000
        Case Else: ValorRomano = 0
    End Select
End Function

' Probar la librería de funciones
Sub ProbarLibreriaFunciones()
    Cells.Clear

    ' Email
    Range("A1").Value = "Email"
    Range("B1").Value = "¿Válido?"
    Range("A2").Value = "juan@ejemplo.com"
    Range("B2").Formula = "=EsEmailValido(A2)"
    Range("A3").Value = "invalido"
    Range("B3").Formula = "=EsEmailValido(A3)"

    ' Limpiar texto
    Range("D1").Value = "Texto Original"
    Range("E1").Value = "Texto Limpio"
    Range("D2").Value = "  mucho   espacio   "
    Range("E2").Formula = "=LimpiarTexto(D2)"

    ' Capitalizar
    Range("G1").Value = "Original"
    Range("H1").Value = "Capitalizado"
    Range("G2").Value = "hola mundo"
    Range("H2").Formula = "=CapitalizarPalabras(G2)"

    ' Edad
    Range("A5").Value = "Fecha Nacimiento"
    Range("B5").Value = "Edad"
    Range("A6").Value = #1/15/1990#
    Range("B6").Formula = "=CalcularEdad(A6)"

    ' Romano
    Range("D5").Value = "Romano"
    Range("E5").Value = "Decimal"
    Range("D6").Value = "XIV"
    Range("E6").Formula = "=RomanoADecimal(D6)"
    Range("D7").Value = "MCMXC"
    Range("E7").Formula = "=RomanoADecimal(D7)"

    Range("A1:H1,A5:E5").Font.Bold = True
    Columns("A:H").AutoFit

    MsgBox "Librería de funciones demostrada", vbInformation
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 4.10: EJEMPLO PRÁCTICO - CALCULADORA DE PRÉSTAMOS
'-------------------------------------------------------------------------------

' Función: Calcular pago mensual de préstamo
Function PagoMensual(monto As Double, tasaAnual As Double, meses As Integer) As Double
    Dim tasaMensual As Double

    If tasaAnual = 0 Then
        PagoMensual = monto / meses
    Else
        tasaMensual = tasaAnual / 12 / 100
        PagoMensual = monto * (tasaMensual * (1 + tasaMensual) ^ meses) / _
                     ((1 + tasaMensual) ^ meses - 1)
    End If
End Function

' Procedimiento: Crear tabla de amortización
Sub TablaAmortizacion()
    Dim monto As Double
    Dim tasaAnual As Double
    Dim años As Integer
    Dim meses As Integer
    Dim pagoMensual As Double
    Dim saldo As Double
    Dim interes As Double
    Dim capital As Double
    Dim i As Integer

    ' Solicitar datos
    monto = InputBox("Monto del préstamo:", "Calculadora", 100000)
    tasaAnual = InputBox("Tasa de interés anual (%):", "Calculadora", 12)
    años = InputBox("Plazo en años:", "Calculadora", 5)

    meses = años * 12
    pagoMensual = PagoMensual(monto, tasaAnual, meses)
    saldo = monto

    ' Limpiar
    Cells.Clear

    ' Título
    Range("A1").Value = "TABLA DE AMORTIZACIÓN"
    Range("A1").Font.Size = 14
    Range("A1").Font.Bold = True

    ' Datos del préstamo
    Range("A2").Value = "Monto:"
    Range("B2").Value = monto
    Range("B2").NumberFormat = "$#,##0.00"

    Range("A3").Value = "Tasa anual:"
    Range("B3").Value = tasaAnual & "%"

    Range("A4").Value = "Plazo:"
    Range("B4").Value = años & " años (" & meses & " meses)"

    Range("A5").Value = "Pago mensual:"
    Range("B5").Value = pagoMensual
    Range("B5").NumberFormat = "$#,##0.00"
    Range("B5").Font.Bold = True
    Range("B5").Interior.Color = RGB(255, 255, 0)

    ' Encabezados de la tabla
    Range("A7:F7").Value = Array("Mes", "Pago", "Interés", "Capital", "Saldo", "% Pagado")
    Range("A7:F7").Font.Bold = True
    Range("A7:F7").Interior.Color = RGB(200, 200, 200)

    ' Generar tabla
    For i = 1 To meses
        interes = saldo * (tasaAnual / 12 / 100)
        capital = pagoMensual - interes
        saldo = saldo - capital

        Cells(7 + i, 1).Value = i
        Cells(7 + i, 2).Value = pagoMensual
        Cells(7 + i, 3).Value = interes
        Cells(7 + i, 4).Value = capital
        Cells(7 + i, 5).Value = IIf(saldo < 0, 0, saldo)
        Cells(7 + i, 6).Value = (i / meses)

        ' Formato
        Range(Cells(7 + i, 2), Cells(7 + i, 5)).NumberFormat = "$#,##0.00"
        Cells(7 + i, 6).NumberFormat = "0.0%"

        ' Resaltar cada año
        If i Mod 12 = 0 Then
            Range(Cells(7 + i, 1), Cells(7 + i, 6)).Font.Bold = True
            Range(Cells(7 + i, 1), Cells(7 + i, 6)).Interior.Color = RGB(220, 230, 241)
        End If
    Next i

    ' Totales
    Dim filaTotal As Integer
    filaTotal = 8 + meses
    Cells(filaTotal, 1).Value = "TOTAL:"
    Cells(filaTotal, 2).Formula = "=SUM(B8:B" & 7 + meses & ")"
    Cells(filaTotal, 3).Formula = "=SUM(C8:C" & 7 + meses & ")"
    Cells(filaTotal, 4).Formula = "=SUM(D8:D" & 7 + meses & ")"

    Range(Cells(filaTotal, 1), Cells(filaTotal, 4)).Font.Bold = True
    Range(Cells(filaTotal, 2), Cells(filaTotal, 4)).NumberFormat = "$#,##0.00"
    Range(Cells(filaTotal, 1), Cells(filaTotal, 4)).Interior.Color = RGB(255, 242, 204)

    ' Bordes
    Range("A7:F" & filaTotal).Borders.LineStyle = xlContinuous

    ' Ajustar columnas
    Columns("A:F").AutoFit

    MsgBox "Tabla de amortización creada exitosamente", vbInformation
End Sub

'===============================================================================
' RESUMEN DEL MÓDULO 4
'===============================================================================
' ✓ Entiendes la diferencia entre Sub y Function
' ✓ Sabes crear funciones con parámetros
' ✓ Conoces parámetros opcionales
' ✓ Comprendes ByVal vs ByRef
' ✓ Puedes crear funciones UDF para usar en Excel
' ✓ Entiendes el scope de variables (local, módulo, público, estático)
' ✓ Conoces la recursión
' ✓ Creaste una librería de funciones útiles
' ✓ Desarrollaste una calculadora de préstamos completa
'
' SIGUIENTE PASO: Módulo 5 - Trabajo con Hojas y Libros
'===============================================================================
