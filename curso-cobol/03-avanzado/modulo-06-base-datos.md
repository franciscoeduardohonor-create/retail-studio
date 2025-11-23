# Módulo 6: COBOL con Bases de Datos (DB2)

## 📖 Introducción

La integración de COBOL con DB2 es fundamental en entornos empresariales y mainframe.

## 🎯 Objetivos

- Entender Embedded SQL
- Conectar a DB2
- Realizar operaciones CRUD en DB2
- Usar cursores
- Manejar transacciones

## 🔌 Embedded SQL

### Estructura Básica

```cobol
IDENTIFICATION DIVISION.
PROGRAM-ID. DB2-EJEMPLO.

DATA DIVISION.
WORKING-STORAGE SECTION.

*> Área de comunicación con DB2
EXEC SQL
    INCLUDE SQLCA
END-EXEC.

*> Variables host (COBOL que se usan en SQL)
01  WS-EMP-ID       PIC 9(6).
01  WS-EMP-NOMBRE   PIC X(40).
01  WS-EMP-SALARIO  PIC 9(6)V99.
```

### SELECT

```cobol
EXEC SQL
    SELECT NOMBRE, SALARIO
    INTO :WS-EMP-NOMBRE, :WS-EMP-SALARIO
    FROM EMPLEADOS
    WHERE EMP_ID = :WS-EMP-ID
END-EXEC.

IF SQLCODE = 0 THEN
    DISPLAY "Empleado: " WS-EMP-NOMBRE
ELSE IF SQLCODE = 100 THEN
    DISPLAY "No encontrado"
ELSE
    DISPLAY "Error: " SQLCODE
END-IF.
```

### INSERT

```cobol
EXEC SQL
    INSERT INTO EMPLEADOS
    (EMP_ID, NOMBRE, SALARIO)
    VALUES (:WS-EMP-ID, :WS-EMP-NOMBRE, :WS-EMP-SALARIO)
END-EXEC.
```

### UPDATE

```cobol
EXEC SQL
    UPDATE EMPLEADOS
    SET SALARIO = :WS-EMP-SALARIO
    WHERE EMP_ID = :WS-EMP-ID
END-EXEC.
```

### DELETE

```cobol
EXEC SQL
    DELETE FROM EMPLEADOS
    WHERE EMP_ID = :WS-EMP-ID
END-EXEC.
```

## 📑 Cursores

Para procesar múltiples registros:

```cobol
*> Declarar cursor
EXEC SQL
    DECLARE C1 CURSOR FOR
    SELECT EMP_ID, NOMBRE, SALARIO
    FROM EMPLEADOS
    WHERE DEPTO = 'SISTEMAS'
END-EXEC.

*> Abrir cursor
EXEC SQL
    OPEN C1
END-EXEC.

*> Leer registros
PERFORM UNTIL SQLCODE NOT = 0
    EXEC SQL
        FETCH C1
        INTO :WS-EMP-ID, :WS-EMP-NOMBRE, :WS-EMP-SALARIO
    END-EXEC

    IF SQLCODE = 0 THEN
        DISPLAY WS-EMP-NOMBRE
    END-IF
END-PERFORM.

*> Cerrar cursor
EXEC SQL
    CLOSE C1
END-EXEC.
```

## 🔄 Transacciones

```cobol
*> Iniciar transacción
EXEC SQL
    BEGIN TRANSACTION
END-EXEC.

*> Operaciones...
EXEC SQL
    UPDATE CUENTAS
    SET SALDO = SALDO - :WS-MONTO
    WHERE CUENTA_ID = :WS-CUENTA-ORIGEN
END-EXEC.

EXEC SQL
    UPDATE CUENTAS
    SET SALDO = SALDO + :WS-MONTO
    WHERE CUENTA_ID = :WS-CUENTA-DESTINO
END-EXEC.

*> Confirmar o revertir
IF SQLCODE = 0 THEN
    EXEC SQL
        COMMIT
    END-EXEC
ELSE
    EXEC SQL
        ROLLBACK
    END-EXEC
END-IF.
```

## 📊 SQLCODE

Códigos importantes:
- **0** - Éxito
- **100** - No encontrado / fin de datos
- **-803** - Duplicado (violación unique)
- **-904** - Recurso no disponible
- **-911** - Deadlock

## 💻 Ejemplo Práctico

Ver: `ejemplo-15-db2-crud.cob`

## 🔨 Ejercicios

1. Sistema bancario con DB2
2. CRUD completo de inventario
3. Reportes desde base de datos
4. Transacciones complejas

## 💡 Mejores Prácticas

1. Siempre verificar SQLCODE
2. Usar COMMIT/ROLLBACK apropiadamente
3. Cerrar cursores
4. Índices para performance
5. Prepared statements para seguridad

## 🎓 Conceptos Dominados

- ✅ EXEC SQL
- ✅ Variables host (:variable)
- ✅ SQLCODE y SQLCA
- ✅ Cursores
- ✅ Transacciones
- ✅ COMMIT y ROLLBACK

## 🎯 Siguiente Paso

**Módulo 7: Proyecto Final Integrador**
