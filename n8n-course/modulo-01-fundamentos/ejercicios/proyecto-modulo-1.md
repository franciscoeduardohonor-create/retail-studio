# Proyecto Módulo 1: Sistema de Recordatorios Automáticos

## Nivel: Principiante
## Tiempo Estimado: 1-2 horas

## Descripción del Proyecto

Crearás un **Sistema de Recordatorios Automáticos** que:
1. Se ejecuta automáticamente en horarios específicos
2. Genera diferentes tipos de recordatorios según la hora del día
3. Incluye frases motivacionales aleatorias
4. Simula el envío de notificaciones
5. Lleva un registro de las ejecuciones

Este proyecto combina todos los conceptos aprendidos en el Módulo 1.

## Objetivos de Aprendizaje

- ✅ Usar Schedule Trigger para automatización
- ✅ Implementar lógica condicional compleja
- ✅ Manejar arrays y selección aleatoria
- ✅ Formatear datos de manera profesional
- ✅ Simular interacciones con servicios externos

## Requisitos del Sistema

### Funcionalidad Principal

El sistema debe ejecutarse **3 veces al día:**
- **8:00 AM** - Recordatorio matutino
- **2:00 PM** - Recordatorio de mediodía
- **7:00 PM** - Recordatorio vespertino

Cada recordatorio debe incluir:
1. Tipo de recordatorio (Mañana/Mediodía/Tarde)
2. Frase motivacional aleatoria
3. Lista de tareas sugeridas según la hora
4. Estadísticas del día
5. Próximo recordatorio programado

## Arquitectura del Workflow

```
[Schedule Trigger: 8am, 2pm, 7pm]
    ↓
[Code: Determinar Tipo de Recordatorio]
    ↓
[Code: Generar Contenido]
    ↓
[Code: Formatear Notificación]
    ↓
[Code: Simular Envío y Logging]
```

## Parte 1: Schedule Trigger

### Configuración

1. Agrega un nodo **Schedule Trigger**
2. Configura **Trigger Times: Specific Time(s)**
3. Agrega tres horarios:
   - 08:00
   - 14:00
   - 19:00

💡 **Para testing:** Primero usa Manual Trigger, y cuando funcione, cambia a Schedule Trigger.

## Parte 2: Determinar Tipo de Recordatorio

### Code Node: "Determinar Contexto"

Este nodo identifica qué tipo de recordatorio enviar.

```javascript
// Obtener hora actual
const ahora = new Date();
const hora = ahora.getHours();
const minuto = ahora.getMinutes();
const diaSemana = ahora.getDay(); // 0 = Domingo, 6 = Sábado

// Información temporal
const esFindeSemana = diaSemana === 0 || diaSemana === 6;
const nombreDia = ahora.toLocaleDateString('es-ES', { weekday: 'long' });
const fecha = ahora.toLocaleDateString('es-ES');

// Determinar tipo de recordatorio según la hora
let tipoRecordatorio;
let icono;
let saludo;

if (hora < 12) {
  tipoRecordatorio = 'matutino';
  icono = '☀️';
  saludo = '¡Buenos días!';
} else if (hora < 18) {
  tipoRecordatorio = 'mediodia';
  icono = '🌤️';
  saludo = '¡Buenas tardes!';
} else {
  tipoRecordatorio = 'vespertino';
  icono = '🌙';
  saludo = '¡Buenas noches!';
}

// Ajustar mensaje si es fin de semana
if (esFindeSemana) {
  saludo += ' ¡Feliz fin de semana!';
}

return [{
  json: {
    timestamp: ahora.toISOString(),
    hora_actual: `${hora}:${minuto.toString().padStart(2, '0')}`,
    tipo: tipoRecordatorio,
    icono: icono,
    saludo: saludo,
    dia_semana: nombreDia,
    fecha: fecha,
    es_finde: esFindeSemana
  }
}];
```

## Parte 3: Generar Contenido Dinámico

### Code Node: "Generar Recordatorio"

```javascript
// Obtener contexto del nodo anterior
const contexto = items[0].json;

// Base de frases motivacionales
const frasesMotivacionales = {
  matutino: [
    '💪 Cada mañana es una nueva oportunidad para ser mejor',
    '🌟 Hoy es un gran día para lograr tus metas',
    '🚀 El éxito comienza con el primer paso del día',
    '✨ Tu actitud determina tu día, ¡hazlo increíble!',
    '🎯 Concéntrate en tus objetivos, todo lo demás es ruido',
  ],
  mediodia: [
    '⚡ Recarga energías, aún queda mucho por hacer',
    '💼 El progreso de hoy será el éxito de mañana',
    '🎨 Sé creativo en la solución de problemas',
    '📊 Revisa tu progreso y ajusta tu rumbo',
    '🔥 Mantén el impulso, vas por buen camino',
  ],
  vespertino: [
    '🌆 Reflexiona sobre lo logrado hoy',
    '📝 Planifica mañana para un mejor inicio',
    '🧘 Desconecta y recarga para mañana',
    '⭐ Celebra tus pequeños logros del día',
    '💤 Descansa bien, mañana será otro gran día',
  ]
};

// Seleccionar frase aleatoria según el tipo
const frases = frasesMotivacionales[contexto.tipo];
const fraseAleatoria = frases[Math.floor(Math.random() * frases.length)];

// Tareas sugeridas según hora y día
let tareasSugeridas = [];

if (contexto.tipo === 'matutino') {
  tareasSugeridas = [
    { tarea: 'Revisar agenda del día', prioridad: 'Alta', estimado: '5 min' },
    { tarea: 'Responder emails urgentes', prioridad: 'Alta', estimado: '15 min' },
    { tarea: 'Planificar tareas prioritarias', prioridad: 'Media', estimado: '10 min' },
    { tarea: 'Ejercicio o meditación', prioridad: 'Media', estimado: '20 min' },
  ];
} else if (contexto.tipo === 'mediodia') {
  tareasSugeridas = [
    { tarea: 'Revisar progreso matutino', prioridad: 'Media', estimado: '10 min' },
    { tarea: 'Tomar descanso activo', prioridad: 'Alta', estimado: '15 min' },
    { tarea: 'Continuar tareas pendientes', prioridad: 'Alta', estimado: '2 horas' },
    { tarea: 'Coordinar con equipo', prioridad: 'Media', estimado: '20 min' },
  ];
} else {
  tareasSugeridas = [
    { tarea: 'Cerrar tareas del día', prioridad: 'Alta', estimado: '30 min' },
    { tarea: 'Preparar lista para mañana', prioridad: 'Alta', estimado: '10 min' },
    { tarea: 'Archivar y organizar', prioridad: 'Baja', estimado: '15 min' },
    { tarea: 'Revisar logros del día', prioridad: 'Media', estimado: '5 min' },
  ];
}

// Ajustar si es fin de semana
if (contexto.es_finde) {
  tareasSugeridas = [
    { tarea: 'Disfrutar tiempo libre', prioridad: 'Alta', estimado: '' },
    { tarea: 'Actividades recreativas', prioridad: 'Alta', estimado: '' },
    { tarea: 'Planificación semanal (opcional)', prioridad: 'Baja', estimado: '20 min' },
  ];
}

// Estadísticas simuladas
const estadisticas = {
  tareas_completadas_hoy: Math.floor(Math.random() * 8 + 2),
  tareas_pendientes: Math.floor(Math.random() * 5 + 1),
  tiempo_productivo: `${Math.floor(Math.random() * 4 + 2)}h ${Math.floor(Math.random() * 60)}m`,
  racha_dias: Math.floor(Math.random() * 30 + 1),
};

estadisticas.porcentaje_completado = Math.floor(
  (estadisticas.tareas_completadas_hoy /
    (estadisticas.tareas_completadas_hoy + estadisticas.tareas_pendientes)) * 100
);

// Próximo recordatorio
let proximoRecordatorio;
if (contexto.tipo === 'matutino') {
  proximoRecordatorio = { hora: '14:00', tipo: 'Mediodía' };
} else if (contexto.tipo === 'mediodia') {
  proximoRecordatorio = { hora: '19:00', tipo: 'Vespertino' };
} else {
  proximoRecordatorio = { hora: '08:00', tipo: 'Matutino (mañana)' };
}

return [{
  json: {
    ...contexto,
    frase_motivacional: fraseAleatoria,
    tareas_sugeridas: tareasSugeridas,
    estadisticas: estadisticas,
    proximo_recordatorio: proximoRecordatorio
  }
}];
```

## Parte 4: Formatear Notificación

### Code Node: "Formatear para Envío"

```javascript
const datos = items[0].json;

// Crear encabezado
const encabezado = `
${datos.icono} ${datos.saludo}
${datos.dia_semana}, ${datos.fecha}
━━━━━━━━━━━━━━━━━━━━
`.trim();

// Crear sección motivacional
const seccionMotivacional = `
💭 MENSAJE DEL DÍA:
${datos.frase_motivacional}
`.trim();

// Crear sección de tareas
let seccionTareas = '\n📋 TAREAS SUGERIDAS:\n';
datos.tareas_sugeridas.forEach((tarea, index) => {
  const numero = index + 1;
  const prioridad = tarea.prioridad === 'Alta' ? '🔴' :
                   tarea.prioridad === 'Media' ? '🟡' : '🟢';
  const tiempo = tarea.estimado ? ` (${tarea.estimado})` : '';
  seccionTareas += `  ${numero}. ${prioridad} ${tarea.tarea}${tiempo}\n`;
});

// Crear sección de estadísticas
const seccionEstadisticas = `
📊 TU PROGRESO HOY:
  ✅ Completadas: ${datos.estadisticas.tareas_completadas_hoy}
  ⏳ Pendientes: ${datos.estadisticas.tareas_pendientes}
  ⚡ Productividad: ${datos.estadisticas.porcentaje_completado}%
  ⏱️  Tiempo activo: ${datos.estadisticas.tiempo_productivo}
  🔥 Racha actual: ${datos.estadisticas.racha_dias} días
`.trim();

// Crear pie de página
const piePagina = `
━━━━━━━━━━━━━━━━━━━━
⏰ Próximo recordatorio: ${datos.proximo_recordatorio.hora} (${datos.proximo_recordatorio.tipo})
`.trim();

// Mensaje completo
const mensajeCompleto = `
${encabezado}

${seccionMotivacional}

${seccionTareas}

${seccionEstadisticas}

${piePagina}
`.trim();

// Versión estructurada para APIs
const notificacionEstructurada = {
  titulo: `${datos.icono} Recordatorio ${datos.tipo.charAt(0).toUpperCase() + datos.tipo.slice(1)}`,
  subtitulo: `${datos.dia_semana}, ${datos.fecha} - ${datos.hora_actual}`,
  cuerpo: mensajeCompleto,
  prioridad: datos.tipo === 'matutino' ? 'alta' : 'normal',
  categoria: 'recordatorio',
  acciones: [
    { id: 'ver_tareas', texto: 'Ver Tareas' },
    { id: 'posponer', texto: 'Recordar en 1 hora' },
    { id: 'completar', texto: 'Marcar como visto' }
  ]
};

return [{
  json: {
    mensaje_texto: mensajeCompleto,
    notificacion: notificacionEstructurada,
    metadata: {
      generado_en: new Date().toISOString(),
      tipo_recordatorio: datos.tipo,
      ejecucion_id: $execution.id
    }
  }
}];
```

## Parte 5: Simular Envío y Logging

### Code Node: "Enviar y Registrar"

```javascript
const datos = items[0].json;

// Simular envío a diferentes canales
const canalesEnvio = ['email', 'push_notification', 'slack'];

const resultadosEnvio = canalesEnvio.map(canal => {
  // Simular latencia de envío
  const latencia = Math.floor(Math.random() * 500 + 100);

  // Simular éxito (95% de éxito)
  const exitoso = Math.random() > 0.05;

  return {
    canal: canal,
    estado: exitoso ? 'enviado' : 'error',
    latencia_ms: latencia,
    timestamp: new Date().toISOString(),
    mensaje_id: `msg_${Date.now()}_${Math.random().toString(36).substr(2, 9)}`
  };
});

// Log detallado
console.log('═══════════════════════════════════════');
console.log('📨 RECORDATORIO ENVIADO');
console.log('═══════════════════════════════════════');
console.log('Tipo:', datos.notificacion.titulo);
console.log('Hora:', datos.metadata.generado_en);
console.log('Ejecución ID:', datos.metadata.ejecucion_id);
console.log('');
console.log('Canales de envío:');
resultadosEnvio.forEach(resultado => {
  const icono = resultado.estado === 'enviado' ? '✅' : '❌';
  console.log(`  ${icono} ${resultado.canal}: ${resultado.estado} (${resultado.latencia_ms}ms)`);
});
console.log('');
console.log('Mensaje enviado:');
console.log(datos.mensaje_texto);
console.log('═══════════════════════════════════════');

// Estadísticas de envío
const exitosos = resultadosEnvio.filter(r => r.estado === 'enviado').length;
const fallidos = resultadosEnvio.filter(r => r.estado === 'error').length;

// Resultado final
const resultado = {
  recordatorio: datos.notificacion,
  mensaje_texto: datos.mensaje_texto,

  envio: {
    total_canales: canalesEnvio.length,
    exitosos: exitosos,
    fallidos: fallidos,
    tasa_exito: `${((exitosos / canalesEnvio.length) * 100).toFixed(1)}%`,
    resultados_detallados: resultadosEnvio
  },

  logs: {
    timestamp: new Date().toISOString(),
    ejecucion_id: datos.metadata.ejecucion_id,
    tipo_recordatorio: datos.metadata.tipo_recordatorio,
    estado_general: fallidos === 0 ? 'SUCCESS' : fallidos < canalesEnvio.length ? 'PARTIAL' : 'FAILED'
  }
};

return [{ json: resultado }];
```

## Testing del Proyecto

### Fase 1: Test Manual

1. Usa **Manual Trigger** en lugar de Schedule
2. Ejecuta varias veces y observa que:
   - Las frases motivacionales cambian (son aleatorias)
   - Las estadísticas varían
   - El formato es correcto
   - Los logs se muestran en consola

### Fase 2: Test con Different Times

Modifica temporalmente el código para simular diferentes horas:

```javascript
// En el primer Code node, reemplaza temporalmente:
const ahora = new Date();
const hora = ahora.getHours();

// Por:
const ahora = new Date();
const hora = 8; // Prueba con 8, 14, 19
```

### Fase 3: Activar Schedule

1. Reemplaza Manual Trigger con Schedule Trigger
2. Configura los horarios: 08:00, 14:00, 19:00
3. **Activa el workflow** (switch arriba)
4. Espera a la hora programada o verifica en Executions

## Mejoras Opcionales (Bonus)

### 1. Persistencia de Estadísticas

Agregar un nodo para guardar stats reales (requiere Módulo 4):
```javascript
// Guardar en JSON file o database
// Por ahora, simula con valores incrementales
```

### 2. Personalización por Usuario

```javascript
const perfilUsuario = {
  nombre: 'Juan',
  zona_horaria: 'America/Mexico_City',
  preferencias: {
    recordatorios_finde: false,
    tono: 'motivacional' // o 'profesional', 'casual'
  }
};
```

### 3. Integración Real con Slack/Email

Ver Módulo 3 para implementar envío real.

## Criterios de Evaluación

Tu proyecto está completo cuando:

- ✅ El workflow se ejecuta sin errores
- ✅ Genera recordatorios diferentes según la hora
- ✅ Las frases motivacionales son aleatorias
- ✅ Las tareas sugeridas cambian según el contexto
- ✅ El formato del mensaje es legible y profesional
- ✅ Los logs muestran información útil
- ✅ Simula el envío a múltiples canales
- ✅ (Opcional) Funciona con Schedule Trigger automático

## Entrega

Exporta tu workflow:
1. Click en el menú (tres líneas) → "Download"
2. Guarda como: `sistema-recordatorios.json`

## Reflexión

Después de completar este proyecto, deberías:
- Entender cómo automatizar tareas con Schedule Trigger
- Saber implementar lógica condicional compleja
- Poder manejar datos dinámicos y aleatorios
- Formatear datos para presentación profesional
- Simular interacciones con servicios externos

## Siguiente Paso

¡Felicidades! Has completado el Módulo 1.

Ahora estás listo para el **Módulo 2: Trabajando con Datos y Expresiones** donde aprenderás a:
- Manipular datos complejos
- Usar expresiones avanzadas
- Trabajar con múltiples items
- Implementar transformaciones poderosas

---

**¡Excelente trabajo llegando hasta aquí!** 🎉
