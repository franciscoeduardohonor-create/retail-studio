# Módulo 1: Fundamentos de n8n

## Objetivos de Aprendizaje

Al finalizar este módulo serás capaz de:
- Entender qué es n8n y cómo funciona
- Crear tu primer workflow
- Conocer los nodos básicos
- Ejecutar workflows manual y automáticamente
- Depurar y probar tus automatizaciones

## 1. ¿Qué es n8n?

n8n (nodemation) es una herramienta de automatización que te permite conectar diferentes aplicaciones y servicios mediante workflows visuales.

### Conceptos Clave

**Workflow (Flujo de Trabajo):**
Un conjunto de nodos conectados que automatizan una tarea.

**Nodo:**
Cada paso en tu automatización. Puede ser:
- **Trigger (Disparador):** Inicia el workflow
- **Action (Acción):** Realiza una operación
- **Conditional (Condicional):** Toma decisiones

**Conexiones:**
Líneas que conectan los nodos y definen el flujo de datos.

**Ejecución:**
Cuando el workflow se ejecuta y procesa datos.

## 2. Anatomía de un Workflow

```
[Trigger] → [Procesar Datos] → [Acción] → [Resultado]
```

### Ejemplo Simple:
```
[Schedule: Cada día 9am] → [HTTP Request: API del clima] → [Email: Enviar pronóstico]
```

## 3. Nodos Básicos Esenciales

### 3.1 Schedule Trigger
Ejecuta el workflow en horarios específicos.

**Usos comunes:**
- Reportes diarios/semanales
- Backups automáticos
- Sincronización de datos

### 3.2 Manual Trigger
Ejecuta el workflow cuando haces clic en "Execute".

**Usos comunes:**
- Testing
- Workflows on-demand
- Procesamiento manual

### 3.3 Webhook Trigger
Recibe datos desde aplicaciones externas.

**Usos comunes:**
- Recibir formularios
- Integraciones en tiempo real
- APIs personalizadas

### 3.4 HTTP Request
Hace peticiones a APIs y servicios web.

**Usos comunes:**
- Consumir APIs
- Enviar datos a servicios
- Integración con cualquier API REST

### 3.5 Set Node
Establece, modifica o crea datos manualmente.

**Usos comunes:**
- Crear variables
- Transformar datos
- Agregar campos adicionales

### 3.6 Code Node
Ejecuta código JavaScript personalizado.

**Usos comunes:**
- Lógica compleja
- Transformaciones avanzadas
- Cálculos personalizados

## 4. Tu Primer Workflow

### Ejemplo 1: "Hola Mundo"

**Objetivo:** Crear un workflow simple que muestre un mensaje.

**Pasos:**
1. Arrastra un nodo "Manual Trigger"
2. Conecta un nodo "Set"
3. En Set, agrega un campo:
   - Name: `mensaje`
   - Value: `¡Hola Mundo desde n8n!`
4. Conecta un nodo "Code" para mostrar el mensaje
5. Ejecuta

Ver código en: `ejemplos/01-hola-mundo.md`

### Ejemplo 2: Obtener Datos de una API

**Objetivo:** Consultar una API pública y mostrar resultados.

Ver código en: `ejemplos/02-api-basica.md`

### Ejemplo 3: Programar una Tarea

**Objetivo:** Ejecutar automáticamente cada hora.

Ver código en: `ejemplos/03-schedule-basico.md`

## 5. Flujo de Datos

### ¿Cómo fluyen los datos en n8n?

Cada nodo recibe datos del anterior y los pasa al siguiente.

**Estructura de datos:**
```json
[
  {
    "json": {
      "campo1": "valor1",
      "campo2": "valor2"
    }
  }
]
```

### Acceder a datos del nodo anterior:

```javascript
// En expresiones n8n
{{ $json.campo1 }}

// En Code Node
const dato = items[0].json.campo1;
```

## 6. Ejecuciones y Debugging

### Panel de Ejecuciones
- Muestra el historial de ejecuciones
- Verde: Éxito
- Rojo: Error

### Ver datos de cada nodo:
1. Ejecuta el workflow
2. Click en cualquier nodo
3. Ve la pestaña "Output Data"

### Tips de Debugging:
- Usa el nodo "Code" para `console.log()`
- Revisa el output de cada nodo
- Usa el nodo "Stop and Error" para breakpoints

## 7. Mejores Prácticas

✅ **DO:**
- Nombra tus nodos descriptivamente
- Comenta workflows complejos
- Prueba cada paso individualmente
- Guarda versiones de tus workflows

❌ **DON'T:**
- No hagas workflows demasiado complejos
- No ignores los errores
- No expongas credenciales en el código
- No uses hardcoded values sin razón

## Ejercicios Prácticos

### Ejercicio 1: Mi Primer Workflow
Crea un workflow que genere tu nombre y edad, y los muestre.

**Pista:** Usa Manual Trigger + Set

### Ejercicio 2: Consulta API del Clima
Usa la API de OpenWeatherMap (o similar) para obtener el clima actual.

**Pista:** HTTP Request node

### Ejercicio 3: Programador Diario
Crea un workflow que se ejecute cada día a las 8am.

**Pista:** Schedule Trigger

Ver soluciones en: `ejercicios/`

## Proyecto del Módulo 1

**Sistema de Recordatorios Automáticos**

Crear un workflow que:
1. Se ejecute cada lunes a las 9am
2. Prepare un mensaje motivacional
3. Lo envíe (simular envío con un Code node)

Ver guía completa en: `ejercicios/proyecto-modulo-1.md`

## Recursos

- [Documentación de nodos básicos](https://docs.n8n.io/integrations/builtin/core-nodes/)
- [Workflows de ejemplo en la comunidad](https://n8n.io/workflows)

## Siguiente Paso

Cuando domines estos conceptos, continúa con el **Módulo 2: Trabajando con Datos y Expresiones** donde aprenderás a manipular y transformar datos de formas más avanzadas.

---

**Tiempo estimado:** 2-3 días
**Nivel:** Principiante
