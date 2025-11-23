Attribute VB_Name = "Modulo_08_Proyectos_Completos"
'===============================================================================
' MÓDULO 8: AUTOMATIZACIÓN Y PROYECTOS COMPLETOS
'===============================================================================
' Este módulo presenta proyectos completos de automatización con VBA
' Incluye: Sistema de inventario, Dashboard, Generador de reportes,
' Automatización de tareas, Integración con otras aplicaciones
'===============================================================================

'-------------------------------------------------------------------------------
' PROYECTO 1: SISTEMA DE INVENTARIO COMPLETO
'-------------------------------------------------------------------------------

' Crear estructura de inventario
Sub CrearSistemaInventario()
    Application.ScreenUpdating = False

    ' Crear hojas necesarias
    Call CrearHojasInventario

    ' Configurar hoja de productos
    Call ConfigurarHojaProductos

    ' Configurar hoja de movimientos
    Call ConfigurarHojaMovimientos

    ' Configurar hoja de dashboard
    Call ConfigurarDashboard

    Application.ScreenUpdating = True
    MsgBox "Sistema de inventario creado exitosamente", vbInformation
End Sub

Private Sub CrearHojasInventario()
    Dim nombresHojas As Variant
    Dim nombreHoja As Variant

    nombresHojas = Array("Productos", "Movimientos", "Dashboard", "Configuración")

    Application.DisplayAlerts = False
    For Each nombreHoja In nombresHojas
        On Error Resume Next
        Worksheets(nombreHoja).Delete
        On Error GoTo 0
        Worksheets.Add(After:=Worksheets(Worksheets.Count)).Name = nombreHoja
    Next nombreHoja
    Application.DisplayAlerts = True
End Sub

Private Sub ConfigurarHojaProductos()
    Dim hoja As Worksheet
    Set hoja = Worksheets("Productos")

    With hoja
        ' Encabezados
        .Range("A1:G1").Value = Array("ID", "Código", "Producto", "Categoría", _
                                      "Stock Actual", "Stock Mínimo", "Precio")
        .Range("A1:G1").Font.Bold = True
        .Range("A1:G1").Interior.Color = RGB(68, 114, 196)
        .Range("A1:G1").Font.Color = RGB(255, 255, 255)
        .Range("A1:G1").HorizontalAlignment = xlCenter

        ' Formato de columnas
        .Columns("E:G").NumberFormat = "#,##0"
        .Columns("G").NumberFormat = "$#,##0.00"

        ' Datos de ejemplo
        .Range("A2:G6").Value = Array( _
            1, "PROD001", "Laptop Dell XPS", "Electrónica", 15, 5, 25000, _
            2, "PROD002", "Mouse Logitech", "Accesorios", 50, 20, 350, _
            3, "PROD003", "Teclado Mecánico", "Accesorios", 30, 10, 1200, _
            4, "PROD004", "Monitor Samsung 27""", "Electrónica", 8, 3, 8500, _
            5, "PROD005", "Webcam HD", "Accesorios", 25, 15, 850)

        ' Ajustar columnas
        .Columns("A:G").AutoFit

        ' Validación de datos en Categoría
        .Range("D2:D1000").Validation.Add xlValidateList, , , "Electrónica,Accesorios,Software"

        ' Formato condicional para stock bajo
        With .Range("E2:E1000")
            .FormatConditions.Delete
            .FormatConditions.Add Type:=xlExpression, Formula1:="=E2<F2"
            .FormatConditions(1).Interior.Color = RGB(255, 200, 200)
            .FormatConditions(1).Font.Color = RGB(200, 0, 0)
        End With
    End With
End Sub

Private Sub ConfigurarHojaMovimientos()
    Dim hoja As Worksheet
    Set hoja = Worksheets("Movimientos")

    With hoja
        .Range("A1:F1").Value = Array("Fecha", "Tipo", "ID Producto", _
                                      "Producto", "Cantidad", "Usuario")
        .Range("A1:F1").Font.Bold = True
        .Range("A1:F1").Interior.Color = RGB(68, 114, 196)
        .Range("A1:F1").Font.Color = RGB(255, 255, 255)

        .Columns("A:F").AutoFit
    End With
End Sub

Private Sub ConfigurarDashboard()
    Dim hoja As Worksheet
    Set hoja = Worksheets("Dashboard")

    With hoja
        ' Título
        .Range("A1").Value = "DASHBOARD DE INVENTARIO"
        .Range("A1").Font.Size = 18
        .Range("A1").Font.Bold = True

        ' KPIs
        .Range("A3").Value = "Total Productos:"
        .Range("B3").Formula = "=COUNTA(Productos!A2:A1000)"

        .Range("A4").Value = "Valor Total Inventario:"
        .Range("B4").Formula = "=SUMPRODUCT(Productos!E2:E1000,Productos!G2:G1000)"
        .Range("B4").NumberFormat = "$#,##0.00"

        .Range("A5").Value = "Productos con Stock Bajo:"
        .Range("B5").Formula = "=SUMPRODUCT((Productos!E2:E1000<Productos!F2:F1000)*1)"

        .Range("A3:A5").Font.Bold = True
        .Range("B3:B5").Font.Size = 12
        .Range("B3:B5").Interior.Color = RGB(255, 242, 204)

        .Columns("A:B").AutoFit
    End With
End Sub

' Agregar producto
Sub AgregarProducto()
    Dim hoja As Worksheet
    Dim ultimaFila As Long
    Dim nuevoID As Long

    Set hoja = Worksheets("Productos")
    ultimaFila = hoja.Cells(Rows.Count, 1).End(xlUp).Row

    ' Calcular nuevo ID
    If ultimaFila > 1 Then
        nuevoID = hoja.Cells(ultimaFila, 1).Value + 1
    Else
        nuevoID = 1
    End If

    ' Pedir datos
    Dim codigo As String
    Dim nombre As String
    Dim categoria As String
    Dim stockInicial As Integer
    Dim stockMinimo As Integer
    Dim precio As Double

    codigo = InputBox("Código del producto:", "Nuevo Producto")
    If codigo = "" Then Exit Sub

    nombre = InputBox("Nombre del producto:", "Nuevo Producto")
    categoria = InputBox("Categoría (Electrónica, Accesorios, Software):", "Nuevo Producto")
    stockInicial = Val(InputBox("Stock inicial:", "Nuevo Producto", "0"))
    stockMinimo = Val(InputBox("Stock mínimo:", "Nuevo Producto", "5"))
    precio = Val(InputBox("Precio:", "Nuevo Producto", "0"))

    ' Agregar a la hoja
    With hoja
        .Cells(ultimaFila + 1, 1).Value = nuevoID
        .Cells(ultimaFila + 1, 2).Value = codigo
        .Cells(ultimaFila + 1, 3).Value = nombre
        .Cells(ultimaFila + 1, 4).Value = categoria
        .Cells(ultimaFila + 1, 5).Value = stockInicial
        .Cells(ultimaFila + 1, 6).Value = stockMinimo
        .Cells(ultimaFila + 1, 7).Value = precio
    End With

    MsgBox "Producto agregado exitosamente", vbInformation
End Sub

' Registrar entrada de inventario
Sub RegistrarEntrada()
    Dim idProducto As Integer
    Dim cantidad As Integer
    Dim hojaProductos As Worksheet
    Dim hojaMovimientos As Worksheet
    Dim i As Long
    Dim encontrado As Boolean

    Set hojaProductos = Worksheets("Productos")
    Set hojaMovimientos = Worksheets("Movimientos")

    idProducto = Val(InputBox("ID del producto:", "Entrada de Inventario"))
    cantidad = Val(InputBox("Cantidad a ingresar:", "Entrada de Inventario"))

    If cantidad <= 0 Then
        MsgBox "Cantidad inválida", vbExclamation
        Exit Sub
    End If

    ' Buscar producto y actualizar stock
    encontrado = False
    For i = 2 To hojaProductos.Cells(Rows.Count, 1).End(xlUp).Row
        If hojaProductos.Cells(i, 1).Value = idProducto Then
            hojaProductos.Cells(i, 5).Value = hojaProductos.Cells(i, 5).Value + cantidad
            encontrado = True

            ' Registrar movimiento
            Dim ultimaFila As Long
            ultimaFila = hojaMovimientos.Cells(Rows.Count, 1).End(xlUp).Row + 1

            hojaMovimientos.Cells(ultimaFila, 1).Value = Now
            hojaMovimientos.Cells(ultimaFila, 2).Value = "ENTRADA"
            hojaMovimientos.Cells(ultimaFila, 3).Value = idProducto
            hojaMovimientos.Cells(ultimaFila, 4).Value = hojaProductos.Cells(i, 3).Value
            hojaMovimientos.Cells(ultimaFila, 5).Value = cantidad
            hojaMovimientos.Cells(ultimaFila, 6).Value = Application.UserName

            MsgBox "Entrada registrada exitosamente", vbInformation
            Exit For
        End If
    Next i

    If Not encontrado Then
        MsgBox "Producto no encontrado", vbExclamation
    End If
End Sub

'-------------------------------------------------------------------------------
' PROYECTO 2: GENERADOR AUTOMÁTICO DE REPORTES
'-------------------------------------------------------------------------------

Sub GenerarReporteVentasMensual()
    Application.ScreenUpdating = False
    Application.Calculation = xlCalculationManual

    Dim hojaReporte As Worksheet
    Dim hojaVentas As Worksheet
    Dim mes As Integer
    Dim año As Integer

    ' Solicitar mes y año
    mes = Val(InputBox("Mes (1-12):", "Reporte", Month(Date)))
    año = Val(InputBox("Año:", "Reporte", Year(Date)))

    ' Crear hoja de reporte
    On Error Resume Next
    Application.DisplayAlerts = False
    Worksheets("Reporte_" & mes & "_" & año).Delete
    Application.DisplayAlerts = True
    On Error GoTo 0

    Set hojaReporte = Worksheets.Add
    hojaReporte.Name = "Reporte_" & mes & "_" & año

    ' Configurar reporte
    With hojaReporte
        ' Encabezado
        .Range("A1").Value = "REPORTE DE VENTAS"
        .Range("A2").Value = "Mes: " & MonthName(mes) & " " & año
        .Range("A1:A2").Font.Size = 14
        .Range("A1:A2").Font.Bold = True

        ' Fecha de generación
        .Range("A3").Value = "Generado el: " & Format(Now, "dd/mm/yyyy hh:mm")

        ' Resumen ejecutivo
        .Range("A5").Value = "RESUMEN EJECUTIVO"
        .Range("A5").Font.Bold = True
        .Range("A5").Font.Size = 12

        .Range("A7:B10").Value = Application.Transpose(Array( _
            "Total Ventas:", "=SUM(D16:D1000)", _
            "Promedio por Venta:", "=AVERAGE(D16:D1000)", _
            "Venta Máxima:", "=MAX(D16:D1000)", _
            "Venta Mínima:", "=MIN(D16:D1000)"))

        .Range("B7:B10").NumberFormat = "$#,##0.00"
        .Range("B7:B10").Font.Bold = True

        ' Detalle de ventas
        .Range("A15").Value = "DETALLE DE VENTAS"
        .Range("A15").Font.Bold = True

        .Range("A16:E16").Value = Array("Fecha", "Cliente", "Producto", "Cantidad", "Total")
        .Range("A16:E16").Font.Bold = True
        .Range("A16:E16").Interior.Color = RGB(68, 114, 196)
        .Range("A16:E16").Font.Color = RGB(255, 255, 255)

        ' Aquí se cargarían los datos reales desde una hoja de ventas
        ' Por ahora, datos de ejemplo
        Dim fila As Integer
        For fila = 17 To 30
            .Cells(fila, 1).Value = DateSerial(año, mes, Int(Rnd() * 28) + 1)
            .Cells(fila, 2).Value = "Cliente " & Int(Rnd() * 10) + 1
            .Cells(fila, 3).Value = "Producto " & Int(Rnd() * 5) + 1
            .Cells(fila, 4).Value = Int(Rnd() * 10) + 1
            .Cells(fila, 5).Formula = "=D" & fila & "*" & (Int(Rnd() * 1000) + 500)
        Next fila

        .Range("E17:E30").NumberFormat = "$#,##0.00"

        ' Gráfico
        Dim grafico As ChartObject
        Set grafico = .ChartObjects.Add(Left:=400, Top:=100, Width:=400, Height:=250)

        With grafico.Chart
            .SetSourceData Source:=hojaReporte.Range("A16:E30")
            .ChartType = xlColumnClustered
            .HasTitle = True
            .ChartTitle.Text = "Ventas del Mes"
        End With

        .Columns("A:E").AutoFit
    End With

    Application.ScreenUpdating = True
    Application.Calculation = xlCalculationAutomatic

    MsgBox "Reporte generado exitosamente", vbInformation
End Sub

'-------------------------------------------------------------------------------
' PROYECTO 3: DASHBOARD INTERACTIVO
'-------------------------------------------------------------------------------

Sub CrearDashboardInteractivo()
    Dim hoja As Worksheet
    Set hoja = Worksheets.Add
    hoja.Name = "Dashboard_Ventas"

    Application.ScreenUpdating = False

    With hoja
        ' Título principal
        .Range("A1:G1").Merge
        .Range("A1").Value = "DASHBOARD DE VENTAS"
        .Range("A1").Font.Size = 20
        .Range("A1").Font.Bold = True
        .Range("A1").HorizontalAlignment = xlCenter
        .Range("A1").Interior.Color = RGB(68, 114, 196)
        .Range("A1").Font.Color = RGB(255, 255, 255)

        ' KPIs principales
        .Range("A3").Value = "KPIs del Mes Actual"
        .Range("A3").Font.Size = 14
        .Range("A3").Font.Bold = True

        ' Tarjetas de KPIs
        Call CrearTarjetaKPI(hoja, "B5", "Ventas Totales", "=SUM(Ventas!E:E)", RGB(76, 175, 80))
        Call CrearTarjetaKPI(hoja, "D5", "Nuevos Clientes", "=COUNT(Clientes!A:A)", RGB(33, 150, 243))
        Call CrearTarjetaKPI(hoja, "F5", "Productos Vendidos", "=SUM(Ventas!D:D)", RGB(255, 152, 0))

        ' Tabla de top productos
        .Range("A10").Value = "Top 5 Productos Más Vendidos"
        .Range("A10").Font.Bold = True

        .Range("A11:C11").Value = Array("Producto", "Cantidad", "Ingresos")
        .Range("A11:C11").Font.Bold = True
        .Range("A11:C11").Interior.Color = RGB(200, 200, 200)

        ' Botones de acción
        Call CrearBoton(hoja, 380, 300, 120, 30, "Actualizar Dashboard", "ActualizarDashboard")
        Call CrearBoton(hoja, 510, 300, 120, 30, "Generar Reporte", "GenerarReporteVentasMensual")

        .Columns("A:G").AutoFit
    End With

    Application.ScreenUpdating = True
    MsgBox "Dashboard creado exitosamente", vbInformation
End Sub

Private Sub CrearTarjetaKPI(hoja As Worksheet, celda As String, titulo As String, _
                           formula As String, color As Long)
    Dim rango As Range
    Set rango = hoja.Range(celda).Resize(3, 2)

    With rango
        .Merge
        .Value = titulo & vbCrLf & formula
        .Font.Size = 12
        .Font.Bold = True
        .HorizontalAlignment = xlCenter
        .VerticalAlignment = xlCenter
        .Interior.Color = color
        .Font.Color = RGB(255, 255, 255)
        .Borders.LineStyle = xlContinuous
    End With
End Sub

Private Sub CrearBoton(hoja As Worksheet, left As Double, top As Double, _
                      ancho As Double, alto As Double, texto As String, macro As String)
    Dim btn As Button

    Set btn = hoja.Buttons.Add(left, top, ancho, alto)
    btn.Text = texto
    btn.OnAction = macro
End Sub

Sub ActualizarDashboard()
    ' Lógica para actualizar el dashboard
    Application.Calculate
    MsgBox "Dashboard actualizado", vbInformation
End Sub

'-------------------------------------------------------------------------------
' PROYECTO 4: AUTOMATIZACIÓN DE EMAILS CON OUTLOOK
'-------------------------------------------------------------------------------

Sub EnviarReportePorEmail()
    ' NOTA: Requiere referencia a "Microsoft Outlook XX.0 Object Library"
    ' Tools > References > Microsoft Outlook XX.0 Object Library

    On Error Resume Next
    Dim outlookApp As Object
    Dim correo As Object

    ' Crear instancia de Outlook
    Set outlookApp = CreateObject("Outlook.Application")
    Set correo = outlookApp.CreateItem(0)  ' 0 = olMailItem

    With correo
        .To = "destinatario@ejemplo.com"
        .CC = "copia@ejemplo.com"
        .Subject = "Reporte Mensual - " & Format(Date, "MMMM yyyy")

        .Body = "Estimado equipo," & vbCrLf & vbCrLf & _
                "Adjunto encontrarán el reporte mensual de ventas." & vbCrLf & vbCrLf & _
                "Saludos cordiales," & vbCrLf & _
                Application.UserName

        ' Adjuntar archivo actual
        .Attachments.Add ThisWorkbook.FullName

        ' Mostrar correo (cambiar a .Send para enviar automáticamente)
        .Display  ' o .Send para enviar directamente
    End With

    Set correo = Nothing
    Set outlookApp = Nothing

    MsgBox "Correo preparado", vbInformation
End Sub

Sub EnviarEmailsPersonalizados()
    ' Enviar emails personalizados a una lista de contactos
    Dim outlookApp As Object
    Dim correo As Object
    Dim hoja As Worksheet
    Dim ultimaFila As Long
    Dim i As Long

    Set hoja = Worksheets("Contactos")  ' Asume que hay una hoja "Contactos"
    ultimaFila = hoja.Cells(Rows.Count, 1).End(xlUp).Row

    Set outlookApp = CreateObject("Outlook.Application")

    For i = 2 To ultimaFila  ' Asume que fila 1 son encabezados
        Set correo = outlookApp.CreateItem(0)

        With correo
            .To = hoja.Cells(i, 2).Value  ' Columna B: Email
            .Subject = "Mensaje personalizado para " & hoja.Cells(i, 1).Value

            .Body = "Hola " & hoja.Cells(i, 1).Value & "," & vbCrLf & vbCrLf & _
                   "Este es un mensaje personalizado." & vbCrLf & vbCrLf & _
                   "Saludos"

            .Send  ' Enviar automáticamente
        End With

        Set correo = Nothing
    Next i

    Set outlookApp = Nothing
    MsgBox "Emails enviados: " & (ultimaFila - 1), vbInformation
End Sub

'-------------------------------------------------------------------------------
' PROYECTO 5: AUTOMATIZACIÓN DE ARCHIVOS
'-------------------------------------------------------------------------------

Sub ConsolidarArchivosExcel()
    ' Consolidar múltiples archivos Excel en uno solo
    Dim carpeta As String
    Dim archivo As String
    Dim libro As Workbook
    Dim hojaOrigen As Worksheet
    Dim hojaDestino As Worksheet
    Dim ultimaFila As Long
    Dim filaDestino As Long

    carpeta = "C:\MisArchivos\"  ' Carpeta con los archivos a consolidar

    ' Crear hoja de consolidación
    Set hojaDestino = ThisWorkbook.Worksheets.Add
    hojaDestino.Name = "Consolidado_" & Format(Now, "yyyymmdd_hhmmss")

    filaDestino = 1

    Application.ScreenUpdating = False
    Application.DisplayAlerts = False

    ' Buscar todos los archivos .xlsx en la carpeta
    archivo = Dir(carpeta & "*.xlsx")

    Do While archivo <> ""
        ' No abrir el archivo actual
        If archivo <> ThisWorkbook.Name Then
            ' Abrir archivo
            Set libro = Workbooks.Open(carpeta & archivo)
            Set hojaOrigen = libro.Worksheets(1)

            ' Copiar datos
            ultimaFila = hojaOrigen.Cells(Rows.Count, 1).End(xlUp).Row

            If ultimaFila > 0 Then
                hojaOrigen.Range("A1:Z" & ultimaFila).Copy _
                    Destination:=hojaDestino.Cells(filaDestino, 1)

                filaDestino = filaDestino + ultimaFila
            End If

            ' Cerrar archivo
            libro.Close SaveChanges:=False
        End If

        ' Siguiente archivo
        archivo = Dir()
    Loop

    Application.ScreenUpdating = True
    Application.DisplayAlerts = True

    MsgBox "Archivos consolidados exitosamente", vbInformation
End Sub

Sub DividirArchivoEnMultiples()
    ' Dividir un archivo grande en múltiples archivos por categoría
    Dim hojaOrigen As Worksheet
    Dim dict As Object
    Dim celda As Range
    Dim categoria As String
    Dim ultimaFila As Long

    Set hojaOrigen = ActiveSheet
    Set dict = CreateObject("Scripting.Dictionary")

    ultimaFila = hojaOrigen.Cells(Rows.Count, 1).End(xlUp).Row

    Application.ScreenUpdating = False

    ' Agrupar por categoría (asume categoría en columna A)
    For Each celda In hojaOrigen.Range("A2:A" & ultimaFila)
        categoria = celda.Value

        If Not dict.Exists(categoria) Then
            dict.Add categoria, New Collection
        End If

        dict(categoria).Add celda.Row
    Next celda

    ' Crear archivo para cada categoría
    Dim clave As Variant
    Dim nuevoLibro As Workbook
    Dim i As Long

    For Each clave In dict.Keys
        Set nuevoLibro = Workbooks.Add

        ' Copiar encabezados
        hojaOrigen.Rows(1).Copy Destination:=nuevoLibro.Worksheets(1).Rows(1)

        ' Copiar datos de la categoría
        Dim filaDestino As Long
        filaDestino = 2

        For i = 1 To dict(clave).Count
            hojaOrigen.Rows(dict(clave)(i)).Copy _
                Destination:=nuevoLibro.Worksheets(1).Rows(filaDestino)
            filaDestino = filaDestino + 1
        Next i

        ' Guardar archivo
        nuevoLibro.SaveAs ThisWorkbook.Path & "\" & clave & ".xlsx"
        nuevoLibro.Close
    Next clave

    Application.ScreenUpdating = True
    MsgBox "Archivos creados: " & dict.Count, vbInformation
End Sub

'-------------------------------------------------------------------------------
' PROYECTO 6: HERRAMIENTA DE LIMPIEZA DE DATOS
'-------------------------------------------------------------------------------

Sub LimpiarDatosCompleto()
    Dim hoja As Worksheet
    Dim rango As Range
    Dim celda As Range
    Dim ultimaFila As Long

    Set hoja = ActiveSheet
    ultimaFila = hoja.Cells(Rows.Count, 1).End(xlUp).Row
    Set rango = hoja.Range("A1:Z" & ultimaFila)

    Application.ScreenUpdating = False

    For Each celda In rango
        If Not IsEmpty(celda) Then
            ' 1. Eliminar espacios extras
            celda.Value = Trim(celda.Value)

            ' 2. Eliminar saltos de línea
            celda.Value = Replace(celda.Value, vbCrLf, " ")
            celda.Value = Replace(celda.Value, vbLf, " ")
            celda.Value = Replace(celda.Value, vbCr, " ")

            ' 3. Convertir a mayúscula la primera letra (si es texto)
            If VarType(celda.Value) = vbString Then
                celda.Value = Application.WorksheetFunction.Proper(celda.Value)
            End If
        End If
    Next celda

    ' Eliminar filas duplicadas
    rango.RemoveDuplicates Columns:=1, Header:=xlYes

    ' Eliminar filas completamente vacías
    Dim fila As Long
    For fila = ultimaFila To 2 Step -1
        If Application.WorksheetFunction.CountA(hoja.Rows(fila)) = 0 Then
            hoja.Rows(fila).Delete
        End If
    Next fila

    Application.ScreenUpdating = True
    MsgBox "Datos limpiados exitosamente", vbInformation
End Sub

'===============================================================================
' MEJORES PRÁCTICAS Y CONSEJOS FINALES
'===============================================================================

' 1. SIEMPRE usar Option Explicit al inicio de cada módulo
' 2. Comentar tu código adecuadamente
' 3. Usar nombres descriptivos para variables y procedimientos
' 4. Dividir código complejo en procedimientos más pequeños
' 5. Implementar manejo de errores (On Error)
' 6. Desactivar ScreenUpdating para mejorar rendimiento
' 7. Usar arrays para procesar grandes cantidades de datos
' 8. Validar datos de entrada del usuario
' 9. Liberar objetos (Set objeto = Nothing)
' 10. Probar código con datos pequeños antes de ejecutar con datos grandes

'===============================================================================
' RECURSOS ADICIONALES
'===============================================================================

' SITIOS WEB ÚTILES:
' - stackoverflow.com (buscar "excel vba")
' - excelmacromastery.com
' - docs.microsoft.com/en-us/office/vba/api/overview/excel

' TECLAS DE ATAJO EN VBA EDITOR:
' F5 - Ejecutar macro
' F8 - Ejecutar paso a paso (debug)
' F9 - Punto de interrupción
' Ctrl+G - Ventana Immediate
' Ctrl+R - Explorador de proyectos

'===============================================================================
' ¡FELICITACIONES!
'===============================================================================
' Has completado el curso de VBA para Excel.
' Ahora tienes las habilidades para:
' ✓ Automatizar tareas repetitivas
' ✓ Crear aplicaciones personalizadas
' ✓ Manipular datos eficientemente
' ✓ Generar reportes automáticos
' ✓ Integrar Excel con otras aplicaciones
' ✓ Desarrollar soluciones profesionales
'
' ¡Sigue practicando y creando proyectos propios!
'===============================================================================
