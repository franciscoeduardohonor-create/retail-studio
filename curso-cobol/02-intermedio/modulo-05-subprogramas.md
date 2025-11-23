# Módulo 5: Subprogramas y Modularización

## 📖 Introducción

Los subprogramas permiten dividir aplicaciones grandes en módulos reutilizables y mantenibles.

## 🎯 Objetivos

- Crear subprogramas independientes
- Usar CALL y CANCEL
- Pasar parámetros (BY REFERENCE y BY CONTENT)
- Trabajar con COPY
- Implementar bibliotecas de código

## 📞 CALL - Llamar Subprogramas

### Programa Principal

```cobol
IDENTIFICATION DIVISION.
PROGRAM-ID. PRINCIPAL.

DATA DIVISION.
WORKING-STORAGE SECTION.
01  WS-NUMERO1    PIC 9(4) VALUE 100.
01  WS-NUMERO2    PIC 9(4) VALUE 50.
01  WS-RESULTADO  PIC 9(5) VALUE 0.

PROCEDURE DIVISION.
    CALL 'SUMAR' USING WS-NUMERO1 WS-NUMERO2 WS-RESULTADO.
    DISPLAY "Resultado: " WS-RESULTADO.
    STOP RUN.
```

### Subprograma

```cobol
IDENTIFICATION DIVISION.
PROGRAM-ID. SUMAR.

DATA DIVISION.
LINKAGE SECTION.
01  LS-NUM1      PIC 9(4).
01  LS-NUM2      PIC 9(4).
01  LS-RESULTADO PIC 9(5).

PROCEDURE DIVISION USING LS-NUM1 LS-NUM2 LS-RESULTADO.
    ADD LS-NUM1 TO LS-NUM2 GIVING LS-RESULTADO.
    GOBACK.
```

## 📊 Paso de Parámetros

### BY REFERENCE (por defecto)
- Pasa la dirección de memoria
- Cambios afectan al programa llamador
- Más eficiente

```cobol
CALL 'SUBPROG' USING BY REFERENCE WS-VARIABLE.
```

### BY CONTENT
- Pasa una copia del valor
- Cambios NO afectan al llamador
- Más seguro

```cobol
CALL 'SUBPROG' USING BY CONTENT WS-VARIABLE.
```

## 📋 COPY - Incluir Código

### Definir Copybook

Archivo: `EMPLEADO.cpy`
```cobol
01  EMPLEADO.
    05  EMP-ID      PIC 9(6).
    05  EMP-NOMBRE  PIC X(40).
    05  EMP-SALARIO PIC 9(6)V99.
```

### Usar Copybook

```cobol
WORKING-STORAGE SECTION.
    COPY EMPLEADO.
```

## 💻 Ejemplo Práctico

Ver: `ejemplo-14-subprogramas.cob`

## 🔨 Ejercicios

1. Crear biblioteca de funciones matemáticas
2. Validador de datos reutilizable
3. Formateador de fechas
4. Calculadora modular

## 💡 Mejores Prácticas

1. Un subprograma = una responsabilidad
2. Documentar parámetros
3. Usar BY CONTENT cuando sea posible
4. Validar parámetros de entrada
5. Manejo consistente de errores

## 🎓 Conceptos Dominados

- ✅ CALL y GOBACK
- ✅ LINKAGE SECTION
- ✅ BY REFERENCE vs BY CONTENT
- ✅ COPY
- ✅ Modularización

## 🎯 Siguiente Paso

**Módulo 6: COBOL Avanzado - Bases de Datos**
