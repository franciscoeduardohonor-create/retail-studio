# Ejercicios Prácticos - Módulo 3: Base de Datos

## Ejercicio 1: Dashboard de Estadísticas
**Nivel: Principiante-Intermedio**

### Objetivo
Crear una página que muestre estadísticas completas del sitio Moodle usando consultas a la BD.

### Requisitos
Usa las funciones de `$DB` para mostrar:

1. **Estadísticas de Usuarios:**
   - Total de usuarios (no eliminados)
   - Usuarios activos (login en últimos 30 días)
   - Usuarios nuevos (creados en últimos 7 días)
   - Usuarios suspendidos

2. **Estadísticas de Cursos:**
   - Total de cursos
   - Cursos visibles vs ocultos
   - Cursos por categoría (top 5)
   - Curso más reciente

3. **Actividad General:**
   - Último usuario en acceder
   - Total de roles asignados
   - Categorías de cursos

### Código Base
```php
<?php
require_once('../../config.php');
require_login();

global $DB, $USER;

// TODO: Implementar estadísticas

// Usuarios
$total_users = $DB->count_records('user', ['deleted' => 0]);
$thirty_days_ago = time() - (30 * 24 * 60 * 60);
$active_users = $DB->count_records_select('user', 'lastlogin > ? AND deleted = 0', [$thirty_days_ago]);

// Continúa con el resto...
```

### Resultado Esperado
```
╔═══════════════════════════════╗
║   DASHBOARD DE ESTADÍSTICAS   ║
╠═══════════════════════════════╣
║ 👥 USUARIOS                   ║
║   Total: 156                  ║
║   Activos (30d): 42           ║
║   Nuevos (7d): 5              ║
║   Suspendidos: 2              ║
╠═══════════════════════════════╣
║ 📚 CURSOS                     ║
║   Total: 23                   ║
║   Visibles: 20                ║
║   Ocultos: 3                  ║
╚═══════════════════════════════╝
```

---

## Ejercicio 2: Buscador de Usuarios
**Nivel: Intermedio**

### Objetivo
Crear un sistema de búsqueda de usuarios con filtros múltiples.

### Requisitos
1. Buscar por:
   - Nombre o apellido (LIKE)
   - Email
   - Username
   - País
   - Estado (activo/suspendido)

2. Mostrar resultados con:
   - Avatar
   - Nombre completo
   - Email
   - Último acceso
   - Botones de acción (ver perfil)

3. Implementar paginación (10 resultados por página)

4. Ordenar por: Nombre, Email, Último acceso

### Pistas
```php
// Construir condiciones dinámicamente
$conditions = [];
$params = [];

if (!empty($search_name)) {
    $conditions[] = $DB->sql_like('CONCAT(firstname, \' \', lastname)', ':name', false);
    $params['name'] = "%{$search_name}%";
}

if (!empty($search_email)) {
    $conditions[] = $DB->sql_like('email', ':email', false);
    $params['email'] = "%{$search_email}%";
}

$where = implode(' AND ', $conditions);
$users = $DB->get_records_select('user', $where, $params, 'lastname ASC', '*', $offset, $limit);
```

---

## Ejercicio 3: Reporte de Cursos por Categoría
**Nivel: Intermedio**

### Objetivo
Generar un reporte completo de cursos agrupados por categoría.

### Requisitos
1. Usar JOIN para unir `course` y `course_categories`
2. Contar estudiantes por curso
3. Mostrar:
   - Categoría
   - Lista de cursos
   - Estudiantes por curso
   - Total por categoría
4. Permitir exportar a CSV

### SQL Base
```php
$sql = "SELECT c.id, c.fullname, c.shortname, cat.name as category,
               (SELECT COUNT(*)
                FROM {user_enrolments} ue
                JOIN {enrol} e ON e.id = ue.enrolid
                WHERE e.courseid = c.id) as student_count
        FROM {course} c
        JOIN {course_categories} cat ON cat.id = c.category
        WHERE c.id != :siteid
        ORDER BY cat.name, c.fullname";

$courses = $DB->get_records_sql($sql, ['siteid' => SITEID]);
```

### Bonus
- Gráfico de barras con cantidad de cursos por categoría
- Filtro por categoría
- Totales y promedios

---

## Ejercicio 4: Sistema de Logs Personalizado
**Nivel: Intermedio-Avanzado**

### Objetivo
Crear un sistema para registrar eventos personalizados en una tabla.

### Requisitos
1. Diseñar estructura de tabla:
   ```sql
   - id (INT)
   - userid (INT)
   - action (VARCHAR)
   - description (TEXT)
   - ipaddress (VARCHAR)
   - timecreated (INT)
   ```

2. Funciones a implementar:
   ```php
   function log_event($action, $description)
   function get_user_logs($userid, $limit = 10)
   function get_logs_by_action($action)
   function delete_old_logs($days = 90)
   ```

3. Crear página de visualización con:
   - Filtros (usuario, acción, fecha)
   - Paginación
   - Búsqueda

### Código Inicial
```php
function log_event($action, $description) {
    global $DB, $USER;

    $log = new stdClass();
    $log->userid = $USER->id;
    $log->action = $action;
    $log->description = $description;
    $log->ipaddress = $_SERVER['REMOTE_ADDR'];
    $log->timecreated = time();

    return $DB->insert_record('local_mylog', $log);
}

function get_user_logs($userid, $limit = 10) {
    global $DB;

    return $DB->get_records('local_mylog',
        ['userid' => $userid],
        'timecreated DESC',
        '*',
        0,
        $limit
    );
}
```

---

## Ejercicio 5: Migración de Datos
**Nivel: Avanzado**

### Objetivo
Crear un script que migre datos de una estructura antigua a una nueva.

### Escenario
Tienes una tabla temporal `temp_users` con datos importados de otro sistema:
```
- full_name (VARCHAR) - "Juan Pérez"
- email_address (VARCHAR)
- registration_date (VARCHAR) - "2024-01-15"
- user_role (VARCHAR) - "student"
```

Debes migrar a las tablas de Moodle correctamente.

### Requisitos
1. Separar `full_name` en firstname y lastname
2. Convertir `registration_date` a timestamp
3. Crear usuarios en `mdl_user`
4. Asignar rol apropiado
5. Manejar errores (email duplicado, etc.)
6. Usar transacciones
7. Log de proceso (exitosos, fallidos)

### Código Base
```php
$transaction = $DB->start_delegated_transaction();

try {
    // Obtener datos temporales
    $temp_users = $DB->get_records('temp_users');

    $success_count = 0;
    $error_count = 0;
    $errors = [];

    foreach ($temp_users as $temp) {
        // Verificar si el email ya existe
        if ($DB->record_exists('user', ['email' => $temp->email_address])) {
            $errors[] = "Email duplicado: {$temp->email_address}";
            $error_count++;
            continue;
        }

        // Separar nombre
        $parts = explode(' ', $temp->full_name, 2);
        $firstname = $parts[0];
        $lastname = $parts[1] ?? '';

        // Crear usuario
        $user = new stdClass();
        $user->username = strtolower(str_replace(' ', '', $temp->full_name));
        $user->firstname = $firstname;
        $user->lastname = $lastname;
        $user->email = $temp->email_address;
        // ... completar campos requeridos

        $userid = $DB->insert_record('user', $user);

        // Asignar rol
        // ... implementar

        $success_count++;
    }

    // Confirmar si todo salió bien
    $transaction->allow_commit();

    echo "Migración completada: {$success_count} exitosos, {$error_count} errores\n";

} catch (Exception $e) {
    echo "Error en migración: " . $e->getMessage();
    // Se revierte automáticamente
}
```

---

## Ejercicio 6: Generador de Reportes SQL
**Nivel: Avanzado**

### Objetivo
Crear un sistema que permita ejecutar reportes SQL predefinidos.

### Requisitos
1. Definir reportes en array asociativo:
   ```php
   $reports = [
       'users_by_country' => [
           'name' => 'Usuarios por País',
           'sql' => 'SELECT country, COUNT(*) as total FROM {user} ...',
           'params' => []
       ],
       // más reportes...
   ];
   ```

2. Interfaz para:
   - Seleccionar reporte
   - Ver SQL del reporte
   - Ejecutar y mostrar resultados
   - Exportar a CSV, Excel, PDF

3. Visualizaciones:
   - Tabla
   - Gráficos (usando Chart.js)
   - Estadísticas resumen

4. Caché de resultados (para reportes pesados)

### Reportes a Implementar
1. Usuarios por país (con gráfico de barras)
2. Cursos más populares (por inscripciones)
3. Actividad por día de la semana
4. Top 10 usuarios más activos
5. Cursos sin actividad reciente

---

## Ejercicio 7: Optimizador de Consultas
**Nivel: Avanzado**

### Objetivo
Analizar y optimizar consultas lentas.

### Tareas
1. Identificar consultas lentas:
   - Usar `$DB->set_debug(true)`
   - Medir tiempo de ejecución
   - Identificar N+1 problems

2. Optimizar:
   ```php
   // ANTES (lento - N+1)
   $courses = $DB->get_records('course');
   foreach ($courses as $course) {
       $category = $DB->get_record('course_categories', ['id' => $course->category]);
       // ...
   }

   // DESPUÉS (rápido - 1 query con JOIN)
   $sql = "SELECT c.*, cat.name as category_name
           FROM {course} c
           JOIN {course_categories} cat ON cat.id = c.category";
   $courses = $DB->get_records_sql($sql);
   ```

3. Crear herramienta de análisis:
   - Input: SQL query
   - Output: EXPLAIN, tiempo de ejecución, sugerencias

---

## Ejercicio 8: API de Estadísticas
**Nivel: Avanzado**

### Objetivo
Crear una API interna que provea estadísticas mediante funciones reutilizables.

### Estructura
Crear archivo `lib/stats_api.php`:

```php
<?php

class moodle_stats {

    /**
     * Obtiene estadísticas de usuarios
     */
    public static function get_user_stats() {
        global $DB;

        $stats = new stdClass();
        $stats->total = $DB->count_records('user', ['deleted' => 0]);
        $stats->active = // ... implementar
        $stats->new_last_week = // ... implementar

        return $stats;
    }

    /**
     * Obtiene estadísticas de cursos
     */
    public static function get_course_stats() {
        // ... implementar
    }

    /**
     * Obtiene usuarios más activos
     */
    public static function get_top_users($limit = 10) {
        // ... implementar
    }

    /**
     * Obtiene cursos populares
     */
    public static function get_popular_courses($limit = 10) {
        // ... implementar
    }

    /**
     * Genera reporte de actividad
     */
    public static function generate_activity_report($from_date, $to_date) {
        // ... implementar
    }
}
```

### Uso
```php
$user_stats = moodle_stats::get_user_stats();
echo "Total de usuarios: {$user_stats->total}";

$top_users = moodle_stats::get_top_users(5);
// ...
```

---

## Proyecto Integrador: Sistema CRUD Completo
**Nivel: Avanzado**

### Objetivo
Crear un sistema completo de gestión (Create, Read, Update, Delete) para una entidad personalizada.

### Escenario
Sistema de gestión de "Eventos" del campus.

### Requisitos Completos

1. **Tabla de Base de Datos:**
   ```sql
   mdl_local_events:
   - id
   - name (VARCHAR 255)
   - description (TEXT)
   - location (VARCHAR 255)
   - start_date (INT)
   - end_date (INT)
   - capacity (INT)
   - organizer_id (INT) -> {user}.id
   - category (VARCHAR 50)
   - visible (TINYINT)
   - timecreated (INT)
   - timemodified (INT)
   ```

2. **Funcionalidades:**
   - Listar eventos (con filtros y búsqueda)
   - Crear nuevo evento
   - Editar evento
   - Eliminar evento (con confirmación)
   - Ver detalles de evento
   - Registrarse a evento (tabla adicional)
   - Ver participantes

3. **Validaciones:**
   - Nombre requerido (mínimo 5 caracteres)
   - Fecha de inicio < fecha de fin
   - Capacidad > 0
   - Solo el organizador puede editar/eliminar

4. **Transacciones:**
   - Al eliminar evento, eliminar también registros de participantes

5. **Consultas Avanzadas:**
   - Eventos próximos (JOIN con usuario organizador)
   - Eventos con plazas disponibles
   - Mis eventos (como participante y organizador)
   - Estadísticas (total, por categoría, participación)

### Archivos a Crear
```
/local/events/
├── index.php (listar)
├── view.php (ver detalle)
├── edit.php (crear/editar)
├── delete.php (eliminar)
├── register.php (inscribirse)
├── lib.php (funciones auxiliares)
└── styles.css
```

### Funciones en lib.php
```php
function events_get_all($filters = [])
function events_get_by_id($id)
function events_create($data)
function events_update($data)
function events_delete($id)
function events_register_user($eventid, $userid)
function events_get_participants($eventid)
function events_get_stats()
```

---

## Checklist de Aprendizaje

Después de completar estos ejercicios, deberías poder:

- [ ] Usar todas las funciones de lectura de $DB
- [ ] Insertar, actualizar y eliminar registros
- [ ] Escribir consultas SQL complejas con JOINs
- [ ] Usar agregaciones (COUNT, SUM, AVG)
- [ ] Implementar transacciones
- [ ] Optimizar consultas para rendimiento
- [ ] Prevenir SQL injection con placeholders
- [ ] Crear sistemas CRUD completos
- [ ] Manejar errores de base de datos
- [ ] Usar subqueries y CASE WHEN

## Recursos Adicionales

- [Moodle Data Manipulation API](https://docs.moodle.org/dev/Data_manipulation_API)
- [SQL en W3Schools](https://www.w3schools.com/sql/)
- [MySQL Performance Tuning](https://dev.mysql.com/doc/refman/8.0/en/optimization.html)

¡Éxito con los ejercicios!
