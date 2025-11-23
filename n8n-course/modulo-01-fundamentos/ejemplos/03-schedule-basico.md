# Ejemplo 3: Automatización con Schedule Trigger

## Objetivo
Aprender a ejecutar workflows automáticamente en horarios específicos.

## Conceptos que Aprenderás
- Schedule Trigger
- Expresiones cron
- Horarios específicos
- Intervalos regulares
- Timezone considerations

## ¿Qué es Schedule Trigger?

El nodo **Schedule Trigger** inicia automáticamente tu workflow en momentos específicos:
- Cada X minutos/horas
- Días específicos de la semana
- Fechas exactas
- Expresiones cron personalizadas

## Ejemplo 1: Ejecución cada 5 Minutos

### Configuración Schedule Trigger

1. Agrega un nodo "Schedule Trigger"
2. Configura:
   - **Trigger Interval:** Every 5 minutes

### Agregar Lógica

Code Node:
```javascript
// Este código se ejecuta automáticamente cada 5 minutos

const ahora = new Date();

// Formateamos la fecha y hora
const timestamp = {
  fecha: ahora.toLocaleDateString('es-ES'),
  hora: ahora.toLocaleTimeString('es-ES'),
  timestamp_unix: ahora.getTime(),
  dia_semana: ahora.toLocaleDateString('es-ES', { weekday: 'long' }),
  mes: ahora.toLocaleDateString('es-ES', { month: 'long' })
};

// Log para debugging
console.log('⏰ Workflow ejecutado automáticamente');
console.log('📅 Fecha:', timestamp.fecha);
console.log('🕐 Hora:', timestamp.hora);

// Retornamos información de la ejecución
return [{
  json: {
    mensaje: 'Ejecución automática completada',
    ejecutado_en: timestamp,
    contador_ejecucion: $execution.id // ID único de cada ejecución
  }
}];
```

💡 **Nota:** Este workflow se ejecutará solo cuando esté ACTIVO. Activa el workflow con el switch en la parte superior.

## Ejemplo 2: Reporte Diario a las 9 AM

### Schedule Trigger Configuración

- **Trigger Times:** Days of the Week
- **Hour:** 09:00
- **Days:** Monday, Tuesday, Wednesday, Thursday, Friday

### Workflow Completo

```
[Schedule: 9am Lu-Vi] → [Get Data] → [Process] → [Create Report]
```

### Get Data (HTTP Request)

Simularemos obtener datos de ventas:
- **URL:** `https://jsonplaceholder.typicode.com/posts?_limit=10`

### Process (Code Node)

```javascript
// Simulamos procesamiento de datos de ventas
const datos = items[0].json;

// Obtenemos información del día
const hoy = new Date();
const diaSemana = hoy.toLocaleDateString('es-ES', { weekday: 'long' });
const fecha = hoy.toLocaleDateString('es-ES');

// Procesamos "ventas" (usando los posts como ejemplo)
const totalItems = datos.length;

// Simulamos algunas métricas
const metricas = {
  total_transacciones: totalItems,
  valor_promedio: (Math.random() * 1000 + 500).toFixed(2),
  transaccion_mayor: (Math.random() * 2000 + 1000).toFixed(2),
  transaccion_menor: (Math.random() * 100 + 50).toFixed(2)
};

// Calculamos total
const totalVentas = (metricas.total_transacciones * metricas.valor_promedio).toFixed(2);

// Creamos el reporte
const reporte = {
  titulo: `📊 Reporte Diario - ${diaSemana.toUpperCase()} ${fecha}`,

  resumen: {
    fecha: fecha,
    dia: diaSemana,
    total_ventas: `$${totalVentas}`,
    transacciones: metricas.total_transacciones,
    ticket_promedio: `$${metricas.valor_promedio}`
  },

  detalles: {
    venta_mayor: `$${metricas.transaccion_mayor}`,
    venta_menor: `$${metricas.transaccion_menor}`,
    rango: `$${metricas.transaccion_menor} - $${metricas.transaccion_mayor}`
  },

  // Comparación con día anterior (simulado)
  comparacion: {
    crecimiento: '+12.5%',
    tendencia: '📈 Positiva'
  }
};

console.log('✅ Reporte generado exitosamente');
console.log(JSON.stringify(reporte, null, 2));

return [{ json: reporte }];
```

## Ejemplo 3: Backup Semanal

### Schedule Trigger Configuración

- **Trigger Times:** Specific Time(s)
- **Hour:** 02:00 (2 AM)
- **Day:** Sunday

### Code Node (Simular Backup)

```javascript
// Este workflow se ejecuta cada domingo a las 2 AM

const fechaBackup = new Date();

// Información del backup
const backup = {
  nombre_backup: `backup_${fechaBackup.getFullYear()}_${fechaBackup.getMonth() + 1}_${fechaBackup.getDate()}.zip`,

  timestamp: {
    inicio: fechaBackup.toISOString(),
    unix: fechaBackup.getTime()
  },

  // Simulamos estadísticas
  estadisticas: {
    archivos_procesados: Math.floor(Math.random() * 1000 + 500),
    tamano_mb: (Math.random() * 500 + 100).toFixed(2),
    duracion_segundos: Math.floor(Math.random() * 60 + 30),
    tipo: 'Completo',
    compresion: '65%'
  },

  estado: '✅ Completado',

  // Próximo backup
  proximo_backup: new Date(fechaBackup.getTime() + 7 * 24 * 60 * 60 * 1000).toLocaleDateString('es-ES')
};

console.log('🗄️  Backup semanal iniciado');
console.log('📦 Archivo:', backup.nombre_backup);
console.log('💾 Tamaño:', backup.estadisticas.tamano_mb, 'MB');
console.log('✅ Estado:', backup.estado);
console.log('📅 Próximo backup:', backup.proximo_backup);

return [{ json: backup }];
```

## Ejemplo 4: Monitoreo cada Hora

### Use Case: Verificar el estado de un servicio cada hora

### Schedule Trigger
- **Trigger Interval:** Every Hour

### HTTP Request
- **URL:** `https://jsonplaceholder.typicode.com/posts/1`

### Code Node (Health Check)

```javascript
// Verificamos si la API responde correctamente
const respuesta = items[0].json;

const ahora = new Date();

// Determinamos el estado
const estadoServicio = respuesta && respuesta.id
  ? '🟢 ONLINE'
  : '🔴 OFFLINE';

const healthCheck = {
  servicio: 'API JSONPlaceholder',
  estado: estadoServicio,
  timestamp: ahora.toISOString(),
  hora_verificacion: ahora.toLocaleTimeString('es-ES'),

  metricas: {
    tiempo_respuesta_ms: Math.floor(Math.random() * 500 + 100),
    codigo_estado: 200,
    datos_recibidos: respuesta ? 'OK' : 'ERROR'
  },

  // Contador de verificaciones exitosas (en producción, esto vendría de una DB)
  estadisticas: {
    verificaciones_hoy: Math.floor(ahora.getHours() + 1),
    uptime_porcentaje: '99.98%',
    ultimo_incidente: 'Hace 15 días'
  }
};

// Alerta si hay problema
if (estadoServicio.includes('OFFLINE')) {
  console.error('🚨 ALERTA: Servicio caído');
  healthCheck.alerta = '🚨 REQUIERE ATENCIÓN INMEDIATA';
} else {
  console.log('✅ Servicio funcionando correctamente');
}

return [{ json: healthCheck }];
```

## Entendiendo Expresiones Cron

### ¿Qué es Cron?

Cron es una sintaxis para definir horarios complejos.

**Formato:**
```
* * * * * *
│ │ │ │ │ │
│ │ │ │ │ └─ Día de la semana (0-7, 0 y 7 = Domingo)
│ │ │ │ └─── Mes (1-12)
│ │ │ └───── Día del mes (1-31)
│ │ └─────── Hora (0-23)
│ └───────── Minuto (0-59)
└─────────── Segundo (0-59) [opcional]
```

### Ejemplos de Expresiones Cron

```bash
# Cada 5 minutos
*/5 * * * *

# Cada hora
0 * * * *

# Cada día a las 9:00 AM
0 9 * * *

# Cada lunes a las 8:30 AM
30 8 * * 1

# Primer día de cada mes a las 00:00
0 0 1 * *

# Cada 15 minutos entre 9 AM y 5 PM, lunes a viernes
*/15 9-17 * * 1-5

# Cada domingo a las 2 AM
0 2 * * 0
```

### En n8n Schedule Trigger

Puedes usar el modo "Custom (Cron)" para expresiones personalizadas:

**Ejemplo: Cada lunes y viernes a las 10:30**
```
30 10 * * 1,5
```

## Ejemplo 5: Recordatorios Periódicos

### Schedule Trigger: Cada día a las 8 AM, 12 PM y 6 PM

- **Trigger Times:** Specific Time(s)
- **Hours:** 08:00, 12:00, 18:00

### Code Node

```javascript
// Determinamos qué tipo de recordatorio enviar según la hora
const ahora = new Date();
const hora = ahora.getHours();

let tipoRecordatorio;
let mensaje;
let icono;

if (hora < 12) {
  tipoRecordatorio = 'Mañana';
  mensaje = '¡Buenos días! Recuerda revisar tus tareas del día.';
  icono = '☀️';
} else if (hora < 18) {
  tipoRecordatorio = 'Mediodía';
  mensaje = '¡Hora del almuerzo! ¿Has completado tus tareas matutinas?';
  icono = '🍽️';
} else {
  tipoRecordatorio = 'Tarde';
  mensaje = '¡Buen trabajo hoy! Revisa tus pendientes para mañana.';
  icono = '🌙';
}

const recordatorio = {
  tipo: tipoRecordatorio,
  icono: icono,
  mensaje: mensaje,
  timestamp: ahora.toLocaleString('es-ES'),

  // Tareas sugeridas (esto vendría de una DB en producción)
  tareas_sugeridas: [
    { tarea: 'Revisar emails', prioridad: 'Alta', completado: false },
    { tarea: 'Actualizar reportes', prioridad: 'Media', completado: false },
    { tarea: 'Llamada con cliente', prioridad: 'Alta', completado: true }
  ],

  // Estadísticas del día
  progreso_dia: {
    tareas_completadas: 5,
    tareas_pendientes: 3,
    porcentaje: '62.5%'
  }
};

console.log(`${icono} ${tipoRecordatorio}: ${mensaje}`);

return [{ json: recordatorio }];
```

## Testing de Workflows Programados

### Problema
No quieres esperar hasta el horario programado para probar.

### Solución: Ejecución Manual

1. **Para testing inmediato:**
   - Click en "Execute Workflow"
   - Ejecuta manualmente aunque el trigger sea Schedule

2. **Para ver ejecuciones pasadas:**
   - Panel lateral → Executions
   - Ve el historial de todas las ejecuciones automáticas

3. **Para debugging:**
   - Desactiva el workflow (switch arriba)
   - Haz pruebas manuales
   - Reactiva cuando esté listo

## Best Practices

### ✅ DO

```javascript
// 1. Logs informativos
console.log('🚀 Inicio de tarea programada');
console.log('📅 Ejecutado:', new Date().toISOString());

// 2. Manejo de errores
try {
  // Tu lógica
} catch (error) {
  console.error('❌ Error:', error.message);
  throw error; // n8n lo registrará
}

// 3. Metadata de ejecución
return [{
  json: {
    data: result,
    ejecutado_en: new Date().toISOString(),
    ejecucion_id: $execution.id
  }
}];
```

### ❌ DON'T

```javascript
// 1. No uses intervalos muy frecuentes innecesariamente
// Mal: Cada minuto cuando cada hora es suficiente

// 2. No olvides timezone
// Las horas son en el timezone del servidor n8n

// 3. No dejes workflows activos que no necesitas
// Consumen recursos y pueden causar efectos no deseados
```

## Ejercicios Prácticos

### Ejercicio 1: Reporte Semanal
Crea un workflow que:
1. Se ejecute cada viernes a las 5 PM
2. Resuma la "actividad de la semana" (simulada)
3. Liste tareas completadas vs pendientes

### Ejercicio 2: Monitoreo Multi-Servicio
Crea un workflow que:
1. Se ejecute cada 30 minutos
2. Verifique 3 APIs diferentes
3. Genere un reporte de estado de cada una

### Ejercicio 3: Recordatorio Inteligente
Crea un workflow que:
1. Se ejecute cada 2 horas durante horario laboral (9 AM - 6 PM)
2. Muestre recordatorios diferentes según la hora
3. Incluya un contador de cuántas veces se ha ejecutado hoy

<details>
<summary>Ver solución Ejercicio 3</summary>

Schedule Trigger:
- Cron: `0 9-18/2 * * 1-5` (cada 2 horas, 9 AM a 6 PM, lunes a viernes)

Code:
```javascript
const ahora = new Date();
const hora = ahora.getHours();

// Contador de ejecuciones hoy (en producción usar DB)
const ejecucionesHoy = Math.floor((hora - 9) / 2) + 1;

const recordatorios = {
  9: '☕ ¡Buenos días! Hora de planificar el día',
  11: '📊 Revisa el progreso de tus tareas matutinas',
  13: '🍽️ ¡Hora del almuerzo! Recarga energías',
  15: '💪 Segunda mitad del día, ¡tú puedes!',
  17: '📝 Prepara el cierre del día'
};

return [{
  json: {
    hora: `${hora}:00`,
    recordatorio: recordatorios[hora] || 'Recordatorio general',
    ejecucion_numero: ejecucionesHoy,
    dia_semana: ahora.toLocaleDateString('es-ES', { weekday: 'long' })
  }
}];
```
</details>

## Timezone y Consideraciones

### Verificar Timezone del Servidor

Code Node:
```javascript
const ahora = new Date();

return [{
  json: {
    hora_local: ahora.toLocaleString('es-ES'),
    hora_utc: ahora.toUTCString(),
    timezone_offset: ahora.getTimezoneOffset(),
    iso: ahora.toISOString()
  }
}];
```

### Ajustar para Diferentes Timezones

```javascript
// Convertir a timezone específico
const opciones = {
  timeZone: 'America/Mexico_City',
  hour12: false
};

const horaMexico = new Date().toLocaleString('es-ES', opciones);
console.log('🇲🇽 Hora en México:', horaMexico);
```

## Puntos Clave

- ✅ Schedule Trigger ejecuta workflows automáticamente
- ✅ Soporta intervalos simples y expresiones cron complejas
- ✅ Activa/desactiva con el switch superior
- ✅ Prueba manualmente antes de activar
- ✅ Revisa el historial en Executions
- ✅ Considera el timezone del servidor
- ✅ Usa console.log() para debugging

## Siguiente Paso

Has completado los ejemplos básicos. Ahora practica con los **ejercicios** y luego pasa al **Módulo 2** para aprender a manipular datos de forma avanzada.
