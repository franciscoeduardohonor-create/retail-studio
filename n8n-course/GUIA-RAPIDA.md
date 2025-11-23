# Guía Rápida: Curso de n8n

## Inicio Rápido

### 1. Instalación de n8n

#### Docker (Recomendado)
```bash
docker run -it --rm \
  --name n8n \
  -p 5678:5678 \
  -v ~/.n8n:/home/node/.n8n \
  n8nio/n8n
```

#### npm
```bash
npm install n8n -g
n8n start
```

Luego abre: http://localhost:5678

### 2. Estructura del Curso

```
📚 Módulo 1: Fundamentos (2-3 días)
   - Manual Trigger, Set, Code
   - HTTP Request
   - Schedule Trigger
   - Tu primer workflow

📊 Módulo 2: Datos y Expresiones (3-4 días)
   - Expresiones {{ }}
   - Transformación de datos
   - IF, Switch, Merge
   - Arrays y loops

🌐 Módulo 3: APIs y Webhooks (4-5 días)
   - HTTP Request avanzado
   - Autenticación
   - Webhooks
   - Paginación y rate limiting

💻 Módulo 4: Código Avanzado (5-6 días)
   - JavaScript avanzado
   - Librerías (moment, lodash, axios)
   - Algoritmos
   - Performance

🚀 Módulo 5: Proyectos Completos (1-2 semanas)
   - E-commerce automatizado
   - Sistema de monitoreo
   - ETL Pipeline
   - Proyecto final
```

## Conceptos Clave

### Expresiones Básicas

```javascript
{{ $json.campo }}                    // Acceder a datos
{{ $json.numero * 2 }}              // Cálculos
{{ $json.texto.toUpperCase() }}     // Funciones
{{ $now.toISO() }}                  // Fecha actual
{{ $execution.id }}                 // ID de ejecución
```

### Estructura de Datos

```javascript
// Input/Output en n8n
[
  {
    json: {
      campo1: "valor1",
      campo2: "valor2"
    }
  }
]
```

### Code Node Template

```javascript
// Procesar items
const resultado = items.map(item => {
  const datos = item.json;

  // Tu lógica aquí
  const procesado = {
    original: datos,
    nuevo_campo: "valor"
  };

  return {
    json: procesado
  };
});

return resultado;
```

## Workflows de Ejemplo Rápido

### 1. Consulta API Simple

```
[Manual Trigger]
    ↓
[HTTP Request: GET https://api.example.com/data]
    ↓
[Code: Procesar respuesta]
```

### 2. Automatización Diaria

```
[Schedule: 9am daily]
    ↓
[Get Data]
    ↓
[Process]
    ↓
[Send Report]
```

### 3. Webhook Receiver

```
[Webhook Trigger]
    ↓
[Validate]
    ↓
[Process]
    ↓
[Webhook Response]
```

## Comandos Útiles

### JavaScript Común en Code Node

```javascript
// Filtrar
items.filter(item => item.json.activo === true)

// Transformar
items.map(item => ({ json: { ...item.json, nuevo: "valor" } }))

// Reducir
items.reduce((sum, item) => sum + item.json.precio, 0)

// Ordenar
items.sort((a, b) => a.json.nombre.localeCompare(b.json.nombre))

// Encontrar
items.find(item => item.json.id === 123)
```

### Lodash Quick Reference

```javascript
const _ = require('lodash');

_.uniq([1, 2, 2, 3])                    // [1, 2, 3]
_.groupBy(items, 'categoria')            // { cat1: [...], cat2: [...] }
_.orderBy(items, ['precio'], ['desc'])   // Ordenar
_.chunk(items, 10)                       // Grupos de 10
_.get(obj, 'path.to.value', 'default')   // Get seguro
```

### Moment.js Quick Reference

```javascript
const moment = require('moment');

moment().format('YYYY-MM-DD')           // 2025-11-23
moment().add(7, 'days')                 // +7 días
moment().subtract(1, 'month')           // -1 mes
moment('2025-12-25').diff(moment(), 'days')  // Diferencia
```

## Patrones Comunes

### Patrón: Validar y Procesar

```javascript
// Validar
const validos = items.filter(item => {
  return item.json.email && item.json.nombre;
});

if (validos.length === 0) {
  throw new Error('No hay items válidos');
}

// Procesar
return validos.map(item => ({
  json: procesarItem(item.json)
}));
```

### Patrón: Try-Catch por Item

```javascript
const resultados = items.map((item, index) => {
  try {
    return { json: procesarItem(item.json) };
  } catch (error) {
    console.error(`Error en item ${index}:`, error.message);
    return {
      json: {
        ...item.json,
        error: true,
        error_mensaje: error.message
      }
    };
  }
});

return resultados;
```

### Patrón: Enriquecer Datos

```javascript
const enriquecido = items.map(item => ({
  json: {
    ...item.json,  // Mantener original
    calculado: item.json.precio * item.json.cantidad,
    timestamp: new Date().toISOString()
  }
}));

return enriquecido;
```

## Troubleshooting

### Error: "Cannot read property 'json' of undefined"

```javascript
// ❌ Problema
const dato = items[0].json.campo;

// ✅ Solución
if (!items || items.length === 0) {
  throw new Error('No hay items para procesar');
}
const dato = items[0].json.campo;
```

### Error: "Cannot return undefined"

```javascript
// ❌ Problema
return resultado;  // resultado es undefined

// ✅ Solución
return [{
  json: {
    mensaje: "Sin resultados"
  }
}];
```

### Debugging

```javascript
// Ver datos
console.log('Items recibidos:', items.length);
console.log('Primer item:', JSON.stringify(items[0], null, 2));

// Ver valores
console.log('Valor:', $json.campo);
console.log('Tipo:', typeof $json.campo);
```

## Atajos de Teclado en n8n

- `Ctrl/Cmd + E` - Ejecutar workflow
- `Ctrl/Cmd + S` - Guardar workflow
- `Ctrl/Cmd + A` - Seleccionar todo
- `Ctrl/Cmd + C` - Copiar nodo
- `Ctrl/Cmd + V` - Pegar nodo
- `Delete` - Eliminar nodo
- `Tab` - Abrir panel de nodos
- `Esc` - Cerrar panel

## APIs Públicas para Practicar

```
JSONPlaceholder:  https://jsonplaceholder.typicode.com
REST Countries:   https://restcountries.com/v3.1/all
Open Meteo:       https://api.open-meteo.com
CoinGecko:        https://api.coingecko.com/api/v3/coins/list
Dog API:          https://dog.ceo/api/breeds/image/random
```

## Recursos

- **Documentación:** https://docs.n8n.io
- **Comunidad:** https://community.n8n.io
- **Templates:** https://n8n.io/workflows
- **GitHub:** https://github.com/n8n-io/n8n

## Checklist de Proyecto

Antes de deployment:

- [ ] Manejo de errores implementado
- [ ] Validación de datos
- [ ] Logging adecuado
- [ ] Credenciales seguras
- [ ] Timeout configurados
- [ ] Testing completado
- [ ] Documentación creada
- [ ] Monitoreo configurado

## Próximos Pasos

1. Completa Módulo 1 (Fundamentos)
2. Practica con los ejercicios
3. Crea tu primer proyecto
4. Avanza a módulos intermedios
5. Implementa proyectos reales

---

**¡Comienza ahora con el Módulo 1!** 🚀

Ver: `modulo-01-fundamentos/README.md`
