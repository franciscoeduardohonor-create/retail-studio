# Ejemplo 2: Trabajando con APIs - Consulta Básica

## Objetivo
Aprender a hacer peticiones HTTP a APIs públicas y procesar las respuestas.

## Conceptos que Aprenderás
- Nodo HTTP Request
- Métodos HTTP (GET, POST)
- Procesamiento de respuestas JSON
- Manejo básico de datos de APIs

## ¿Qué es una API?

Una **API (Application Programming Interface)** es un conjunto de endpoints (URLs) que te permiten interactuar con un servicio o aplicación.

**Ejemplo:** La API de GitHub te permite obtener información de repositorios, usuarios, etc.

## Ejemplo: API de Usuarios Aleatorios

Usaremos la API pública **JSONPlaceholder** que no requiere autenticación.

### Paso 1: Setup Básico

1. Crea un nuevo workflow
2. Agrega un **Manual Trigger**

### Paso 2: Agregar HTTP Request

1. Click en "+" después del Manual Trigger
2. Busca y selecciona "HTTP Request"
3. Configura:
   - **Method:** GET
   - **URL:** `https://jsonplaceholder.typicode.com/users`

💡 **¿Qué hace?** Hace una petición GET a la API para obtener una lista de usuarios.

4. Click en "Execute Node" para probar

Deberías ver una respuesta con 10 usuarios en formato JSON.

### Paso 3: Procesar la Respuesta

Agrega un nodo **Code** después del HTTP Request:

```javascript
// La respuesta de la API viene en items[0].json
// Como la API devuelve un array de usuarios, lo procesamos

// Accedemos a todos los usuarios
const usuarios = items[0].json;

// Extraemos solo la información que nos interesa
const usuariosProcesados = usuarios.map(usuario => {
  return {
    id: usuario.id,
    nombre_completo: usuario.name,
    nombre_usuario: usuario.username,
    email: usuario.email,
    ciudad: usuario.address.city,
    empresa: usuario.company.name,
    website: usuario.website
  };
});

// Opcional: filtrar solo usuarios de una ciudad específica
const usuariosFiltrados = usuariosProcesados.filter(user =>
  user.ciudad === 'Gwenborough'
);

// Creamos estadísticas
const estadisticas = {
  total_usuarios: usuariosProcesados.length,
  usuarios_filtrados: usuariosFiltrados.length,
  ciudades_unicas: [...new Set(usuariosProcesados.map(u => u.ciudad))],
  dominios_email: [...new Set(usuariosProcesados.map(u => u.email.split('@')[1]))]
};

// Retornamos los datos procesados
return [{
  json: {
    usuarios: usuariosProcesados,
    usuarios_filtrados: usuariosFiltrados,
    estadisticas: estadisticas
  }
}];
```

### Explicación del Código

#### 1. Acceder a la Respuesta
```javascript
const usuarios = items[0].json;
```
La respuesta de HTTP Request está en `items[0].json`.

#### 2. Transformar Datos con map()
```javascript
usuarios.map(usuario => {
  return {
    nombre: usuario.name
  };
});
```
`map()` transforma cada elemento del array.

#### 3. Filtrar Datos con filter()
```javascript
usuarios.filter(user => user.ciudad === 'Gwenborough')
```
`filter()` devuelve solo los elementos que cumplen la condición.

#### 4. Valores Únicos con Set
```javascript
[...new Set(array)]
```
Elimina duplicados de un array.

## Ejemplo 2: Consultar un Usuario Específico

### HTTP Request Configuración

- **Method:** GET
- **URL:** `https://jsonplaceholder.typicode.com/users/1`

Esto devuelve solo el usuario con ID 1.

### Code Node

```javascript
// Obtenemos el usuario
const usuario = items[0].json;

// Creamos un perfil formateado
const perfil = {
  // Información Personal
  info_personal: {
    nombre: usuario.name,
    usuario: usuario.username,
    email: usuario.email,
    telefono: usuario.phone,
    website: usuario.website
  },

  // Dirección
  direccion: {
    calle: usuario.address.street,
    suite: usuario.address.suite,
    ciudad: usuario.address.city,
    codigo_postal: usuario.address.zipcode,
    coordenadas: {
      lat: parseFloat(usuario.address.geo.lat),
      lng: parseFloat(usuario.address.geo.lng)
    }
  },

  // Empresa
  trabajo: {
    empresa: usuario.company.name,
    eslogan: usuario.company.catchPhrase,
    descripcion: usuario.company.bs
  }
};

return [{ json: perfil }];
```

## Ejemplo 3: Obtener Posts de un Usuario

### Workflow Multi-paso

**Flujo:**
```
[Manual] → [Get User] → [Get Posts] → [Process]
```

### Paso 1: Get User

HTTP Request:
- **URL:** `https://jsonplaceholder.typicode.com/users/1`

### Paso 2: Get Posts

HTTP Request:
- **URL:** `https://jsonplaceholder.typicode.com/posts?userId={{ $json.id }}`

💡 **Expresión:** `{{ $json.id }}` toma el ID del usuario del nodo anterior.

### Paso 3: Process

Code Node:
```javascript
// Datos del usuario (del primer nodo HTTP)
// Usamos $node para acceder a un nodo específico por nombre
const usuario = $('HTTP Request').first().json;

// Posts del usuario (del segundo nodo HTTP)
const posts = items[0].json;

// Análisis de posts
const analisis = {
  usuario: {
    nombre: usuario.name,
    email: usuario.email
  },

  estadisticas_posts: {
    total_posts: posts.length,

    // Promedio de longitud de título
    promedio_longitud_titulo: posts.reduce((sum, post) =>
      sum + post.title.length, 0) / posts.length,

    // Promedio de longitud de body
    promedio_longitud_contenido: posts.reduce((sum, post) =>
      sum + post.body.length, 0) / posts.length,

    // Post más largo
    post_mas_largo: posts.reduce((max, post) =>
      post.body.length > max.body.length ? post : max, posts[0]
    ).title,

    // Palabras totales (aproximado)
    palabras_totales: posts.reduce((sum, post) =>
      sum + post.body.split(' ').length, 0
    )
  },

  // Primeros 3 posts
  posts_recientes: posts.slice(0, 3).map(post => ({
    titulo: post.title,
    preview: post.body.substring(0, 50) + '...'
  }))
};

return [{ json: analisis }];
```

### Acceder a Datos de Nodos Anteriores

```javascript
// Método 1: Nodo anterior directo
const data = items[0].json;

// Método 2: Nodo específico por nombre
const userData = $('HTTP Request').first().json;

// Método 3: Todos los items de un nodo
const allItems = $('HTTP Request').all();
```

## Ejemplo 4: API con Parámetros

### Búsqueda Dinámica

Set Node (para crear parámetros):
```
Name: userId → Value: 1
Name: limit → Value: 5
```

HTTP Request:
- **URL:** `https://jsonplaceholder.typicode.com/posts`
- **Query Parameters:**
  - `userId`: `{{ $json.userId }}`
  - `_limit`: `{{ $json.limit }}`

Esto construye: `https://jsonplaceholder.typicode.com/posts?userId=1&_limit=5`

## Ejemplo 5: Múltiples APIs en Paralelo

A veces necesitas datos de múltiples fuentes.

### Setup

1. Manual Trigger
2. HTTP Request 1 (Usuarios):
   - URL: `https://jsonplaceholder.typicode.com/users/1`
3. HTTP Request 2 (Posts):
   - URL: `https://jsonplaceholder.typicode.com/posts?userId=1`

💡 Conecta ambos HTTP Requests al mismo nodo anterior para ejecución paralela.

4. Merge Node
   - Mode: Merge By Position
   - Conecta ambos HTTP Requests al Merge

5. Code Node:

```javascript
// El Merge node combina los resultados
// Necesitamos acceder a cada input específico

const usuario = $input.first().json;
const posts = $input.last().json;

const resumen = {
  usuario: usuario.name,
  total_posts: posts.length,
  lista_posts: posts.map(p => p.title)
};

return [{ json: resumen }];
```

## Ejercicios Prácticos

### Ejercicio 1: Lista de Tareas
Usa `https://jsonplaceholder.typicode.com/todos?userId=1` para:
1. Obtener las tareas del usuario 1
2. Contar cuántas están completadas vs pendientes
3. Mostrar las primeras 5 pendientes

<details>
<summary>Ver solución</summary>

```javascript
const tareas = items[0].json;

const completadas = tareas.filter(t => t.completed);
const pendientes = tareas.filter(t => !t.completed);

return [{
  json: {
    total: tareas.length,
    completadas: completadas.length,
    pendientes: pendientes.length,
    porcentaje_completado: (completadas.length / tareas.length * 100).toFixed(2) + '%',
    proximas_5_pendientes: pendientes.slice(0, 5).map(t => t.title)
  }
}];
```
</details>

### Ejercicio 2: Álbumes y Fotos
1. Obtén álbumes: `https://jsonplaceholder.typicode.com/albums?userId=1`
2. Para el primer álbum, obtén sus fotos: `https://jsonplaceholder.typicode.com/photos?albumId=X`
3. Muestra las primeras 3 fotos

### Ejercicio 3: Comentarios por Post
1. Obtén un post específico
2. Obtén sus comentarios
3. Analiza: quién comentó más, longitud promedio de comentarios

## APIs Públicas para Practicar

- **JSONPlaceholder:** https://jsonplaceholder.typicode.com (No auth)
- **REST Countries:** https://restcountries.com/v3.1/all (Información de países)
- **Open Meteo:** https://api.open-meteo.com (Clima, no auth)
- **CoinGecko:** https://api.coingecko.com/api/v3/coins/list (Criptomonedas)
- **Dog API:** https://dog.ceo/api/breeds/image/random (Fotos aleatorias de perros)

## Puntos Clave

- ✅ HTTP Request hace peticiones a APIs
- ✅ GET para obtener datos
- ✅ La respuesta está en `items[0].json`
- ✅ Usa expresiones `{{ }}` para valores dinámicos
- ✅ `map()` transforma arrays
- ✅ `filter()` filtra arrays
- ✅ Accede a nodos específicos con `$('nombre_nodo')`

## Siguiente Paso

Aprende a ejecutar workflows automáticamente en **Ejemplo 3: Schedule Básico**.
