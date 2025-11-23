# Ejercicios del Módulo 1: Fundamentos Básicos

## Instrucciones Generales

1. Crea un archivo .c para cada ejercicio
2. Compila y ejecuta tu código para verificar que funcione
3. Asegúrate de comentar tu código
4. Prueba con diferentes valores de entrada

## Ejercicio 1: Información Personal ⭐

**Dificultad:** Muy Fácil

Escribe un programa que muestre tu información personal:

```
Nombre: [Tu nombre]
Edad: [Tu edad]
Ciudad: [Tu ciudad]
Ocupación: [Tu ocupación]
```

**Conceptos a practicar:**
- printf()
- Formato de texto

---

## Ejercicio 2: Calculadora de Propinas ⭐

**Dificultad:** Fácil

Crea un programa que:
1. Pida el monto de la cuenta
2. Pida el porcentaje de propina (15, 18, 20, etc.)
3. Calcule y muestre:
   - La propina
   - El total a pagar

**Ejemplo:**
```
Monto de la cuenta: $50.00
Porcentaje de propina: 18%

Propina: $9.00
Total: $59.00
```

**Conceptos a practicar:**
- Variables (float)
- scanf()
- Operaciones aritméticas
- printf() con formato

---

## Ejercicio 3: Conversor de Unidades ⭐⭐

**Dificultad:** Fácil-Medio

Crea un conversor que permita convertir:
- Kilómetros a millas (1 km = 0.621371 millas)
- Celsius a Fahrenheit (F = C * 9/5 + 32)
- Kilogramos a libras (1 kg = 2.20462 libras)

El programa debe pedir al usuario qué conversión desea hacer.

**Conceptos a practicar:**
- Variables
- Operadores aritméticos
- Entrada/salida
- Conversiones

---

## Ejercicio 4: Verificador de Edad ⭐⭐

**Dificultad:** Medio

Escribe un programa que:
1. Pida el año actual
2. Pida tu año de nacimiento
3. Calcule tu edad
4. Determine si eres:
   - Menor de edad (< 18)
   - Adulto joven (18-30)
   - Adulto (31-60)
   - Adulto mayor (> 60)

**Conceptos a practicar:**
- Variables int
- Operaciones aritméticas
- Operadores relacionales
- if/else (lo veremos más a fondo en el módulo 2)

---

## Ejercicio 5: Calculadora de Área y Perímetro ⭐⭐

**Dificultad:** Medio

Crea un programa que calcule el área y perímetro de:
1. Cuadrado (lado)
2. Rectángulo (largo y ancho)
3. Círculo (radio) - usa π = 3.14159

Muestra los resultados con 2 decimales.

**Conceptos a practicar:**
- Variables float
- Operaciones matemáticas
- Formato de salida

---

## Ejercicio 6: Factura de Compra ⭐⭐⭐

**Dificultad:** Medio-Difícil

Simula una factura de compra:
1. Pide el nombre del producto
2. Pide el precio unitario
3. Pide la cantidad
4. Calcula:
   - Subtotal (precio × cantidad)
   - IVA (16% del subtotal)
   - Total

Muestra una factura formateada:
```
═══════════════════════════════
         FACTURA DE COMPRA
═══════════════════════════════
Producto: [nombre]
Precio unitario: $[precio]
Cantidad: [cantidad]
───────────────────────────────
Subtotal: $[subtotal]
IVA (16%): $[iva]
───────────────────────────────
TOTAL: $[total]
═══════════════════════════════
```

**Conceptos a practicar:**
- Múltiples variables
- Operaciones matemáticas
- Formato de salida avanzado

---

## Ejercicio 7: Intercambio de Variables ⭐⭐⭐

**Dificultad:** Medio-Difícil

Escribe un programa que:
1. Lea dos números
2. Los muestre
3. Los intercambie SIN usar una tercera variable
4. Muestre los números intercambiados

**Pista:** Usa operaciones aritméticas para el intercambio.

**Conceptos a practicar:**
- Variables
- Operaciones aritméticas
- Lógica de programación

---

## Ejercicio 8: Calculadora de Tiempo ⭐⭐⭐

**Dificultad:** Difícil

Crea un programa que:
1. Pida una cantidad en segundos
2. Convierta a días, horas, minutos y segundos
3. Muestre el resultado

**Ejemplo:**
```
Ingresa segundos: 93784

93784 segundos equivalen a:
1 día(s)
2 hora(s)
3 minuto(s)
4 segundo(s)
```

**Pista:** Usa división (/) y módulo (%)

**Conceptos a practicar:**
- División entera
- Operador módulo
- Lógica matemática

---

## Ejercicio 9: Calculadora Científica Básica ⭐⭐⭐⭐

**Dificultad:** Difícil

Expande la calculadora simple del ejemplo 6 para incluir:
1. Todas las operaciones básicas (+, -, *, /, %)
2. Validación de entrada
3. Mensajes de error claros
4. Presentación profesional
5. Operaciones adicionales:
   - Valor absoluto
   - Redondeo
   - Determinar mayor/menor

**Conceptos a practicar:**
- Todo lo aprendido en el módulo

---

## Ejercicio 10: Sistema de Calificaciones ⭐⭐⭐⭐

**Dificultad:** Muy Difícil

Crea un programa para calcular calificaciones:
1. Pide 5 calificaciones de exámenes
2. Pide 3 calificaciones de tareas
3. Calcula:
   - Promedio de exámenes (60% de la nota final)
   - Promedio de tareas (40% de la nota final)
   - Nota final
4. Determina:
   - Si aprobó (≥ 60)
   - Letra de calificación (A: 90-100, B: 80-89, C: 70-79, D: 60-69, F: <60)
5. Muestra un reporte completo

**Conceptos a practicar:**
- Múltiples variables
- Operaciones matemáticas complejas
- Lógica condicional
- Formato de salida profesional

---

## Soluciones

Las soluciones están disponibles en la carpeta `soluciones/`, pero intenta resolver los ejercicios por tu cuenta primero. ¡Aprender viene del esfuerzo!

## Consejos

1. **Lee el ejercicio completamente** antes de empezar a programar
2. **Planifica** qué variables necesitas
3. **Escribe pseudo-código** si el problema es complejo
4. **Prueba con diferentes valores** para asegurarte de que funciona
5. **Comenta tu código** para recordar qué hace cada parte
6. **Si te atascas**, revisa los ejemplos del módulo
7. **No te rindas** - la programación requiere práctica

## Siguiente Paso

Una vez que hayas completado al menos 5 de estos ejercicios, estás listo para el [Módulo 2: Control de Flujo y Funciones](../../modulo-2-control-flujo/README.md)
