Attribute VB_Name = "Modulo_02_Celdas_Rangos"
'===============================================================================
' MÓDULO 2: TRABAJANDO CON CELDAS Y RANGOS
'===============================================================================
' Este módulo te enseña a manipular celdas y rangos en Excel con VBA
' Incluye: propiedades, métodos, selección, formato y ejemplos prácticos
'===============================================================================

'-------------------------------------------------------------------------------
' SECCIÓN 2.1: FORMAS DE REFERENCIAR CELDAS
'-------------------------------------------------------------------------------

Sub FormasReferenciarCeldas()
    ' Hay varias formas de referenciar celdas en VBA

    ' MÉTODO 1: Usando Range con notación A1
    Range("A1").Value = "Método 1: Range(""A1"")"

    ' MÉTODO 2: Usando Cells con números (fila, columna)
    Cells(2, 1).Value = "Método 2: Cells(2, 1)"  ' Fila 2, Columna 1 = A2

    ' MÉTODO 3: Combinando Range y Cells
    Range(Cells(3, 1), Cells(3, 3)).Value = "Método 3: Rango combinado"

    ' MÉTODO 4: Rangos múltiples
    Range("A4:C4").Value = "Método 4: Rango A4:C4"

    ' MÉTODO 5: Usando variables
    Dim miCelda As Range
    Set miCelda = Range("A5")
    miCelda.Value = "Método 5: Usando variable"

    ' IMPORTANTE: Se usa SET para asignar objetos
    ' Sin SET para valores simples, CON SET para objetos
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 2.2: PROPIEDADES BÁSICAS DE CELDAS
'-------------------------------------------------------------------------------

Sub PropiedadesCeldas()
    ' Limpiar área de trabajo
    Range("A1:E10").Clear

    ' VALUE - Valor de la celda
    Range("A1").Value = "Texto"
    Range("B1").Value = 123
    Range("C1").Value = 45.67

    ' FORMULA - Fórmula de la celda
    Range("D1").Formula = "=B1+C1"  ' Suma B1 y C1
    Range("E1").Formula = "=SUM(B1:C1)"

    ' TEXT - Valor como texto (solo lectura)
    Dim textoValor As String
    textoValor = Range("D1").Text
    MsgBox "El texto de D1 es: " & textoValor

    ' ADDRESS - Dirección de la celda
    MsgBox "La dirección es: " & Range("D1").Address  ' Muestra $D$1

    ' ROW y COLUMN - Número de fila y columna
    MsgBox "D1 está en la fila: " & Range("D1").Row & _
           " y columna: " & Range("D1").Column

    ' COUNT - Número de celdas en un rango
    MsgBox "Celdas en A1:E1: " & Range("A1:E1").Count
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 2.3: FORMATEO DE CELDAS
'-------------------------------------------------------------------------------

Sub FormatearCeldas()
    ' Preparar datos
    Range("A1").Value = "Producto"
    Range("B1").Value = "Precio"
    Range("A2").Value = "Laptop"
    Range("B2").Value = 15000

    ' FONT - Formato de fuente
    With Range("A1:B1")
        .Font.Bold = True              ' Negrita
        .Font.Size = 14                ' Tamaño de fuente
        .Font.Color = RGB(255, 255, 255)  ' Color blanco
        .Font.Name = "Arial"           ' Tipo de fuente
    End With

    ' INTERIOR - Color de fondo
    With Range("A1:B1").Interior
        .Color = RGB(0, 112, 192)     ' Azul
        ' También puedes usar: .ColorIndex = 5 (para colores predefinidos)
    End With

    ' BORDERS - Bordes
    With Range("A1:B2").Borders
        .LineStyle = xlContinuous      ' Línea continua
        .Weight = xlThin               ' Grosor delgado
        .Color = RGB(0, 0, 0)         ' Color negro
    End With

    ' NUMBERFORMAT - Formato de números
    Range("B2").NumberFormat = "$#,##0.00"  ' Formato moneda

    ' ALIGNMENT - Alineación
    With Range("A1:B2")
        .HorizontalAlignment = xlCenter  ' Centrado horizontal
        .VerticalAlignment = xlCenter    ' Centrado vertical
    End With

    ' AJUSTAR ANCHO DE COLUMNAS
    Columns("A:B").AutoFit  ' Ajustar automáticamente
    ' O manualmente:
    ' Columns("A").ColumnWidth = 15
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 2.4: TRABAJANDO CON RANGOS MÚLTIPLES
'-------------------------------------------------------------------------------

Sub RangosMultiples()
    ' Limpiar
    Cells.Clear

    ' RANGO CONTIGUO
    Range("A1:C1").Value = "Encabezado"
    Range("A1:C1").Font.Bold = True

    ' LLENAR UN RANGO CON UN SOLO VALOR
    Range("A2:A10").Value = "Producto"

    ' LLENAR CON DIFERENTES VALORES usando Array
    Range("A2:A4").Value = Application.Transpose(Array("Laptop", "Mouse", "Teclado"))
    Range("B2:B4").Value = Application.Transpose(Array(15000, 250, 800))

    ' RANGO NO CONTIGUO (separado por comas)
    Range("A6,C6,E6").Value = "No contiguo"
    Range("A6,C6,E6").Interior.Color = RGB(255, 255, 0)  ' Amarillo

    ' USAR VARIABLES PARA DEFINIR RANGOS
    Dim filaInicio As Integer
    Dim filaFin As Integer
    filaInicio = 8
    filaFin = 10

    Range("A" & filaInicio & ":A" & filaFin).Value = "Rango dinámico"
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 2.5: MÉTODOS IMPORTANTES DE RANGOS
'-------------------------------------------------------------------------------

Sub MetodosRangos()
    ' Preparar datos de ejemplo
    Range("A1:C5").Clear
    Range("A1:C1").Value = Array("Nombre", "Edad", "Ciudad")
    Range("A2").Value = "Juan"
    Range("B2").Value = 25
    Range("C2").Value = "Madrid"

    ' COPY - Copiar
    Range("A1:C2").Copy
    Range("A4").PasteSpecial xlPasteAll  ' Pegar todo
    Application.CutCopyMode = False  ' Quitar el borde de copiado

    ' CLEAR - Limpiar todo (formato y contenido)
    ' Range("A4:C5").Clear

    ' CLEARCONTENTS - Limpiar solo contenido
    ' Range("A4:C5").ClearContents

    ' CLEARFORMATS - Limpiar solo formato
    ' Range("A4:C5").ClearFormats

    ' DELETE - Eliminar celdas
    ' Range("A4:C5").Delete Shift:=xlUp  ' Eliminar y desplazar hacia arriba

    ' INSERT - Insertar celdas
    Range("A3").Insert Shift:=xlDown  ' Insertar y desplazar hacia abajo

    ' SELECT - Seleccionar (evita usar esto cuando sea posible)
    ' Range("A1").Select  ' No recomendado

    ' OFFSET - Desplazamiento relativo
    Range("A1").Offset(1, 0).Value = "Una fila abajo"  ' Offset(filas, columnas)
    Range("A1").Offset(0, 1).Value = "Una columna a la derecha"

    ' RESIZE - Cambiar tamaño del rango
    Range("A1").Resize(3, 2).Interior.Color = RGB(200, 200, 200)
    ' Resize(filas, columnas)
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 2.6: SELECCIÓN VS REFERENCIA (MUY IMPORTANTE)
'-------------------------------------------------------------------------------

Sub SeleccionVsReferencia()
    ' ❌ MÉTODO NO RECOMENDADO - Usar Select
    Range("A1").Select
    Selection.Value = "Método lento"

    ' ✅ MÉTODO RECOMENDADO - Referencia directa (más rápido)
    Range("A2").Value = "Método rápido"

    ' EJEMPLO PRÁCTICO: Copiar datos
    ' ❌ Forma lenta con Select
    Range("A1").Select
    Selection.Copy
    Range("B1").Select
    ActiveSheet.Paste

    ' ✅ Forma rápida sin Select
    Range("A2").Copy Range("B2")
    Application.CutCopyMode = False

    ' REGLA DE ORO: Evita Select y Selection siempre que sea posible
    ' Solo úsalo cuando realmente necesites que el usuario vea la selección
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 2.7: ENCONTRAR LA ÚLTIMA FILA/COLUMNA
'-------------------------------------------------------------------------------

Sub EncontrarUltimaFila()
    ' Preparar datos de ejemplo
    Range("A1:B1").Value = Array("ID", "Nombre")
    Range("A2:B5").Formula = "=ROW()"

    ' MÉTODO 1: Encontrar última fila con datos en columna A
    Dim ultimaFila As Long
    ultimaFila = Cells(Rows.Count, 1).End(xlUp).Row
    MsgBox "Última fila con datos en columna A: " & ultimaFila

    ' MÉTODO 2: Encontrar última columna con datos en fila 1
    Dim ultimaColumna As Long
    ultimaColumna = Cells(1, Columns.Count).End(xlToLeft).Column
    MsgBox "Última columna con datos en fila 1: " & ultimaColumna

    ' USAR LA ÚLTIMA FILA PARA AGREGAR DATOS
    Dim nuevaFila As Long
    nuevaFila = Cells(Rows.Count, 1).End(xlUp).Row + 1
    Cells(nuevaFila, 1).Value = "Nuevo"
    Cells(nuevaFila, 2).Value = "Registro"

    ' Resaltar la última fila
    Range("A" & nuevaFila & ":B" & nuevaFila).Interior.Color = RGB(144, 238, 144)
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 2.8: TRABAJAR CON HOJAS ESPECÍFICAS
'-------------------------------------------------------------------------------

Sub TrabajarConHojas()
    ' REFERENCIAR HOJAS POR NOMBRE
    Worksheets("Hoja1").Range("A1").Value = "Hoja por nombre"

    ' REFERENCIAR HOJAS POR ÍNDICE
    Worksheets(1).Range("A2").Value = "Primera hoja"

    ' USAR ACTIVESHEET (hoja activa actual)
    ActiveSheet.Range("A3").Value = "Hoja activa"

    ' USAR THISWORKBOOK vs ACTIVEWORKBOOK
    ' ThisWorkbook: El libro donde está el código
    ' ActiveWorkbook: El libro actualmente activo

    ' MEJOR PRÁCTICA: Usar variables para hojas
    Dim hoja As Worksheet
    Set hoja = Worksheets("Hoja1")

    hoja.Range("A4").Value = "Usando variable"
    hoja.Range("A4").Font.Bold = True
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 2.9: EJEMPLO PRÁCTICO - CREAR TABLA DE MULTIPLICAR
'-------------------------------------------------------------------------------

Sub TablaDeMultiplicar()
    Dim numero As Integer
    Dim fila As Integer

    ' Limpiar área
    Range("A1:C15").Clear

    ' Pedir número al usuario
    numero = InputBox("¿Qué tabla de multiplicar quieres crear?", "Tabla")

    ' Validar entrada
    If numero < 1 Or numero > 100 Then
        MsgBox "Número no válido. Debe ser entre 1 y 100"
        Exit Sub
    End If

    ' Crear encabezado
    Range("A1").Value = "Tabla del " & numero
    Range("A1").Font.Size = 14
    Range("A1").Font.Bold = True
    Range("A1").Font.Color = RGB(0, 0, 255)

    ' Generar la tabla
    For fila = 1 To 10
        Cells(fila + 2, 1).Value = numero
        Cells(fila + 2, 2).Value = "×"
        Cells(fila + 2, 3).Value = fila
        Cells(fila + 2, 4).Value = "="
        Cells(fila + 2, 5).Value = numero * fila

        ' Formato
        Range(Cells(fila + 2, 1), Cells(fila + 2, 5)).Font.Name = "Courier New"

        ' Alternar colores
        If fila Mod 2 = 0 Then
            Range(Cells(fila + 2, 1), Cells(fila + 2, 5)).Interior.Color = RGB(240, 240, 240)
        End If
    Next fila

    ' Aplicar bordes
    Range("A2:E12").Borders.LineStyle = xlContinuous

    ' Ajustar columnas
    Columns("A:E").AutoFit
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 2.10: EJEMPLO PRÁCTICO - FORMATO CONDICIONAL SIMPLE
'-------------------------------------------------------------------------------

Sub FormatoCondicionalSimple()
    Dim celda As Range
    Dim rango As Range

    ' Limpiar
    Range("A1:B20").Clear

    ' Crear datos de ejemplo
    Range("A1").Value = "Calificación"
    Range("A1").Font.Bold = True

    ' Llenar con números aleatorios del 0 al 100
    Dim i As Integer
    For i = 2 To 20
        Cells(i, 1).Value = Int(Rnd() * 101)  ' Número aleatorio 0-100
    Next i

    ' Definir el rango a formatear
    Set rango = Range("A2:A20")

    ' Aplicar formato condicional
    For Each celda In rango
        If celda.Value >= 90 Then
            ' Excelente - Verde
            celda.Interior.Color = RGB(0, 255, 0)
            celda.Font.Color = RGB(0, 100, 0)
            celda.Font.Bold = True
        ElseIf celda.Value >= 70 Then
            ' Bueno - Amarillo
            celda.Interior.Color = RGB(255, 255, 0)
        ElseIf celda.Value >= 50 Then
            ' Regular - Naranja
            celda.Interior.Color = RGB(255, 165, 0)
        Else
            ' Reprobado - Rojo
            celda.Interior.Color = RGB(255, 0, 0)
            celda.Font.Color = RGB(255, 255, 255)
            celda.Font.Bold = True
        End If
    Next celda

    ' Leyenda
    Range("C2").Value = "≥ 90"
    Range("D2").Value = "Excelente"
    Range("C2:D2").Interior.Color = RGB(0, 255, 0)

    Range("C3").Value = "≥ 70"
    Range("D3").Value = "Bueno"
    Range("C3:D3").Interior.Color = RGB(255, 255, 0)

    Range("C4").Value = "≥ 50"
    Range("D4").Value = "Regular"
    Range("C4:D4").Interior.Color = RGB(255, 165, 0)

    Range("C5").Value = "< 50"
    Range("D5").Value = "Reprobado"
    Range("C5:D5").Interior.Color = RGB(255, 0, 0)
    Range("C5:D5").Font.Color = RGB(255, 255, 255)

    Columns("A:D").AutoFit
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 2.11: EJEMPLO PRÁCTICO - REPORTE DE VENTAS
'-------------------------------------------------------------------------------

Sub CrearReporteVentas()
    Dim i As Integer

    ' Limpiar hoja
    Cells.Clear

    ' ENCABEZADOS
    Range("A1").Value = "REPORTE DE VENTAS MENSUAL"
    Range("A1").Font.Size = 16
    Range("A1").Font.Bold = True
    Range("A1").Font.Color = RGB(255, 255, 255)
    Range("A1:E1").Merge  ' Combinar celdas
    Range("A1:E1").Interior.Color = RGB(68, 114, 196)
    Range("A1:E1").HorizontalAlignment = xlCenter

    ' Columnas
    Range("A3:E3").Value = Array("ID", "Producto", "Cantidad", "Precio Unit.", "Total")
    Range("A3:E3").Font.Bold = True
    Range("A3:E3").Interior.Color = RGB(217, 217, 217)
    Range("A3:E3").HorizontalAlignment = xlCenter

    ' DATOS DE EJEMPLO
    Dim productos() As Variant
    productos = Array("Laptop", "Mouse", "Teclado", "Monitor", "Webcam")

    Dim precios() As Variant
    precios = Array(15000, 250, 800, 5000, 1200)

    ' Generar 10 ventas aleatorias
    For i = 4 To 13
        Cells(i, 1).Value = i - 3  ' ID
        Cells(i, 2).Value = productos(Int(Rnd() * 5))  ' Producto aleatorio
        Cells(i, 3).Value = Int(Rnd() * 10) + 1  ' Cantidad 1-10
        Cells(i, 4).Value = precios(Int(Rnd() * 5))  ' Precio
        Cells(i, 5).Formula = "=C" & i & "*D" & i  ' Total = Cantidad × Precio
    Next i

    ' FORMATO DE NÚMEROS
    Range("D4:E13").NumberFormat = "$#,##0.00"
    Range("A4:E13").Borders.LineStyle = xlContinuous

    ' TOTALES
    Range("A15").Value = "TOTAL GENERAL:"
    Range("A15").Font.Bold = True
    Range("E15").Formula = "=SUM(E4:E13)"
    Range("E15").Font.Bold = True
    Range("E15").NumberFormat = "$#,##0.00"
    Range("E15").Interior.Color = RGB(255, 242, 204)

    ' ESTADÍSTICAS
    Range("A17").Value = "Venta Promedio:"
    Range("E17").Formula = "=AVERAGE(E4:E13)"
    Range("E17").NumberFormat = "$#,##0.00"

    Range("A18").Value = "Venta Máxima:"
    Range("E18").Formula = "=MAX(E4:E13)"
    Range("E18").NumberFormat = "$#,##0.00"

    Range("A19").Value = "Venta Mínima:"
    Range("E19").Formula = "=MIN(E4:E13)"
    Range("E19").NumberFormat = "$#,##0.00"

    ' AJUSTAR COLUMNAS
    Columns("A:E").AutoFit

    ' Mensaje final
    MsgBox "¡Reporte de ventas creado exitosamente!", vbInformation
End Sub

'===============================================================================
' RESUMEN DEL MÓDULO 2
'===============================================================================
' ✓ Aprendiste diferentes formas de referenciar celdas (Range, Cells)
' ✓ Conoces las propiedades principales (Value, Formula, Address, etc.)
' ✓ Sabes formatear celdas (fuente, color, bordes, alineación)
' ✓ Entiendes cómo trabajar con rangos múltiples
' ✓ Conoces métodos importantes (Copy, Clear, Insert, Delete, Offset)
' ✓ Comprendes la diferencia entre selección y referencia
' ✓ Sabes encontrar la última fila/columna con datos
' ✓ Puedes trabajar con diferentes hojas
' ✓ Creaste ejemplos prácticos (tabla de multiplicar, formato condicional, reporte)
'
' SIGUIENTE PASO: Módulo 3 - Estructuras de Control
'===============================================================================
