# Ejercicios Prácticos - Módulo 2: PHP Básico

## Ejercicio 1: Calculadora de Notas
**Nivel: Principiante**

### Objetivo
Crear una página que calcule el promedio de calificaciones y determine si el estudiante aprobó.

### Requisitos
1. Crea un array con al menos 5 calificaciones
2. Calcula el promedio
3. Determina si aprobó (promedio >= 70)
4. Muestra la calificación más alta y más baja
5. Cuenta cuántas materias reprobó (< 70)

### Código base
```php
<?php
require_once('../../config.php');
require_login();

// Tu código aquí

$calificaciones = [85, 92, 68, 75, 90];

// TODO: Calcular promedio


// TODO: Determinar si aprobó


// TODO: Encontrar nota más alta y más baja


// TODO: Contar reprobadas

```

### Resultado esperado
```
Calificaciones: 85, 92, 68, 75, 90
Promedio: 82.0
Estado: APROBADO ✓
Nota más alta: 92
Nota más baja: 68
Materias reprobadas: 1
```

---

## Ejercicio 2: Analizador de Actividad de Usuarios
**Nivel: Principiante-Intermedio**

### Objetivo
Crear funciones que analicen la actividad de usuarios en Moodle.

### Requisitos
1. Crea una función `obtener_usuarios_activos()` que retorne usuarios activos en los últimos N días
2. Crea una función `calcular_tiempo_desde_login($timestamp)` que calcule tiempo desde último login
3. Crea una función `clasificar_usuario($lastlogin)` que retorne: 'Muy activo', 'Activo', 'Inactivo'
4. Muestra una tabla con los primeros 10 usuarios y su clasificación

### Pistas
```php
function obtener_usuarios_activos($dias = 7) {
    global $DB;

    $tiempo_limite = time() - ($dias * 24 * 60 * 60);

    // TODO: Consultar usuarios cuyo lastlogin > $tiempo_limite

    return $usuarios;
}

function clasificar_usuario($lastlogin) {
    $ahora = time();
    $diferencia = $ahora - $lastlogin;

    // TODO: Implementar lógica
    // Menos de 1 día = 'Muy activo'
    // Menos de 7 días = 'Activo'
    // Más de 7 días = 'Inactivo'
}
```

---

## Ejercicio 3: Sistema de Badges (Insignias)
**Nivel: Intermedio**

### Objetivo
Crear un sistema que asigne "badges" virtuales a usuarios según criterios.

### Requisitos
1. Crea una función que determine qué badges merece un usuario
2. Criterios:
   - **Pionero**: ID < 10
   - **Veterano**: Registrado hace más de 6 meses
   - **Activo**: Login en los últimos 7 días
   - **Super Usuario**: Tiene más de 3 badges
3. Muestra los badges del usuario actual con iconos

### Estructura
```php
function obtener_badges_usuario($userid) {
    global $DB;

    $user = $DB->get_record('user', array('id' => $userid));
    $badges = array();

    // TODO: Verificar cada criterio y agregar badges

    if ($user->id < 10) {
        $badges[] = array(
            'nombre' => 'Pionero',
            'icono' => '🏆',
            'descripcion' => 'Uno de los primeros usuarios'
        );
    }

    // TODO: Agregar más verificaciones

    return $badges;
}
```

### Resultado esperado
```
Tus Badges:
🏆 Pionero - Uno de los primeros usuarios
⭐ Activo - Has accedido recientemente
🔥 Super Usuario - Tienes múltiples logros
```

---

## Ejercicio 4: Filtro y Ordenamiento de Cursos
**Nivel: Intermedio**

### Objetivo
Crear un sistema de filtrado y ordenamiento de cursos.

### Requisitos
1. Obtén todos los cursos (sin el sitio principal)
2. Filtra solo los cursos visibles
3. Ordena por nombre alfabéticamente
4. Agrupa por categoría
5. Muestra en tabla con cantidad de estudiantes

### Código base
```php
// Obtener cursos
$all_courses = $DB->get_records('course');

// TODO: Filtrar cursos visibles
$visible_courses = array_filter($all_courses, function($course) {
    // Tu código aquí
});

// TODO: Ordenar por nombre
usort($visible_courses, function($a, $b) {
    // Tu código aquí
});

// TODO: Agrupar por categoría
$courses_by_category = array();
foreach ($visible_courses as $course) {
    // Tu código aquí
}
```

---

## Ejercicio 5: Generador de Reportes
**Nivel: Intermedio-Avanzado**

### Objetivo
Crear funciones para generar un reporte completo del sitio.

### Requisitos
1. Función `generar_reporte_usuarios()`: estadísticas de usuarios
2. Función `generar_reporte_cursos()`: estadísticas de cursos
3. Función `generar_reporte_actividad()`: actividad reciente
4. Función `exportar_reporte_array($datos)`: convierte a formato tabla HTML

### Estructura del reporte
```php
function generar_reporte_usuarios() {
    global $DB;

    return array(
        'total' => $DB->count_records('user', array('deleted' => 0)),
        'activos' => // Usuarios con login en últimos 30 días,
        'nuevos' => // Usuarios creados en último mes,
        'suspendidos' => $DB->count_records('user', array('suspended' => 1))
    );
}

function generar_reporte_completo() {
    return array(
        'usuarios' => generar_reporte_usuarios(),
        'cursos' => generar_reporte_cursos(),
        'actividad' => generar_reporte_actividad()
    );
}
```

---

## Ejercicio 6: Validador de Datos
**Nivel: Intermedio**

### Objetivo
Crear funciones de validación para diferentes tipos de datos.

### Requisitos
Crea las siguientes funciones con type hinting:

```php
/**
 * Valida un email
 */
function validar_email(string $email): bool {
    // TODO: Implementar
}

/**
 * Valida un nombre de usuario
 * - Mínimo 3 caracteres
 * - Solo letras, números y guión bajo
 */
function validar_username(string $username): bool {
    // TODO: Implementar
}

/**
 * Valida una contraseña
 * - Mínimo 8 caracteres
 * - Al menos una mayúscula
 * - Al menos un número
 */
function validar_password(string $password): array {
    // Retorna array con:
    // ['valido' => true/false, 'errores' => [...]]
}

/**
 * Sanitiza un texto para evitar XSS
 */
function sanitizar_texto(string $texto): string {
    // TODO: Implementar usando funciones de Moodle
}
```

---

## Ejercicio 7: Procesador de Arrays Multidimensionales
**Nivel: Avanzado**

### Objetivo
Trabajar con estructuras de datos complejas.

### Requisitos
Dado este array de cursos con estudiantes:

```php
$cursos_estudiantes = array(
    array(
        'curso' => 'PHP Básico',
        'estudiantes' => array(
            array('nombre' => 'Juan', 'calificacion' => 85),
            array('nombre' => 'Ana', 'calificacion' => 92),
            array('nombre' => 'Pedro', 'calificacion' => 78)
        )
    ),
    array(
        'curso' => 'JavaScript',
        'estudiantes' => array(
            array('nombre' => 'María', 'calificacion' => 88),
            array('nombre' => 'Carlos', 'calificacion' => 95)
        )
    )
);
```

Crea funciones para:
1. `obtener_promedio_curso($curso_data)`: Promedio de un curso
2. `obtener_mejor_estudiante($curso_data)`: Estudiante con mejor nota
3. `obtener_promedio_general($todos_cursos)`: Promedio de todos los cursos
4. `generar_reporte_completo($todos_cursos)`: Tabla con toda la información

---

## Ejercicio 8: Mini Sistema de Permisos
**Nivel: Avanzado**

### Objetivo
Crear un sistema simple de verificación de permisos.

### Requisitos
```php
// Define permisos
$permisos_usuario = array(
    'ver_cursos' => true,
    'editar_cursos' => false,
    'eliminar_cursos' => false,
    'ver_usuarios' => true,
    'editar_usuarios' => false
);

/**
 * Verifica si el usuario tiene un permiso
 */
function tiene_permiso(string $permiso, array $permisos_usuario): bool {
    // TODO
}

/**
 * Verifica si tiene TODOS los permisos
 */
function tiene_todos_permisos(array $permisos_requeridos, array $permisos_usuario): bool {
    // TODO
}

/**
 * Verifica si tiene AL MENOS UNO de los permisos
 */
function tiene_algun_permiso(array $permisos_requeridos, array $permisos_usuario): bool {
    // TODO
}

// Uso:
if (tiene_permiso('editar_cursos', $permisos_usuario)) {
    // Mostrar botón editar
}

if (tiene_todos_permisos(['ver_cursos', 'editar_cursos'], $permisos_usuario)) {
    // Permitir edición
}
```

---

## Ejercicio Integrador: Dashboard Personalizado
**Nivel: Avanzado**

### Objetivo
Combinar todos los conceptos en un dashboard completo.

### Requisitos Completos

1. **Sección de Usuario**
   - Nombre y avatar
   - Badges obtenidos
   - Última actividad

2. **Sección de Estadísticas**
   - Total de cursos inscritos
   - Promedio de calificaciones
   - Horas en la plataforma (estimado)

3. **Sección de Cursos**
   - Lista de cursos con filtros
   - Ordenar por: nombre, fecha, progreso
   - Agrupar por categoría

4. **Sección de Actividad Reciente**
   - Últimos 5 accesos al sistema
   - Últimas actividades completadas

### Funciones requeridas
- `obtener_datos_usuario($userid)`
- `obtener_cursos_usuario($userid)`
- `calcular_estadisticas_usuario($userid)`
- `obtener_actividad_reciente($userid, $limit)`
- `renderizar_dashboard($userid)`

---

## Checklist de Aprendizaje

Después de completar estos ejercicios, deberías poder:

- [ ] Trabajar con variables y operadores
- [ ] Usar estructuras de control (if, switch, for, foreach, while)
- [ ] Crear y manipular arrays (simples, asociativos, multidimensionales)
- [ ] Crear funciones con parámetros y valores de retorno
- [ ] Usar type hinting en funciones
- [ ] Trabajar con funciones anónimas (closures)
- [ ] Filtrar y transformar arrays con array_filter, array_map, array_reduce
- [ ] Realizar consultas básicas a la base de datos
- [ ] Aplicar buenas prácticas de código PHP

## Recursos Adicionales

- [PHP Manual Oficial](https://www.php.net/manual/es/)
- [Moodle Coding Style](https://docs.moodle.org/dev/Coding_style)
- [PHP The Right Way](https://phptherightway.com/)

## Soluciones

Las soluciones están disponibles en la carpeta `soluciones/`. ¡Intenta resolverlos primero antes de ver las respuestas!

¡Éxito con los ejercicios!
