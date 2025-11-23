# Módulo 3: APIs y Webhooks

## Objetivos de Aprendizaje

- Consumir APIs REST complejas
- Implementar autenticación (API Keys, OAuth, Bearer tokens)
- Crear y recibir webhooks
- Manejar errores y reintentos
- Trabajar con paginación
- Rate limiting y optimización

## Contenido

### 1. HTTP Request Avanzado

#### Métodos HTTP

```javascript
GET     // Obtener datos
POST    // Crear recursos
PUT     // Actualizar completo
PATCH   // Actualizar parcial
DELETE  // Eliminar
```

#### Headers Comunes

```javascript
{
  "Content-Type": "application/json",
  "Authorization": "Bearer YOUR_TOKEN",
  "User-Agent": "n8n-workflow",
  "Accept": "application/json"
}
```

### 2. Autenticación

#### API Key en Header

```
Header Name: X-API-Key
Header Value: {{ $credentials.apiKey }}
```

#### Bearer Token

```
Header Name: Authorization
Header Value: Bearer {{ $credentials.token }}
```

#### OAuth 2.0

n8n maneja OAuth automáticamente con credenciales configuradas.

### 3. Webhooks

#### Webhook Trigger

Recibe datos de servicios externos.

**URL del webhook:**
```
https://your-n8n.com/webhook/unique-path
```

**Ejemplo de uso:**
- Recibir formularios
- Integraciones en tiempo real
- Eventos de GitHub, Stripe, etc.

#### Responder a Webhooks

```javascript
// Webhook Response Node
return [{
  json: {
    status: 'success',
    message: 'Datos recibidos correctamente',
    received_at: new Date().toISOString()
  }
}];
```

### 4. Manejo de Errores

#### Try-Catch en Code Node

```javascript
try {
  // Tu lógica
  const resultado = procesarDatos(items);
  return resultado;

} catch (error) {
  console.error('❌ Error:', error.message);

  // Retornar error estructurado
  return [{
    json: {
      error: true,
      mensaje: error.message,
      timestamp: new Date().toISOString()
    }
  }];
}
```

#### Error Trigger

Configura un workflow que se ejecute cuando otro falla.

### 5. Paginación

#### Patrón común de paginación

```javascript
let todosLosDatos = [];
let pagina = 1;
let hayMasPaginas = true;

while (hayMasPaginas) {
  // Hacer request a API
  const url = `https://api.example.com/data?page=${pagina}&limit=100`;

  // Simular petición HTTP (en n8n usarías HTTP Request node)
  const respuesta = await fetch(url);
  const datos = await respuesta.json();

  todosLosDatos = todosLosDatos.concat(datos.items);

  // Verificar si hay más páginas
  if (datos.items.length < 100 || !datos.next_page) {
    hayMasPaginas = false;
  }

  pagina++;
}

return todosLosDatos.map(item => ({ json: item }));
```

### 6. Rate Limiting

#### Implementar delays

```javascript
// Procesar en lotes con delay
const lotes = [];
const tamañoLote = 10;

for (let i = 0; i < items.length; i += tamañoLote) {
  const lote = items.slice(i, i + tamañoLote);

  // Procesar lote
  await procesarLote(lote);

  // Esperar para respetar rate limits
  if (i + tamañoLote < items.length) {
    await new Promise(resolve => setTimeout(resolve, 1000)); // 1 segundo
  }
}
```

## Ejemplo Práctico 1: GitHub API

### Obtener Repositorios

```javascript
// HTTP Request
Method: GET
URL: https://api.github.com/users/{{ $json.username }}/repos

Headers:
  Authorization: token {{ $credentials.githubToken }}
  Accept: application/vnd.github.v3+json
```

### Procesar Respuesta

```javascript
const repos = items[0].json;

const analisis = repos.map(repo => ({
  nombre: repo.name,
  estrellas: repo.stargazers_count,
  lenguaje: repo.language,
  url: repo.html_url,
  actualizado: repo.updated_at
}));

// Ordenar por estrellas
analisis.sort((a, b) => b.estrellas - a.estrellas);

return analisis.map(item => ({ json: item }));
```

## Ejemplo Práctico 2: Webhook de Formulario

### Workflow

```
[Webhook Trigger] → [Validate Data] → [Save to DB] → [Send Email] → [Webhook Response]
```

### Validate Data

```javascript
const datos = items[0].json;

// Validar campos requeridos
const camposRequeridos = ['nombre', 'email', 'mensaje'];
const faltantes = camposRequeridos.filter(campo => !datos[campo]);

if (faltantes.length > 0) {
  throw new Error(`Campos faltantes: ${faltantes.join(', ')}`);
}

// Validar email
const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
if (!emailRegex.test(datos.email)) {
  throw new Error('Email inválido');
}

// Sanitizar datos
return [{
  json: {
    nombre: datos.nombre.trim(),
    email: datos.email.toLowerCase().trim(),
    mensaje: datos.mensaje.trim(),
    fecha_recibido: new Date().toISOString(),
    ip: datos.$request?.headers['x-forwarded-for'] || 'unknown'
  }
}];
```

## Ejemplo Práctico 3: API con Paginación

Ver: `ejemplos/03-paginacion-api.md`

## Ejercicios

### Ejercicio 1: CRUD Completo
Implementa Create, Read, Update, Delete con una API REST.

### Ejercicio 2: Webhook Processor
Crea un sistema que reciba webhooks, valide, procese y responda.

### Ejercicio 3: API Aggregator
Consume múltiples APIs y combina sus datos.

## Proyecto: Integración Completa con API Externa

Ver: `ejercicios/proyecto-modulo-3.md`

**Sistema de Monitoreo de Criptomonedas:**
1. Consume CoinGecko API
2. Obtiene precios de múltiples monedas
3. Calcula cambios y tendencias
4. Envía alertas cuando hay cambios significativos
5. Guarda histórico

## APIs Recomendadas para Practicar

### Sin Autenticación
- **JSONPlaceholder:** https://jsonplaceholder.typicode.com
- **REST Countries:** https://restcountries.com
- **Open Meteo:** https://open-meteo.com
- **CoinGecko:** https://www.coingecko.com/en/api

### Con API Key (Gratuitas)
- **OpenWeatherMap:** https://openweathermap.org/api
- **NewsAPI:** https://newsapi.org
- **NASA API:** https://api.nasa.gov
- **TMDB (Movies):** https://www.themoviedb.org/documentation/api

### Webhooks para Practicar
- **GitHub Webhooks:** Eventos de repositorios
- **Stripe Webhooks:** Eventos de pagos (modo test)
- **Discord Webhooks:** Mensajes a canales
- **Slack Webhooks:** Notificaciones

## Patrones Importantes

### Patrón: Retry con Backoff Exponencial

```javascript
async function fetchConReintentos(url, maxReintentos = 3) {
  for (let intento = 0; intento < maxReintentos; intento++) {
    try {
      const respuesta = await fetch(url);
      if (respuesta.ok) {
        return await respuesta.json();
      }
    } catch (error) {
      if (intento === maxReintentos - 1) throw error;

      // Backoff exponencial: 1s, 2s, 4s...
      const delay = Math.pow(2, intento) * 1000;
      await new Promise(resolve => setTimeout(resolve, delay));
    }
  }
}
```

### Patrón: Batch Processing

```javascript
// Procesar items en lotes de 50
const BATCH_SIZE = 50;
const resultados = [];

for (let i = 0; i < items.length; i += BATCH_SIZE) {
  const lote = items.slice(i, i + BATCH_SIZE);

  // Procesar lote en paralelo
  const promesas = lote.map(item => procesarItem(item));
  const resultadosLote = await Promise.all(promesas);

  resultados.push(...resultadosLote);

  // Rate limiting
  await new Promise(resolve => setTimeout(resolve, 100));
}

return resultados.map(r => ({ json: r }));
```

## Best Practices

✅ **DO:**
- Siempre valida respuestas de APIs
- Implementa manejo de errores robusto
- Usa reintentos con backoff exponencial
- Respeta rate limits
- Guarda logs de errores
- Usa timeouts apropiados

❌ **DON'T:**
- No expongas API keys en el código
- No ignores códigos de error HTTP
- No hagas loops infinitos sin límite
- No sobrecargues APIs externas
- No asumas que las APIs siempre responden

## Debugging de APIs

### Ver Request Completo

```javascript
console.log('REQUEST:');
console.log('URL:', url);
console.log('Method:', method);
console.log('Headers:', headers);
console.log('Body:', JSON.stringify(body, null, 2));
```

### Ver Response Completo

```javascript
console.log('RESPONSE:');
console.log('Status:', response.status);
console.log('Headers:', response.headers);
console.log('Body:', JSON.stringify(response.data, null, 2));
```

## Recursos

- [HTTP Status Codes](https://httpstatuses.com/)
- [REST API Tutorial](https://restfulapi.net/)
- [Webhook.site](https://webhook.site/) - Testing webhooks
- [Postman](https://www.postman.com/) - Testing APIs

## Tiempo Estimado
4-5 días

## Siguiente Paso

**Módulo 4: Código Personalizado y JavaScript Avanzado**

Aprenderás:
- JavaScript avanzado en n8n
- Librerías disponibles (moment, axios, lodash)
- Operaciones complejas
- Integración con bases de datos
- Performance optimization

---

¡Las APIs son el puente entre servicios! 🌉
