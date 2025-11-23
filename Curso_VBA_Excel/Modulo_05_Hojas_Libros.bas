Attribute VB_Name = "Modulo_05_Hojas_Libros"
'===============================================================================
' MÓDULO 5: TRABAJO CON HOJAS Y LIBROS
'===============================================================================
' Este módulo cubre la manipulación de hojas y libros de Excel con VBA
' Incluye: crear/eliminar hojas, copiar, mover, proteger, trabajar con
' múltiples libros, importar/exportar datos
'===============================================================================

'-------------------------------------------------------------------------------
' SECCIÓN 5.1: REFERENCIAR HOJAS
'-------------------------------------------------------------------------------

Sub ReferenciarHojas()
    ' MÉTODO 1: Por nombre
    Worksheets("Hoja1").Range("A1").Value = "Método 1"

    ' MÉTODO 2: Por índice (posición)
    Worksheets(1).Range("A2").Value = "Método 2"

    ' MÉTODO 3: ActiveSheet (hoja actualmente activa)
    ActiveSheet.Range("A3").Value = "Método 3"

    ' MÉTODO 4: ThisWorkbook.Worksheets (libro donde está el código)
    ThisWorkbook.Worksheets("Hoja1").Range("A4").Value = "Método 4"

    ' MÉTODO 5: Usando variable (RECOMENDADO)
    Dim hoja As Worksheet
    Set hoja = Worksheets("Hoja1")
    hoja.Range("A5").Value = "Método 5 - Mejor práctica"

    ' MÉTODO 6: CodeName (nombre interno de la hoja)
    ' Sheet1.Range("A6").Value = "CodeName"
    ' Nota: Sheet1, Sheet2, etc. son los CodeNames visibles en el editor VBA
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 5.2: CREAR HOJAS NUEVAS
'-------------------------------------------------------------------------------

Sub CrearHojaNueva()
    Dim nuevaHoja As Worksheet

    ' Crear hoja al final
    Set nuevaHoja = Worksheets.Add(After:=Worksheets(Worksheets.Count))
    nuevaHoja.Name = "DatosNuevos"

    ' Escribir algo en la nueva hoja
    nuevaHoja.Range("A1").Value = "Esta es una hoja nueva"
    nuevaHoja.Range("A1").Font.Bold = True
End Sub

Sub CrearMultiplesHojas()
    Dim i As Integer
    Dim hoja As Worksheet

    ' Crear 5 hojas nuevas
    For i = 1 To 5
        Set hoja = Worksheets.Add(After:=Worksheets(Worksheets.Count))
        hoja.Name = "Mes_" & i
        hoja.Range("A1").Value = "Mes " & i
        hoja.Tab.Color = RGB(100 + i * 20, 150, 200)  ' Color de pestaña
    Next i

    MsgBox "Se crearon 5 hojas nuevas", vbInformation
End Sub

Sub CrearHojaConPosicion()
    Dim hoja As Worksheet

    ' Crear al inicio
    Set hoja = Worksheets.Add(Before:=Worksheets(1))
    hoja.Name = "Primera"

    ' Crear después de una hoja específica
    Set hoja = Worksheets.Add(After:=Worksheets("Hoja1"))
    hoja.Name = "DespuesDeHoja1"
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 5.3: ELIMINAR HOJAS
'-------------------------------------------------------------------------------

Sub EliminarHoja()
    ' Desactivar alertas para evitar el mensaje de confirmación
    Application.DisplayAlerts = False

    ' Eliminar hoja por nombre
    If HojaExiste("DatosNuevos") Then
        Worksheets("DatosNuevos").Delete
        MsgBox "Hoja eliminada", vbInformation
    Else
        MsgBox "La hoja no existe", vbExclamation
    End If

    ' Reactivar alertas
    Application.DisplayAlerts = True
End Sub

' Función auxiliar: Verificar si una hoja existe
Function HojaExiste(nombreHoja As String) As Boolean
    Dim hoja As Worksheet

    HojaExiste = False

    For Each hoja In ThisWorkbook.Worksheets
        If hoja.Name = nombreHoja Then
            HojaExiste = True
            Exit Function
        End If
    Next hoja
End Function

Sub EliminarHojasConPatron()
    Dim hoja As Worksheet
    Dim i As Integer

    Application.DisplayAlerts = False

    ' Eliminar todas las hojas que empiecen con "Mes_"
    For i = Worksheets.Count To 1 Step -1  ' Iterar al revés
        If Left(Worksheets(i).Name, 4) = "Mes_" Then
            Worksheets(i).Delete
        End If
    Next i

    Application.DisplayAlerts = True
    MsgBox "Hojas eliminadas", vbInformation
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 5.4: COPIAR Y MOVER HOJAS
'-------------------------------------------------------------------------------

Sub CopiarHoja()
    Dim hojaOriginal As Worksheet
    Dim hojaCopiada As Worksheet

    Set hojaOriginal = Worksheets("Hoja1")

    ' Copiar después de la última hoja
    hojaOriginal.Copy After:=Worksheets(Worksheets.Count)

    ' La hoja copiada se convierte en la hoja activa
    Set hojaCopiada = ActiveSheet
    hojaCopiada.Name = "Copia_" & hojaOriginal.Name

    MsgBox "Hoja copiada: " & hojaCopiada.Name, vbInformation
End Sub

Sub MoverHoja()
    ' Mover una hoja al inicio
    If HojaExiste("Datos") Then
        Worksheets("Datos").Move Before:=Worksheets(1)
    End If

    ' Mover al final
    ' Worksheets("Datos").Move After:=Worksheets(Worksheets.Count)
End Sub

Sub CopiarHojaAOtroLibro()
    Dim libroOrigen As Workbook
    Dim libroDestino As Workbook

    Set libroOrigen = ThisWorkbook

    ' Crear nuevo libro
    Set libroDestino = Workbooks.Add

    ' Copiar hoja al nuevo libro
    libroOrigen.Worksheets("Hoja1").Copy Before:=libroDestino.Worksheets(1)

    MsgBox "Hoja copiada a nuevo libro", vbInformation
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 5.5: OCULTAR Y MOSTRAR HOJAS
'-------------------------------------------------------------------------------

Sub OcultarHoja()
    ' Ocultar normalmente (usuario puede des-ocultar)
    Worksheets("Hoja2").Visible = xlSheetHidden

    ' Ocultar completamente (solo VBA puede des-ocultar)
    Worksheets("Hoja3").Visible = xlSheetVeryHidden
End Sub

Sub MostrarHoja()
    Worksheets("Hoja2").Visible = xlSheetVisible
    Worksheets("Hoja3").Visible = xlSheetVisible
End Sub

Sub OcultarTodasMenosActiva()
    Dim hoja As Worksheet
    Dim hojaActiva As Worksheet

    Set hojaActiva = ActiveSheet

    For Each hoja In ThisWorkbook.Worksheets
        If hoja.Name <> hojaActiva.Name Then
            hoja.Visible = xlSheetHidden
        End If
    Next hoja

    MsgBox "Todas las hojas ocultas excepto: " & hojaActiva.Name
End Sub

Sub MostrarTodasLasHojas()
    Dim hoja As Worksheet

    For Each hoja In ThisWorkbook.Worksheets
        hoja.Visible = xlSheetVisible
    Next hoja

    MsgBox "Todas las hojas visibles", vbInformation
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 5.6: PROPIEDADES DE HOJAS
'-------------------------------------------------------------------------------

Sub PropiedadesHoja()
    Dim hoja As Worksheet
    Set hoja = ActiveSheet

    ' NOMBRE
    MsgBox "Nombre: " & hoja.Name

    ' ÍNDICE (posición)
    MsgBox "Índice: " & hoja.Index

    ' CODE NAME
    MsgBox "CodeName: " & hoja.CodeName

    ' RANGO USADO
    MsgBox "Rango usado: " & hoja.UsedRange.Address

    ' ÚLTIMA FILA CON DATOS
    Dim ultimaFila As Long
    ultimaFila = hoja.Cells(hoja.Rows.Count, 1).End(xlUp).Row
    MsgBox "Última fila: " & ultimaFila

    ' ÚLTIMA COLUMNA
    Dim ultimaColumna As Long
    ultimaColumna = hoja.Cells(1, hoja.Columns.Count).End(xlToLeft).Column
    MsgBox "Última columna: " & ultimaColumna

    ' COLOR DE PESTAÑA
    hoja.Tab.Color = RGB(255, 0, 0)  ' Rojo

    ' ESTADO DE PROTECCIÓN
    MsgBox "¿Protegida? " & hoja.ProtectContents
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 5.7: TRABAJAR CON MÚLTIPLES LIBROS
'-------------------------------------------------------------------------------

Sub AbrirLibro()
    Dim rutaArchivo As String
    Dim libro As Workbook

    ' Ruta del archivo a abrir
    rutaArchivo = "C:\MisDocumentos\datos.xlsx"

    ' Verificar si el archivo existe
    If Dir(rutaArchivo) <> "" Then
        Set libro = Workbooks.Open(rutaArchivo)
        MsgBox "Libro abierto: " & libro.Name
    Else
        MsgBox "El archivo no existe", vbExclamation
    End If
End Sub

Sub CrearNuevoLibro()
    Dim nuevoLibro As Workbook

    Set nuevoLibro = Workbooks.Add
    nuevoLibro.Worksheets(1).Range("A1").Value = "Nuevo Libro"

    MsgBox "Nuevo libro creado", vbInformation
End Sub

Sub CerrarLibro()
    Dim libro As Workbook

    ' Cerrar sin guardar
    Set libro = Workbooks("datos.xlsx")
    libro.Close SaveChanges:=False

    ' Cerrar guardando
    ' libro.Close SaveChanges:=True
End Sub

Sub GuardarLibro()
    ' Guardar el libro actual
    ThisWorkbook.Save

    ' Guardar con otro nombre (SaveAs)
    ' ThisWorkbook.SaveAs "C:\MisDocumentos\copia.xlsx"

    ' Guardar en formato específico
    ' ThisWorkbook.SaveAs "C:\MisDocumentos\datos.csv", FileFormat:=xlCSV
End Sub

Sub TrabajarConVariosLibros()
    Dim libroActual As Workbook
    Dim otroLibro As Workbook

    Set libroActual = ThisWorkbook
    Set otroLibro = Workbooks("OtroArchivo.xlsx")

    ' Copiar datos entre libros
    libroActual.Worksheets("Hoja1").Range("A1:C10").Copy _
        Destination:=otroLibro.Worksheets("Hoja1").Range("A1")

    MsgBox "Datos copiados entre libros", vbInformation
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 5.8: PROTECCIÓN DE HOJAS Y LIBROS
'-------------------------------------------------------------------------------

Sub ProtegerHoja()
    Dim hoja As Worksheet
    Set hoja = ActiveSheet

    ' Proteger con contraseña
    hoja.Protect Password:="miContraseña", _
                 DrawingObjects:=True, _
                 Contents:=True, _
                 Scenarios:=True

    MsgBox "Hoja protegida", vbInformation
End Sub

Sub DesprotegerHoja()
    Dim hoja As Worksheet
    Set hoja = ActiveSheet

    If hoja.ProtectContents Then
        hoja.Unprotect Password:="miContraseña"
        MsgBox "Hoja desprotegida", vbInformation
    Else
        MsgBox "La hoja no está protegida", vbExclamation
    End If
End Sub

Sub ProtegerHojaConExcepciones()
    Dim hoja As Worksheet
    Set hoja = ActiveSheet

    ' Desbloquear ciertas celdas ANTES de proteger
    Range("B2:B10").Locked = False

    ' Proteger la hoja
    hoja.Protect Password:="miContraseña"

    ' Ahora solo B2:B10 se puede editar
    MsgBox "Hoja protegida con excepciones en B2:B10", vbInformation
End Sub

Sub ProtegerLibro()
    ' Proteger estructura del libro (no se pueden agregar/eliminar hojas)
    ThisWorkbook.Protect Password:="miContraseña", Structure:=True

    MsgBox "Libro protegido", vbInformation
End Sub

Sub DesprotegerLibro()
    ThisWorkbook.Unprotect Password:="miContraseña"
    MsgBox "Libro desprotegido", vbInformation
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 5.9: IMPORTAR Y EXPORTAR DATOS
'-------------------------------------------------------------------------------

Sub ImportarDesdeCSV()
    Dim rutaCSV As String
    Dim hoja As Worksheet

    rutaCSV = "C:\MisDocumentos\datos.csv"

    ' Crear nueva hoja para importar
    Set hoja = Worksheets.Add
    hoja.Name = "DatosImportados"

    ' Abrir archivo de texto
    With hoja.QueryTables.Add(Connection:="TEXT;" & rutaCSV, _
                              Destination:=hoja.Range("A1"))
        .TextFileParseType = xlDelimited
        .TextFileCommaDelimiter = True
        .Refresh
    End With

    MsgBox "Datos CSV importados", vbInformation
End Sub

Sub ExportarACSV()
    Dim rutaCSV As String
    Dim hoja As Worksheet

    Set hoja = ActiveSheet
    rutaCSV = "C:\MisDocumentos\exportado.csv"

    ' Copiar la hoja a un nuevo libro
    hoja.Copy

    ' Guardar como CSV
    ActiveWorkbook.SaveAs Filename:=rutaCSV, FileFormat:=xlCSV
    ActiveWorkbook.Close SaveChanges:=False

    MsgBox "Datos exportados a CSV", vbInformation
End Sub

Sub ExportarRangoATexto()
    Dim rutaTXT As String
    Dim fso As Object
    Dim archivo As Object
    Dim celda As Range
    Dim linea As String

    rutaTXT = "C:\MisDocumentos\datos.txt"

    ' Crear objeto FileSystemObject
    Set fso = CreateObject("Scripting.FileSystemObject")
    Set archivo = fso.CreateTextFile(rutaTXT, True)

    ' Escribir datos
    For Each celda In Range("A1:A10")
        archivo.WriteLine celda.Value
    Next celda

    archivo.Close

    MsgBox "Datos exportados a TXT", vbInformation
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 5.10: EJEMPLO PRÁCTICO - CONSOLIDAR DATOS DE MÚLTIPLES HOJAS
'-------------------------------------------------------------------------------

Sub ConsolidarDatosDeHojas()
    Dim hoja As Worksheet
    Dim hojaResumen As Worksheet
    Dim ultimaFila As Long
    Dim filaDestino As Long

    ' Crear hoja resumen
    On Error Resume Next
    Application.DisplayAlerts = False
    Worksheets("Resumen").Delete
    Application.DisplayAlerts = True
    On Error GoTo 0

    Set hojaResumen = Worksheets.Add
    hojaResumen.Name = "Resumen"

    ' Encabezados
    hojaResumen.Range("A1:D1").Value = Array("Hoja Origen", "Producto", "Cantidad", "Precio")
    hojaResumen.Range("A1:D1").Font.Bold = True

    filaDestino = 2

    ' Iterar todas las hojas excepto Resumen
    For Each hoja In ThisWorkbook.Worksheets
        If hoja.Name <> "Resumen" Then
            ' Encontrar última fila con datos
            ultimaFila = hoja.Cells(hoja.Rows.Count, 1).End(xlUp).Row

            If ultimaFila > 1 Then  ' Si hay datos más allá del encabezado
                ' Copiar datos
                hoja.Range("A2:C" & ultimaFila).Copy _
                    Destination:=hojaResumen.Range("B" & filaDestino)

                ' Agregar nombre de hoja origen
                hojaResumen.Range("A" & filaDestino & ":A" & filaDestino + ultimaFila - 2).Value = hoja.Name

                filaDestino = filaDestino + ultimaFila - 1
            End If
        End If
    Next hoja

    ' Formato
    hojaResumen.Columns("A:D").AutoFit
    hojaResumen.Range("A1:D" & filaDestino - 1).Borders.LineStyle = xlContinuous

    MsgBox "Datos consolidados en hoja Resumen", vbInformation
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 5.11: EJEMPLO PRÁCTICO - CREAR ÍNDICE DE HOJAS
'-------------------------------------------------------------------------------

Sub CrearIndiceHojas()
    Dim hojaIndice As Worksheet
    Dim hoja As Worksheet
    Dim fila As Integer

    ' Crear hoja de índice
    On Error Resume Next
    Application.DisplayAlerts = False
    Worksheets("Índice").Delete
    Application.DisplayAlerts = True
    On Error GoTo 0

    Set hojaIndice = Worksheets.Add(Before:=Worksheets(1))
    hojaIndice.Name = "Índice"

    ' Título
    hojaIndice.Range("A1").Value = "ÍNDICE DE HOJAS"
    hojaIndice.Range("A1").Font.Size = 16
    hojaIndice.Range("A1").Font.Bold = True

    ' Encabezados
    hojaIndice.Range("A3:C3").Value = Array("Nº", "Nombre de Hoja", "Registros")
    hojaIndice.Range("A3:C3").Font.Bold = True
    hojaIndice.Range("A3:C3").Interior.Color = RGB(200, 200, 200)

    fila = 4

    ' Listar todas las hojas
    For Each hoja In ThisWorkbook.Worksheets
        If hoja.Name <> "Índice" Then
            hojaIndice.Cells(fila, 1).Value = hoja.Index
            hojaIndice.Cells(fila, 2).Value = hoja.Name

            ' Crear hipervínculo
            hojaIndice.Hyperlinks.Add Anchor:=hojaIndice.Cells(fila, 2), _
                                      Address:="", _
                                      SubAddress:="'" & hoja.Name & "'!A1", _
                                      TextToDisplay:=hoja.Name

            ' Contar registros (filas con datos)
            Dim ultimaFila As Long
            ultimaFila = hoja.Cells(hoja.Rows.Count, 1).End(xlUp).Row
            If ultimaFila > 1 Then
                hojaIndice.Cells(fila, 3).Value = ultimaFila - 1
            Else
                hojaIndice.Cells(fila, 3).Value = 0
            End If

            ' Color de pestaña
            hojaIndice.Cells(fila, 4).Interior.Color = hoja.Tab.Color

            fila = fila + 1
        End If
    Next hoja

    ' Formato
    hojaIndice.Range("A3:C" & fila - 1).Borders.LineStyle = xlContinuous
    hojaIndice.Columns("A:D").AutoFit

    ' Resumen
    hojaIndice.Range("A" & fila + 1).Value = "Total de hojas:"
    hojaIndice.Range("B" & fila + 1).Value = ThisWorkbook.Worksheets.Count - 1
    hojaIndice.Range("A" & fila + 1 & ":B" & fila + 1).Font.Bold = True

    hojaIndice.Activate
    MsgBox "Índice de hojas creado con hipervínculos", vbInformation
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 5.12: EJEMPLO PRÁCTICO - BACKUP AUTOMÁTICO
'-------------------------------------------------------------------------------

Sub CrearBackup()
    Dim rutaBackup As String
    Dim nombreArchivo As String
    Dim fecha As String

    ' Crear nombre con fecha y hora
    fecha = Format(Now, "yyyy-mm-dd_hh-nn-ss")
    nombreArchivo = "Backup_" & fecha & ".xlsx"

    ' Ruta donde guardar (mismo directorio del libro actual)
    rutaBackup = ThisWorkbook.Path & "\Backups\"

    ' Crear carpeta si no existe
    If Dir(rutaBackup, vbDirectory) = "" Then
        MkDir rutaBackup
    End If

    ' Guardar copia
    ThisWorkbook.SaveCopyAs rutaBackup & nombreArchivo

    MsgBox "Backup creado:" & vbCrLf & nombreArchivo, vbInformation
End Sub

'===============================================================================
' RESUMEN DEL MÓDULO 5
'===============================================================================
' ✓ Sabes referenciar hojas de diferentes formas
' ✓ Puedes crear, eliminar, copiar y mover hojas
' ✓ Conoces cómo ocultar y mostrar hojas
' ✓ Entiendes las propiedades de las hojas
' ✓ Puedes trabajar con múltiples libros
' ✓ Sabes proteger y desproteger hojas y libros
' ✓ Puedes importar y exportar datos (CSV, TXT)
' ✓ Creaste ejemplos prácticos (consolidar datos, índice, backup)
'
' SIGUIENTE PASO: Módulo 6 - Formularios de Usuario (UserForms)
'===============================================================================
