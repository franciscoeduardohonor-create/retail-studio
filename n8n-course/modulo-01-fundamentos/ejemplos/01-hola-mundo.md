# Ejemplo 1: Hola Mundo en n8n

## Objetivo
Crear tu primer workflow en n8n que muestre un mensaje simple.

## Conceptos que Aprenderás
- Nodo Manual Trigger
- Nodo Set
- Nodo Code
- Flujo básico de datos

## Paso a Paso

### 1. Crear el Workflow

Abre n8n y crea un nuevo workflow.

### 2. Agregar Manual Trigger

**¿Qué hace?** Permite ejecutar el workflow manualmente haciendo clic en "Execute Workflow".

1. Busca "Manual Trigger" en la barra de búsqueda
2. Arrástralo al canvas
3. No requiere configuración

### 3. Agregar Nodo Set

**¿Qué hace?** Te permite crear o modificar datos manualmente.

1. Click en el "+" después del Manual Trigger
2. Busca y selecciona "Set"
3. Click en "Add Value"
4. Configura:
   - **Name:** `mensaje`
   - **Value:** `¡Hola Mundo desde n8n!`

5. Click en "Add Value" nuevamente
6. Configura:
   - **Name:** `fecha`
   - **Value:** `{{ $now.toISO() }}`

💡 **Nota:** `{{ $now.toISO() }}` es una expresión que obtiene la fecha/hora actual.

### 4. Agregar Nodo Code

**¿Qué hace?** Ejecuta código JavaScript personalizado.

1. Click en el "+" después del Set node
2. Busca y selecciona "Code"
3. En el editor, escribe:

```javascript
// Este código se ejecuta en cada ejecución del workflow

// Accedemos a los datos del nodo anterior
const mensaje = items[0].json.mensaje;
const fecha = items[0].json.fecha;

// Mostramos en la consola (verás esto en los logs de n8n)
console.log('=== MI PRIMER WORKFLOW ===');
console.log('Mensaje:', mensaje);
console.log('Fecha:', fecha);

// Creamos un nuevo objeto con la información formateada
const resultado = {
  mensaje_completo: `${mensaje} - Ejecutado el ${fecha}`,
  longitud_mensaje: mensaje.length,
  timestamp: new Date().getTime()
};

// Retornamos los datos para el siguiente nodo
// items es un array, por eso retornamos un array con un objeto
return [
  {
    json: resultado
  }
];
```

### 5. Ejecutar el Workflow

1. Click en "Execute Workflow" (botón arriba a la derecha)
2. Observa cómo cada nodo se ilumina en verde al ejecutarse
3. Click en el nodo "Code" para ver el output

### Output Esperado

Deberías ver algo como:

```json
{
  "mensaje_completo": "¡Hola Mundo desde n8n! - Ejecutado el 2025-11-23T10:30:00.000Z",
  "longitud_mensaje": 25,
  "timestamp": 1700739000000
}
```

## Entendiendo el Código

### items[0].json

```javascript
items[0].json.mensaje
//│     │   │    │
//│     │   │    └─ Campo que creamos en Set
//│     │   └────── Objeto JSON con los datos
//│     └────────── Primer elemento (índice 0)
//└──────────────── Array de items recibidos
```

En n8n, los datos siempre vienen en un array de items. Cada item tiene un objeto `json` con los datos.

### Return Statement

```javascript
return [
  {
    json: { /* tus datos */ }
  }
];
```

Siempre debes retornar un array de objetos con la estructura `{ json: {...} }`.

## Variaciones del Ejemplo

### Variación 1: Múltiples Mensajes

Modifica el nodo Set para agregar más valores:

```
Name: nombre → Value: Tu Nombre
Name: edad → Value: 25
Name: ciudad → Value: Tu Ciudad
```

Luego en Code:

```javascript
const { nombre, edad, ciudad } = items[0].json;

return [{
  json: {
    presentacion: `Hola, soy ${nombre}, tengo ${edad} años y vivo en ${ciudad}`
  }
}];
```

### Variación 2: Operaciones Matemáticas

En Set:
```
Name: numero1 → Value: 10
Name: numero2 → Value: 5
```

En Code:
```javascript
const { numero1, numero2 } = items[0].json;

return [{
  json: {
    suma: numero1 + numero2,
    resta: numero1 - numero2,
    multiplicacion: numero1 * numero2,
    division: numero1 / numero2
  }
}];
```

## Ejercicio Práctico

**Desafío:** Modifica el workflow para que:
1. En Set, agregues tu nombre, apellido y año de nacimiento
2. En Code, calcules tu edad aproximada
3. Retornes un mensaje personalizado como: "Hola [nombre] [apellido], tienes aproximadamente [edad] años"

### Solución

<details>
<summary>Click para ver la solución</summary>

Set node:
```
Name: nombre → Value: Juan
Name: apellido → Value: Pérez
Name: anio_nacimiento → Value: 1995
```

Code node:
```javascript
const { nombre, apellido, anio_nacimiento } = items[0].json;

const anio_actual = new Date().getFullYear();
const edad = anio_actual - anio_nacimiento;

return [{
  json: {
    mensaje: `Hola ${nombre} ${apellido}, tienes aproximadamente ${edad} años`,
    edad_exacta: edad,
    generacion: edad < 25 ? 'Gen Z' : edad < 40 ? 'Millennial' : 'Gen X'
  }
}];
```
</details>

## Puntos Clave

- ✅ Manual Trigger inicia workflows manualmente
- ✅ Set crea/modifica datos
- ✅ Code ejecuta JavaScript personalizado
- ✅ Los datos fluyen de nodo a nodo
- ✅ Usa `items[0].json` para acceder a datos
- ✅ Siempre retorna `[{ json: {...} }]`

## Siguiente Paso

Ahora que dominas el flujo básico, aprende a trabajar con APIs en el **Ejemplo 2: API Básica**.
