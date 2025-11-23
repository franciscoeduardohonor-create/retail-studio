# Módulo 2: Estructuras de Control y Datos

## 📖 Introducción

En este módulo profundizaremos en las estructuras de control (IF, EVALUATE, PERFORM) y aprenderemos a organizar datos de manera eficiente usando niveles jerárquicos y tipos de datos más complejos.

## 🎯 Objetivos de Aprendizaje

- Dominar estructuras condicionales (IF, EVALUATE)
- Entender y usar bucles (PERFORM)
- Trabajar con estructuras de datos jerárquicas
- Usar validación de datos efectiva
- Implementar lógica empresarial compleja

## 🔄 Estructuras de Control

### 1. IF - Condicionales

La estructura IF permite tomar decisiones en el programa:

```cobol
IF condición THEN
    sentencias
END-IF

IF condición THEN
    sentencias
ELSE
    otras-sentencias
END-IF

IF condición1 THEN
    sentencias
ELSE IF condición2 THEN
    otras-sentencias
ELSE
    sentencias-finales
END-IF
```

### 2. EVALUATE - Switch/Case

EVALUATE es más limpio para múltiples condiciones:

```cobol
EVALUATE variable
    WHEN valor1
        sentencias
    WHEN valor2
        sentencias
    WHEN OTHER
        sentencias-default
END-EVALUATE
```

### 3. PERFORM - Bucles y Subrutinas

PERFORM tiene múltiples usos:

**Llamar a un párrafo:**
```cobol
PERFORM nombre-parrafo
```

**Bucle con contador:**
```cobol
PERFORM nombre-parrafo 10 TIMES
```

**Bucle con condición:**
```cobol
PERFORM UNTIL condición
    sentencias
END-PERFORM
```

**Bucle VARYING (for loop):**
```cobol
PERFORM VARYING contador FROM 1 BY 1 UNTIL contador > 10
    sentencias
END-PERFORM
```

## 📊 Estructuras de Datos

### Niveles Jerárquicos

COBOL permite crear estructuras complejas usando niveles:

```cobol
01  EMPLEADO.
    05  EMP-NOMBRE.
        10  EMP-PRIMER-NOMBRE    PIC X(20).
        10  EMP-APELLIDO         PIC X(30).
    05  EMP-DIRECCION.
        10  EMP-CALLE            PIC X(40).
        10  EMP-CIUDAD           PIC X(30).
        10  EMP-CP               PIC X(5).
    05  EMP-SALARIO              PIC 9(6)V99.
```

### PICTURE Avanzado

- **A** - Solo letras
- **X** - Alfanumérico
- **9** - Numérico
- **V** - Punto decimal implícito
- **S** - Con signo
- **Z** - Supresión de ceros a la izquierda
- **$** - Signo de moneda

Ejemplos:
```cobol
01  WS-PRECIO    PIC ZZZ,ZZ9.99.     *> Con formato
01  WS-TELEFONO  PIC 9(3)-9(3)-9(4).  *> Con guiones
01  WS-MONTO     PIC $$,$$$,$$9.99.   *> Con $
```

### Condiciones de Nivel 88

Permiten dar nombres a valores específicos:

```cobol
01  WS-ESTADO-CIVIL    PIC X.
    88  SOLTERO        VALUE 'S'.
    88  CASADO         VALUE 'C'.
    88  DIVORCIADO     VALUE 'D'.
    88  VIUDO          VALUE 'V'.

*> Uso:
IF CASADO THEN
    DISPLAY "Cliente casado"
END-IF

SET SOLTERO TO TRUE.  *> Asigna 'S' a WS-ESTADO-CIVIL
```

## ✅ Validación de Datos

### Validación de Rango

```cobol
IF WS-EDAD NOT NUMERIC THEN
    DISPLAY "Edad debe ser numérica"
END-IF

IF WS-EDAD < 18 OR WS-EDAD > 120 THEN
    DISPLAY "Edad fuera de rango"
END-IF
```

### Validación de Formato

```cobol
IF WS-EMAIL NOT CONTAINS "@" THEN
    DISPLAY "Email inválido"
END-IF
```

## 💻 Ejemplos Prácticos

### Ejemplo 5: Sistema de Calificaciones
Ver: `ejemplo-05-calificaciones.cob`
- IF anidados
- Validación de entrada
- Cálculo de promedios

### Ejemplo 6: Menú Interactivo
Ver: `ejemplo-06-menu.cob`
- EVALUATE
- PERFORM UNTIL
- Estructura modular

### Ejemplo 7: Gestión de Empleados
Ver: `ejemplo-07-empleados.cob`
- Estructuras jerárquicas
- Nivel 88 (condiciones)
- Validación compleja

### Ejemplo 8: Procesamiento de Lotes
Ver: `ejemplo-08-bucles.cob`
- PERFORM VARYING
- Acumuladores
- Contadores

## 🔨 Ejercicios Prácticos

### Ejercicio 1: Calculadora de Impuestos
Crea un programa que:
1. Pida el salario anual
2. Calcule impuestos según rangos:
   - $0 - $10,000: 0%
   - $10,001 - $30,000: 10%
   - $30,001 - $60,000: 20%
   - Más de $60,000: 30%
3. Muestre el impuesto y salario neto

### Ejercicio 2: Validador de Datos Personales
Crea un programa que valide:
- Nombre (solo letras, 2-50 caracteres)
- Edad (numérica, 18-100)
- Email (debe contener @ y .)
- Teléfono (formato específico)

### Ejercicio 3: Sistema de Inventario Simple
Crea un programa con menú que permita:
1. Agregar producto (nombre, cantidad, precio)
2. Mostrar inventario
3. Buscar producto
4. Calcular valor total del inventario
5. Salir

### Ejercicio 4: Generador de Reportes
Procesa datos de ventas de una semana:
- Pide ventas de lunes a domingo
- Calcula el total semanal
- Encuentra el día con más ventas
- Calcula el promedio diario
- Muestra un reporte formateado

## 💡 Consejos y Mejores Prácticas

1. **Modularización**: Usa PERFORM para dividir lógica en párrafos
2. **Validación temprana**: Valida datos apenas los recibas
3. **Nombres descriptivos**: Los párrafos deben explicar qué hacen
4. **Nivel 88**: Úsalo para hacer el código más legible
5. **Estructuras**: Organiza datos relacionados en grupos
6. **Comentarios**: Explica la lógica empresarial compleja

## ⚠️ Errores Comunes

1. **Olvidar END-IF**: Cada IF debe cerrarse
2. **Olvidar END-PERFORM**: Los bucles deben cerrarse
3. **Condiciones mal escritas**: Revisar operadores lógicos
4. **No validar entrada**: Siempre asumir que el usuario puede equivocarse
5. **Bucles infinitos**: Asegurar que la condición eventualmente se cumpla

## 🎓 Conceptos Dominados

- ✅ IF simple y anidado
- ✅ EVALUATE para múltiples casos
- ✅ PERFORM TIMES, UNTIL, VARYING
- ✅ Estructuras jerárquicas (niveles 01-49)
- ✅ PICTURE avanzado con formatos
- ✅ Nivel 88 (condiciones con nombre)
- ✅ Validación de datos
- ✅ Modularización con párrafos

## 🎯 Siguiente Paso

Una vez dominados estos conceptos, estás listo para:
**Módulo 3: Manejo de Archivos** (Nivel Intermedio)

---

¡La clave está en la práctica! Haz todos los ejercicios antes de continuar.
