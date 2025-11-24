# Módulo 3: Base de Datos en Moodle

## 3.1 API de Base de Datos de Moodle

### Introducción

La API de Base de Datos de Moodle (`$DB`) es una abstracción poderosa que:
- **Independencia del motor**: Funciona con MySQL, MariaDB, PostgreSQL, MSSQL, Oracle
- **Seguridad**: Previene inyección SQL automáticamente
- **Consistencia**: Interfaz uniforme para todas las operaciones
- **Rendimiento**: Optimizaciones automáticas

### La Variable Global $DB

```php
global $DB;  // Objeto principal para trabajar con BD
```

## Estructura de Tablas en Moodle

### Prefijo de Tablas

Todas las tablas en Moodle tienen un prefijo (por defecto `mdl_`):

```php
// En código Moodle, usa placeholders sin prefijo
{user}         // Se convierte en mdl_user
{course}       // Se convierte en mdl_course
{user_enrolments} // Se convierte en mdl_user_enrolments
```

### Tablas Principales

```
mdl_user                # Usuarios del sistema
mdl_course              # Cursos
mdl_course_categories   # Categorías de cursos
mdl_context             # Contextos (permisos)
mdl_role                # Roles
mdl_role_assignments    # Asignación de roles
mdl_enrol               # Métodos de inscripción
mdl_user_enrolments     # Inscripciones de usuarios
mdl_grade_items         # Items de calificación
mdl_grade_grades        # Calificaciones
mdl_modules             # Módulos de actividad
mdl_course_modules      # Instancias de módulos en cursos
```

## Funciones de Lectura (SELECT)

### 1. get_record() - Obtener UN registro

```php
/**
 * Obtiene un único registro
 * @param string $table Nombre de la tabla
 * @param array $conditions Condiciones WHERE
 * @param string $fields Campos a retornar
 * @param int $strictness Nivel de strictness
 * @return object|false
 */

// Ejemplo: Obtener un usuario por ID
$user = $DB->get_record('user', ['id' => 2], '*', MUST_EXIST);

// Obtener solo campos específicos
$user = $DB->get_record('user', ['id' => 2], 'id, username, email');

// Con múltiples condiciones
$course = $DB->get_record('course',
    ['shortname' => 'MATH101', 'visible' => 1],
    '*',
    MUST_EXIST
);
```

**Niveles de Strictness:**
- `MUST_EXIST` - Lanza excepción si no existe
- `IGNORE_MISSING` - Retorna false si no existe (por defecto)
- `IGNORE_MULTIPLE` - Retorna el primero si hay varios

### 2. get_records() - Obtener MÚLTIPLES registros

```php
/**
 * Obtiene múltiples registros
 * @return array Array de objetos indexado por ID
 */

// Obtener todos los usuarios activos
$users = $DB->get_records('user', ['deleted' => 0]);

// Con ordenamiento
$courses = $DB->get_records('course', null, 'fullname ASC');

// Con límite
$recent_users = $DB->get_records('user', ['deleted' => 0], 'id DESC', '*', 0, 10);
// Parámetros: tabla, condiciones, orden, campos, offset, limit

// Resultado:
// Array (
//     [1] => stdClass Object ( [id] => 1, [username] => 'admin', ... )
//     [2] => stdClass Object ( [id] => 2, [username] => 'user1', ... )
// )
```

### 3. get_records_select() - Con condiciones SQL personalizadas

```php
/**
 * Obtiene registros con condiciones SQL complejas
 */

// Usuarios creados en los últimos 30 días
$time_limit = time() - (30 * 24 * 60 * 60);
$users = $DB->get_records_select(
    'user',
    'timecreated > ? AND deleted = ?',
    [$time_limit, 0],
    'timecreated DESC'
);

// Cursos con nombre que contiene texto
$courses = $DB->get_records_select(
    'course',
    $DB->sql_like('fullname', ':searchtext', false),
    ['searchtext' => '%PHP%']
);

// IMPORTANTE: Usar placeholders (?) o named placeholders (:name)
// NUNCA concatenar valores directamente (SQL injection)
```

### 4. get_field() - Obtener un SOLO CAMPO

```php
/**
 * Obtiene el valor de un campo específico
 */

// Obtener email de un usuario
$email = $DB->get_field('user', 'email', ['id' => 2]);

// Obtener nombre de curso
$coursename = $DB->get_field('course', 'fullname', ['id' => 5]);

// Con MUST_EXIST
$username = $DB->get_field('user', 'username', ['id' => 999], MUST_EXIST);
// Lanza excepción si no existe
```

### 5. get_fieldset() - Obtener ARRAY de valores

```php
/**
 * Obtiene un array con valores de un campo
 */

// Obtener todos los emails
$emails = $DB->get_fieldset_select('user', 'email', 'deleted = 0');
// Resultado: ['admin@example.com', 'user1@example.com', ...]

// IDs de cursos visibles
$course_ids = $DB->get_fieldset_select('course', 'id', 'visible = 1');
// Resultado: [1, 2, 3, 5, 7, ...]
```

### 6. count_records() - Contar registros

```php
/**
 * Cuenta registros que coinciden con condiciones
 */

// Total de usuarios
$total_users = $DB->count_records('user', ['deleted' => 0]);

// Total de cursos visibles
$visible_courses = $DB->count_records('course', ['visible' => 1]);

// Con condiciones complejas
$active_users = $DB->count_records_select(
    'user',
    'lastlogin > ? AND deleted = 0',
    [time() - (7 * 24 * 60 * 60)]
);
```

### 7. record_exists() - Verificar existencia

```php
/**
 * Verifica si existe un registro
 * Más eficiente que count_records cuando solo necesitas saber si existe
 */

// ¿Existe el usuario con username 'john'?
if ($DB->record_exists('user', ['username' => 'john', 'deleted' => 0])) {
    // Existe
}

// Verificar si un curso existe
if ($DB->record_exists('course', ['id' => $courseid])) {
    // El curso existe
}
```

## Funciones de Escritura (INSERT/UPDATE/DELETE)

### 1. insert_record() - Insertar registro

```php
/**
 * Inserta un nuevo registro
 * @return int ID del registro insertado
 */

// Crear nuevo usuario (ejemplo simplificado)
$user = new stdClass();
$user->username = 'newuser';
$user->firstname = 'John';
$user->lastname = 'Doe';
$user->email = 'john@example.com';
$user->password = hash_internal_user_password('Password123!');
$user->timecreated = time();
$user->timemodified = time();

$userid = $DB->insert_record('user', $user);
echo "Usuario creado con ID: {$userid}";

// Insertar sin retornar ID (más rápido si no lo necesitas)
$DB->insert_record('user', $user, false);
```

### 2. update_record() - Actualizar registro

```php
/**
 * Actualiza un registro existente
 * IMPORTANTE: El objeto debe tener el campo 'id'
 */

// Actualizar email de usuario
$user = $DB->get_record('user', ['id' => 2]);
$user->email = 'newemail@example.com';
$user->timemodified = time();
$DB->update_record('user', $user);

// Actualizar curso
$course = new stdClass();
$course->id = 5;
$course->fullname = 'Nuevo nombre del curso';
$course->timemodified = time();
$DB->update_record('course', $course);
```

### 3. insert_records() - Insertar múltiples registros

```php
/**
 * Inserta múltiples registros (más eficiente)
 */

$records = array();

for ($i = 1; $i <= 100; $i++) {
    $record = new stdClass();
    $record->name = "Item {$i}";
    $record->timecreated = time();
    $records[] = $record;
}

// Insertar todos de una vez
$DB->insert_records('my_custom_table', $records);
```

### 4. delete_records() - Eliminar registros

```php
/**
 * Elimina registros que coinciden con condiciones
 */

// Eliminar un usuario específico
$DB->delete_records('user', ['id' => 999]);

// Eliminar múltiples registros
$DB->delete_records('user_preferences', ['userid' => 5]);

// CUIDADO: Sin condiciones elimina TODO
// $DB->delete_records('table_name'); // ¡Elimina toda la tabla!
```

### 5. delete_records_select() - Eliminar con condiciones complejas

```php
/**
 * Elimina con condiciones SQL
 */

// Eliminar usuarios inactivos hace más de 1 año
$one_year_ago = time() - (365 * 24 * 60 * 60);
$DB->delete_records_select(
    'user',
    'lastlogin < ? AND deleted = 0',
    [$one_year_ago]
);
```

### 6. set_field() - Actualizar un solo campo

```php
/**
 * Actualiza un único campo (más eficiente que update_record)
 */

// Suspender un usuario
$DB->set_field('user', 'suspended', 1, ['id' => 5]);

// Hacer curso invisible
$DB->set_field('course', 'visible', 0, ['id' => 10]);

// Con múltiples condiciones
$DB->set_field('course', 'visible', 0, ['category' => 3, 'visible' => 1]);
```

## Consultas SQL Complejas

### get_records_sql() - SQL SELECT personalizado

```php
/**
 * Ejecuta una consulta SELECT personalizada
 */

// Obtener usuarios con sus roles
$sql = "SELECT u.id, u.username, u.email, r.shortname as role
        FROM {user} u
        JOIN {role_assignments} ra ON ra.userid = u.id
        JOIN {role} r ON r.id = ra.roleid
        WHERE u.deleted = 0
        ORDER BY u.lastname ASC";

$users_with_roles = $DB->get_records_sql($sql);

// Con parámetros
$sql = "SELECT c.*
        FROM {course} c
        WHERE c.category = :categoryid
        AND c.visible = :visible
        ORDER BY c.fullname ASC";

$params = [
    'categoryid' => 5,
    'visible' => 1
];

$courses = $DB->get_records_sql($sql, $params);

// Con límite
$courses = $DB->get_records_sql($sql, $params, 0, 10); // LIMIT 10
```

### get_record_sql() - SQL para un solo registro

```php
/**
 * Ejecuta SQL que retorna un registro
 */

// Obtener estadísticas
$sql = "SELECT COUNT(*) as total,
               SUM(CASE WHEN visible = 1 THEN 1 ELSE 0 END) as visible_count
        FROM {course}
        WHERE category = ?";

$stats = $DB->get_record_sql($sql, [5]);

echo "Total: {$stats->total}, Visibles: {$stats->visible_count}";
```

### execute() - Ejecutar cualquier SQL (INSERT/UPDATE/DELETE)

```php
/**
 * Ejecuta SQL que NO retorna datos
 */

// Actualización masiva
$sql = "UPDATE {user}
        SET city = :city
        WHERE country = :country";

$params = [
    'city' => 'Unknown',
    'country' => 'US'
];

$DB->execute($sql, $params);

// CUIDADO: Solo usar cuando las funciones normales no sean suficientes
```

## Transacciones

```php
/**
 * Usar transacciones para operaciones atómicas
 */

$transaction = $DB->start_delegated_transaction();

try {
    // Crear curso
    $course = new stdClass();
    $course->fullname = 'Nuevo Curso';
    $course->shortname = 'NC001';
    $course->timecreated = time();
    $courseid = $DB->insert_record('course', $course);

    // Crear categoría de calificación
    $gradecat = new stdClass();
    $gradecat->courseid = $courseid;
    $gradecat->fullname = 'General';
    $DB->insert_record('grade_categories', $gradecat);

    // Si todo está bien, confirmar
    $transaction->allow_commit();

} catch (Exception $e) {
    // Si hay error, revertir todos los cambios
    // La transacción se revierte automáticamente
    throw $e;
}
```

## Funciones Helper SQL

### sql_like() - Búsquedas LIKE seguras

```php
// Buscar cursos que contengan "PHP"
$sql = "SELECT * FROM {course} WHERE " .
       $DB->sql_like('fullname', ':searchtext', false);

$params = ['searchtext' => '%PHP%'];
$courses = $DB->get_records_sql($sql, $params);

// Case insensitive (tercer parámetro = false)
// Case sensitive (tercer parámetro = true)
```

### sql_concat() - Concatenar campos

```php
// Concatenar nombre y apellido
$fullname_sql = $DB->sql_concat('firstname', "' '", 'lastname');

$sql = "SELECT id, {$fullname_sql} as fullname FROM {user}";
$users = $DB->get_records_sql($sql);
```

### sql_compare_text() - Comparar campos TEXT

```php
// Para campos TEXT/CLOB en diferentes bases de datos
$sql = "SELECT * FROM {my_table}
        WHERE " . $DB->sql_compare_text('description') . " = " .
        $DB->sql_compare_text(':desc');

$params = ['desc' => 'Some description'];
```

## Buenas Prácticas

### ✅ HACER

```php
// Usar placeholders
$users = $DB->get_records_select('user', 'id > ?', [100]);

// Named placeholders
$sql = "SELECT * FROM {user} WHERE username = :username";
$user = $DB->get_record_sql($sql, ['username' => 'john']);

// Verificar existencia antes de actualizar
if ($DB->record_exists('user', ['id' => $userid])) {
    $DB->set_field('user', 'suspended', 1, ['id' => $userid]);
}

// Usar transacciones para operaciones relacionadas
$transaction = $DB->start_delegated_transaction();
// ... operaciones ...
$transaction->allow_commit();
```

### ❌ NO HACER

```php
// NUNCA concatenar valores directamente (SQL INJECTION!)
$sql = "SELECT * FROM {user} WHERE username = '{$username}'"; // MAL!

// NUNCA usar variables sin sanitizar
$table = $_GET['table'];
$DB->get_records($table); // MAL! Puede acceder a cualquier tabla

// No hacer queries en bucles (N+1 problem)
foreach ($courseids as $id) {
    $course = $DB->get_record('course', ['id' => $id]); // MAL!
}
// Mejor: Una sola query con IN
$courses = $DB->get_records_list('course', 'id', $courseids);
```

## Debugging de Consultas

```php
// Activar debug de SQL
$DB->set_debug(true);

// Tu consulta
$users = $DB->get_records('user', ['deleted' => 0]);

// Desactivar debug
$DB->set_debug(false);

// Esto imprimirá las consultas SQL ejecutadas
```

## Próximos Temas

En las siguientes secciones verás:
- Crear tablas personalizadas con XMLDB
- Optimización de consultas
- Índices y rendimiento
- Ejemplos prácticos completos
