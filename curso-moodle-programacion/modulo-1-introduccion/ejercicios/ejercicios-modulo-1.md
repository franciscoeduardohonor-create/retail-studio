# Ejercicios Prácticos - Módulo 1

## Ejercicio 1: Tu Primera Página Personalizada
**Nivel: Principiante**

### Objetivo
Crear una página que muestre un saludo personalizado al usuario.

### Tareas
1. Crea un archivo `saludo.php` en `/local/holamundo/`
2. Muestra el nombre completo del usuario
3. Muestra la hora actual
4. Muestra cuántos días han pasado desde su último acceso
5. Usa clases CSS de Bootstrap (que Moodle incluye) para estilizar

### Pistas
```php
// Para obtener la fecha actual
$now = time();

// Para formatear fechas
date('d/m/Y H:i:s', $timestamp);

// Para calcular diferencia de días
$dias = floor(($now - $USER->lastlogin) / 86400);
```

### Resultado esperado
Una página que muestre:
```
¡Hola, Juan Pérez!

Hoy es: 23/11/2025 14:30:00
Han pasado 3 días desde tu último acceso.
```

---

## Ejercicio 2: Página de Estadísticas
**Nivel: Principiante-Intermedio**

### Objetivo
Crear una página que muestre estadísticas del sitio Moodle.

### Tareas
1. Crea `estadisticas.php` en `/local/holamundo/`
2. Muestra:
   - Total de usuarios (no eliminados)
   - Total de cursos (excluyendo el sitio principal)
   - Total de categorías de cursos
   - Usuario más reciente registrado
3. Presenta la información en tarjetas (cards) de Bootstrap

### Pistas
```php
// Contar registros
$total = $DB->count_records('tabla', array('campo' => 'valor'));

// Obtener un registro
$record = $DB->get_record('tabla', array('id' => 1));

// Obtener varios registros con límite
$records = $DB->get_records('tabla', null, 'id DESC', '*', 0, 1);
```

### Consultas SQL necesarias
```php
// Usuarios activos (no eliminados)
$usuarios = $DB->count_records('user', array('deleted' => 0));

// Cursos (sin contar el sitio)
$cursos = $DB->count_records('course') - 1;

// Categorías
$categorias = $DB->count_records('course_categories');

// Último usuario registrado
$ultimo_usuario = $DB->get_record_sql(
    "SELECT * FROM {user} WHERE deleted = 0 ORDER BY id DESC LIMIT 1"
);
```

---

## Ejercicio 3: Navegador de Contextos
**Nivel: Intermedio**

### Objetivo
Crear una página que muestre información sobre los diferentes contextos de Moodle.

### Tareas
1. Crea `contextos.php`
2. Muestra información sobre:
   - Contexto de sistema
   - Contexto de usuario
   - Lista de contextos de cursos (primeros 5)
3. Explica qué es cada contexto

### Conceptos de contextos
```php
// Contexto de sistema (nivel más alto)
$system_context = context_system::instance();

// Contexto de usuario
$user_context = context_user::instance($USER->id);

// Obtener todos los cursos
$courses = $DB->get_records('course', null, 'id DESC', '*', 0, 5);

// Para cada curso, obtener su contexto
foreach ($courses as $course) {
    $course_context = context_course::instance($course->id);
    // Mostrar información
}
```

---

## Ejercicio 4: Generador de HTML
**Nivel: Intermedio**

### Objetivo
Practicar el uso de `html_writer` para crear HTML seguro.

### Tareas
Crea una página que genere:
1. Una tabla HTML con 3 columnas: ID, Nombre, Email
2. Rellénala con los primeros 10 usuarios del sistema
3. Alterna colores de filas (usa clases CSS)
4. Añade un botón en cada fila para "Ver perfil"

### Estructura esperada
```php
// Crear tabla
echo html_writer::start_tag('table', array('class' => 'table table-striped'));

// Cabecera
echo html_writer::start_tag('thead');
echo html_writer::start_tag('tr');
echo html_writer::tag('th', 'ID');
echo html_writer::tag('th', 'Nombre');
echo html_writer::tag('th', 'Email');
echo html_writer::tag('th', 'Acción');
echo html_writer::end_tag('tr');
echo html_writer::end_tag('thead');

// Cuerpo
echo html_writer::start_tag('tbody');

// Obtener usuarios
$users = $DB->get_records('user', array('deleted' => 0), 'id ASC', '*', 0, 10);

foreach ($users as $user) {
    echo html_writer::start_tag('tr');
    echo html_writer::tag('td', $user->id);
    echo html_writer::tag('td', fullname($user));
    echo html_writer::tag('td', $user->email);

    // Botón
    $url = new moodle_url('/user/profile.php', array('id' => $user->id));
    echo html_writer::tag('td',
        $OUTPUT->single_button($url, 'Ver perfil', 'get', array('class' => 'btn-sm'))
    );

    echo html_writer::end_tag('tr');
}

echo html_writer::end_tag('tbody');
echo html_writer::end_tag('table');
```

---

## Ejercicio 5: Verificación de Capacidades
**Nivel: Intermedio-Avanzado**

### Objetivo
Aprender a verificar permisos del usuario.

### Tareas
1. Crea una página que solo sea accesible para administradores
2. Muestra un mensaje de error si el usuario no es admin
3. Si es admin, muestra opciones de administración simuladas

### Conceptos de capacidades
```php
// Verificar si es admin
$is_admin = is_siteadmin();

// Verificar capacidad específica
$context = context_system::instance();
$can_manage = has_capability('moodle/site:config', $context);

// Requerir capacidad (lanza excepción si no la tiene)
require_capability('moodle/site:config', $context);
```

### Código base
```php
require_once('../../config.php');
require_login();

$context = context_system::instance();
$PAGE->set_context($context);

// Verificar si el usuario es administrador
if (!is_siteadmin()) {
    // Mostrar error
    print_error('nopermissions', 'error', '', 'Solo administradores');
}

// El resto del código solo se ejecuta si es admin
$PAGE->set_url(new moodle_url('/local/holamundo/admin.php'));
$PAGE->set_title('Panel de Administración');
$PAGE->set_heading('Opciones de Administrador');

echo $OUTPUT->header();

echo html_writer::tag('div',
    '¡Bienvenido al panel de administración!',
    array('class' => 'alert alert-success')
);

// Aquí va el resto de tu código

echo $OUTPUT->footer();
```

---

## Ejercicio Integrador: Dashboard Personalizado
**Nivel: Avanzado**

### Objetivo
Crear un dashboard completo que combine todos los conceptos aprendidos.

### Requisitos
1. Muestra información del usuario actual (con avatar)
2. Muestra estadísticas del sitio en tarjetas
3. Lista los últimos 5 cursos creados
4. Lista los últimos 5 usuarios registrados
5. Muestra un gráfico simple (puede ser con HTML/CSS)
6. Solo accesible para usuarios autenticados
7. Usa Bootstrap para el diseño
8. Implementa navegación por pestañas (tabs)

### Estructura sugerida
```
+------------------------------------------+
|            MI DASHBOARD                  |
+------------------------------------------+
| [Avatar] Hola, Juan                      |
| Email: juan@example.com                  |
+------------------------------------------+
| [Tab: Estadísticas] [Tab: Cursos] [Tab: Usuarios] |
+------------------------------------------+
| Contenido según tab seleccionado         |
|                                          |
+------------------------------------------+
```

### Bonus
- Añade un formulario para buscar usuarios
- Implementa paginación para las listas
- Añade gráficos con Chart.js (JavaScript)

---

## Soluciones

Las soluciones a estos ejercicios están disponibles en la carpeta `soluciones/`.
Te recomendamos intentar resolverlos por tu cuenta primero.

## Recursos Adicionales

- [Documentación de Moodle](https://docs.moodle.org)
- [Moodle Developer Docs](https://moodledev.io)
- [Bootstrap 4 Documentation](https://getbootstrap.com/docs/4.6/)

## Checklist de Aprendizaje

Después de completar estos ejercicios, deberías poder:

- [ ] Crear archivos PHP básicos en Moodle
- [ ] Usar las variables globales principales ($CFG, $USER, $DB, $PAGE, $OUTPUT)
- [ ] Configurar una página correctamente
- [ ] Generar HTML seguro con html_writer
- [ ] Realizar consultas básicas a la base de datos
- [ ] Verificar permisos de usuario
- [ ] Usar Bootstrap para estilos
- [ ] Entender el sistema de contextos de Moodle

¡Mucha suerte con los ejercicios!
