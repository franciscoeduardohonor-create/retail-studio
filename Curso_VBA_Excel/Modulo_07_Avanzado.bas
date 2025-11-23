Attribute VB_Name = "Modulo_07_Avanzado"
'===============================================================================
' MÓDULO 7: TÉCNICAS AVANZADAS DE VBA
'===============================================================================
' Este módulo cubre técnicas avanzadas de programación en VBA
' Incluye: Arrays, Colecciones, Dictionary, Expresiones Regulares,
' Trabajo con archivos, APIs de Windows, optimización de código
'===============================================================================

'-------------------------------------------------------------------------------
' SECCIÓN 7.1: ARRAYS (ARREGLOS) BÁSICOS
'-------------------------------------------------------------------------------

Sub ArraysBasicos()
    ' DECLARAR ARRAY con tamaño fijo
    Dim numeros(4) As Integer  ' 5 elementos (0 a 4)

    ' Asignar valores
    numeros(0) = 10
    numeros(1) = 20
    numeros(2) = 30
    numeros(3) = 40
    numeros(4) = 50

    ' Leer valores
    Dim i As Integer
    For i = 0 To 4
        Cells(i + 1, 1).Value = numeros(i)
    Next i

    ' ARRAY DINÁMICO (se puede redimensionar)
    Dim valores() As Double
    ReDim valores(9)  ' Crear con 10 elementos (0 a 9)

    For i = 0 To 9
        valores(i) = i * 1.5
        Cells(i + 1, 2).Value = valores(i)
    Next i

    ' REDIMENSIONAR preservando datos
    ReDim Preserve valores(14)  ' Ahora tiene 15 elementos

    For i = 10 To 14
        valores(i) = i * 2
        Cells(i + 1, 2).Value = valores(i)
    Next i
End Sub

Sub ArraysMultidimensionales()
    ' ARRAY DE 2 DIMENSIONES (tabla)
    Dim tabla(2, 3) As String  ' 3 filas × 4 columnas

    ' Llenar array
    tabla(0, 0) = "Producto"
    tabla(0, 1) = "Enero"
    tabla(0, 2) = "Febrero"
    tabla(0, 3) = "Marzo"

    tabla(1, 0) = "Laptop"
    tabla(1, 1) = "10"
    tabla(1, 2) = "15"
    tabla(1, 3) = "12"

    tabla(2, 0) = "Mouse"
    tabla(2, 1) = "50"
    tabla(2, 2) = "45"
    tabla(2, 3) = "60"

    ' Escribir en Excel
    Dim fila As Integer, col As Integer
    For fila = 0 To 2
        For col = 0 To 3
            Cells(fila + 1, col + 1).Value = tabla(fila, col)
        Next col
    Next fila

    Range("A1:D1").Font.Bold = True
End Sub

Sub FuncionesArrays()
    ' LBOUND y UBOUND - Límites inferior y superior del array
    Dim frutas() As String
    frutas = Split("Manzana,Naranja,Plátano,Uva", ",")

    MsgBox "Índice inferior: " & LBound(frutas)  ' 0
    MsgBox "Índice superior: " & UBound(frutas)  ' 3
    MsgBox "Total elementos: " & (UBound(frutas) - LBound(frutas) + 1)

    ' ARRAY() - Crear array rápidamente
    Dim colores As Variant
    colores = Array("Rojo", "Verde", "Azul", "Amarillo")

    Dim i As Integer
    For i = LBound(colores) To UBound(colores)
        Cells(i + 1, 1).Value = colores(i)
    Next i

    ' FILTER - Filtrar elementos (requiere Variant)
    Dim nombres As Variant
    nombres = Array("Juan", "José", "María", "Jorge", "Julia")

    ' Filtrar nombres que contengan "J"
    Dim filtrados As Variant
    filtrados = Filter(nombres, "J", True, vbTextCompare)

    For i = LBound(filtrados) To UBound(filtrados)
        Cells(i + 1, 3).Value = filtrados(i)
    Next i

    ' JOIN - Convertir array a string
    Dim texto As String
    texto = Join(nombres, ", ")
    MsgBox texto  ' "Juan, José, María, Jorge, Julia"
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 7.2: ARRAYS DINÁMICOS Y OPTIMIZACIÓN
'-------------------------------------------------------------------------------

Sub CargarDatosConArrays()
    ' Leer datos de Excel a un array (MUY RÁPIDO)
    Dim datos As Variant
    Dim ultimaFila As Long

    ultimaFila = Cells(Rows.Count, 1).End(xlUp).Row

    ' Cargar rango completo a array (una sola operación)
    datos = Range("A1:C" & ultimaFila).Value

    ' Procesar datos (en memoria, muy rápido)
    Dim i As Long
    For i = 1 To UBound(datos, 1)
        ' datos(fila, columna)
        Debug.Print datos(i, 1), datos(i, 2), datos(i, 3)
    Next i

    ' Modificar datos
    For i = 2 To UBound(datos, 1)
        If IsNumeric(datos(i, 3)) Then
            datos(i, 3) = datos(i, 3) * 1.1  ' Incrementar 10%
        End If
    Next i

    ' Escribir todo de vuelta a Excel (una sola operación)
    Range("A1:C" & ultimaFila).Value = datos
End Sub

Sub CompararRendimiento()
    ' MÉTODO LENTO - Sin arrays (celdas una por una)
    Dim inicioLento As Double
    Dim finLento As Double

    inicioLento = Timer

    Dim i As Long
    For i = 1 To 1000
        Cells(i, 1).Value = i
        Cells(i, 2).Value = i * 2
    Next i

    finLento = Timer
    MsgBox "Método lento: " & Format(finLento - inicioLento, "0.000") & " segundos"

    ' MÉTODO RÁPIDO - Con arrays
    Dim inicioRapido As Double
    Dim finRapido As Double

    inicioRapido = Timer

    Dim datos(1 To 1000, 1 To 2) As Variant

    For i = 1 To 1000
        datos(i, 1) = i
        datos(i, 2) = i * 2
    Next i

    Range("D1:E1000").Value = datos

    finRapido = Timer
    MsgBox "Método rápido: " & Format(finRapido - inicioRapido, "0.000") & " segundos"
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 7.3: COLECCIONES (COLLECTIONS)
'-------------------------------------------------------------------------------

Sub TrabajarConColecciones()
    ' Las colecciones son arrays dinámicos que pueden contener objetos
    ' y permiten acceso por índice o por clave

    Dim miColeccion As New Collection

    ' AGREGAR elementos
    miColeccion.Add "Juan"
    miColeccion.Add "María"
    miColeccion.Add "Pedro"

    ' Agregar con clave
    miColeccion.Add Item:="México", Key:="MX"
    miColeccion.Add Item:="España", Key:="ES"

    ' CONTAR elementos
    MsgBox "Total de elementos: " & miColeccion.Count

    ' ACCEDER por índice (base 1)
    MsgBox "Primer elemento: " & miColeccion(1)  ' "Juan"

    ' ACCEDER por clave
    MsgBox "País ES: " & miColeccion("ES")  ' "España"

    ' ITERAR
    Dim elemento As Variant
    Dim fila As Integer
    fila = 1

    For Each elemento In miColeccion
        Cells(fila, 1).Value = elemento
        fila = fila + 1
    Next elemento

    ' REMOVER elemento
    miColeccion.Remove 1  ' Remover primer elemento
    miColeccion.Remove "MX"  ' Remover por clave
End Sub

Sub ColeccionDeObjetos()
    ' Colección de rangos
    Dim rangos As New Collection

    rangos.Add Range("A1:A10")
    rangos.Add Range("C1:C10")
    rangos.Add Range("E1:E10")

    ' Aplicar formato a todos
    Dim rango As Range
    For Each rango In rangos
        rango.Interior.Color = RGB(255, 255, 0)
        rango.Font.Bold = True
    Next rango

    MsgBox "Formato aplicado a " & rangos.Count & " rangos"
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 7.4: DICTIONARY (Diccionario)
'-------------------------------------------------------------------------------
' NOTA: Requiere activar referencia "Microsoft Scripting Runtime"
' En VBA Editor: Tools > References > Microsoft Scripting Runtime

Sub TrabajarConDictionary()
    ' Dictionary es como un array asociativo (clave-valor)
    Dim dict As Object
    Set dict = CreateObject("Scripting.Dictionary")

    ' AGREGAR elementos
    dict.Add "nombre", "Juan Pérez"
    dict.Add "edad", 30
    dict.Add "ciudad", "Madrid"
    dict.Add "email", "juan@ejemplo.com"

    ' ACCEDER a valores
    MsgBox "Nombre: " & dict("nombre")
    MsgBox "Edad: " & dict("edad")

    ' VERIFICAR si existe una clave
    If dict.Exists("ciudad") Then
        MsgBox "Ciudad: " & dict("ciudad")
    End If

    ' MODIFICAR valor
    dict("edad") = 31

    ' CONTAR elementos
    MsgBox "Total de elementos: " & dict.Count

    ' ITERAR sobre claves
    Dim clave As Variant
    Dim fila As Integer
    fila = 1

    For Each clave In dict.Keys
        Cells(fila, 1).Value = clave
        Cells(fila, 2).Value = dict(clave)
        fila = fila + 1
    Next clave

    ' REMOVER elemento
    dict.Remove "email"

    ' LIMPIAR todo
    ' dict.RemoveAll
End Sub

Sub ContarFrecuenciaConDictionary()
    ' Contar cuántas veces aparece cada valor en un rango
    Dim dict As Object
    Set dict = CreateObject("Scripting.Dictionary")

    Dim celda As Range
    Dim valor As String

    ' Contar frecuencias
    For Each celda In Range("A1:A100")
        If celda.Value <> "" Then
            valor = celda.Value

            If dict.Exists(valor) Then
                dict(valor) = dict(valor) + 1
            Else
                dict.Add valor, 1
            End If
        End If
    Next celda

    ' Mostrar resultados
    Dim clave As Variant
    Dim fila As Integer
    fila = 1

    Range("C1:D1").Value = Array("Valor", "Frecuencia")
    Range("C1:D1").Font.Bold = True

    fila = 2
    For Each clave In dict.Keys
        Cells(fila, 3).Value = clave
        Cells(fila, 4).Value = dict(clave)
        fila = fila + 1
    Next clave

    Columns("C:D").AutoFit
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 7.5: EXPRESIONES REGULARES (REGEX)
'-------------------------------------------------------------------------------
' NOTA: Requiere activar "Microsoft VBScript Regular Expressions 5.5"

Sub IntroduccionRegex()
    ' Crear objeto RegExp
    Dim regex As Object
    Set regex = CreateObject("VBScript.RegExp")

    ' Configurar regex
    regex.Global = True  ' Buscar todas las coincidencias
    regex.IgnoreCase = True  ' Ignorar mayúsculas/minúsculas

    ' VALIDAR EMAIL
    regex.Pattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"

    Dim email As String
    email = "usuario@ejemplo.com"

    If regex.Test(email) Then
        MsgBox email & " es un email válido"
    Else
        MsgBox email & " NO es un email válido"
    End If

    ' EXTRAER NÚMEROS de un texto
    regex.Pattern = "\d+"  ' \d = dígito, + = uno o más

    Dim texto As String
    texto = "Tengo 25 años y vivo en el piso 3B"

    Dim matches As Object
    Set matches = regex.Execute(texto)

    Dim match As Object
    For Each match In matches
        MsgBox "Número encontrado: " & match.Value
    Next match
End Sub

Sub ValidarDatosConRegex()
    Dim regex As Object
    Set regex = CreateObject("VBScript.RegExp")
    regex.Global = True
    regex.IgnoreCase = True

    Dim celda As Range
    Dim fila As Integer

    ' Preparar datos de ejemplo
    Range("A1").Value = "Email"
    Range("B1").Value = "Válido?"
    Range("A1:B1").Font.Bold = True

    Range("A2:A6").Value = Application.Transpose(Array( _
        "juan@ejemplo.com", _
        "maria.garcia@empresa.es", _
        "invalido.com", _
        "pedro@dominio", _
        "ana.lopez@correo.com.mx"))

    ' Patrón de email
    regex.Pattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"

    ' Validar cada email
    For Each celda In Range("A2:A6")
        If regex.Test(celda.Value) Then
            celda.Offset(0, 1).Value = "✓ Válido"
            celda.Offset(0, 1).Font.Color = RGB(0, 150, 0)
        Else
            celda.Offset(0, 1).Value = "✗ Inválido"
            celda.Offset(0, 1).Font.Color = RGB(255, 0, 0)
        End If
    Next celda

    Columns("A:B").AutoFit
End Sub

Sub LimpiarTextoConRegex()
    Dim regex As Object
    Set regex = CreateObject("VBScript.RegExp")
    regex.Global = True

    ' Remover caracteres especiales, dejar solo letras y números
    regex.Pattern = "[^a-zA-Z0-9\s]"  ' ^ = negación

    Dim textoOriginal As String
    Dim textoLimpio As String

    textoOriginal = "¡Hola! ¿Cómo estás? #VBA @Excel 2024"
    textoLimpio = regex.Replace(textoOriginal, "")

    MsgBox "Original: " & textoOriginal & vbCrLf & _
           "Limpio: " & textoLimpio
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 7.6: TRABAJO CON ARCHIVOS DE TEXTO
'-------------------------------------------------------------------------------

Sub LeerArchivoTexto()
    ' Método 1: FileSystemObject (recomendado)
    Dim fso As Object
    Dim archivo As Object
    Dim linea As String
    Dim fila As Integer

    Set fso = CreateObject("Scripting.FileSystemObject")
    Set archivo = fso.OpenTextFile("C:\datos.txt", 1)  ' 1 = ForReading

    fila = 1

    Do While Not archivo.AtEndOfStream
        linea = archivo.ReadLine
        Cells(fila, 1).Value = linea
        fila = fila + 1
    Loop

    archivo.Close
    MsgBox "Archivo leído: " & fila - 1 & " líneas"
End Sub

Sub EscribirArchivoTexto()
    Dim fso As Object
    Dim archivo As Object

    Set fso = CreateObject("Scripting.FileSystemObject")
    Set archivo = fso.CreateTextFile("C:\salida.txt", True)  ' True = sobrescribir

    ' Escribir líneas
    archivo.WriteLine "Primera línea"
    archivo.WriteLine "Segunda línea"
    archivo.WriteLine "Tercera línea"

    ' Escribir sin salto de línea
    archivo.Write "Texto sin salto"

    archivo.Close
    MsgBox "Archivo creado exitosamente"
End Sub

Sub ExportarRangoATextoDelimitado()
    Dim fso As Object
    Dim archivo As Object
    Dim rango As Range
    Dim celda As Range
    Dim linea As String

    Set fso = CreateObject("Scripting.FileSystemObject")
    Set archivo = fso.CreateTextFile("C:\datos_exportados.txt", True)

    Set rango = Range("A1:C10")

    ' Escribir cada fila
    Dim fila As Range
    For Each fila In rango.Rows
        linea = ""
        For Each celda In fila.Cells
            linea = linea & celda.Value & vbTab  ' Separado por tabulador
        Next celda
        archivo.WriteLine Trim(linea)
    Next fila

    archivo.Close
    MsgBox "Datos exportados"
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 7.7: OPTIMIZACIÓN DE CÓDIGO
'-------------------------------------------------------------------------------

Sub TecnicasOptimizacion()
    ' 1. DESACTIVAR ACTUALIZACIÓN DE PANTALLA
    Application.ScreenUpdating = False

    ' 2. DESACTIVAR CÁLCULO AUTOMÁTICO
    Application.Calculation = xlCalculationManual

    ' 3. DESACTIVAR EVENTOS
    Application.EnableEvents = False

    ' 4. USAR ARRAYS en lugar de leer/escribir celda por celda
    Dim datos(1 To 1000, 1 To 5) As Variant
    Dim i As Long, j As Long

    For i = 1 To 1000
        For j = 1 To 5
            datos(i, j) = i * j
        Next j
    Next i

    Range("A1:E1000").Value = datos

    ' 5. RESTAURAR CONFIGURACIÓN
    Application.ScreenUpdating = True
    Application.Calculation = xlCalculationAutomatic
    Application.EnableEvents = True

    MsgBox "Optimización aplicada"
End Sub

Sub ComparacionOptimizada()
    Dim inicio As Double
    Dim fin As Double

    ' MÉTODO NO OPTIMIZADO
    inicio = Timer

    Dim i As Long
    For i = 1 To 5000
        Cells(i, 1).Value = i
    Next i

    fin = Timer
    MsgBox "Sin optimizar: " & Format(fin - inicio, "0.00") & " seg"

    ' MÉTODO OPTIMIZADO
    inicio = Timer

    Application.ScreenUpdating = False
    Application.Calculation = xlCalculationManual

    Dim datos(1 To 5000, 1 To 1) As Variant
    For i = 1 To 5000
        datos(i, 1) = i
    Next i

    Range("C1:C5000").Value = datos

    Application.ScreenUpdating = True
    Application.Calculation = xlCalculationAutomatic

    fin = Timer
    MsgBox "Optimizado: " & Format(fin - inicio, "0.00") & " seg"
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 7.8: EVENTOS DE WORKSHEET Y WORKBOOK
'-------------------------------------------------------------------------------

' NOTA: Estos eventos se colocan en el módulo de la hoja (Sheet1, Sheet2, etc.)
' o en ThisWorkbook

' Evento: Cambio en una celda
' Private Sub Worksheet_Change(ByVal Target As Range)
'     If Target.Address = "$A$1" Then
'         MsgBox "A1 cambió a: " & Target.Value
'     End If
' End Sub

' Evento: Seleccionar una celda
' Private Sub Worksheet_SelectionChange(ByVal Target As Range)
'     Me.Range("Z1").Value = "Última selección: " & Target.Address
' End Sub

' Evento: Activar hoja
' Private Sub Worksheet_Activate()
'     MsgBox "Hoja activada: " & Me.Name
' End Sub

' Evento: Abrir libro
' Private Sub Workbook_Open()
'     MsgBox "Bienvenido a " & ThisWorkbook.Name
' End Sub

' Evento: Antes de guardar
' Private Sub Workbook_BeforeSave(ByVal SaveAsUI As Boolean, Cancel As Boolean)
'     If MsgBox("¿Deseas guardar?", vbYesNo) = vbNo Then
'         Cancel = True  ' Cancelar guardado
'     End If
' End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 7.9: EJEMPLO PRÁCTICO - ANÁLISIS DE DATOS CON DICTIONARY
'-------------------------------------------------------------------------------

Sub AnalisisVentasPorCategoria()
    ' Analizar ventas totales por categoría usando Dictionary
    Dim dict As Object
    Set dict = CreateObject("Scripting.Dictionary")

    Dim ultimaFila As Long
    Dim i As Long
    Dim categoria As String
    Dim venta As Double

    ultimaFila = Cells(Rows.Count, 1).End(xlUp).Row

    ' Suponer: Columna A = Categoría, Columna B = Venta
    For i = 2 To ultimaFila  ' Asumiendo fila 1 son encabezados
        categoria = Cells(i, 1).Value
        venta = Cells(i, 2).Value

        If dict.Exists(categoria) Then
            dict(categoria) = dict(categoria) + venta
        Else
            dict.Add categoria, venta
        End If
    Next i

    ' Crear reporte
    Dim hojaReporte As Worksheet
    On Error Resume Next
    Application.DisplayAlerts = False
    Worksheets("Reporte").Delete
    Application.DisplayAlerts = True
    On Error GoTo 0

    Set hojaReporte = Worksheets.Add
    hojaReporte.Name = "Reporte"

    ' Título
    hojaReporte.Range("A1").Value = "ANÁLISIS DE VENTAS POR CATEGORÍA"
    hojaReporte.Range("A1").Font.Size = 14
    hojaReporte.Range("A1").Font.Bold = True

    ' Encabezados
    hojaReporte.Range("A3:B3").Value = Array("Categoría", "Total Ventas")
    hojaReporte.Range("A3:B3").Font.Bold = True
    hojaReporte.Range("A3:B3").Interior.Color = RGB(200, 200, 200)

    ' Datos
    Dim clave As Variant
    Dim fila As Integer
    fila = 4

    For Each clave In dict.Keys
        hojaReporte.Cells(fila, 1).Value = clave
        hojaReporte.Cells(fila, 2).Value = dict(clave)
        hojaReporte.Cells(fila, 2).NumberFormat = "$#,##0.00"
        fila = fila + 1
    Next clave

    ' Total
    hojaReporte.Cells(fila, 1).Value = "TOTAL GENERAL:"
    hojaReporte.Cells(fila, 2).Formula = "=SUM(B4:B" & fila - 1 & ")"
    hojaReporte.Range(hojaReporte.Cells(fila, 1), hojaReporte.Cells(fila, 2)).Font.Bold = True
    hojaReporte.Cells(fila, 2).NumberFormat = "$#,##0.00"

    ' Formato
    hojaReporte.Range("A3:B" & fila).Borders.LineStyle = xlContinuous
    hojaReporte.Columns("A:B").AutoFit

    MsgBox "Análisis completado. Encontradas " & dict.Count & " categorías", vbInformation
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 7.10: EJEMPLO PRÁCTICO - PROCESAMIENTO MASIVO CON ARRAYS
'-------------------------------------------------------------------------------

Sub ProcesarGrandesVolumenes()
    ' Procesar 10,000 filas de forma optimizada
    Dim inicio As Double
    inicio = Timer

    Application.ScreenUpdating = False
    Application.Calculation = xlCalculationManual

    Dim ultimaFila As Long
    ultimaFila = 10000

    ' Cargar datos a array
    Dim datos As Variant
    datos = Range("A1:C" & ultimaFila).Value

    ' Procesar en memoria
    Dim i As Long
    For i = 2 To UBound(datos, 1)  ' Empezar en 2 (fila 1 son encabezados)
        ' Aplicar descuento del 10%
        If IsNumeric(datos(i, 3)) Then
            datos(i, 3) = datos(i, 3) * 0.9
        End If

        ' Calcular comisión (columna D)
        ReDim Preserve datos(1 To UBound(datos, 1), 1 To 4)
        datos(i, 4) = datos(i, 3) * 0.05  ' 5% de comisión
    Next i

    ' Escribir de vuelta a Excel
    Range("A1:D" & ultimaFila).Value = datos

    Application.ScreenUpdating = True
    Application.Calculation = xlCalculationAutomatic

    Dim fin As Double
    fin = Timer

    MsgBox "Procesadas " & Format(ultimaFila, "#,##0") & " filas en " & _
           Format(fin - inicio, "0.00") & " segundos", vbInformation
End Sub

'===============================================================================
' RESUMEN DEL MÓDULO 7
'===============================================================================
' ✓ Dominas el uso de Arrays (estáticos, dinámicos, multidimensionales)
' ✓ Sabes trabajar con Colecciones (Collection)
' ✓ Conoces Dictionary para datos clave-valor
' ✓ Puedes usar Expresiones Regulares (RegEx) para validación
' ✓ Sabes leer y escribir archivos de texto
' ✓ Entiendes técnicas de optimización de código
' ✓ Conoces eventos de Worksheet y Workbook
' ✓ Puedes procesar grandes volúmenes de datos eficientemente
'
' SIGUIENTE PASO: Módulo 8 - Automatización y Proyectos Completos
'===============================================================================
