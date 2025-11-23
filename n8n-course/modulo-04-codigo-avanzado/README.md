# Módulo 4: Código Personalizado y JavaScript Avanzado

## Objetivos de Aprendizaje

- Dominar el nodo Code con JavaScript avanzado
- Usar librerías disponibles en n8n
- Implementar algoritmos complejos
- Optimizar performance
- Debugging avanzado
- Trabajar con datos externos (archivos, bases de datos)

## Librerías Disponibles en n8n

### Librerías Integradas

```javascript
// Moment.js - Manejo de fechas
const moment = require('moment');
const fecha = moment().format('YYYY-MM-DD');

// Lodash - Utilidades para datos
const _ = require('lodash');
const unicos = _.uniq([1, 2, 2, 3, 3, 3]);

// Axios - HTTP requests
const axios = require('axios');
const { data } = await axios.get('https://api.example.com/data');

// crypto - Criptografía
const crypto = require('crypto');
const hash = crypto.createHash('sha256').update('texto').digest('hex');
```

### Variables Globales de n8n

```javascript
$input           // Datos de entrada
$items           // Alias de items
$json            // JSON del primer item
$binary          // Datos binarios
$node            // Información del nodo actual
$workflow        // Información del workflow
$execution       // Información de la ejecución
$itemIndex       // Índice del item actual (en loops)
$now             // Fecha/hora actual (Luxon)
$today           // Fecha actual sin hora
```

## Ejemplo 1: Trabajar con Fechas (Moment.js)

```javascript
const moment = require('moment');

// Configurar español
moment.locale('es');

const operacionesFecha = {
  // Fecha actual
  ahora: moment().format('LLLL'),

  // Sumar/restar
  en_7_dias: moment().add(7, 'days').format('YYYY-MM-DD'),
  hace_30_dias: moment().subtract(30, 'days').format('YYYY-MM-DD'),

  // Diferencias
  dias_hasta_navidad: moment('2025-12-25').diff(moment(), 'days'),

  // Inicio/fin de periodo
  inicio_mes: moment().startOf('month').format('YYYY-MM-DD'),
  fin_mes: moment().endOf('month').format('YYYY-MM-DD'),

  // Formateo personalizado
  fecha_legible: moment().format('dddd D [de] MMMM [de] YYYY'),

  // Validar fecha
  es_valida: moment('2025-13-45', 'YYYY-MM-DD').isValid(), // false

  // Comparaciones
  es_despues: moment('2025-12-25').isAfter(moment()),
  es_antes: moment('2020-01-01').isBefore(moment()),

  // Rangos
  esta_en_rango: moment('2025-11-23').isBetween('2025-11-01', '2025-11-30')
};

return [{ json: operacionesFecha }];
```

## Ejemplo 2: Manipulación de Datos con Lodash

```javascript
const _ = require('lodash');

const datos = items.map(item => item.json);

// Operaciones útiles
const procesado = {
  // Eliminar duplicados
  emails_unicos: _.uniq(datos.map(d => d.email)),

  // Agrupar por campo
  por_categoria: _.groupBy(datos, 'categoria'),

  // Obtener valores de un campo
  todos_nombres: _.map(datos, 'nombre'),

  // Filtrar por condición
  activos: _.filter(datos, { activo: true }),

  // Encontrar uno
  primero_premium: _.find(datos, { tipo: 'premium' }),

  // Ordenar
  ordenado_precio: _.orderBy(datos, ['precio'], ['desc']),

  // Aplanar array anidado
  tags_planos: _.flatMap(datos, 'tags'),

  // Obtener valor profundo seguro
  valor_seguro: _.get(datos[0], 'usuario.perfil.nombre', 'N/A'),

  // Chunk (dividir en grupos)
  grupos_de_10: _.chunk(datos, 10),

  // Diferencia entre arrays
  diferencia: _.difference([1, 2, 3, 4], [2, 4]),

  // Merge profundo
  combinado: _.merge(
    { a: 1, b: { c: 2 } },
    { b: { d: 3 } }
  ), // { a: 1, b: { c: 2, d: 3 } }

  // Tomar muestra aleatoria
  muestra_5: _.sampleSize(datos, 5),

  // Debounce function (útil para evitar sobrecarga)
  estadisticas: {
    total: _.size(datos),
    promedio_precio: _.meanBy(datos, 'precio'),
    suma_total: _.sumBy(datos, 'precio'),
    max_precio: _.maxBy(datos, 'precio')?.precio,
    min_precio: _.minBy(datos, 'precio')?.precio
  }
};

return [{ json: procesado }];
```

## Ejemplo 3: HTTP Requests con Axios

```javascript
const axios = require('axios');

// GET simple
const respuesta = await axios.get('https://api.github.com/users/octocat');
const usuario = respuesta.data;

// POST con datos
const nuevoPost = await axios.post('https://jsonplaceholder.typicode.com/posts', {
  title: 'Mi título',
  body: 'Mi contenido',
  userId: 1
}, {
  headers: {
    'Content-Type': 'application/json'
  }
});

// Múltiples requests en paralelo
const [usuarios, posts, comentarios] = await Promise.all([
  axios.get('https://jsonplaceholder.typicode.com/users'),
  axios.get('https://jsonplaceholder.typicode.com/posts'),
  axios.get('https://jsonplaceholder.typicode.com/comments?_limit=10')
]);

// Con manejo de errores
let datos;
try {
  const response = await axios.get('https://api.example.com/data', {
    timeout: 5000, // 5 segundos
    headers: {
      'Authorization': 'Bearer YOUR_TOKEN'
    }
  });
  datos = response.data;
} catch (error) {
  if (error.response) {
    // Error de respuesta (4xx, 5xx)
    console.error('Error de API:', error.response.status, error.response.data);
    datos = { error: true, status: error.response.status };
  } else if (error.request) {
    // No hubo respuesta
    console.error('Sin respuesta del servidor');
    datos = { error: true, mensaje: 'Timeout o sin conexión' };
  } else {
    // Error en configuración
    console.error('Error:', error.message);
    datos = { error: true, mensaje: error.message };
  }
}

return [{
  json: {
    usuario: usuario,
    nuevo_post: nuevoPost.data,
    paralelo: {
      total_usuarios: usuarios.data.length,
      total_posts: posts.data.length,
      total_comentarios: comentarios.data.length
    },
    datos_con_manejo_error: datos
  }
}];
```

## Ejemplo 4: Criptografía y Seguridad

```javascript
const crypto = require('crypto');

const texto = 'información sensible';
const secreto = 'mi-clave-secreta-super-segura';

// 1. Hash (SHA-256)
const hash = crypto
  .createHash('sha256')
  .update(texto)
  .digest('hex');

// 2. HMAC (Hash con clave)
const hmac = crypto
  .createHmac('sha256', secreto)
  .update(texto)
  .digest('hex');

// 3. Generar ID único
const uuid = crypto.randomUUID();

// 4. Generar token aleatorio
const token = crypto.randomBytes(32).toString('hex');

// 5. Cifrar datos (AES)
const algorithm = 'aes-256-cbc';
const key = crypto.scryptSync(secreto, 'salt', 32);
const iv = crypto.randomBytes(16);

const cipher = crypto.createCipheriv(algorithm, key, iv);
let encrypted = cipher.update(texto, 'utf8', 'hex');
encrypted += cipher.final('hex');

// 6. Descifrar datos
const decipher = crypto.createDecipheriv(algorithm, key, iv);
let decrypted = decipher.update(encrypted, 'hex', 'utf8');
decrypted += decipher.final('utf8');

return [{
  json: {
    original: texto,
    hash_sha256: hash,
    hmac: hmac,
    uuid: uuid,
    token_aleatorio: token,
    cifrado: {
      encrypted: encrypted,
      iv: iv.toString('hex'),
      decrypted: decrypted
    },
    validaciones: {
      cifrado_correcto: texto === decrypted,
      hash_unico: hash.length === 64
    }
  }
}];
```

## Ejemplo 5: Algoritmos y Lógica Compleja

### Algoritmo de Búsqueda Binaria

```javascript
function busquedaBinaria(array, objetivo) {
  let inicio = 0;
  let fin = array.length - 1;

  while (inicio <= fin) {
    const medio = Math.floor((inicio + fin) / 2);

    if (array[medio] === objetivo) {
      return medio; // Encontrado
    }

    if (array[medio] < objetivo) {
      inicio = medio + 1;
    } else {
      fin = medio - 1;
    }
  }

  return -1; // No encontrado
}

// Datos ordenados
const numeros = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19];
const indice = busquedaBinaria(numeros, 11);

return [{ json: { encontrado_en_indice: indice } }];
```

### Procesamiento de Texto Avanzado

```javascript
const texto = items[0].json.contenido;

// Análisis de texto
const analisis = {
  // Estadísticas básicas
  total_caracteres: texto.length,
  total_palabras: texto.split(/\s+/).length,
  total_lineas: texto.split('\n').length,

  // Contar frecuencia de palabras
  frecuencia_palabras: texto
    .toLowerCase()
    .match(/\b\w+\b/g)
    .reduce((acc, palabra) => {
      acc[palabra] = (acc[palabra] || 0) + 1;
      return acc;
    }, {}),

  // Palabras más comunes (top 10)
  palabras_comunes: Object.entries(
    texto.toLowerCase().match(/\b\w+\b/g).reduce((acc, p) => {
      acc[p] = (acc[p] || 0) + 1;
      return acc;
    }, {})
  )
  .sort((a, b) => b[1] - a[1])
  .slice(0, 10)
  .map(([palabra, count]) => ({ palabra, apariciones: count })),

  // Extraer emails
  emails: texto.match(/\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b/g) || [],

  // Extraer URLs
  urls: texto.match(/https?:\/\/[^\s]+/g) || [],

  // Extraer números de teléfono (formato simple)
  telefonos: texto.match(/\b\d{10}\b/g) || [],

  // Sentiment analysis básico (muy simplificado)
  palabras_positivas: (texto.match(/\b(bueno|excelente|genial|increíble|maravilloso)\b/gi) || []).length,
  palabras_negativas: (texto.match(/\b(malo|terrible|horrible|pésimo|deficiente)\b/gi) || []).length
};

// Calcular sentiment score
analisis.sentiment_score = analisis.palabras_positivas - analisis.palabras_negativas;
analisis.sentiment = analisis.sentiment_score > 0 ? 'Positivo' :
                     analisis.sentiment_score < 0 ? 'Negativo' : 'Neutral';

return [{ json: analisis }];
```

### Sistema de Caché Simple

```javascript
// Usar un objeto global para cachear (persiste durante la ejecución)
if (!global.cache) {
  global.cache = {};
}

const cacheKey = 'mi_dato_cacheado';
const CACHE_TTL = 5 * 60 * 1000; // 5 minutos

// Función para obtener datos (con caché)
async function obtenerDatosConCache(key) {
  const ahora = Date.now();

  // Verificar si existe en caché y no ha expirado
  if (global.cache[key] && global.cache[key].expira > ahora) {
    console.log('✅ Datos obtenidos del caché');
    return global.cache[key].datos;
  }

  // Si no está en caché, obtener datos frescos
  console.log('🔄 Obteniendo datos frescos...');
  const axios = require('axios');
  const { data } = await axios.get('https://api.example.com/data');

  // Guardar en caché
  global.cache[key] = {
    datos: data,
    expira: ahora + CACHE_TTL
  };

  return data;
}

const datos = await obtenerDatosConCache(cacheKey);

return [{ json: datos }];
```

## Performance Optimization

### 1. Procesar en Lotes (Batching)

```javascript
const BATCH_SIZE = 100;
const resultados = [];

// Procesar en lotes para evitar memory issues
for (let i = 0; i < items.length; i += BATCH_SIZE) {
  const lote = items.slice(i, i + BATCH_SIZE);

  const procesados = lote.map(item => {
    // Procesamiento pesado aquí
    return procesarItem(item);
  });

  resultados.push(...procesados);

  // Log progreso
  console.log(`Procesados ${Math.min(i + BATCH_SIZE, items.length)} de ${items.length}`);
}

return resultados;
```

### 2. Usar Map vs ForEach

```javascript
// ✅ Eficiente - map crea nuevo array
const procesados = items.map(item => ({
  json: procesarDato(item.json)
}));

// ❌ Ineficiente - push en cada iteración
const procesados = [];
items.forEach(item => {
  procesados.push({ json: procesarDato(item.json) });
});
```

### 3. Evitar Operaciones Costosas en Loops

```javascript
// ❌ Malo - calcula length en cada iteración
for (let i = 0; i < items.length; i++) {
  procesarItem(items[i]);
}

// ✅ Bueno - calcula length una vez
const length = items.length;
for (let i = 0; i < length; i++) {
  procesarItem(items[i]);
}

// ✅ Mejor - usa for...of
for (const item of items) {
  procesarItem(item);
}
```

## Debugging Avanzado

### Logging Estructurado

```javascript
function log(nivel, mensaje, datos = {}) {
  const timestamp = new Date().toISOString();
  const logEntry = {
    timestamp,
    nivel,
    mensaje,
    ...datos,
    workflow: $workflow.name,
    execution: $execution.id
  };

  console.log(JSON.stringify(logEntry));
}

// Uso
log('INFO', 'Procesamiento iniciado', { total_items: items.length });
log('WARN', 'Item sin campo requerido', { item_id: item.json.id });
log('ERROR', 'Error al procesar', { error: error.message, stack: error.stack });
```

### Try-Catch con Contexto

```javascript
const resultados = items.map((item, index) => {
  try {
    return {
      json: procesarItem(item.json)
    };
  } catch (error) {
    console.error(`❌ Error en item ${index}:`, {
      error: error.message,
      item_id: item.json.id,
      item_data: JSON.stringify(item.json)
    });

    // Retornar item con error flag
    return {
      json: {
        ...item.json,
        _error: true,
        _error_message: error.message
      }
    };
  }
});

return resultados;
```

## Proyecto del Módulo 4

**Sistema ETL (Extract, Transform, Load) Completo**

Ver: `ejercicios/proyecto-modulo-4.md`

1. Extraer datos de múltiples fuentes (APIs, archivos)
2. Validar y limpiar datos
3. Transformar con lógica compleja
4. Enriquecer con datos externos
5. Optimizar performance
6. Manejar errores robustamente
7. Generar reportes detallados

## Best Practices

✅ **DO:**
- Usa funciones puras cuando sea posible
- Implementa manejo de errores robusto
- Optimiza loops y operaciones pesadas
- Usa caché para datos que no cambian frecuentemente
- Log información útil para debugging
- Valida inputs y outputs

❌ **DON'T:**
- No uses variables globales sin control
- No ignores errores
- No hagas operaciones síncronas pesadas que bloqueen
- No cargues todos los datos en memoria si son muy grandes
- No uses eval() o código no seguro

## Recursos

- [MDN JavaScript](https://developer.mozilla.org/es/docs/Web/JavaScript)
- [Lodash Docs](https://lodash.com/docs/)
- [Moment.js Docs](https://momentjs.com/docs/)
- [Axios Docs](https://axios-http.com/docs/intro)

## Tiempo Estimado
5-6 días

## Siguiente Paso

**Módulo 5: Proyectos Prácticos Completos**

Integrarás todo lo aprendido en proyectos del mundo real.

---

¡El código personalizado te da superpoderes en n8n! 🚀
