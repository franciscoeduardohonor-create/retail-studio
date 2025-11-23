# Ejercicio 1: Mi Primer Workflow

## Nivel: Principiante

## Objetivo
Crear un workflow que genere información personal y la formatee de manera profesional.

## Requisitos

Crea un workflow que:

1. Use un **Manual Trigger**
2. Use un nodo **Set** para definir:
   - Tu nombre completo
   - Tu edad
   - Tu ciudad
   - Tu profesión o área de estudio
   - Tu lenguaje de programación favorito

3. Use un nodo **Code** para:
   - Crear una presentación formateada
   - Calcular el año de nacimiento aproximado
   - Determinar si eres mayor o menor de 25 años
   - Crear un objeto con toda la información organizada

## Resultado Esperado

El output debería verse similar a:

```json
{
  "presentacion": "Hola, soy Juan Pérez, tengo 28 años y vivo en Ciudad de México",
  "detalles": {
    "nombre": "Juan Pérez",
    "edad": 28,
    "ciudad": "Ciudad de México",
    "profesion": "Desarrollador Web",
    "lenguaje_favorito": "JavaScript"
  },
  "calculado": {
    "anio_nacimiento": 1997,
    "categoria_edad": "Adulto joven (25+)",
    "generacion": "Millennial"
  },
  "mensaje_personalizado": "Como desarrollador de 28 años, estás en el mejor momento para crear cosas increíbles con JavaScript"
}
```

## Pistas

### Set Node Configuración

```
Name: nombre → Value: [Tu nombre]
Name: edad → Value: [Tu edad]
Name: ciudad → Value: [Tu ciudad]
Name: profesion → Value: [Tu profesión]
Name: lenguaje → Value: [Tu lenguaje favorito]
```

### Code Node - Estructura Base

```javascript
// 1. Obtén los datos del nodo anterior
const { nombre, edad, ciudad, profesion, lenguaje } = items[0].json;

// 2. Calcula el año de nacimiento
const anioActual = new Date().getFullYear();
const anioNacimiento = // Completa esto

// 3. Determina la categoría de edad
const categoriaEdad = // Usa un if/else o ternario

// 4. Crea la presentación
const presentacion = // Usa template strings

// 5. Retorna todo organizado
return [{
  json: {
    // Completa aquí
  }
}];
```

## Bonus (Opcional)

Agrega estas funcionalidades extra:

1. **Calcular días vividos aproximadamente:**
```javascript
const diasVividos = edad * 365;
```

2. **Determinar generación:**
```javascript
let generacion;
if (anioNacimiento >= 1997) generacion = 'Gen Z';
else if (anioNacimiento >= 1981) generacion = 'Millennial';
else if (anioNacimiento >= 1965) generacion = 'Gen X';
else generacion = 'Baby Boomer';
```

3. **Mensaje personalizado según el lenguaje favorito:**
```javascript
const mensajesLenguaje = {
  'JavaScript': '¡El lenguaje del web! 🌐',
  'Python': '¡Excelente para IA y data! 🐍',
  'Java': '¡Robusto y empresarial! ☕',
  // Agrega más...
};
```

## Validación

Tu workflow está completo cuando:
- ✅ Se ejecuta sin errores
- ✅ Muestra todos los datos solicitados
- ✅ Los cálculos son correctos
- ✅ El formato JSON es válido
- ✅ La presentación se lee profesionalmente

## Tiempo Estimado
15-20 minutos

---

## Solución

<details>
<summary>⚠️ Solo mira la solución después de intentarlo</summary>

### Set Node

```
Name: nombre → Value: Juan Pérez
Name: edad → Value: 28
Name: ciudad → Value: Ciudad de México
Name: profesion → Value: Desarrollador Web
Name: lenguaje → Value: JavaScript
```

### Code Node

```javascript
// Obtenemos datos del Set node
const { nombre, edad, ciudad, profesion, lenguaje } = items[0].json;

// Cálculos
const anioActual = new Date().getFullYear();
const anioNacimiento = anioActual - edad;

// Categoría de edad
const categoriaEdad = edad < 18 ? 'Menor de edad' :
                     edad < 25 ? 'Joven (18-24)' :
                     edad < 40 ? 'Adulto joven (25-39)' :
                     edad < 60 ? 'Adulto (40-59)' :
                     'Adulto mayor (60+)';

// Generación
let generacion;
if (anioNacimiento >= 1997) {
  generacion = 'Gen Z';
} else if (anioNacimiento >= 1981) {
  generacion = 'Millennial';
} else if (anioNacimiento >= 1965) {
  generacion = 'Gen X';
} else {
  generacion = 'Baby Boomer';
}

// Presentación
const presentacion = `Hola, soy ${nombre}, tengo ${edad} años y vivo en ${ciudad}`;

// Mensaje personalizado
const mensajeProfesion = `Como ${profesion.toLowerCase()} de ${edad} años`;
const mensajeLenguaje = `estás en el mejor momento para crear cosas increíbles con ${lenguaje}`;
const mensajeCompleto = `${mensajeProfesion}, ${mensajeLenguaje}`;

// BONUS: Cálculos adicionales
const diasVividos = edad * 365;
const horasVividas = diasVividos * 24;

// Emojis según lenguaje
const emojiLenguaje = {
  'JavaScript': '🌐',
  'Python': '🐍',
  'Java': '☕',
  'C++': '⚡',
  'Go': '🏃',
  'Rust': '🦀',
  'PHP': '🐘',
  'Ruby': '💎'
}[lenguaje] || '💻';

// Retornamos todo organizado
return [{
  json: {
    presentacion: presentacion,

    detalles: {
      nombre: nombre,
      edad: edad,
      ciudad: ciudad,
      profesion: profesion,
      lenguaje_favorito: lenguaje + ' ' + emojiLenguaje
    },

    calculado: {
      anio_nacimiento: anioNacimiento,
      categoria_edad: categoriaEdad,
      generacion: generacion,
      dias_vividos: diasVividos.toLocaleString(),
      horas_vividas: horasVividas.toLocaleString()
    },

    mensaje_personalizado: mensajeCompleto,

    estadisticas: {
      caracteres_nombre: nombre.length,
      edad_perro: (edad * 7) + ' años perrunos 🐕',
      anios_hasta_100: 100 - edad
    }
  }
}];
```

### Output Esperado

```json
{
  "presentacion": "Hola, soy Juan Pérez, tengo 28 años y vivo en Ciudad de México",
  "detalles": {
    "nombre": "Juan Pérez",
    "edad": 28,
    "ciudad": "Ciudad de México",
    "profesion": "Desarrollador Web",
    "lenguaje_favorito": "JavaScript 🌐"
  },
  "calculado": {
    "anio_nacimiento": 1997,
    "categoria_edad": "Adulto joven (25-39)",
    "generacion": "Millennial",
    "dias_vividos": "10,220",
    "horas_vividas": "245,280"
  },
  "mensaje_personalizado": "Como desarrollador web de 28 años, estás en el mejor momento para crear cosas increíbles con JavaScript",
  "estadisticas": {
    "caracteres_nombre": 11,
    "edad_perro": "196 años perrunos 🐕",
    "anios_hasta_100": 72
  }
}
```

</details>

## Reflexión

Después de completar este ejercicio, deberías entender:
- Cómo fluyen los datos entre nodos
- Cómo acceder a datos con `items[0].json`
- Cómo usar destructuring: `const { nombre } = items[0].json`
- Cómo retornar datos en el formato correcto
- Operaciones básicas en JavaScript dentro de n8n

## Siguiente Paso

Continúa con el **Ejercicio 2: Consulta API del Clima** para aprender a trabajar con APIs reales.
