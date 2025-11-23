# Módulo 3: Manejo de Archivos en COBOL

## 📖 Introducción

El manejo de archivos es una de las fortalezas principales de COBOL. En este módulo aprenderás a trabajar con archivos secuenciales e indexados, realizar operaciones CRUD y procesar grandes volúmenes de datos.

## 🎯 Objetivos

- Entender la estructura de archivos en COBOL
- Trabajar con archivos secuenciales
- Utilizar archivos indexados (VSAM)
- Realizar operaciones CRUD completas
- Validar y procesar datos de archivos
- Manejar errores de I/O

## 📂 Tipos de Archivos en COBOL

### 1. Archivos Secuenciales (Sequential)
- Se leen/escriben en orden
- Acceso desde el principio hasta el final
- Ideales para reportes y procesamiento por lotes
- Más rápidos para lectura completa

### 2. Archivos Indexados (Indexed/VSAM)
- Acceso directo por clave
- Pueden leerse secuencialmente o por clave
- Ideales para bases de datos simples
- Permiten búsquedas rápidas

### 3. Archivos Relativos (Relative)
- Acceso por número de registro
- Menos comunes en práctica
- Similar a arrays en disco

## 🏗️ Estructura para Trabajar con Archivos

### ENVIRONMENT DIVISION

Define la configuración del archivo:

```cobol
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT nombre-archivo
        ASSIGN TO "ruta/archivo.dat"
        ORGANIZATION IS SEQUENTIAL
        ACCESS MODE IS SEQUENTIAL
        FILE STATUS IS ws-file-status.
```

### DATA DIVISION

Define la estructura del archivo:

```cobol
DATA DIVISION.
FILE SECTION.
FD  nombre-archivo.
01  registro-archivo.
    05  campo1    PIC X(20).
    05  campo2    PIC 9(6).

WORKING-STORAGE SECTION.
01  ws-file-status  PIC XX.
```

### FILE STATUS

Códigos importantes:
- **00** - Operación exitosa
- **10** - Fin de archivo
- **23** - Registro no encontrado (indexados)
- **30** - Error permanente
- **35** - Archivo no existe
- **48** - Ya existe (para creación)

## 🔧 Operaciones Básicas

### OPEN - Abrir Archivo

```cobol
OPEN INPUT archivo      *> Solo lectura
OPEN OUTPUT archivo     *> Solo escritura (crea nuevo)
OPEN I-O archivo        *> Lectura y escritura
OPEN EXTEND archivo     *> Agregar al final
```

### READ - Leer Registro

```cobol
READ archivo
    AT END
        MOVE 'S' TO ws-fin-archivo
    NOT AT END
        PERFORM procesar-registro
END-READ.
```

### WRITE - Escribir Registro

```cobol
WRITE registro-archivo.

*> Con verificación:
WRITE registro-archivo
    INVALID KEY
        DISPLAY "Error: clave duplicada"
END-WRITE.
```

### REWRITE - Actualizar Registro

```cobol
REWRITE registro-archivo
    INVALID KEY
        DISPLAY "Error: no se puede actualizar"
END-REWRITE.
```

### DELETE - Eliminar Registro

```cobol
DELETE archivo
    INVALID KEY
        DISPLAY "Error: registro no encontrado"
END-DELETE.
```

### CLOSE - Cerrar Archivo

```cobol
CLOSE archivo.
```

## 📝 Archivos Secuenciales

### Características:
- Organization: SEQUENTIAL
- Access: SEQUENTIAL
- Solo se puede leer de principio a fin
- Para modificar, hay que crear archivo nuevo

### Ejemplo típico:
```cobol
PERFORM UNTIL ws-fin-archivo = 'S'
    READ archivo-entrada
        AT END
            MOVE 'S' TO ws-fin-archivo
        NOT AT END
            PERFORM procesar-registro
            WRITE registro-salida
    END-READ
END-PERFORM.
```

## 🔑 Archivos Indexados

### Características:
- Organization: INDEXED
- Access: SEQUENTIAL, RANDOM o DYNAMIC
- Requiere RECORD KEY (clave primaria)
- Permite ALTERNATE KEY (claves secundarias)

### Definición:
```cobol
SELECT empleados
    ASSIGN TO "empleados.dat"
    ORGANIZATION IS INDEXED
    ACCESS MODE IS DYNAMIC
    RECORD KEY IS emp-id
    ALTERNATE RECORD KEY IS emp-email
        WITH DUPLICATES
    FILE STATUS IS ws-status.
```

### Acceso Directo:
```cobol
MOVE "E001" TO emp-id.
READ empleados
    INVALID KEY
        DISPLAY "Empleado no encontrado"
    NOT INVALID KEY
        DISPLAY emp-nombre
END-READ.
```

## 💻 Ejemplos Prácticos

### Ejemplo 9: Archivo Secuencial - Crear y Leer
Ver: `ejemplo-09-archivo-secuencial.cob`

### Ejemplo 10: Archivo Indexado - CRUD Completo
Ver: `ejemplo-10-archivo-indexado.cob`

### Ejemplo 11: Procesamiento de Ventas
Ver: `ejemplo-11-procesar-ventas.cob`

### Ejemplo 12: Merge de Archivos
Ver: `ejemplo-12-merge-archivos.cob`

## 🔨 Ejercicios Prácticos

### Ejercicio 1: Agenda Telefónica
Crea un sistema que:
1. Agregue contactos (nombre, teléfono, email)
2. Busque contactos por nombre
3. Actualice información
4. Elimine contactos
5. Liste todos los contactos
Usa archivo indexado.

### Ejercicio 2: Procesador de Logs
Lee un archivo de log secuencial y:
1. Cuente errores, warnings, info
2. Filtre por tipo de mensaje
3. Genere reporte de resumen
4. Exporte errores a archivo separado

### Ejercicio 3: Sistema de Inventario
Administra productos con:
1. Código, nombre, cantidad, precio
2. Alta de productos
3. Actualización de stock
4. Búsqueda por código
5. Reporte de productos con bajo stock

### Ejercicio 4: Conciliación Bancaria
Compara dos archivos (movimientos y estado de cuenta):
1. Lee ambos archivos
2. Encuentra movimientos coincidentes
3. Identifica diferencias
4. Genera reporte de conciliación

## 💡 Mejores Prácticas

1. **Siempre verificar FILE STATUS** después de operaciones
2. **Cerrar archivos** al terminar (libera recursos)
3. **Validar datos** antes de escribir
4. **Manejar errores** apropiadamente
5. **Usar nombres descriptivos** para archivos
6. **Documentar estructura** de registros
7. **Hacer respaldos** antes de modificar archivos importantes

## ⚠️ Errores Comunes

1. **Olvidar OPEN antes de READ/WRITE**
2. **No verificar AT END en loops**
3. **No cerrar archivos (CLOSE)**
4. **No verificar FILE STATUS**
5. **Abrir OUTPUT archivo existente** (lo sobrescribe)
6. **Intentar REWRITE en archivo SEQUENTIAL**
7. **No inicializar RECORD KEY antes de READ**

## 🎓 Conceptos Dominados

- ✅ SELECT y ASSIGN
- ✅ ORGANIZATION (SEQUENTIAL, INDEXED)
- ✅ ACCESS MODE
- ✅ FILE STATUS
- ✅ OPEN (INPUT, OUTPUT, I-O, EXTEND)
- ✅ READ (con AT END)
- ✅ WRITE
- ✅ REWRITE
- ✅ DELETE
- ✅ CLOSE
- ✅ RECORD KEY
- ✅ Procesamiento secuencial
- ✅ Acceso indexado

## 🎯 Siguiente Paso

Continúa con:
**Módulo 4: Tablas y Arreglos**

---

El manejo de archivos es crítico en COBOL. Practica mucho con archivos reales.
