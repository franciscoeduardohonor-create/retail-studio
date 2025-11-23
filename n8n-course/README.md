# Curso Práctico de n8n: De Principiante a Avanzado

¡Bienvenido al curso completo de n8n! Este curso te llevará desde los conceptos básicos hasta técnicas avanzadas de automatización con n8n.

## ¿Qué es n8n?

n8n es una herramienta de automatización de flujos de trabajo (workflow automation) de código abierto que te permite conectar diferentes aplicaciones y servicios para crear automatizaciones poderosas sin necesidad de escribir mucho código.

## Estructura del Curso

### 📚 Módulo 1: Fundamentos de n8n (Principiante)
**Duración estimada: 2-3 días**
- Introducción a n8n y conceptos básicos
- Nodos y conexiones
- Tu primer workflow
- Nodos básicos: Schedule, HTTP Request, Set
- Ejecución manual vs automática
- **Proyecto:** Automatización de recordatorios

### 📊 Módulo 2: Trabajando con Datos y Expresiones (Intermedio)
**Duración estimada: 3-4 días**
- Manejo de datos en n8n
- Expresiones y variables
- Transformación de datos
- Nodos: Function, IF, Switch, Merge
- Filtrado y mapeo de datos
- **Proyecto:** Sistema de procesamiento de datos

### 🌐 Módulo 3: APIs y Webhooks (Intermedio-Avanzado)
**Duración estimada: 4-5 días**
- Trabajando con APIs REST
- Webhooks: recibir y enviar datos
- Autenticación (API Keys, OAuth)
- Manejo de errores
- Rate limiting y reintentos
- **Proyecto:** Integración con APIs externas

### 💻 Módulo 4: Código Personalizado y JavaScript (Avanzado)
**Duración estimada: 5-6 días**
- Nodo Code (JavaScript)
- Librerías disponibles
- Debugging y troubleshooting
- Operaciones avanzadas con datos
- Integración con bases de datos
- **Proyecto:** Sistema personalizado con lógica compleja

### 🚀 Módulo 5: Proyectos Prácticos Completos (Avanzado)
**Duración estimada: 1-2 semanas**
- Automatización de e-commerce
- Sistema de notificaciones multi-canal
- ETL (Extract, Transform, Load)
- Monitoreo y alertas
- Integraciones empresariales
- **Proyecto Final:** Aplicación completa de automatización

## Cómo Usar Este Curso

1. **Lee la teoría** en cada archivo README.md de cada módulo
2. **Estudia los ejemplos** en la carpeta `ejemplos/` - todos están comentados
3. **Practica con los ejercicios** en la carpeta `ejercicios/`
4. **Importa los workflows** desde la carpeta `workflows/` para verlos en acción
5. **Crea tus propias variaciones** de los ejemplos

## Requisitos Previos

- Conocimientos básicos de programación (útil pero no obligatorio)
- n8n instalado (local o cloud)
  - Local: `npm install n8n -g` y luego `n8n start`
  - Cloud: Crear cuenta en [n8n.cloud](https://n8n.cloud)

## Instalación de n8n

### Opción 1: Docker (Recomendada)
```bash
docker run -it --rm \
  --name n8n \
  -p 5678:5678 \
  -v ~/.n8n:/home/node/.n8n \
  n8nio/n8n
```

### Opción 2: npm
```bash
npm install n8n -g
n8n start
```

Luego abre tu navegador en: http://localhost:5678

## Importar Workflows de Ejemplo

1. Abre n8n en tu navegador
2. Click en el menú (tres líneas) → "Import from File"
3. Selecciona el archivo .json del workflow
4. Click en "Import"

## Convenciones del Curso

- 📝 **Teoría:** Conceptos y explicaciones
- 💡 **Ejemplo:** Código con comentarios explicativos
- ✏️ **Ejercicio:** Práctica para ti
- 🎯 **Proyecto:** Implementación completa
- ⚠️ **Importante:** Notas críticas
- 💭 **Tip:** Consejos y mejores prácticas

## Recursos Adicionales

- [Documentación oficial de n8n](https://docs.n8n.io/)
- [Foro de la comunidad](https://community.n8n.io/)
- [n8n en GitHub](https://github.com/n8n-io/n8n)
- [Plantillas de workflows](https://n8n.io/workflows)

## Certificación

Al completar todos los módulos y proyectos, habrás dominado:
- ✅ Creación de workflows automatizados
- ✅ Integración con múltiples servicios
- ✅ Manejo avanzado de datos
- ✅ Programación con JavaScript en n8n
- ✅ Debugging y optimización
- ✅ Mejores prácticas y patrones

## ¡Comencemos!

Dirígete al **Módulo 1** para empezar tu viaje en n8n.

---

**Autor:** Curso creado para aprendizaje práctico de n8n
**Última actualización:** Noviembre 2025
**Versión:** 1.0
