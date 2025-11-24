# 🎓 Curso Completo de Programación en Moodle

## De Principiante a Avanzado con Ejemplos Prácticos

Bienvenido al curso más completo de programación en Moodle en español. Este curso te llevará desde cero hasta crear plugins profesionales, con cientos de ejemplos comentados y ejercicios prácticos.

---

## 📋 Índice del Curso

### 🟢 Nivel Principiante

#### [Módulo 1: Introducción a la Programación en Moodle](./modulo-1-introduccion/)
**Duración estimada: 8-10 horas**

📚 **Teoría:**
- ¿Qué es Moodle y por qué programar en él?
- Configuración del entorno de desarrollo (Docker, Local, Manual)
- Arquitectura de Moodle
- Primeros pasos con PHP en Moodle

💻 **Ejemplos Prácticos:**
1. [Hola Mundo en Moodle](./modulo-1-introduccion/ejemplos/01-hola-mundo.php) - Tu primera página
2. [Variables Globales](./modulo-1-introduccion/ejemplos/02-variables-globales.php) - $USER, $DB, $CFG, $PAGE, $OUTPUT

✏️ **Ejercicios:**
- 5 ejercicios prácticos desde crear páginas simples hasta un dashboard personalizado
- [Ver ejercicios completos](./modulo-1-introduccion/ejercicios/ejercicios-modulo-1.md)

**Aprenderás:**
- ✅ Configurar tu entorno de desarrollo
- ✅ Estructura de archivos de Moodle
- ✅ Variables globales esenciales
- ✅ Generar HTML con html_writer
- ✅ Sistema de contextos
- ✅ Verificar permisos básicos

---

#### [Módulo 2: PHP Básico para Moodle](./modulo-2-php-basico/)
**Duración estimada: 12-15 horas**

📚 **Teoría:**
- PHP en el contexto de Moodle
- Variables, tipos de datos y operadores
- Estructuras de control
- Arrays y sus funciones
- Funciones y buenas prácticas
- Convenciones de código de Moodle

💻 **Ejemplos Prácticos:**
1. [Variables y Operadores](./modulo-2-php-basico/ejemplos/01-variables-operadores.php) - Casos reales con datos de Moodle
2. [Estructuras de Control](./modulo-2-php-basico/ejemplos/02-estructuras-control.php) - if, switch, for, foreach, while
3. [Arrays Avanzados](./modulo-2-php-basico/ejemplos/03-arrays.php) - Filtrar, mapear, reducir
4. [Funciones](./modulo-2-php-basico/ejemplos/04-funciones.php) - Type hinting, closures, recursión

✏️ **Ejercicios:**
- 8 ejercicios progresivos desde calculadora hasta sistema de permisos
- [Ver ejercicios completos](./modulo-2-php-basico/ejercicios/ejercicios-modulo-2.md)

**Aprenderás:**
- ✅ Sintaxis PHP moderna (7.4+)
- ✅ Trabajar con arrays de forma efectiva
- ✅ Crear funciones reutilizables
- ✅ Type hinting y documentación PHPDoc
- ✅ Funciones anónimas y closures
- ✅ Estándares de código de Moodle

---

### 🟡 Nivel Intermedio

#### [Módulo 3: Base de Datos en Moodle](./modulo-3-base-datos/)
**Duración estimada: 15-18 horas**

📚 **Teoría:**
- API de Base de Datos de Moodle ($DB)
- Consultas SELECT, INSERT, UPDATE, DELETE
- Transacciones
- Optimización de consultas
- XMLDB para definir estructuras

💻 **Ejemplos Prácticos:**
1. Consultas básicas con get_record, get_records
2. Consultas complejas con SQL
3. Insertar y actualizar datos
4. Manejo de transacciones
5. Crear tablas personalizadas

✏️ **Ejercicios:**
- Sistema CRUD completo
- Generador de reportes
- Migración de datos
- Optimización de consultas

**Aprenderás:**
- ✅ Todas las funciones de $DB
- ✅ Escribir SQL seguro
- ✅ Prevenir SQL injection
- ✅ Crear tablas personalizadas
- ✅ Migrations con XMLDB
- ✅ Optimización y índices

---

#### [Módulo 4: Formularios y APIs de Moodle](./modulo-4-formularios-apis/)
**Duración estimada: 15-18 horas**

📚 **Teoría:**
- Forms API (moodleform)
- File API (manejo de archivos)
- Events API (eventos del sistema)
- Capabilities (sistema de permisos)
- Webservices API

💻 **Ejemplos Prácticos:**
1. Crear formularios con validación
2. Subir y manejar archivos
3. Disparar y escuchar eventos
4. Verificar capacidades
5. Crear webservices REST

✏️ **Ejercicios:**
- Formulario de registro personalizado
- Sistema de upload de archivos
- Logger de eventos
- API REST para mobile

**Aprenderás:**
- ✅ Crear formularios profesionales
- ✅ Validación de datos
- ✅ Manejo seguro de archivos
- ✅ Sistema de eventos
- ✅ Roles y capacidades
- ✅ APIs externas

---

### 🔴 Nivel Avanzado

#### [Módulo 5: Creación de Plugins](./modulo-5-plugins/)
**Duración estimada: 20-25 horas**

📚 **Teoría:**
- Tipos de plugins en Moodle
- Estructura de un plugin
- Ciclo de vida (install, upgrade, uninstall)
- Configuración y settings
- Versionado y dependencias

💻 **Ejemplos Prácticos:**
1. **Plugin Local**: Sistema de notificaciones
2. **Bloque (Block)**: Dashboard personalizado
3. **Módulo de Actividad (mod)**: Quiz personalizado
4. **Plugin de Autenticación (auth)**: Login con redes sociales
5. **Tema (theme)**: Tema responsive personalizado

✏️ **Proyectos:**
- Sistema de gamificación
- LTI integration
- Plugin de reportes
- Integración con APIs externas

**Aprenderás:**
- ✅ Arquitectura de plugins
- ✅ Todos los tipos de plugins
- ✅ Ciclo de install/upgrade
- ✅ Settings avanzados
- ✅ Unit testing
- ✅ Publicar en repositorio

---

#### [Módulo 6: Temas Avanzados](./modulo-6-temas-avanzados/)
**Duración estimada: 20-25 horas**

📚 **Teoría:**
- Programación Orientada a Objetos en Moodle
- Namespaces y Autoloading
- Mustache templates
- AMD JavaScript modules
- SCSS y compilación de estilos
- Testing (PHPUnit y Behat)
- Performance y caching
- Security best practices

💻 **Ejemplos Prácticos:**
1. Clases con namespaces
2. Templates con Mustache
3. JavaScript AMD modules
4. Unit tests
5. Acceptance tests con Behat
6. Sistema de caché
7. Task scheduling

✏️ **Proyectos Avanzados:**
- Plugin completo con OOP
- SPA con JavaScript
- Test suite completo
- Performance optimization

**Aprenderás:**
- ✅ OOP avanzado
- ✅ Design patterns en Moodle
- ✅ JavaScript moderno
- ✅ Testing automatizado
- ✅ CI/CD
- ✅ Security hardening
- ✅ Optimización avanzada

---

## 🎯 Proyectos Finales

### Proyecto 1: Sistema de Certificados
Crea un plugin completo que genere certificados PDF personalizados al completar cursos.

**Tecnologías:**
- Plugin local
- PDF library
- Events API
- File API
- Templates

### Proyecto 2: LMS Mobile Integration
Desarrolla una API REST y app mobile básica para acceder a Moodle.

**Tecnologías:**
- Webservices
- External API
- Authentication
- Mobile app (React Native/Flutter)

### Proyecto 3: Sistema de Gamificación
Plugin completo con puntos, badges, leaderboards.

**Tecnologías:**
- Plugin local
- Custom DB tables
- JavaScript
- Mustache templates
- Cron tasks

---

## 🛠️ Requisitos del Curso

### Software Necesario
- **PHP 7.4+** (recomendado 8.0+)
- **MySQL 5.7+** o **MariaDB 10.2+**
- **Apache** o **Nginx**
- **Moodle 4.0+**
- **Git** para control de versiones
- **Composer** para dependencias PHP

### Editor Recomendado
- **VSCode** con extensiones:
  - PHP Intelephense
  - PHP Debug
  - GitLens
  - Moodle Pack

### Conocimientos Previos
- ✅ HTML/CSS básico
- ✅ Lógica de programación
- ⚠️ PHP básico (se enseña en el curso)
- ⚠️ SQL básico (se enseña en el curso)
- ⚠️ JavaScript (opcional, se enseña en módulos avanzados)

---

## 📚 Metodología del Curso

### 1. **Teoría Clara y Concisa**
Cada módulo incluye documentación teórica con:
- Conceptos fundamentales
- Arquitectura de Moodle
- Mejores prácticas
- Ejemplos visuales

### 2. **Ejemplos Comentados**
Todos los archivos de código incluyen:
- ✅ Comentarios línea por línea
- ✅ Explicación de cada función
- ✅ Casos de uso reales
- ✅ Errores comunes a evitar

### 3. **Ejercicios Progresivos**
Ejercicios diseñados para:
- 🎯 Reforzar conceptos
- 🎯 Practicar lo aprendido
- 🎯 Enfrentar desafíos reales
- 🎯 Construir portfolio

### 4. **Proyectos Prácticos**
Proyectos completos que:
- 🚀 Integran múltiples conceptos
- 🚀 Simulan desarrollo real
- 🚀 Pueden usarse en producción
- 🚀 Construyen experiencia

---

## 🗂️ Estructura de Archivos

```
curso-moodle-programacion/
│
├── README.md                          # Este archivo
│
├── modulo-1-introduccion/
│   ├── teoria/
│   │   ├── 01-que-es-moodle.md
│   │   └── 02-entorno-desarrollo.md
│   ├── ejemplos/
│   │   ├── 01-hola-mundo.php
│   │   └── 02-variables-globales.php
│   └── ejercicios/
│       └── ejercicios-modulo-1.md
│
├── modulo-2-php-basico/
│   ├── teoria/
│   │   └── 01-php-para-moodle.md
│   ├── ejemplos/
│   │   ├── 01-variables-operadores.php
│   │   ├── 02-estructuras-control.php
│   │   ├── 03-arrays.php
│   │   └── 04-funciones.php
│   └── ejercicios/
│       └── ejercicios-modulo-2.md
│
├── modulo-3-base-datos/
│   ├── teoria/
│   ├── ejemplos/
│   └── ejercicios/
│
├── modulo-4-formularios-apis/
│   ├── teoria/
│   ├── ejemplos/
│   └── ejercicios/
│
├── modulo-5-plugins/
│   ├── teoria/
│   ├── ejemplos/
│   └── proyectos/
│
├── modulo-6-temas-avanzados/
│   ├── teoria/
│   ├── ejemplos/
│   └── proyectos/
│
└── proyectos-finales/
    ├── proyecto-1-certificados/
    ├── proyecto-2-mobile-api/
    └── proyecto-3-gamificacion/
```

---

## 🚀 Cómo Usar Este Curso

### Opción 1: Aprendizaje Secuencial (Recomendado)
1. Comienza por el Módulo 1
2. Lee la teoría completa
3. Ejecuta cada ejemplo en tu Moodle local
4. Completa todos los ejercicios
5. Pasa al siguiente módulo

### Opción 2: Aprendizaje por Objetivos
1. Identifica qué quieres lograr
2. Ve directo al módulo correspondiente
3. Estudia los prerequisitos si es necesario
4. Completa el proyecto relacionado

### Opción 3: Referencia Rápida
1. Usa el índice para encontrar temas específicos
2. Consulta los ejemplos como referencia
3. Copia y adapta código para tus proyectos

---

## 💡 Consejos para el Éxito

### Para Principiantes
1. **No te saltes los módulos básicos** - La base es crucial
2. **Escribe todo el código tú mismo** - No copies y pegues
3. **Experimenta** - Rompe cosas, aprende de errores
4. **Lee la documentación oficial** - Es tu mejor amigo
5. **Únete a la comunidad** - Forums de Moodle, Stack Overflow

### Para Intermedios
1. **Profundiza en APIs** - Domina $DB, Forms, Files, Events
2. **Lee código de otros** - Estudia plugins populares
3. **Contribuye** - Haz pull requests a proyectos open source
4. **Documenta todo** - Practica PHPDoc desde ahora

### Para Avanzados
1. **Sigue coding guidelines** - Calidad profesional
2. **Implementa testing** - PHPUnit y Behat
3. **Optimiza siempre** - Performance matters
4. **Comparte conocimiento** - Escribe tutoriales, ayuda a otros

---

## 📖 Recursos Adicionales

### Documentación Oficial
- [Moodle Developer Docs](https://docs.moodle.org/dev/)
- [Moodle API Documentation](https://moodledev.io/)
- [Moodle Forums](https://moodle.org/forums/)

### Herramientas
- [Moodle Plugin Skeleton](https://moodle.org/plugins/tool_pluginskel)
- [Moodle Code Checker](https://moodle.org/plugins/local_codechecker)
- [Moodle PHPDoc Check](https://moodle.org/plugins/local_moodlecheck)

### Comunidad
- [Moodle Developer Forum](https://moodle.org/mod/forum/view.php?id=55)
- [Moodle Telegram Group](https://t.me/moodledev)
- [Moodle Stack Overflow](https://stackoverflow.com/questions/tagged/moodle)

---

## 🤝 Contribuciones

Este curso es de código abierto. Si encuentras errores, tienes sugerencias o quieres agregar contenido:

1. Abre un issue describiendo el problema/sugerencia
2. Haz un fork del repositorio
3. Crea una rama con tus cambios
4. Envía un pull request

---

## 📝 Licencia

Este curso está bajo licencia **MIT**. Eres libre de:
- ✅ Usar el contenido
- ✅ Modificarlo
- ✅ Compartirlo
- ✅ Usarlo comercialmente

Con la única condición de dar crédito al autor original.

---

## ✨ Sobre el Autor

Este curso fue creado con la intención de democratizar el conocimiento de programación en Moodle.

**Créditos especiales a:**
- La comunidad de Moodle
- Todos los desarrolladores que contribuyen a Moodle
- Los miles de estudiantes que aprenderán con este material

---

## 🎯 Próximos Pasos

¿Listo para empezar?

👉 **[Ve al Módulo 1: Introducción](./modulo-1-introduccion/)**

O si prefieres, configura tu entorno primero:

👉 **[Guía de Configuración de Entorno](./modulo-1-introduccion/teoria/02-entorno-desarrollo.md)**

---

## ❓ FAQ

**P: ¿Cuánto tiempo toma completar el curso?**
R: Depende de tu ritmo, pero aproximadamente 100-150 horas para el curso completo.

**P: ¿Necesito una instalación de Moodle?**
R: Sí, necesitas Moodle 4.0+ instalado localmente. Hay guías en el Módulo 1.

**P: ¿Puedo saltar módulos?**
R: Puedes, pero no se recomienda. Cada módulo construye sobre el anterior.

**P: ¿Hay certificado?**
R: Este es un curso autodidacta. No hay certificado oficial, pero tendrás un portfolio de proyectos.

**P: ¿Está actualizado para Moodle 4.x?**
R: Sí, todos los ejemplos son compatibles con Moodle 4.0+.

**P: ¿Hay video tutoriales?**
R: Actualmente solo contenido escrito, pero los ejemplos están muy comentados.

---

**¡Éxito en tu viaje de aprendizaje! 🚀**

*Última actualización: Noviembre 2024*
