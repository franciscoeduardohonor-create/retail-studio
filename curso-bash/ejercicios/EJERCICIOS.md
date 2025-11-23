# Ejercicios Prácticos de BASH

¡Pon a prueba tus conocimientos con estos ejercicios! Cada ejercicio incluye la descripción del problema y pistas para resolverlo.

## 📚 Cómo usar estos ejercicios

1. Lee el enunciado del ejercicio
2. Intenta resolverlo por tu cuenta
3. Si te atascas, lee las pistas
4. Verifica tu solución ejecutándola
5. Compara con la solución propuesta (en archivo separado)

---

## 🟢 EJERCICIOS NIVEL PRINCIPIANTE

### Ejercicio 1: Calculadora Simple
**Objetivo:** Crear una calculadora que suma dos números ingresados por el usuario.

**Requisitos:**
- Solicitar dos números al usuario
- Mostrar la suma de ambos
- Validar que sean números

**Pistas:**
- Usa `read` para input del usuario
- Usa `$(( ))` para aritmética
- Usa `[[ ]] ` y regex para validar

**Archivo:** `ejercicios/01_calculadora.sh`

---

### Ejercicio 2: Conversor de Temperatura
**Objetivo:** Convertir temperatura de Celsius a Fahrenheit y viceversa.

**Requisitos:**
- Menú para elegir conversión
- Input de temperatura
- Mostrar resultado
- Fórmulas: F = C * 9/5 + 32, C = (F - 32) * 5/9

**Archivo:** `ejercicios/02_temperatura.sh`

---

### Ejercicio 3: Generador de Contraseñas
**Objetivo:** Generar contraseña aleatoria de longitud especificada.

**Requisitos:**
- Pedir longitud al usuario (8-32 caracteres)
- Generar contraseña aleatoria
- Incluir mayúsculas, minúsculas, números y símbolos

**Pistas:**
- Usa `/dev/urandom` o `$RANDOM`
- Combina caracteres con tr/sed

**Archivo:** `ejercicios/03_password_gen.sh`

---

### Ejercicio 4: Adivina el Número
**Objetivo:** Juego de adivinar número aleatorio entre 1 y 100.

**Requisitos:**
- Generar número aleatorio
- Pedir intentos al usuario
- Dar pistas (mayor/menor)
- Contar intentos
- Mostrar mensaje al ganar

**Archivo:** `ejercicios/04_adivina.sh`

---

### Ejercicio 5: Organizador de Archivos
**Objetivo:** Organizar archivos por extensión en carpetas.

**Requisitos:**
- Recibir directorio como argumento
- Crear carpetas por tipo (docs, images, videos, etc.)
- Mover archivos a carpetas correspondientes
- Mostrar resumen de archivos movidos

**Archivo:** `ejercicios/05_organizar.sh`

---

## 🟡 EJERCICIOS NIVEL INTERMEDIO

### Ejercicio 6: Analizador de Logs
**Objetivo:** Analizar archivo de log y extraer estadísticas.

**Requisitos:**
- Contar líneas por nivel (INFO, WARNING, ERROR)
- Encontrar errores más frecuentes
- Extraer IPs únicas
- Generar reporte

**Pistas:**
- Usa grep, awk, sort, uniq
- Cuenta con wc -l
- Extrae patrones con regex

**Archivo:** `ejercicios/06_log_analyzer.sh`

---

### Ejercicio 7: Backup Inteligente
**Objetivo:** Script de backup con rotación automática.

**Requisitos:**
- Backup de directorio especificado
- Comprimir con tar.gz
- Incluir fecha en nombre
- Mantener solo últimos N backups
- Log de operaciones

**Archivo:** `ejercicios/07_backup.sh`

---

### Ejercicio 8: Monitor de Sistema
**Objetivo:** Monitorear recursos del sistema y alertar.

**Requisitos:**
- Monitorear CPU, memoria, disco
- Alertar si supera umbral (ej: 80%)
- Guardar historial
- Mostrar gráfico ASCII simple

**Archivo:** `ejercicios/08_monitor.sh`

---

### Ejercicio 9: Procesador de CSV
**Objetivo:** Procesar archivo CSV y generar estadísticas.

**Requisitos:**
- Leer archivo CSV
- Calcular promedios, máximos, mínimos
- Filtrar por condiciones
- Exportar resultados

**Pistas:**
- Usa awk para columnas
- IFS para delimitador
- Arrays para acumular

**Archivo:** `ejercicios/09_csv_processor.sh`

---

### Ejercicio 10: Gestor de Tareas
**Objetivo:** Sistema simple de TODO list en terminal.

**Requisitos:**
- Agregar tareas
- Listar tareas
- Marcar como completadas
- Eliminar tareas
- Persistir en archivo

**Archivo:** `ejercicios/10_todo.sh`

---

## 🔴 EJERCICIOS NIVEL AVANZADO

### Ejercicio 11: Web Scraper
**Objetivo:** Extraer información de página web.

**Requisitos:**
- Descargar página con curl
- Extraer datos específicos (títulos, links, etc.)
- Parsear HTML con grep/sed
- Guardar en formato estructurado

**Archivo:** `ejercicios/11_scraper.sh`

---

### Ejercicio 12: Deploy Automation
**Objetivo:** Script completo de deployment.

**Requisitos:**
- Pull código de git
- Ejecutar tests
- Build aplicación
- Deploy con zero-downtime
- Rollback automático si falla
- Notificaciones

**Archivo:** `ejercicios/12_deploy.sh`

---

### Ejercicio 13: API Cliente
**Objetivo:** Cliente para interactuar con API REST.

**Requisitos:**
- CRUD completo (Create, Read, Update, Delete)
- Autenticación con token
- Parsear respuestas JSON
- Manejo de errores HTTP
- Caché de respuestas

**Archivo:** `ejercicios/13_api_client.sh`

---

### Ejercicio 14: Sistema de Plugins
**Objetivo:** Sistema extensible con plugins.

**Requisitos:**
- Arquitectura modular
- Carga dinámica de plugins
- API para plugins
- Configuración por plugin
- Hooks/eventos

**Archivo:** `ejercicios/14_plugin_system.sh`

---

### Ejercicio 15: Proyecto Final
**Objetivo:** Aplicación completa que integre múltiples conceptos.

**Ideas:**
- Sistema de gestión de inventario
- Automatización de servidor
- Dashboard de monitoreo
- Sistema de CI/CD personalizado
- Bot de automatización

**Requisitos:**
- Usar módulos
- Base de datos (SQLite)
- Logging completo
- Tests
- Documentación
- Manejo de errores robusto
- Interfaz de usuario amigable

**Archivo:** `ejercicios/15_proyecto_final.sh`

---

## 🎯 Challenges Extra

### Challenge 1: One-Liner
Resuelve estos problemas en una sola línea:

1. Encontrar los 10 archivos más grandes en /var
2. Contar palabras únicas en un archivo
3. Listar usuarios con shell /bin/bash
4. Encontrar archivos modificados hoy
5. Calcular suma de números en archivo

### Challenge 2: Code Golf
Escribe el código más corto posible para:

1. FizzBuzz (1 a 100)
2. Palíndromo checker
3. Factorial recursivo
4. Fibonacci
5. Ordenar array

### Challenge 3: Performance
Optimiza estos scripts para máxima velocidad:

1. Procesar archivo de 1M líneas
2. Búsqueda en múltiples archivos
3. Generación de reportes
4. Procesamiento paralelo

---

## 📝 Notas

- Todos los ejercicios tienen soluciones en `ejercicios/soluciones/`
- Intenta resolver sin mirar las soluciones primero
- No hay una única forma correcta - sé creativo
- Prueba diferentes enfoques
- Optimiza después de que funcione

## 🏆 Certificación

Al completar todos los ejercicios, habrás dominado:
- ✅ Fundamentos de BASH
- ✅ Procesamiento de datos
- ✅ Automatización de tareas
- ✅ Scripting avanzado
- ✅ Mejores prácticas

¡Suerte y que te diviertas programando en BASH! 🚀
