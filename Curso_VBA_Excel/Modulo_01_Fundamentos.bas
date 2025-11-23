Attribute VB_Name = "Modulo_01_Fundamentos"
'===============================================================================
' MÓDULO 1: FUNDAMENTOS DE VBA
'===============================================================================
' Este módulo cubre los conceptos básicos de VBA para Excel
' Incluye: variables, tipos de datos, operadores, mensajes y comentarios
'===============================================================================

'-------------------------------------------------------------------------------
' SECCIÓN 1.1: TU PRIMER MACRO
'-------------------------------------------------------------------------------

' Este es el macro más simple posible
' Para ejecutarlo: presiona F5 o haz clic en el botón Run
Sub MiPrimerMacro()
    ' MsgBox muestra un mensaje en pantalla
    MsgBox "¡Hola! Este es mi primer macro en VBA"
End Sub

' Macro que escribe en una celda
Sub EscribirEnCelda()
    ' Range representa una celda o grupo de celdas
    ' Aquí escribimos "Hola Mundo" en la celda A1
    Range("A1").Value = "Hola Mundo"

    ' También podemos escribir en otras celdas
    Range("B1").Value = "¡VBA es genial!"
    Range("C1").Value = 123
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 1.2: COMENTARIOS EN VBA
'-------------------------------------------------------------------------------

Sub EjemplosDeComentarios()
    ' Los comentarios comienzan con un apóstrofe (')
    ' El código en esta línea NO se ejecuta

    MsgBox "Este mensaje sí se ejecuta" ' Comentario al final de línea

    ' Puedes usar comentarios para:
    ' 1. Explicar qué hace tu código
    ' 2. Desactivar temporalmente líneas de código
    ' 3. Organizar secciones de tu programa
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 1.3: VARIABLES Y TIPOS DE DATOS
'-------------------------------------------------------------------------------

Sub Variables_TiposBasicos()
    ' IMPORTANTE: Option Explicit obliga a declarar todas las variables
    ' (Es una buena práctica ponerlo al inicio del módulo)

    ' DECLARACIÓN DE VARIABLES
    ' Sintaxis: Dim NombreVariable As TipoDato

    ' STRING (cadena de texto)
    Dim nombre As String
    nombre = "Juan Pérez"
    MsgBox "Nombre: " & nombre

    ' INTEGER (número entero de -32,768 a 32,767)
    Dim edad As Integer
    edad = 25
    MsgBox "Edad: " & edad

    ' LONG (número entero más grande: -2,147,483,648 a 2,147,483,647)
    Dim poblacion As Long
    poblacion = 1500000
    MsgBox "Población: " & poblacion

    ' DOUBLE (número decimal)
    Dim precio As Double
    precio = 99.99
    MsgBox "Precio: $" & precio

    ' BOOLEAN (Verdadero o Falso)
    Dim estaActivo As Boolean
    estaActivo = True
    MsgBox "¿Está activo? " & estaActivo

    ' DATE (fechas y horas)
    Dim fechaNacimiento As Date
    fechaNacimiento = #1/15/1990#  ' Formato: #MM/DD/YYYY#
    MsgBox "Fecha de nacimiento: " & fechaNacimiento
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 1.4: OPERADORES ARITMÉTICOS
'-------------------------------------------------------------------------------

Sub OperadoresAritmeticos()
    Dim num1 As Double
    Dim num2 As Double
    Dim resultado As Double

    num1 = 10
    num2 = 3

    ' SUMA (+)
    resultado = num1 + num2  ' = 13
    MsgBox "Suma: " & num1 & " + " & num2 & " = " & resultado

    ' RESTA (-)
    resultado = num1 - num2  ' = 7
    MsgBox "Resta: " & num1 & " - " & num2 & " = " & resultado

    ' MULTIPLICACIÓN (*)
    resultado = num1 * num2  ' = 30
    MsgBox "Multiplicación: " & num1 & " * " & num2 & " = " & resultado

    ' DIVISIÓN (/)
    resultado = num1 / num2  ' = 3.333...
    MsgBox "División: " & num1 & " / " & num2 & " = " & resultado

    ' DIVISIÓN ENTERA (\) - devuelve solo la parte entera
    resultado = num1 \ num2  ' = 3
    MsgBox "División entera: " & num1 & " \ " & num2 & " = " & resultado

    ' MÓDULO (Mod) - devuelve el residuo de la división
    resultado = num1 Mod num2  ' = 1 (10/3 = 3 con residuo 1)
    MsgBox "Módulo: " & num1 & " Mod " & num2 & " = " & resultado

    ' EXPONENCIACIÓN (^)
    resultado = num1 ^ 2  ' = 100 (10 al cuadrado)
    MsgBox "Exponenciación: " & num1 & " ^ 2 = " & resultado
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 1.5: OPERADORES DE COMPARACIÓN
'-------------------------------------------------------------------------------

Sub OperadoresComparacion()
    Dim a As Integer
    Dim b As Integer
    Dim resultado As Boolean

    a = 10
    b = 5

    ' IGUAL A (=)
    resultado = (a = b)  ' False
    MsgBox a & " = " & b & " es " & resultado

    ' DIFERENTE DE (<>)
    resultado = (a <> b)  ' True
    MsgBox a & " <> " & b & " es " & resultado

    ' MAYOR QUE (>)
    resultado = (a > b)  ' True
    MsgBox a & " > " & b & " es " & resultado

    ' MENOR QUE (<)
    resultado = (a < b)  ' False
    MsgBox a & " < " & b & " es " & resultado

    ' MAYOR O IGUAL QUE (>=)
    resultado = (a >= b)  ' True
    MsgBox a & " >= " & b & " es " & resultado

    ' MENOR O IGUAL QUE (<=)
    resultado = (a <= b)  ' False
    MsgBox a & " <= " & b & " es " & resultado
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 1.6: OPERADORES LÓGICOS
'-------------------------------------------------------------------------------

Sub OperadoresLogicos()
    Dim edad As Integer
    Dim tieneLicencia As Boolean
    Dim resultado As Boolean

    edad = 20
    tieneLicencia = True

    ' AND (Y lógico) - Ambas condiciones deben ser verdaderas
    resultado = (edad >= 18 And tieneLicencia = True)
    MsgBox "¿Puede conducir? (edad>=18 AND tiene licencia): " & resultado

    ' OR (O lógico) - Al menos una condición debe ser verdadera
    resultado = (edad < 18 Or tieneLicencia = False)
    MsgBox "¿Tiene restricciones? (edad<18 OR sin licencia): " & resultado

    ' NOT (Negación) - Invierte el valor booleano
    resultado = Not (edad < 18)
    MsgBox "¿Es mayor de edad? NOT(edad<18): " & resultado
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 1.7: CONCATENACIÓN DE STRINGS
'-------------------------------------------------------------------------------

Sub ConcatenacionStrings()
    Dim nombre As String
    Dim apellido As String
    Dim nombreCompleto As String
    Dim edad As Integer
    Dim mensaje As String

    nombre = "María"
    apellido = "García"
    edad = 30

    ' CONCATENAR con & (recomendado)
    nombreCompleto = nombre & " " & apellido
    MsgBox "Nombre completo: " & nombreCompleto

    ' CONCATENAR strings con números
    mensaje = nombre & " tiene " & edad & " años"
    MsgBox mensaje

    ' También puedes usar + pero & es más seguro
    mensaje = "Hola " & nombre & ", ¿cómo estás?"
    MsgBox mensaje
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 1.8: CONSTANTES
'-------------------------------------------------------------------------------

Sub UsandoConstantes()
    ' Las constantes son valores que NO cambian durante la ejecución
    ' Se declaran con Const en lugar de Dim

    Const IVA As Double = 0.16  ' 16% de IVA
    Const EMPRESA As String = "Mi Empresa S.A."
    Const PI As Double = 3.14159265358979

    Dim subtotal As Double
    Dim total As Double

    subtotal = 1000
    total = subtotal * (1 + IVA)

    MsgBox "Empresa: " & EMPRESA & vbCrLf & _
           "Subtotal: $" & subtotal & vbCrLf & _
           "IVA (" & IVA * 100 & "%): $" & subtotal * IVA & vbCrLf & _
           "Total: $" & total

    ' vbCrLf es una constante predefinida que representa un salto de línea
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 1.9: INPUT DEL USUARIO
'-------------------------------------------------------------------------------

Sub PedirDatosUsuario()
    Dim nombreUsuario As String
    Dim edadUsuario As Integer

    ' InputBox pide datos al usuario
    nombreUsuario = InputBox("¿Cuál es tu nombre?", "Entrada de Datos")
    edadUsuario = InputBox("¿Cuál es tu edad?", "Entrada de Datos")

    ' Validar si el usuario canceló
    If nombreUsuario <> "" Then
        MsgBox "Hola " & nombreUsuario & ", tienes " & edadUsuario & " años"
    Else
        MsgBox "No ingresaste ningún nombre"
    End If
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 1.10: EJEMPLO PRÁCTICO COMPLETO - CALCULADORA SIMPLE
'-------------------------------------------------------------------------------

Sub CalculadoraSimple()
    ' Declaración de variables
    Dim numero1 As Double
    Dim numero2 As Double
    Dim operacion As String
    Dim resultado As Double
    Dim mensaje As String

    ' Solicitar datos al usuario
    numero1 = InputBox("Ingresa el primer número:", "Calculadora")
    numero2 = InputBox("Ingresa el segundo número:", "Calculadora")
    operacion = InputBox("¿Qué operación deseas realizar?" & vbCrLf & _
                        "Escribe: suma, resta, multiplicacion o division", _
                        "Calculadora")

    ' Convertir a minúsculas para evitar problemas
    operacion = LCase(operacion)  ' LCase convierte a minúsculas

    ' Realizar la operación
    Select Case operacion
        Case "suma"
            resultado = numero1 + numero2
            mensaje = numero1 & " + " & numero2 & " = " & resultado

        Case "resta"
            resultado = numero1 - numero2
            mensaje = numero1 & " - " & numero2 & " = " & resultado

        Case "multiplicacion"
            resultado = numero1 * numero2
            mensaje = numero1 & " × " & numero2 & " = " & resultado

        Case "division"
            If numero2 <> 0 Then
                resultado = numero1 / numero2
                mensaje = numero1 & " ÷ " & numero2 & " = " & resultado
            Else
                mensaje = "Error: No se puede dividir entre cero"
            End If

        Case Else
            mensaje = "Operación no válida"
    End Select

    ' Mostrar resultado
    MsgBox mensaje, vbInformation, "Resultado"

    ' Escribir el resultado en Excel
    Range("A1").Value = "Operación:"
    Range("B1").Value = mensaje
    Range("A1:B1").Font.Bold = True
End Sub

'-------------------------------------------------------------------------------
' SECCIÓN 1.11: PRÁCTICA - CONVERSOR DE TEMPERATURAS
'-------------------------------------------------------------------------------

Sub ConversorTemperaturas()
    ' Este programa convierte entre Celsius y Fahrenheit

    Dim temperatura As Double
    Dim unidad As String
    Dim resultado As Double
    Dim mensaje As String

    ' Pedir datos al usuario
    temperatura = InputBox("Ingresa la temperatura:", "Conversor")
    unidad = InputBox("¿En qué unidad está?" & vbCrLf & _
                     "Escribe: C (Celsius) o F (Fahrenheit)", _
                     "Conversor")

    ' Convertir a mayúsculas
    unidad = UCase(unidad)  ' UCase convierte a mayúsculas

    ' Realizar conversión
    If unidad = "C" Then
        ' Celsius a Fahrenheit: F = (C × 9/5) + 32
        resultado = (temperatura * 9 / 5) + 32
        mensaje = temperatura & "°C = " & resultado & "°F"
    ElseIf unidad = "F" Then
        ' Fahrenheit a Celsius: C = (F - 32) × 5/9
        resultado = (temperatura - 32) * 5 / 9
        mensaje = temperatura & "°F = " & resultado & "°C"
    Else
        mensaje = "Unidad no válida. Usa C o F"
    End If

    ' Mostrar resultado
    MsgBox mensaje, vbInformation, "Resultado de Conversión"

    ' Escribir en Excel
    Range("D1").Value = "Temperatura Original:"
    Range("E1").Value = temperatura & "°" & unidad
    Range("D2").Value = "Temperatura Convertida:"
    Range("E2").Value = resultado & "°" & IIf(unidad = "C", "F", "C")
    Range("D1:E2").Font.Bold = True
End Sub

'===============================================================================
' RESUMEN DEL MÓDULO 1
'===============================================================================
' ✓ Aprendiste a crear macros básicos
' ✓ Conoces los tipos de datos principales (String, Integer, Double, Boolean, Date)
' ✓ Sabes usar operadores aritméticos (+, -, *, /, \, Mod, ^)
' ✓ Conoces operadores de comparación (=, <>, >, <, >=, <=)
' ✓ Entiendes operadores lógicos (And, Or, Not)
' ✓ Puedes solicitar datos con InputBox
' ✓ Puedes mostrar mensajes con MsgBox
' ✓ Sabes concatenar strings
' ✓ Entiendes qué son las constantes
'
' SIGUIENTE PASO: Módulo 2 - Trabajando con Celdas y Rangos
'===============================================================================
