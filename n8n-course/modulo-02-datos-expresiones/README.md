# Módulo 2: Trabajando con Datos y Expresiones

## Objetivos de Aprendizaje

Al finalizar este módulo serás capaz de:
- Manipular datos complejos en n8n
- Usar expresiones avanzadas con `{{ }}`
- Trabajar con múltiples items
- Transformar y filtrar datos eficientemente
- Usar nodos de control de flujo (IF, Switch, Merge)
- Implementar lógica compleja sin código

## Introducción

En el Módulo 1 aprendiste los fundamentos. Ahora es momento de dominar el manejo de datos, que es el corazón de cualquier automatización en n8n.

## Contenido del Módulo

### 1. Expresiones en n8n

Las expresiones te permiten acceder y manipular datos dinámicamente usando la sintaxis `{{ }}`.

#### Expresiones Básicas

```javascript
// Acceder a datos del nodo actual
{{ $json.campo }}

// Acceder a datos de un nodo específico
{{ $node["Nombre del Nodo"].json.campo }}

// Usar funciones
{{ $json.texto.toUpperCase() }}
{{ $json.numero * 2 }}
{{ $json.fecha.toDateTime() }}
```

#### Variables Especiales

```javascript
{{ $now }}              // Fecha/hora actual
{{ $today }}            // Fecha actual (sin hora)
{{ $execution.id }}     // ID de ejecución
{{ $workflow.id }}      // ID del workflow
{{ $workflow.name }}    // Nombre del workflow
{{ $item }}             // Item actual (en loops)
{{ $itemIndex }}        // Índice del item actual
```

### 2. Nodos de Transformación

#### Set Node
Crea, modifica o elimina campos de datos.

**Casos de uso:**
- Crear variables
- Renombrar campos
- Agregar valores calculados
- Preparar datos para el siguiente nodo

#### Function Node (Code)
Ejecuta JavaScript personalizado.

**Ventajas:**
- Lógica compleja
- Transformaciones avanzadas
- Acceso a librerías
- Control total sobre los datos

### 3. Nodos de Control de Flujo

#### IF Node
Divide el flujo basado en condiciones.

```
[Datos] → [IF: edad > 18?]
            ├── TRUE → [Proceso Adultos]
            └── FALSE → [Proceso Menores]
```

#### Switch Node
Múltiples rutas basadas en valores.

```
[Datos] → [SWITCH: tipo_cliente]
            ├── "premium" → [Proceso Premium]
            ├── "regular" → [Proceso Regular]
            └── "nuevo" → [Proceso Nuevo]
```

#### Merge Node
Combina datos de múltiples fuentes.

**Modos:**
- **Append:** Agrega items al final
- **Merge By Position:** Combina items en la misma posición
- **Merge By Key:** Combina basado en un campo clave

### 4. Trabajando con Arrays

#### Operaciones Comunes

```javascript
// Filtrar
const adultos = items.filter(item => item.json.edad >= 18);

// Mapear (transformar)
const nombres = items.map(item => item.json.nombre);

// Reducir (agregar)
const total = items.reduce((sum, item) => sum + item.json.precio, 0);

// Ordenar
items.sort((a, b) => a.json.nombre.localeCompare(b.json.nombre));

// Buscar
const encontrado = items.find(item => item.json.id === 123);
```

### 5. Trabajando con Múltiples Items

En n8n, los datos fluyen como arrays de items:

```javascript
// Input (del nodo anterior):
[
  { json: { nombre: "Juan", edad: 25 } },
  { json: { nombre: "María", edad: 30 } },
  { json: { nombre: "Pedro", edad: 22 } }
]
```

**Procesar todos los items:**

```javascript
// items es un array con todos los items
const procesados = items.map(item => {
  return {
    json: {
      nombre: item.json.nombre,
      es_mayor: item.json.edad >= 18,
      categoria: item.json.edad < 30 ? 'joven' : 'adulto'
    }
  };
});

return procesados;
```

### 6. Expresiones Avanzadas

#### Operaciones con Strings

```javascript
{{ $json.nombre.toUpperCase() }}           // JUAN
{{ $json.nombre.toLowerCase() }}           // juan
{{ $json.texto.slice(0, 10) }}            // Primeros 10 chars
{{ $json.texto.split(',') }}              // Array separado por comas
{{ $json.texto.trim() }}                  // Quita espacios
{{ $json.nombre.length }}                 // Longitud
```

#### Operaciones con Números

```javascript
{{ $json.precio * 1.16 }}                 // Con IVA
{{ Math.round($json.numero) }}            // Redondear
{{ Math.floor($json.numero) }}            // Redondear abajo
{{ Math.ceil($json.numero) }}             // Redondear arriba
{{ $json.numero.toFixed(2) }}             // 2 decimales
```

#### Operaciones con Fechas

```javascript
{{ $now.toISO() }}                        // ISO format
{{ $now.toFormat('yyyy-MM-dd') }}         // Custom format
{{ $now.plus({ days: 7 }) }}              // Sumar 7 días
{{ $now.minus({ hours: 2 }) }}            // Restar 2 horas
{{ $now.diff($json.fecha, 'days') }}      // Diferencia en días
```

#### Operaciones Lógicas

```javascript
{{ $json.edad >= 18 ? 'Mayor' : 'Menor' }}
{{ $json.activo && $json.verificado }}
{{ $json.tipo === 'premium' || $json.tipo === 'vip' }}
```

### 7. Patrones Comunes

#### Patrón 1: Enriquecer Datos

```javascript
// Agregar campos calculados a cada item
items.map(item => {
  const original = item.json;
  return {
    json: {
      ...original,  // Mantener datos originales
      total: original.precio * original.cantidad,
      con_descuento: original.precio > 100,
      categoria: original.precio < 50 ? 'económico' :
                 original.precio < 200 ? 'medio' : 'premium'
    }
  };
});
```

#### Patrón 2: Filtrar y Transformar

```javascript
// Filtrar items y transformar en un solo paso
items
  .filter(item => item.json.activo)
  .map(item => ({
    json: {
      id: item.json.id,
      nombre: item.json.nombre,
      formatted: `${item.json.nombre} (#${item.json.id})`
    }
  }));
```

#### Patrón 3: Agrupar Datos

```javascript
// Agrupar items por categoría
const grupos = items.reduce((acc, item) => {
  const categoria = item.json.categoria;
  if (!acc[categoria]) {
    acc[categoria] = [];
  }
  acc[categoria].push(item.json);
  return acc;
}, {});

return [{ json: grupos }];
```

#### Patrón 4: Deduplicar

```javascript
// Eliminar duplicados basado en un campo
const unicos = [];
const vistos = new Set();

items.forEach(item => {
  const id = item.json.id;
  if (!vistos.has(id)) {
    vistos.add(id);
    unicos.push(item);
  }
});

return unicos;
```

## Ejemplos Prácticos

### Ejemplo 1: Pipeline de Transformación
Archivo: `ejemplos/01-pipeline-transformacion.md`
- Obtener datos de API
- Filtrar por criterios
- Enriquecer con cálculos
- Formatear para salida

### Ejemplo 2: Control de Flujo con IF/Switch
Archivo: `ejemplos/02-control-flujo.md`
- Rutas condicionales
- Múltiples condiciones
- Manejo de casos especiales

### Ejemplo 3: Merge y Combinación de Datos
Archivo: `ejemplos/03-merge-datos.md`
- Combinar múltiples fuentes
- Enriquecer datos con lookups
- Merge strategies

### Ejemplo 4: Expresiones Avanzadas
Archivo: `ejemplos/04-expresiones-avanzadas.md`
- Manipulación de strings
- Cálculos complejos
- Formato de fechas

## Ejercicios

### Ejercicio 1: Procesador de Ventas
Transforma datos de ventas crudos en reporte formateado.

### Ejercicio 2: Sistema de Categorización
Clasifica productos según múltiples criterios.

### Ejercicio 3: Deduplicador Inteligente
Elimina duplicados considerando múltiples campos.

## Proyecto del Módulo 2

**Sistema de Procesamiento de Datos de E-commerce**

Crear un workflow que:
1. Recibe datos de productos y ventas
2. Filtra productos activos
3. Calcula métricas (total, promedio, etc.)
4. Categoriza productos
5. Genera reporte ejecutivo
6. Identifica productos destacados y de baja rotación

Ver: `ejercicios/proyecto-modulo-2.md`

## Nodos Nuevos Introducidos

- **Set:** Modificar datos manualmente
- **IF:** Condiciones binarias
- **Switch:** Múltiples rutas
- **Merge:** Combinar datos
- **Split In Batches:** Procesar en lotes
- **Item Lists:** Trabajar con arrays

## Recursos Adicionales

- [Documentación de Expresiones n8n](https://docs.n8n.io/code-examples/expressions/)
- [Function Node Examples](https://docs.n8n.io/integrations/builtin/core-nodes/n8n-nodes-base.function/)

## Tiempo Estimado
3-4 días de práctica intensiva

## Siguiente Paso

Una vez completado este módulo, continúa con el **Módulo 3: APIs y Webhooks** donde aprenderás a:
- Trabajar con APIs REST avanzadas
- Implementar webhooks
- Manejar autenticación
- Rate limiting y reintentos
- Integración con servicios reales

---

¡Dominar el manejo de datos es la clave para crear automatizaciones poderosas! 💪
