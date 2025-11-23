# Proyecto Final: Sistema Bancario Completo

## 🎯 Objetivo

Desarrollar un sistema bancario completo que integre todos los conceptos aprendidos en el curso.

## 📋 Requisitos Funcionales

### 1. Gestión de Clientes
- Alta, baja, modificación de clientes
- Búsqueda por ID o nombre
- Validación de datos (RFC, CURP, etc.)

### 2. Gestión de Cuentas
- Apertura de cuentas (ahorro, cheques)
- Consulta de saldo
- Bloqueo/desbloqueo de cuentas
- Cierre de cuentas

### 3. Operaciones Bancarias
- Depósitos
- Retiros
- Transferencias entre cuentas
- Pago de servicios

### 4. Reportes
- Estado de cuenta
- Movimientos del día/mes
- Cuentas con saldo bajo
- Clientes activos/inactivos

### 5. Seguridad
- Validación de PIN
- Límites de retiro
- Registro de transacciones (audit trail)

## 🗂️ Estructura de Archivos

### CLIENTES.dat (Indexado)
```
RECORD KEY: CLIENTE-ID
ALTERNATE KEY: CLIENTE-RFC

- CLIENTE-ID       PIC 9(10)
- CLIENTE-NOMBRE   PIC X(50)
- CLIENTE-RFC      PIC X(13)
- CLIENTE-DIRECCION
- CLIENTE-TELEFONO
- CLIENTE-EMAIL
- CLIENTE-FECHA-ALTA
- CLIENTE-ACTIVO
```

### CUENTAS.dat (Indexado)
```
RECORD KEY: CUENTA-NUMERO
ALTERNATE KEY: CLIENTE-ID

- CUENTA-NUMERO     PIC 9(16)
- CLIENTE-ID        PIC 9(10)
- CUENTA-TIPO       PIC X (A=Ahorro, C=Cheques)
- SALDO             PIC 9(10)V99
- FECHA-APERTURA
- ESTADO            PIC X
- PIN               PIC 9(4)
```

### MOVIMIENTOS.dat (Secuencial)
```
- MOV-ID           PIC 9(12)
- CUENTA-NUMERO    PIC 9(16)
- TIPO-MOV         PIC X (D=Depósito, R=Retiro, T=Transferencia)
- MONTO            PIC 9(8)V99
- FECHA-HORA
- DESCRIPCION
```

## 💻 Módulos del Sistema

### PRINCIPAL.cob
- Menú principal
- Control de flujo
- Coordinación de módulos

### MOD-CLIENTES.cob
- CRUD de clientes
- Validaciones

### MOD-CUENTAS.cob
- Gestión de cuentas
- Verificación de saldos

### MOD-OPERACIONES.cob
- Depósitos
- Retiros
- Transferencias

### MOD-REPORTES.cob
- Generación de reportes
- Estadísticas

### MOD-UTILIDADES.cob (Subprograma)
- Validación de RFC
- Formateo de fechas
- Cálculos

## 🔨 Tareas del Proyecto

### Fase 1: Diseño (1-2 días)
1. Definir estructura de archivos
2. Diseñar pantallas
3. Documentar flujos

### Fase 2: Módulos Básicos (3-4 días)
1. Implementar gestión de clientes
2. Implementar gestión de cuentas
3. Probar CRUD básico

### Fase 3: Operaciones (2-3 días)
1. Depósitos y retiros
2. Transferencias
3. Validaciones de negocio

### Fase 4: Reportes (2 días)
1. Estado de cuenta
2. Reporte de movimientos
3. Estadísticas

### Fase 5: Pruebas y Refinamiento (1-2 días)
1. Pruebas integrales
2. Manejo de errores
3. Documentación

## ✅ Criterios de Evaluación

### Funcionalidad (40%)
- Todas las operaciones funcionan
- Validaciones correctas
- Manejo de errores

### Código (30%)
- Estructura clara
- Modularización
- Comentarios
- Nombres descriptivos

### Archivos (20%)
- Correcta definición
- Operaciones eficientes
- Integridad de datos

### Usabilidad (10%)
- Interfaz clara
- Mensajes comprensibles
- Flujo intuitivo

## 🎓 Conceptos Aplicados

- ✅ Archivos indexados
- ✅ Archivos secuenciales
- ✅ Tablas y búsquedas
- ✅ Subprogramas
- ✅ Validación de datos
- ✅ Estructuras complejas
- ✅ Menús interactivos
- ✅ Manejo de errores
- ✅ Transacciones
- ✅ Generación de reportes

## 💡 Consejos

1. Empieza por lo simple
2. Prueba cada módulo independientemente
3. Valida todos los datos de entrada
4. Maneja todos los errores posibles
5. Documenta conforme avanzas
6. Haz respaldos frecuentes
7. Usa copybooks para estructuras comunes

## 🚀 Extensiones Opcionales

- Integración con DB2
- Cálculo de intereses
- Préstamos y créditos
- Tarjetas de débito/crédito
- Inversiones
- Web services (JSON/XML)
- Reportes en PDF/HTML

## 📚 Entregables

1. Código fuente completo
2. Documentación técnica
3. Manual de usuario
4. Archivos de prueba
5. Scripts de compilación

---

## ¡Felicidades por completar el curso!

Has aprendido COBOL desde cero hasta poder desarrollar aplicaciones empresariales completas. Este conocimiento es valioso y demandado en el mercado laboral.

### Próximos Pasos

1. Completa el proyecto final
2. Practica con código legacy real
3. Aprende CICS para transacciones online
4. Estudia JCL para mainframes
5. Considera certificaciones IBM

**¡Éxito en tu carrera como programador COBOL!** 🎉
