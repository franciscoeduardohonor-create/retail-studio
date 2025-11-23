# Ejercicio 2: API del Clima

## Nivel: Principiante

## Objetivo
Aprender a consumir APIs reales y procesar datos del mundo real.

## Requisitos

Crea un workflow que:

1. Obtenga datos del clima de una ciudad usando una API pública
2. Extraiga información relevante (temperatura, descripción, humedad)
3. Formatee los datos de manera legible
4. Agregue información adicional calculada

## API a Utilizar

Usaremos **Open-Meteo** (no requiere API key):

```
https://api.open-meteo.com/v1/forecast?latitude=19.43&longitude=-99.13&current_weather=true
```

Coordenadas de ejemplo (Ciudad de México):
- Latitud: 19.43
- Longitud: -99.13

## Estructura del Workflow

```
[Manual Trigger] → [Set: Coords] → [HTTP Request] → [Code: Process] → [Code: Format]
```

## Parte 1: Set Coordinates

Crea variables para las coordenadas:

```
Name: lat → Value: 19.43
Name: lon → Value: -99.13
Name: ciudad → Value: Ciudad de México
```

💡 **Cambia estas coordenadas** a las de tu ciudad favorita.

## Parte 2: HTTP Request

Configura el nodo HTTP Request:

- **Method:** GET
- **URL:** `https://api.open-meteo.com/v1/forecast?latitude={{ $json.lat }}&longitude={{ $json.lon }}&current_weather=true&timezone=auto`

💡 Nota cómo usamos `{{ $json.lat }}` y `{{ $json.lon }}` para valores dinámicos.

## Parte 3: Process Data (Code Node)

```javascript
// COMPLETA ESTE CÓDIGO

// Obtén los datos de la ciudad
const ciudad = $('Set').first().json.ciudad;

// Obtén el clima actual de la respuesta
const climaActual = items[0].json.current_weather;

// Extrae los datos importantes
const temperatura = // temp en celsius
const velocidadViento = // windspeed
const direccionViento = // winddirection en grados

// Convierte la dirección del viento de grados a punto cardinal
// 0/360 = N, 90 = E, 180 = S, 270 = W
function gradosADireccion(grados) {
  // Implementa esta función
  // Pista: usa if/else o un array de direcciones
}

// Determina descripción del clima según código WMO
function codigoWMOaDescripcion(codigo) {
  // 0 = Despejado
  // 1-3 = Parcialmente nublado
  // 45, 48 = Niebla
  // etc.
  // Implementa al menos 3 casos
}

// Calcula temperatura en Fahrenheit
const tempFahrenheit = // Fórmula: (C * 9/5) + 32

// Determina si hace calor, frío o templado
const sensacion = // Implementa lógica

// Retorna datos procesados
return [{
  json: {
    // Completa aquí
  }
}];
```

## Resultado Esperado

```json
{
  "ciudad": "Ciudad de México",
  "timestamp": "2025-11-23T10:30:00",
  "clima_actual": {
    "temperatura_celsius": 18.5,
    "temperatura_fahrenheit": 65.3,
    "sensacion": "Templado",
    "descripcion": "Parcialmente nublado",
    "codigo_wmo": 2
  },
  "viento": {
    "velocidad_kmh": 12,
    "velocidad_mph": 7.5,
    "direccion_grados": 225,
    "direccion_cardinal": "SW (Suroeste)"
  },
  "analisis": {
    "condicion_general": "Buen día para salir",
    "recomendacion_ropa": "Chamarra ligera",
    "actividad_sugerida": "Ideal para caminar"
  }
}
```

## Pistas

### Convertir Grados a Dirección Cardinal

```javascript
function gradosADireccion(grados) {
  const direcciones = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
  const index = Math.round(grados / 45) % 8;
  return direcciones[index];
}
```

### Código WMO Weather Codes (Simplificado)

```javascript
function codigoWMOaDescripcion(codigo) {
  const descripciones = {
    0: 'Despejado ☀️',
    1: 'Mayormente despejado 🌤️',
    2: 'Parcialmente nublado ⛅',
    3: 'Nublado ☁️',
    45: 'Niebla 🌫️',
    48: 'Niebla con escarcha 🌫️❄️',
    51: 'Llovizna ligera 🌦️',
    61: 'Lluvia ligera 🌧️',
    71: 'Nevada ligera 🌨️',
    95: 'Tormenta ⛈️'
  };
  return descripciones[codigo] || 'Desconocido';
}
```

### Convertir km/h a mph

```javascript
const mph = kmh * 0.621371;
```

## Bonus Challenges

### 1. Múltiples Ciudades

Modifica el workflow para consultar 3 ciudades y comparar:

Set Node:
```javascript
// Usa un array de ciudades
ciudades: [
  { nombre: 'Ciudad de México', lat: 19.43, lon: -99.13 },
  { nombre: 'Guadalajara', lat: 20.66, lon: -103.35 },
  { nombre: 'Monterrey', lat: 25.68, lon: -100.31 }
]
```

### 2. Pronóstico de 7 Días

Usa este endpoint para obtener pronóstico semanal:
```
https://api.open-meteo.com/v1/forecast?latitude=LAT&longitude=LON&daily=temperature_2m_max,temperature_2m_min,precipitation_sum&timezone=auto
```

### 3. Alertas Personalizadas

Agrega lógica para generar alertas:
```javascript
const alertas = [];

if (temperatura > 30) {
  alertas.push('🔥 Alerta de calor extremo');
}

if (velocidadViento > 40) {
  alertas.push('💨 Vientos fuertes');
}

// Agrega más condiciones...
```

## Tiempo Estimado
25-30 minutos

---

## Solución Completa

<details>
<summary>⚠️ Solo mira la solución después de intentarlo</summary>

### Set Node
```
Name: lat → Value: 19.43
Name: lon → Value: -99.13
Name: ciudad → Value: Ciudad de México
```

### HTTP Request
- **Method:** GET
- **URL:** `https://api.open-meteo.com/v1/forecast?latitude={{ $json.lat }}&longitude={{ $json.lon }}&current_weather=true&timezone=auto`

### Code Node: Process Data

```javascript
// Obtener datos de nodos anteriores
const ciudad = $('Set').first().json.ciudad;
const respuestaAPI = items[0].json;
const climaActual = respuestaAPI.current_weather;

// Extraer datos importantes
const temperatura = climaActual.temperature;
const velocidadViento = climaActual.windspeed;
const direccionViento = climaActual.winddirection;
const codigoWMO = climaActual.weathercode;
const timestamp = climaActual.time;

// Función: Grados a dirección cardinal
function gradosADireccion(grados) {
  const direcciones = [
    'N (Norte)',
    'NE (Noreste)',
    'E (Este)',
    'SE (Sureste)',
    'S (Sur)',
    'SW (Suroeste)',
    'W (Oeste)',
    'NW (Noroeste)'
  ];
  const index = Math.round(grados / 45) % 8;
  return direcciones[index];
}

// Función: Código WMO a descripción
function codigoWMOaDescripcion(codigo) {
  const descripciones = {
    0: 'Despejado ☀️',
    1: 'Mayormente despejado 🌤️',
    2: 'Parcialmente nublado ⛅',
    3: 'Nublado ☁️',
    45: 'Niebla 🌫️',
    48: 'Niebla con escarcha 🌫️❄️',
    51: 'Llovizna ligera 🌦️',
    53: 'Llovizna moderada 🌦️',
    55: 'Llovizna intensa 🌦️',
    61: 'Lluvia ligera 🌧️',
    63: 'Lluvia moderada 🌧️',
    65: 'Lluvia intensa 🌧️',
    71: 'Nevada ligera 🌨️',
    73: 'Nevada moderada 🌨️',
    75: 'Nevada intensa 🌨️',
    95: 'Tormenta ⛈️',
    96: 'Tormenta con granizo ⛈️🧊'
  };
  return descripciones[codigo] || `Código ${codigo}`;
}

// Conversiones
const tempFahrenheit = (temperatura * 9/5) + 32;
const velocidadMPH = velocidadViento * 0.621371;

// Determinar sensación térmica
let sensacion;
if (temperatura < 10) {
  sensacion = 'Frío ❄️';
} else if (temperatura < 20) {
  sensacion = 'Fresco 🍃';
} else if (temperatura < 25) {
  sensacion = 'Templado 🌡️';
} else if (temperatura < 30) {
  sensacion = 'Cálido ☀️';
} else {
  sensacion = 'Caluroso 🔥';
}

// Análisis y recomendaciones
let condicionGeneral;
let recomendacionRopa;
let actividadSugerida;

if (codigoWMO >= 61) {
  condicionGeneral = 'Día lluvioso, prepara paraguas';
  recomendacionRopa = 'Impermeable y paraguas';
  actividadSugerida = 'Actividades bajo techo';
} else if (codigoWMO >= 45) {
  condicionGeneral = 'Día con poca visibilidad';
  recomendacionRopa = 'Chamarra';
  actividadSugerida = 'Ten cuidado al conducir';
} else if (temperatura > 28) {
  condicionGeneral = 'Día caluroso';
  recomendacionRopa = 'Ropa ligera y protector solar';
  actividadSugerida = 'Busca sombra, mantente hidratado';
} else if (temperatura < 15) {
  condicionGeneral = 'Día frío';
  recomendacionRopa = 'Abrigo o chamarra gruesa';
  actividadSugerida = 'Bebida caliente recomendada';
} else {
  condicionGeneral = 'Buen día para salir';
  recomendacionRopa = 'Chamarra ligera';
  actividadSugerida = 'Ideal para caminar';
}

// Alertas
const alertas = [];
if (temperatura > 35) alertas.push('🔥 ALERTA: Calor extremo');
if (temperatura < 0) alertas.push('❄️ ALERTA: Temperaturas bajo cero');
if (velocidadViento > 50) alertas.push('💨 ALERTA: Vientos muy fuertes');
if (codigoWMO >= 95) alertas.push('⛈️ ALERTA: Tormenta eléctrica');

// Resultado final
const resultado = {
  ciudad: ciudad,
  timestamp: timestamp,
  fecha_legible: new Date(timestamp).toLocaleString('es-ES', {
    weekday: 'long',
    year: 'numeric',
    month: 'long',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  }),

  clima_actual: {
    temperatura_celsius: temperatura,
    temperatura_fahrenheit: parseFloat(tempFahrenheit.toFixed(1)),
    sensacion: sensacion,
    descripcion: codigoWMOaDescripcion(codigoWMO),
    codigo_wmo: codigoWMO
  },

  viento: {
    velocidad_kmh: velocidadViento,
    velocidad_mph: parseFloat(velocidadMPH.toFixed(1)),
    direccion_grados: direccionViento,
    direccion_cardinal: gradosADireccion(direccionViento)
  },

  analisis: {
    condicion_general: condicionGeneral,
    recomendacion_ropa: recomendacionRopa,
    actividad_sugerida: actividadSugerida
  },

  alertas: alertas.length > 0 ? alertas : ['Sin alertas'],

  metadata: {
    fuente: 'Open-Meteo API',
    consultado_en: new Date().toISOString()
  }
};

// Log para debugging
console.log('🌤️ Clima obtenido para:', ciudad);
console.log('🌡️ Temperatura:', temperatura, '°C');
console.log('📝 Descripción:', codigoWMOaDescripcion(codigoWMO));

return [{ json: resultado }];
```

</details>

## Variaciones para Practicar

1. **Cambiar a Diferentes Ciudades:**
   - Nueva York: lat: 40.71, lon: -74.01
   - Londres: lat: 51.51, lon: -0.13
   - Tokio: lat: 35.68, lon: 139.65
   - Sydney: lat: -33.87, lon: 151.21

2. **Agregar Pronóstico de 3 Días:**
   Usa el endpoint con `&daily=temperature_2m_max,temperature_2m_min&forecast_days=3`

3. **Comparador de Ciudades:**
   Crea un loop que consulte múltiples ciudades y encuentre cuál tiene mejor clima

## Aprendizajes Clave

- ✅ Consumir APIs REST con HTTP Request
- ✅ Usar valores dinámicos con expresiones `{{ }}`
- ✅ Procesar respuestas JSON complejas
- ✅ Crear funciones helper en Code nodes
- ✅ Formatear datos para presentación
- ✅ Implementar lógica condicional

## Siguiente Paso

Continúa con el **Ejercicio 3: Programador Diario** para aprender sobre Schedule Triggers.
