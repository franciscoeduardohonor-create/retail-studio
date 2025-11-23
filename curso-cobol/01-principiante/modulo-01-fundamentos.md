# Módulo 1: Fundamentos de COBOL

## 📖 Introducción

### ¿Qué es COBOL?

COBOL (Common Business-Oriented Language) es un lenguaje de programación creado en 1959, diseñado específicamente para aplicaciones de negocio. Aunque tiene más de 60 años, sigue siendo crucial:

- 95% de los cajeros automáticos usan COBOL
- 80% de las transacciones presenciales usan COBOL
- 43% de los sistemas bancarios están construidos en COBOL
- Procesa más del 70% de las transacciones comerciales mundiales

### ¿Por qué aprender COBOL en 2024?

1. **Demanda laboral**: Escasez de programadores COBOL
2. **Salarios competitivos**: Conocimiento especializado bien pagado
3. **Sistemas críticos**: Bancos, seguros, gobierno
4. **Mantenimiento legacy**: Billones de líneas de código existentes
5. **Modernización**: Integración con sistemas nuevos

## 🏗️ Estructura de un Programa COBOL

Todo programa COBOL tiene 4 divisiones obligatorias:

### 1. IDENTIFICATION DIVISION
Identifica el programa (metadatos)

### 2. ENVIRONMENT DIVISION
Configura el entorno de ejecución (archivos, hardware)

### 3. DATA DIVISION
Define todas las variables y estructuras de datos

### 4. PROCEDURE DIVISION
Contiene la lógica del programa (el código ejecutable)

## 📝 Sintaxis Básica

### Reglas Importantes:

1. **Columnas**: COBOL usa formato de columnas (modo legacy)
   - Columnas 1-6: Números de secuencia
   - Columna 7: Indicador (*, -, /)
   - Columnas 8-11: Área A (divisiones, secciones, párrafos)
   - Columnas 12-72: Área B (sentencias)

2. **Formato libre**: Con `-free` puedes usar formato moderno

3. **Case insensitive**: COBOL no distingue mayúsculas/minúsculas

4. **Punto final**: Todas las sentencias terminan con punto (.)

5. **Comentarios**: Línea que empieza con asterisco (*)

## 💻 Ejemplos Prácticos

Ahora vamos a ver varios ejemplos incrementales:

### Ejemplo 1: Hola Mundo
Ver: `ejemplo-01-hola-mundo.cob`

### Ejemplo 2: Variables y Display
Ver: `ejemplo-02-variables.cob`

### Ejemplo 3: Entrada de Usuario
Ver: `ejemplo-03-entrada-usuario.cob`

### Ejemplo 4: Operaciones Básicas
Ver: `ejemplo-04-operaciones.cob`

## 🔨 Ejercicios Prácticos

### Ejercicio 1: Tu Primer Programa
Modifica el ejemplo "Hola Mundo" para que muestre:
```
Bienvenido a COBOL
Tu nombre: [tu nombre]
Fecha: 2024
```

### Ejercicio 2: Calculadora Simple
Crea un programa que:
1. Pida dos números al usuario
2. Muestre la suma, resta, multiplicación y división
3. Formatee la salida de manera elegante

### Ejercicio 3: Presentación Personal
Crea un programa que pida:
- Nombre
- Edad
- Ciudad

Y muestre un mensaje personalizado formateado.

## 💡 Consejos

1. **Indentación**: Aunque no sea obligatoria, ayuda a la legibilidad
2. **Nombres descriptivos**: Las variables deben ser claras
3. **Comentarios**: Documenta tu código
4. **Prueba frecuente**: Compila y ejecuta constantemente

## ⚠️ Errores Comunes

1. Olvidar el punto (.) al final de sentencias
2. Usar variables sin definirlas en DATA DIVISION
3. No respetar las columnas en modo legacy
4. Confundir PICTURE con VALUE

## 📚 Conceptos Clave Aprendidos

- ✅ Estructura de 4 divisiones
- ✅ IDENTIFICATION DIVISION
- ✅ DATA DIVISION básica
- ✅ PROCEDURE DIVISION
- ✅ DISPLAY (salida)
- ✅ ACCEPT (entrada)
- ✅ Variables con PICTURE
- ✅ Operaciones aritméticas básicas

## 🎯 Siguiente Paso

Una vez que domines estos conceptos y completes los ejercicios, continúa con:
**Módulo 2: Estructuras de Control y Datos**

---

¡Practica mucho con los ejemplos! La práctica es clave en COBOL.
