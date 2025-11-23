Attribute VB_Name = "Modulo_06_UserForms"
'===============================================================================
' MÓDULO 6: FORMULARIOS DE USUARIO (USERFORMS)
'===============================================================================
' Este módulo cubre la creación y uso de UserForms en VBA
' Incluye: controles, eventos, validación, formularios interactivos
'
' NOTA: Este archivo contiene el código VBA para los UserForms.
' Los formularios se crean desde el Editor VBA (Insert > UserForm)
'===============================================================================

'-------------------------------------------------------------------------------
' SECCIÓN 6.1: INTRODUCCIÓN A USERFORMS
'-------------------------------------------------------------------------------

' CÓMO CREAR UN USERFORM:
' 1. Abre el Editor VBA (Alt + F11)
' 2. Ve a Insert > UserForm
' 3. Usa la Toolbox para agregar controles (TextBox, Label, Button, etc.)
' 4. Haz doble clic en el formulario o controles para escribir código de eventos

' MOSTRAR UN USERFORM
Sub MostrarFormulario()
    ' Para mostrar un UserForm llamado "UserForm1"
    UserForm1.Show
    ' .Show vbModal - El usuario debe cerrar el form antes de continuar
    ' .Show vbModeless - Permite trabajar en Excel mientras el form está abierto
End Sub

' OCULTAR UN USERFORM (desde dentro del UserForm)
' Private Sub btnCerrar_Click()
'     Unload Me  ' Cierra y descarga el formulario
'     ' Me.Hide   ' Solo oculta el formulario (permanece en memoria)
' End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 6.2: CONTROLES PRINCIPALES
'-------------------------------------------------------------------------------

' LABEL (etiqueta) - Mostrar texto estático
' Propiedades importantes:
'   .Caption = "Texto a mostrar"
'   .Font.Size = 12
'   .ForeColor = RGB(255, 0, 0)

' TEXTBOX (caja de texto) - Entrada de datos
' Propiedades:
'   .Value = "texto"
'   .Text = "texto"
'   .MaxLength = 50
'   .PasswordChar = "*"  ' Para contraseñas

' COMMANDBUTTON (botón)
' Evento principal: Click
' Private Sub btnAceptar_Click()
'     ' Código al hacer clic
' End Sub

' COMBOBOX (lista desplegable)
'   .AddItem "Opción 1"
'   .ListIndex  ' Índice seleccionado
'   .Value  ' Valor seleccionado

' LISTBOX (lista)
'   .AddItem "Item"
'   .MultiSelect = fmMultiSelectMulti  ' Selección múltiple

' CHECKBOX (casilla de verificación)
'   .Value = True/False

' OPTIONBUTTON (botón de opción)
'   Usar FRAME para agrupar opciones

' SPINBUTTON y SCROLLBAR
'   .Min, .Max, .Value

'-------------------------------------------------------------------------------
' SECCIÓN 6.3: EJEMPLO 1 - FORMULARIO SIMPLE DE REGISTRO
'-------------------------------------------------------------------------------

' DISEÑO DEL USERFORM "frmRegistro":
' - Label: "Nombre:"
' - TextBox: txtNombre
' - Label: "Edad:"
' - TextBox: txtEdad
' - Label: "Email:"
' - TextBox: txtEmail
' - CommandButton: btnGuardar
' - CommandButton: btnCancelar

' Código del UserForm frmRegistro:
' ============================================

' Private Sub UserForm_Initialize()
'     ' Este evento se ejecuta al cargar el formulario
'     Me.Caption = "Registro de Usuario"
'     txtNombre.Value = ""
'     txtEdad.Value = ""
'     txtEmail.Value = ""
'     txtNombre.SetFocus  ' Poner cursor en nombre
' End Sub

' Private Sub btnGuardar_Click()
'     ' Validar que no estén vacíos
'     If txtNombre.Value = "" Then
'         MsgBox "Por favor ingresa tu nombre", vbExclamation
'         txtNombre.SetFocus
'         Exit Sub
'     End If
'
'     If txtEdad.Value = "" Or Not IsNumeric(txtEdad.Value) Then
'         MsgBox "Por favor ingresa una edad válida", vbExclamation
'         txtEdad.SetFocus
'         Exit Sub
'     End If
'
'     If InStr(txtEmail.Value, "@") = 0 Then
'         MsgBox "Por favor ingresa un email válido", vbExclamation
'         txtEmail.SetFocus
'         Exit Sub
'     End If
'
'     ' Guardar en Excel
'     Dim ultimaFila As Long
'     ultimaFila = Worksheets("Datos").Cells(Rows.Count, 1).End(xlUp).Row + 1
'
'     With Worksheets("Datos")
'         .Cells(ultimaFila, 1).Value = txtNombre.Value
'         .Cells(ultimaFila, 2).Value = txtEdad.Value
'         .Cells(ultimaFila, 3).Value = txtEmail.Value
'     End With
'
'     MsgBox "Registro guardado exitosamente", vbInformation
'
'     ' Limpiar formulario
'     txtNombre.Value = ""
'     txtEdad.Value = ""
'     txtEmail.Value = ""
'     txtNombre.SetFocus
' End Sub

' Private Sub btnCancelar_Click()
'     Unload Me
' End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 6.4: EJEMPLO 2 - FORMULARIO CON COMBOBOX
'-------------------------------------------------------------------------------

' DISEÑO "frmProducto":
' - Label: "Producto:"
' - TextBox: txtProducto
' - Label: "Categoría:"
' - ComboBox: cboCategoria
' - Label: "Precio:"
' - TextBox: txtPrecio
' - CommandButton: btnAgregar

' Private Sub UserForm_Initialize()
'     ' Llenar el ComboBox
'     cboCategoria.Clear
'     cboCategoria.AddItem "Electrónica"
'     cboCategoria.AddItem "Ropa"
'     cboCategoria.AddItem "Alimentos"
'     cboCategoria.AddItem "Libros"
'     cboCategoria.AddItem "Juguetes"
'
'     ' Seleccionar primer item por defecto
'     cboCategoria.ListIndex = 0
' End Sub

' Private Sub btnAgregar_Click()
'     Dim ultimaFila As Long
'
'     ' Validaciones
'     If txtProducto.Value = "" Then
'         MsgBox "Ingresa el nombre del producto", vbExclamation
'         Exit Sub
'     End If
'
'     If Not IsNumeric(txtPrecio.Value) Then
'         MsgBox "Ingresa un precio válido", vbExclamation
'         Exit Sub
'     End If
'
'     ' Guardar
'     ultimaFila = Worksheets("Productos").Cells(Rows.Count, 1).End(xlUp).Row + 1
'
'     With Worksheets("Productos")
'         .Cells(ultimaFila, 1).Value = txtProducto.Value
'         .Cells(ultimaFila, 2).Value = cboCategoria.Value
'         .Cells(ultimaFila, 3).Value = CDbl(txtPrecio.Value)
'         .Cells(ultimaFila, 3).NumberFormat = "$#,##0.00"
'     End With
'
'     MsgBox "Producto agregado", vbInformation
'
'     ' Limpiar
'     txtProducto.Value = ""
'     txtPrecio.Value = ""
'     cboCategoria.ListIndex = 0
' End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 6.5: EJEMPLO 3 - FORMULARIO DE BÚSQUEDA
'-------------------------------------------------------------------------------

' DISEÑO "frmBusqueda":
' - Label: "Buscar:"
' - TextBox: txtBuscar
' - CommandButton: btnBuscar
' - ListBox: lstResultados

' Private Sub btnBuscar_Click()
'     Dim hoja As Worksheet
'     Dim ultimaFila As Long
'     Dim i As Long
'     Dim textoBuscar As String
'
'     Set hoja = Worksheets("Datos")
'     textoBuscar = LCase(txtBuscar.Value)
'
'     ' Limpiar resultados anteriores
'     lstResultados.Clear
'
'     If textoBuscar = "" Then
'         MsgBox "Ingresa un texto para buscar", vbExclamation
'         Exit Sub
'     End If
'
'     ultimaFila = hoja.Cells(Rows.Count, 1).End(xlUp).Row
'
'     ' Buscar en columna A
'     For i = 2 To ultimaFila
'         If InStr(LCase(hoja.Cells(i, 1).Value), textoBuscar) > 0 Then
'             lstResultados.AddItem hoja.Cells(i, 1).Value & " - " & _
'                                   hoja.Cells(i, 2).Value
'         End If
'     Next i
'
'     If lstResultados.ListCount = 0 Then
'         MsgBox "No se encontraron resultados", vbInformation
'     Else
'         MsgBox "Se encontraron " & lstResultados.ListCount & " resultados", vbInformation
'     End If
' End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 6.6: VALIDACIÓN EN TIEMPO REAL
'-------------------------------------------------------------------------------

' Validar solo números en TextBox
' Private Sub txtEdad_KeyPress(ByVal KeyAscii As MSForms.ReturnInteger)
'     ' Solo permitir números y tecla de retroceso
'     If KeyAscii < 48 Or KeyAscii > 57 Then
'         If KeyAscii <> 8 Then  ' 8 = Backspace
'             KeyAscii = 0  ' Cancelar la tecla
'             Beep
'         End If
'     End If
' End Sub

' Convertir a mayúsculas automáticamente
' Private Sub txtNombre_Change()
'     txtNombre.Value = UCase(txtNombre.Value)
' End Sub

' Limitar longitud de texto
' Private Sub txtTelefono_Change()
'     If Len(txtTelefono.Value) > 10 Then
'         txtTelefono.Value = Left(txtTelefono.Value, 10)
'     End If
' End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 6.7: EJEMPLO 4 - FORMULARIO CON CHECKBOX Y OPTIONBUTTON
'-------------------------------------------------------------------------------

' DISEÑO "frmEncuesta":
' - Frame: "¿Qué te gusta?"
'   - CheckBox: chkDeportes
'   - CheckBox: chkMusica
'   - CheckBox: chkLectura
' - Frame: "Género"
'   - OptionButton: optMasculino
'   - OptionButton: optFemenino
'   - OptionButton: optOtro
' - CommandButton: btnEnviar

' Private Sub UserForm_Initialize()
'     Me.Caption = "Encuesta"
'
'     ' Configurar CheckBoxes
'     chkDeportes.Caption = "Deportes"
'     chkMusica.Caption = "Música"
'     chkLectura.Caption = "Lectura"
'
'     ' Configurar OptionButtons
'     optMasculino.Caption = "Masculino"
'     optFemenino.Caption = "Femenino"
'     optOtro.Caption = "Otro"
'
'     ' Seleccionar opción por defecto
'     optMasculino.Value = True
' End Sub

' Private Sub btnEnviar_Click()
'     Dim gustos As String
'     Dim genero As String
'
'     ' Recopilar checkboxes seleccionados
'     gustos = ""
'     If chkDeportes.Value Then gustos = gustos & "Deportes, "
'     If chkMusica.Value Then gustos = gustos & "Música, "
'     If chkLectura.Value Then gustos = gustos & "Lectura, "
'
'     ' Quitar última coma
'     If Len(gustos) > 0 Then
'         gustos = Left(gustos, Len(gustos) - 2)
'     Else
'         gustos = "Ninguno"
'     End If
'
'     ' Obtener género seleccionado
'     If optMasculino.Value Then
'         genero = "Masculino"
'     ElseIf optFemenino.Value Then
'         genero = "Femenino"
'     Else
'         genero = "Otro"
'     End If
'
'     ' Mostrar resultado
'     MsgBox "Gustos: " & gustos & vbCrLf & "Género: " & genero, vbInformation
'
'     ' Guardar en Excel
'     Dim ultimaFila As Long
'     ultimaFila = Worksheets("Encuestas").Cells(Rows.Count, 1).End(xlUp).Row + 1
'
'     With Worksheets("Encuestas")
'         .Cells(ultimaFila, 1).Value = gustos
'         .Cells(ultimaFila, 2).Value = genero
'         .Cells(ultimaFila, 3).Value = Now  ' Fecha y hora
'     End With
' End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 6.8: EJEMPLO 5 - FORMULARIO CON SPINNER Y SCROLLBAR
'-------------------------------------------------------------------------------

' DISEÑO "frmCalificacion":
' - Label: lblCantidad
' - SpinButton: spnCantidad
' - Label: lblVolumen
' - ScrollBar: scbVolumen
' - CommandButton: btnOK

' Private Sub UserForm_Initialize()
'     ' Configurar SpinButton
'     With spnCantidad
'         .Min = 0
'         .Max = 100
'         .Value = 10
'     End With
'     lblCantidad.Caption = "Cantidad: " & spnCantidad.Value
'
'     ' Configurar ScrollBar
'     With scbVolumen
'         .Min = 0
'         .Max = 100
'         .Value = 50
'     End With
'     lblVolumen.Caption = "Volumen: " & scbVolumen.Value & "%"
' End Sub

' Private Sub spnCantidad_Change()
'     lblCantidad.Caption = "Cantidad: " & spnCantidad.Value
' End Sub

' Private Sub scbVolumen_Change()
'     lblVolumen.Caption = "Volumen: " & scbVolumen.Value & "%"
' End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 6.9: CARGAR DATOS DE EXCEL A USERFORM
'-------------------------------------------------------------------------------

' EJEMPLO: Cargar datos en un ComboBox desde Excel
' Private Sub UserForm_Initialize()
'     Dim hoja As Worksheet
'     Dim ultimaFila As Long
'     Dim i As Long
'
'     Set hoja = Worksheets("Clientes")
'     ultimaFila = hoja.Cells(Rows.Count, 1).End(xlUp).Row
'
'     ' Limpiar ComboBox
'     cboClientes.Clear
'
'     ' Cargar nombres de clientes
'     For i = 2 To ultimaFila  ' Asumiendo que fila 1 es encabezado
'         cboClientes.AddItem hoja.Cells(i, 1).Value
'     Next i
' End Sub

' EJEMPLO: Llenar TextBoxes con datos de una fila
' Private Sub cboClientes_Click()
'     Dim hoja As Worksheet
'     Dim ultimaFila As Long
'     Dim i As Long
'     Dim nombreSeleccionado As String
'
'     Set hoja = Worksheets("Clientes")
'     nombreSeleccionado = cboClientes.Value
'     ultimaFila = hoja.Cells(Rows.Count, 1).End(xlUp).Row
'
'     ' Buscar el cliente seleccionado
'     For i = 2 To ultimaFila
'         If hoja.Cells(i, 1).Value = nombreSeleccionado Then
'             txtNombre.Value = hoja.Cells(i, 1).Value
'             txtTelefono.Value = hoja.Cells(i, 2).Value
'             txtEmail.Value = hoja.Cells(i, 3).Value
'             Exit For
'         End If
'     Next i
' End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 6.10: EJEMPLO COMPLETO - SISTEMA CRUD (Crear, Leer, Actualizar, Eliminar)
'-------------------------------------------------------------------------------

' Este es un ejemplo de código para un formulario CRUD completo
' DISEÑO "frmCRUD":
' - TextBox: txtID (ReadOnly = True)
' - TextBox: txtNombre
' - TextBox: txtEmail
' - TextBox: txtTelefono
' - CommandButton: btnNuevo
' - CommandButton: btnGuardar
' - CommandButton: btnActualizar
' - CommandButton: btnEliminar
' - CommandButton: btnBuscar
' - ListBox: lstRegistros

' Private Sub UserForm_Initialize()
'     CargarRegistros
'     LimpiarFormulario
'     txtID.Locked = True
'     txtID.BackColor = RGB(230, 230, 230)
' End Sub

' Private Sub CargarRegistros()
'     Dim hoja As Worksheet
'     Dim ultimaFila As Long
'     Dim i As Long
'
'     Set hoja = Worksheets("Clientes")
'     ultimaFila = hoja.Cells(Rows.Count, 1).End(xlUp).Row
'
'     lstRegistros.Clear
'     lstRegistros.ColumnCount = 4
'     lstRegistros.ColumnWidths = "30;100;150;100"
'
'     For i = 2 To ultimaFila
'         lstRegistros.AddItem
'         lstRegistros.List(lstRegistros.ListCount - 1, 0) = hoja.Cells(i, 1).Value  ' ID
'         lstRegistros.List(lstRegistros.ListCount - 1, 1) = hoja.Cells(i, 2).Value  ' Nombre
'         lstRegistros.List(lstRegistros.ListCount - 1, 2) = hoja.Cells(i, 3).Value  ' Email
'         lstRegistros.List(lstRegistros.ListCount - 1, 3) = hoja.Cells(i, 4).Value  ' Teléfono
'     Next i
' End Sub

' Private Sub LimpiarFormulario()
'     txtID.Value = ""
'     txtNombre.Value = ""
'     txtEmail.Value = ""
'     txtTelefono.Value = ""
'     txtNombre.SetFocus
' End Sub

' Private Sub btnNuevo_Click()
'     LimpiarFormulario
' End Sub

' Private Sub btnGuardar_Click()
'     Dim hoja As Worksheet
'     Dim ultimaFila As Long
'
'     ' Validar
'     If txtNombre.Value = "" Then
'         MsgBox "Ingresa el nombre", vbExclamation
'         Exit Sub
'     End If
'
'     Set hoja = Worksheets("Clientes")
'     ultimaFila = hoja.Cells(Rows.Count, 1).End(xlUp).Row + 1
'
'     ' Guardar
'     hoja.Cells(ultimaFila, 1).Value = ultimaFila - 1  ' ID auto-incremental
'     hoja.Cells(ultimaFila, 2).Value = txtNombre.Value
'     hoja.Cells(ultimaFila, 3).Value = txtEmail.Value
'     hoja.Cells(ultimaFila, 4).Value = txtTelefono.Value
'
'     MsgBox "Registro guardado", vbInformation
'     CargarRegistros
'     LimpiarFormulario
' End Sub

' Private Sub lstRegistros_Click()
'     ' Cargar datos del registro seleccionado
'     If lstRegistros.ListIndex >= 0 Then
'         txtID.Value = lstRegistros.List(lstRegistros.ListIndex, 0)
'         txtNombre.Value = lstRegistros.List(lstRegistros.ListIndex, 1)
'         txtEmail.Value = lstRegistros.List(lstRegistros.ListIndex, 2)
'         txtTelefono.Value = lstRegistros.List(lstRegistros.ListIndex, 3)
'     End If
' End Sub

' Private Sub btnActualizar_Click()
'     Dim hoja As Worksheet
'     Dim ultimaFila As Long
'     Dim i As Long
'     Dim idBuscar As String
'
'     If txtID.Value = "" Then
'         MsgBox "Selecciona un registro de la lista", vbExclamation
'         Exit Sub
'     End If
'
'     Set hoja = Worksheets("Clientes")
'     ultimaFila = hoja.Cells(Rows.Count, 1).End(xlUp).Row
'     idBuscar = txtID.Value
'
'     ' Buscar y actualizar
'     For i = 2 To ultimaFila
'         If hoja.Cells(i, 1).Value = idBuscar Then
'             hoja.Cells(i, 2).Value = txtNombre.Value
'             hoja.Cells(i, 3).Value = txtEmail.Value
'             hoja.Cells(i, 4).Value = txtTelefono.Value
'             MsgBox "Registro actualizado", vbInformation
'             CargarRegistros
'             LimpiarFormulario
'             Exit For
'         End If
'     Next i
' End Sub

' Private Sub btnEliminar_Click()
'     Dim hoja As Worksheet
'     Dim ultimaFila As Long
'     Dim i As Long
'     Dim idBuscar As String
'     Dim respuesta As VbMsgBoxResult
'
'     If txtID.Value = "" Then
'         MsgBox "Selecciona un registro de la lista", vbExclamation
'         Exit Sub
'     End If
'
'     respuesta = MsgBox("¿Estás seguro de eliminar este registro?", vbYesNo + vbQuestion)
'
'     If respuesta = vbNo Then Exit Sub
'
'     Set hoja = Worksheets("Clientes")
'     ultimaFila = hoja.Cells(Rows.Count, 1).End(xlUp).Row
'     idBuscar = txtID.Value
'
'     ' Buscar y eliminar
'     For i = 2 To ultimaFila
'         If hoja.Cells(i, 1).Value = idBuscar Then
'             hoja.Rows(i).Delete
'             MsgBox "Registro eliminado", vbInformation
'             CargarRegistros
'             LimpiarFormulario
'             Exit For
'         End If
'     Next i
' End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 6.11: TIPS Y MEJORES PRÁCTICAS
'-------------------------------------------------------------------------------

' 1. INICIALIZACIÓN:
'    - Usa UserForm_Initialize para configurar el formulario
'    - Establece valores por defecto
'    - Carga datos iniciales

' 2. VALIDACIÓN:
'    - Siempre valida los datos antes de guardar
'    - Usa eventos KeyPress para validación en tiempo real
'    - Muestra mensajes claros de error

' 3. NAVEGACIÓN:
'    - Usa TabIndex para controlar el orden de tabulación
'    - SetFocus para poner el cursor donde lo necesites

' 4. DISEÑO:
'    - Usa etiquetas descriptivas
'    - Agrupa controles relacionados con Frame
'    - Mantén un diseño consistente y limpio

' 5. RENDIMIENTO:
'    - Usa Screen.Updating = False al procesar muchos datos
'    - Descarga formularios (Unload) cuando no los necesites

' 6. ERRORES:
'    - Implementa manejo de errores (On Error)
'    - Valida que las hojas existan antes de usarlas

'===============================================================================
' RESUMEN DEL MÓDULO 6
'===============================================================================
' ✓ Comprendes qué son los UserForms y cómo crearlos
' ✓ Conoces los controles principales (TextBox, ComboBox, ListBox, etc.)
' ✓ Sabes manejar eventos de controles
' ✓ Puedes validar datos en formularios
' ✓ Entiendes cómo cargar y guardar datos desde/hacia Excel
' ✓ Puedes crear formularios CRUD completos
' ✓ Conoces las mejores prácticas para UserForms
'
' SIGUIENTE PASO: Módulo 7 - Nivel Avanzado (Arrays, Diccionarios, RegEx)
'===============================================================================
