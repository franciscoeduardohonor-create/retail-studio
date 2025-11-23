# 📝 Ejercicios Prácticos - Curso VBA Excel

## Instrucciones Generales

Para cada ejercicio:
1. **Lee cuidadosamente** el enunciado
2. **Intenta resolverlo** por tu cuenta primero
3. **Consulta los módulos** si necesitas ayuda
4. **Prueba tu código** con diferentes datos
5. **Compara** tu solución con las soluciones propuestas al final

---

## 🟢 NIVEL PRINCIPIANTE

### Ejercicio 1.1: Mi Primera Macro
**Objetivo:** Crear un macro que escriba tu nombre en la celda A1 y la fecha actual en B1.

**Requisitos:**
- Usar `Range().Value`
- Usar la función `Date` para obtener la fecha
- Aplicar formato negrita a ambas celdas

---

### Ejercicio 1.2: Calculadora de IMC
**Objetivo:** Crear un macro que calcule el Índice de Masa Corporal (IMC).

**Requisitos:**
- Pedir al usuario su peso (kg) y altura (metros) usando `InputBox`
- Calcular IMC: peso / (altura^2)
- Mostrar el resultado usando `MsgBox`
- Escribir el resultado en la celda A1

---

### Ejercicio 1.3: Conversor de Unidades
**Objetivo:** Crear un conversor de kilómetros a millas.

**Requisitos:**
- Pedir kilómetros al usuario
- Convertir: millas = kilómetros * 0.621371
- Mostrar resultado formateado
- Escribir tanto km como millas en Excel

---

### Ejercicio 1.4: Calculadora de Propina
**Objetivo:** Calcular propina y total de una cuenta.

**Requisitos:**
- Pedir el monto de la cuenta
- Pedir el porcentaje de propina (10%, 15%, 20%)
- Calcular propina y total
- Mostrar desglose en Excel

---

### Ejercicio 1.5: Validador de Edad
**Objetivo:** Validar si una persona puede votar.

**Requisitos:**
- Pedir la edad al usuario
- Usar estructura `If...Then...Else`
- Mostrar mensaje indicando si puede votar (≥18)
- Color verde si puede, rojo si no puede

---

## 🟡 NIVEL INTERMEDIO

### Ejercicio 2.1: Tabla de Multiplicar Personalizada
**Objetivo:** Generar una tabla de multiplicar de cualquier número.

**Requisitos:**
- Pedir el número al usuario
- Generar tabla del 1 al 20
- Aplicar formato alternado (filas pares/impares)
- Agregar bordes y encabezados

---

### Ejercicio 2.2: Calificaciones con Formato Condicional
**Objetivo:** Crear un sistema de calificaciones con colores.

**Requisitos:**
- Crear lista de 15 estudiantes con calificaciones aleatorias (0-100)
- Aplicar colores según rango:
  - 90-100: Verde (Excelente)
  - 70-89: Amarillo (Bueno)
  - 50-69: Naranja (Regular)
  - 0-49: Rojo (Reprobado)
- Calcular promedio general
- Contar cuántos aprobaron (≥60)

---

### Ejercicio 2.3: Buscador de Datos
**Objetivo:** Crear un buscador que encuentre y resalte datos.

**Requisitos:**
- Crear una lista de 20 productos con precios
- Pedir al usuario qué producto buscar
- Encontrar el producto y resaltarlo
- Mostrar su precio en un mensaje
- Manejar el caso cuando no se encuentra

---

### Ejercicio 2.4: Generador de Nómina
**Objetivo:** Calcular nómina de empleados.

**Requisitos:**
- Lista de empleados con horas trabajadas y tarifa por hora
- Calcular salario bruto
- Calcular descuentos (10% de impuestos)
- Calcular salario neto
- Sumar total de nómina
- Formato de moneda

---

### Ejercicio 2.5: Registro de Asistencia
**Objetivo:** Sistema simple de asistencia.

**Requisitos:**
- Lista de 10 estudiantes
- Usar `InputBox` con validación para marcar: P (Presente), F (Falta), T (Tardanza)
- Contar totales de cada tipo
- Calcular porcentaje de asistencia
- Aplicar formato condicional

---

## 🔴 NIVEL AVANZADO

### Ejercicio 3.1: Sistema CRUD de Contactos
**Objetivo:** Crear un sistema completo de gestión de contactos.

**Requisitos:**
- Crear/Leer/Actualizar/Eliminar contactos
- Campos: ID, Nombre, Teléfono, Email, Ciudad
- Validar email con función personalizada
- Buscar contactos por nombre
- Exportar a archivo de texto

---

### Ejercicio 3.2: Análisis de Ventas con Dictionary
**Objetivo:** Analizar ventas por vendedor y producto.

**Requisitos:**
- Datos: Fecha, Vendedor, Producto, Cantidad, Precio
- Usar Dictionary para agrupar ventas por vendedor
- Calcular total de ventas por vendedor
- Encontrar el vendedor top
- Crear gráfico de ventas
- Exportar resumen a nueva hoja

---

### Ejercicio 3.3: Dashboard Dinámico
**Objetivo:** Crear un dashboard que se actualice automáticamente.

**Requisitos:**
- 3 hojas: Datos, Resumen, Dashboard
- KPIs: Total ventas, Promedio, Mejor mes, Peor mes
- Tabla dinámica de ventas por mes
- Gráfico de tendencia
- Botón "Actualizar Dashboard"
- Formato profesional

---

### Ejercicio 3.4: Generador de Facturas
**Objetivo:** Sistema automático de generación de facturas.

**Requisitos:**
- Hoja de productos con precios
- Formulario para ingresar factura
- Calcular subtotal, IVA (16%), total
- Generar número de factura automático
- Crear PDF de la factura (usando Print to PDF)
- Guardar historial de facturas

---

### Ejercicio 3.5: Herramienta de Análisis de Datos
**Objetivo:** Analizar un conjunto grande de datos.

**Requisitos:**
- Generar 1000 registros de ventas aleatorias
- Usar arrays para procesamiento rápido
- Calcular estadísticas: media, mediana, moda
- Identificar outliers (valores atípicos)
- Crear histograma de frecuencias
- Exportar análisis completo

---

## 🚀 PROYECTOS FINALES

### Proyecto Final 1: Sistema de Biblioteca
**Descripción completa:**

Crear un sistema completo de gestión de biblioteca con:

**Funcionalidades:**
1. **Gestión de Libros**
   - Agregar/Editar/Eliminar libros
   - Campos: ISBN, Título, Autor, Editorial, Año, Categoría, Disponibles

2. **Gestión de Usuarios**
   - Registrar usuarios
   - Campos: ID, Nombre, Teléfono, Email, Fecha registro

3. **Préstamos**
   - Registrar préstamo (actualizar disponibilidad)
   - Registrar devolución
   - Calcular multas por retraso ($10/día)
   - Historial de préstamos

4. **Reportes**
   - Libros más prestados
   - Usuarios más activos
   - Libros vencidos
   - Multas pendientes

5. **UserForm**
   - Interfaz gráfica para todas las operaciones
   - Búsqueda de libros
   - Búsqueda de usuarios

---

### Proyecto Final 2: Sistema de Control de Gastos Personales
**Descripción completa:**

**Funcionalidades:**
1. **Registro de Gastos**
   - Fecha, Categoría, Descripción, Monto, Método de pago
   - Categorías: Alimentación, Transporte, Servicios, Entretenimiento, Otros

2. **Registro de Ingresos**
   - Fecha, Fuente, Monto

3. **Dashboard**
   - Balance actual
   - Gastos por categoría (gráfico de pastel)
   - Tendencia mensual (gráfico de líneas)
   - Comparación ingresos vs gastos

4. **Presupuesto**
   - Establecer presupuesto mensual por categoría
   - Alertas cuando se supera el 80% del presupuesto
   - Semáforo de estado (verde/amarillo/rojo)

5. **Reportes**
   - Reporte mensual
   - Reporte por categoría
   - Exportar a PDF

---

### Proyecto Final 3: Sistema de Inventario y Ventas
**Descripción completa:**

**Funcionalidades:**
1. **Productos**
   - Código, Nombre, Categoría, Precio Compra, Precio Venta, Stock
   - Alertas de stock mínimo
   - Códigos de barras

2. **Proveedores**
   - Registro de proveedores
   - Historial de compras

3. **Compras**
   - Registrar entrada de mercancía
   - Actualizar stock automáticamente
   - Generar orden de compra

4. **Ventas**
   - Punto de venta (POS) simple
   - Búsqueda rápida de productos
   - Aplicar descuentos
   - Generar ticket de venta
   - Calcular cambio

5. **Reportes y Análisis**
   - Inventario valorizado
   - Productos más vendidos
   - Margen de ganancia por producto
   - Análisis de ventas por período
   - Productos con rotación lenta

6. **Dashboard**
   - KPIs principales
   - Gráficos de ventas
   - Estado del inventario
   - Proyección de ventas

---

## 💡 DESAFÍOS EXTRAS

### Desafío 1: Juego de Adivinar el Número
Crear un juego donde:
- La computadora piensa un número del 1-100
- El usuario intenta adivinarlo
- Dar pistas "más alto" o "más bajo"
- Contar intentos
- Guardar récord de menos intentos

---

### Desafío 2: Generador de Contraseñas Seguras
Crear un generador que:
- Pida longitud de contraseña
- Incluya mayúsculas, minúsculas, números, símbolos
- Validar fortaleza
- Generar múltiples opciones
- Copiar al portapapeles

---

### Desafío 3: Organizador de Tareas (To-Do List)
Sistema de tareas con:
- Agregar/Completar/Eliminar tareas
- Prioridad (Alta/Media/Baja)
- Fecha de vencimiento
- Estado (Pendiente/En Proceso/Completada)
- Alertas de tareas vencidas
- Filtros y búsquedas

---

## 📚 SOLUCIONES

### Solución Ejercicio 1.1
```vba
Sub MiPrimeraMacro()
    ' Escribir nombre en A1
    Range("A1").Value = "Tu Nombre"
    Range("A1").Font.Bold = True

    ' Escribir fecha en B1
    Range("B1").Value = Date
    Range("B1").Font.Bold = True

    ' Ajustar columnas
    Columns("A:B").AutoFit

    MsgBox "¡Macro completada!", vbInformation
End Sub
```

### Solución Ejercicio 1.2
```vba
Sub CalculadoraIMC()
    Dim peso As Double
    Dim altura As Double
    Dim imc As Double
    Dim categoria As String

    ' Pedir datos
    peso = InputBox("Ingresa tu peso en kg:", "Calculadora IMC")
    altura = InputBox("Ingresa tu altura en metros:", "Calculadora IMC")

    ' Validar
    If peso <= 0 Or altura <= 0 Then
        MsgBox "Valores inválidos", vbExclamation
        Exit Sub
    End If

    ' Calcular IMC
    imc = peso / (altura ^ 2)

    ' Determinar categoría
    If imc < 18.5 Then
        categoria = "Bajo peso"
    ElseIf imc < 25 Then
        categoria = "Peso normal"
    ElseIf imc < 30 Then
        categoria = "Sobrepeso"
    Else
        categoria = "Obesidad"
    End If

    ' Mostrar resultado
    MsgBox "Tu IMC es: " & Format(imc, "0.00") & vbCrLf & _
           "Categoría: " & categoria, vbInformation

    ' Escribir en Excel
    Range("A1").Value = "Peso (kg):"
    Range("B1").Value = peso
    Range("A2").Value = "Altura (m):"
    Range("B2").Value = altura
    Range("A3").Value = "IMC:"
    Range("B3").Value = Format(imc, "0.00")
    Range("A4").Value = "Categoría:"
    Range("B4").Value = categoria

    Range("A1:A4").Font.Bold = True
    Columns("A:B").AutoFit
End Sub
```

### Solución Ejercicio 2.2
```vba
Sub SistemaCalificaciones()
    Dim i As Integer
    Dim calificacion As Integer
    Dim suma As Double
    Dim aprobados As Integer

    ' Limpiar
    Cells.Clear

    ' Encabezados
    Range("A1:C1").Value = Array("Estudiante", "Calificación", "Estado")
    Range("A1:C1").Font.Bold = True
    Range("A1:C1").Interior.Color = RGB(68, 114, 196)
    Range("A1:C1").Font.Color = RGB(255, 255, 255)

    suma = 0
    aprobados = 0
    Randomize

    ' Generar estudiantes
    For i = 2 To 16  ' 15 estudiantes
        ' Nombre
        Cells(i, 1).Value = "Estudiante " & (i - 1)

        ' Calificación aleatoria
        calificacion = Int(Rnd() * 101)  ' 0-100
        Cells(i, 2).Value = calificacion
        suma = suma + calificacion

        ' Estado
        If calificacion >= 60 Then
            Cells(i, 3).Value = "Aprobado"
            aprobados = aprobados + 1
        Else
            Cells(i, 3).Value = "Reprobado"
        End If

        ' Formato condicional
        If calificacion >= 90 Then
            Cells(i, 2).Interior.Color = RGB(0, 255, 0)
            Cells(i, 2).Font.Color = RGB(0, 100, 0)
            Cells(i, 2).Font.Bold = True
        ElseIf calificacion >= 70 Then
            Cells(i, 2).Interior.Color = RGB(255, 255, 0)
        ElseIf calificacion >= 50 Then
            Cells(i, 2).Interior.Color = RGB(255, 165, 0)
        Else
            Cells(i, 2).Interior.Color = RGB(255, 0, 0)
            Cells(i, 2).Font.Color = RGB(255, 255, 255)
            Cells(i, 2).Font.Bold = True
        End If
    Next i

    ' Estadísticas
    Range("A18").Value = "Promedio General:"
    Range("B18").Value = Format(suma / 15, "0.00")
    Range("B18").Font.Bold = True

    Range("A19").Value = "Aprobados:"
    Range("B19").Value = aprobados

    Range("A20").Value = "Reprobados:"
    Range("B20").Value = 15 - aprobados

    Range("A18:A20").Font.Bold = True

    ' Bordes
    Range("A1:C16").Borders.LineStyle = xlContinuous

    ' Ajustar
    Columns("A:C").AutoFit

    MsgBox "Sistema de calificaciones creado" & vbCrLf & _
           "Promedio: " & Format(suma / 15, "0.00") & vbCrLf & _
           "Aprobados: " & aprobados & "/" & 15, vbInformation
End Sub
```

---

## 🎯 CONSEJOS PARA RESOLVER EJERCICIOS

1. **Lee el enunciado completo** antes de empezar a programar
2. **Planifica la solución** en papel (pseudocódigo)
3. **Divide el problema** en partes más pequeñas
4. **Prueba cada parte** antes de continuar
5. **Usa nombres descriptivos** para variables
6. **Comenta tu código** para entenderlo después
7. **Maneja errores** con validaciones
8. **Prueba con diferentes datos** (casos extremos)
9. **Optimiza después** que funcione correctamente
10. **No te rindas** - la práctica hace al maestro

---

## 📖 CÓMO USAR ESTE ARCHIVO

1. **Elige un ejercicio** según tu nivel
2. **Crea un nuevo módulo** en VBA
3. **Escribe tu solución** desde cero
4. **Prueba tu código**
5. **Compara** con la solución propuesta
6. **Mejora** tu código
7. **Pasa al siguiente** ejercicio

---

## 🏆 CERTIFICACIÓN PERSONAL

Cuando completes todos los ejercicios y al menos un proyecto final, habrás dominado VBA para Excel.

**Checklist de Progreso:**
- [ ] Ejercicios Nivel Principiante (1.1 - 1.5)
- [ ] Ejercicios Nivel Intermedio (2.1 - 2.5)
- [ ] Ejercicios Nivel Avanzado (3.1 - 3.5)
- [ ] Al menos 1 Proyecto Final completado
- [ ] 2 Desafíos extras completados

¡Mucho éxito en tu aprendizaje de VBA!
