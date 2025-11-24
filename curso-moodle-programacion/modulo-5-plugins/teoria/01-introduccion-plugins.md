# Módulo 5: Creación de Plugins en Moodle

## 5.1 Introducción a los Plugins

### ¿Qué es un Plugin?

Un **plugin** en Moodle es un módulo de código que extiende la funcionalidad base del sistema sin modificar el core.

### Ventajas de los Plugins

✅ **Modularidad**: Código organizado y separado del core
✅ **Actualizable**: Se actualiza independientemente de Moodle
✅ **Reutilizable**: Puede compartirse con la comunidad
✅ **Mantenible**: Fácil de mantener y actualizar
✅ **Desinstalable**: Se puede remover sin afectar el sistema

### Tipos de Plugins en Moodle

```
Moodle Plugins
├── Activity modules (mod)          # Actividades del curso
├── Blocks (block)                  # Bloques laterales
├── Question types (qtype)          # Tipos de preguntas
├── Question behaviours (qbehaviour) # Comportamientos de preguntas
├── Local plugins (local)           # Funcionalidad general
├── Course formats (format)         # Formatos de curso
├── Enrolment plugins (enrol)       # Métodos de inscripción
├── Authentication plugins (auth)   # Métodos de autenticación
├── Repository plugins (repository) # Repositorios de archivos
├── Portfolio plugins (portfolio)   # Portafolios
├── Themes (theme)                  # Temas visuales
├── Admin tools (tool)              # Herramientas de administración
├── Assignment submission (assignsubmission) # Tipos de entrega
├── Assignment feedback (assignfeedback)    # Tipos de retroalimentación
├── Quiz access rules (quizaccess)  # Reglas de acceso a quiz
├── Reports (report)                # Reportes
├── Gradebook plugins (grade)       # Calificaciones
├── Text filters (filter)           # Filtros de texto
├── Editors (editor)                # Editores HTML
├── Media players (media)           # Reproductores
└── Webservice protocols (webservice) # Protocolos de webservice
```

## Estructura Básica de un Plugin

### Archivos Esenciales

```
/local/miplugin/                    # Carpeta del plugin
├── version.php                     # REQUERIDO: Información de versión
├── lib.php                         # Funciones principales
├── settings.php                    # Configuración del admin
├── db/
│   ├── install.xml                 # Estructura de tablas
│   ├── upgrade.php                 # Scripts de actualización
│   ├── access.php                  # Capabilities
│   ├── events.php                  # Event observers
│   └── messages.php                # Message providers
├── classes/
│   ├── event/                      # Clases de eventos
│   ├── form/                       # Clases de formularios
│   ├── output/                     # Renderers
│   └── task/                       # Tareas programadas
├── lang/
│   └── en/
│       └── local_miplugin.php      # Strings en inglés
├── templates/                      # Mustache templates
├── amd/
│   └── src/                        # JavaScript AMD modules
└── styles.css                      # Estilos CSS
```

### version.php (OBLIGATORIO)

```php
<?php
/**
 * Version information
 *
 * @package    local_miplugin
 * @copyright  2024 Tu Nombre
 * @license    http://www.gnu.org/copyleft/gpl.html GNU GPL v3 or later
 */

defined('MOODLE_INTERNAL') || die();

$plugin->component = 'local_miplugin';    // Nombre completo del plugin
$plugin->version   = 2024112400;          // Formato: YYYYMMDDXX
$plugin->requires  = 2022112800;          // Versión mínima de Moodle (4.1)
$plugin->maturity  = MATURITY_STABLE;     // ALPHA, BETA, RC, STABLE
$plugin->release   = 'v1.0.0';            // Versión legible

// Dependencias (opcional)
$plugin->dependencies = array(
    'mod_forum' => 2022112800,            // Requiere mod_forum
    'local_otro' => 2024010100            // Requiere otro plugin
);
```

### Convenciones de Nombres

```php
// Formato general: {type}_{name}

// Ejemplos:
local_miplugin          // Plugin local
mod_myactivity          // Módulo de actividad
block_myblock           // Bloque
theme_mytheme           // Tema
auth_myauth             // Autenticación
enrol_myenrol           // Método de inscripción

// Tablas de BD: {prefix}_{name}_{table}
mdl_local_miplugin_items
mdl_local_miplugin_settings

// Capabilities: {component}:{action}
local/miplugin:view
local/miplugin:edit
local/miplugin:delete

// Event classes: {component}\event\{event_name}
\local_miplugin\event\item_created
\local_miplugin\event\item_deleted

// Strings: {identifier}, {component}
get_string('pluginname', 'local_miplugin')
get_string('mystring', 'local_miplugin')
```

## Plugin Local - El Más Versátil

### Cuándo Usar Plugin Local

✅ Funcionalidad que no encaja en otros tipos
✅ Herramientas administrativas
✅ Integraciones con sistemas externos
✅ Reportes personalizados
✅ Páginas personalizadas
✅ APIs internas

### Estructura Completa de Plugin Local

```
/local/miplugin/
├── version.php                     # Versión
├── settings.php                    # Configuración
├── lib.php                         # Funciones principales
├── index.php                       # Página principal
│
├── db/
│   ├── install.xml                 # Crear tablas
│   ├── upgrade.php                 # Actualizar tablas
│   ├── access.php                  # Permisos
│   ├── events.php                  # Observers
│   └── messages.php                # Notificaciones
│
├── classes/
│   ├── event/
│   │   ├── item_created.php        # Evento personalizado
│   │   └── item_deleted.php
│   ├── form/
│   │   └── edit_form.php           # Formulario
│   ├── observer.php                # Event observer
│   ├── privacy/
│   │   └── provider.php            # GDPR compliance
│   └── task/
│       └── cleanup_task.php        # Tarea programada
│
├── lang/
│   ├── en/
│   │   └── local_miplugin.php      # Inglés
│   └── es/
│       └── local_miplugin.php      # Español (opcional)
│
├── pix/
│   └── icon.svg                    # Icono del plugin
│
├── templates/
│   ├── item_list.mustache          # Template Mustache
│   └── item_view.mustache
│
├── amd/
│   └── src/
│       └── main.js                 # JavaScript AMD
│
└── styles.css                      # Estilos CSS
```

### settings.php - Configuración del Admin

```php
<?php
/**
 * Plugin settings
 */

defined('MOODLE_INTERNAL') || die;

if ($hassiteconfig) {
    // Crear página de configuración
    $settings = new admin_settingpage(
        'local_miplugin',
        get_string('pluginname', 'local_miplugin')
    );

    // Agregar al árbol de configuración
    $ADMIN->add('localplugins', $settings);

    // Campo de texto
    $settings->add(new admin_setting_configtext(
        'local_miplugin/apikey',
        get_string('apikey', 'local_miplugin'),
        get_string('apikey_desc', 'local_miplugin'),
        '',                             // Valor por defecto
        PARAM_TEXT                      // Tipo de parámetro
    ));

    // Checkbox
    $settings->add(new admin_setting_configcheckbox(
        'local_miplugin/enabled',
        get_string('enabled', 'local_miplugin'),
        get_string('enabled_desc', 'local_miplugin'),
        1                               // Habilitado por defecto
    ));

    // Select
    $options = array(
        'option1' => get_string('option1', 'local_miplugin'),
        'option2' => get_string('option2', 'local_miplugin'),
        'option3' => get_string('option3', 'local_miplugin')
    );
    $settings->add(new admin_setting_configselect(
        'local_miplugin/mode',
        get_string('mode', 'local_miplugin'),
        get_string('mode_desc', 'local_miplugin'),
        'option1',                      // Opción por defecto
        $options
    ));

    // Textarea
    $settings->add(new admin_setting_configtextarea(
        'local_miplugin/customtext',
        get_string('customtext', 'local_miplugin'),
        get_string('customtext_desc', 'local_miplugin'),
        '',
        PARAM_TEXT
    ));

    // HTML Editor
    $settings->add(new admin_setting_confightmleditor(
        'local_miplugin/welcometext',
        get_string('welcometext', 'local_miplugin'),
        get_string('welcometext_desc', 'local_miplugin'),
        ''
    ));

    // File picker
    $settings->add(new admin_setting_configstoredfile(
        'local_miplugin/logo',
        get_string('logo', 'local_miplugin'),
        get_string('logo_desc', 'local_miplugin'),
        'logo',                         // Filearea
        0,                              // Item ID
        array('maxfiles' => 1, 'accepted_types' => array('image'))
    ));
}
```

### lib.php - Funciones Principales

```php
<?php
/**
 * Library functions
 */

defined('MOODLE_INTERNAL') || die();

/**
 * Agregar items al menú de navegación
 *
 * @param global_navigation $navigation
 */
function local_miplugin_extend_navigation(global_navigation $navigation) {
    global $USER, $PAGE;

    // Solo si está logueado
    if (isloggedin() && !isguestuser()) {
        $context = context_system::instance();

        if (has_capability('local/miplugin:view', $context)) {
            // Crear nodo
            $node = $navigation->add(
                get_string('pluginname', 'local_miplugin'),
                new moodle_url('/local/miplugin/index.php'),
                navigation_node::TYPE_CUSTOM,
                null,
                'local_miplugin',
                new pix_icon('icon', '', 'local_miplugin')
            );

            // Hacer visible
            $node->showinflatnavigation = true;
        }
    }
}

/**
 * Agregar items al menú de configuración
 *
 * @param settings_navigation $navigation
 * @param context $context
 */
function local_miplugin_extend_settings_navigation($navigation, $context) {
    global $PAGE;

    // Solo en páginas del plugin
    if ($PAGE->pagetype == 'local-miplugin-index') {
        if (has_capability('local/miplugin:manage', $context)) {
            $node = $navigation->add(
                get_string('settings'),
                new moodle_url('/local/miplugin/settings.php'),
                navigation_node::TYPE_SETTING
            );
        }
    }
}

/**
 * Hook para fragmentos (AJAX)
 *
 * @param array $args
 * @return string
 */
function local_miplugin_output_fragment_get_items($args) {
    global $DB, $OUTPUT;

    $context = $args['context'];
    $itemid = $args['itemid'] ?? 0;

    // Verificar permisos
    require_capability('local/miplugin:view', $context);

    // Obtener datos
    if ($itemid) {
        $item = $DB->get_record('local_miplugin_items',
            array('id' => $itemid), '*', MUST_EXIST);

        // Renderizar con template
        return $OUTPUT->render_from_template('local_miplugin/item_view', $item);
    }

    return '';
}

/**
 * Serve uploaded files
 *
 * @param stdClass $course
 * @param stdClass $cm
 * @param context $context
 * @param string $filearea
 * @param array $args
 * @param bool $forcedownload
 * @param array $options
 * @return bool
 */
function local_miplugin_pluginfile($course, $cm, $context, $filearea, $args, $forcedownload, array $options = array()) {

    // Verificar contexto
    if ($context->contextlevel != CONTEXT_SYSTEM) {
        return false;
    }

    // Verificar permisos
    require_capability('local/miplugin:view', $context);

    // Áreas de archivos permitidas
    $fileareas = array('attachments', 'logo');
    if (!in_array($filearea, $fileareas)) {
        return false;
    }

    // Obtener archivo
    $itemid = array_shift($args);
    $filename = array_pop($args);
    $filepath = $args ? '/' . implode('/', $args) . '/' : '/';

    $fs = get_file_storage();
    $file = $fs->get_file($context->id, 'local_miplugin', $filearea,
        $itemid, $filepath, $filename);

    if (!$file) {
        return false;
    }

    // Enviar archivo
    send_stored_file($file, 86400, 0, $forcedownload, $options);
}
```

## Instalación y Actualización

### db/install.xml - Crear Tablas

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<XMLDB PATH="local/miplugin/db" VERSION="20241124" COMMENT="XMLDB file for Moodle local/miplugin">
  <TABLES>
    <TABLE NAME="local_miplugin_items" COMMENT="Items del plugin">
      <FIELDS>
        <FIELD NAME="id" TYPE="int" LENGTH="10" NOTNULL="true" SEQUENCE="true"/>
        <FIELD NAME="name" TYPE="char" LENGTH="255" NOTNULL="true" SEQUENCE="false"/>
        <FIELD NAME="description" TYPE="text" NOTNULL="false" SEQUENCE="false"/>
        <FIELD NAME="userid" TYPE="int" LENGTH="10" NOTNULL="true" DEFAULT="0" SEQUENCE="false"/>
        <FIELD NAME="status" TYPE="int" LENGTH="2" NOTNULL="true" DEFAULT="0" SEQUENCE="false"/>
        <FIELD NAME="timecreated" TYPE="int" LENGTH="10" NOTNULL="true" DEFAULT="0" SEQUENCE="false"/>
        <FIELD NAME="timemodified" TYPE="int" LENGTH="10" NOTNULL="true" DEFAULT="0" SEQUENCE="false"/>
      </FIELDS>
      <KEYS>
        <KEY NAME="primary" TYPE="primary" FIELDS="id"/>
        <KEY NAME="userid" TYPE="foreign" FIELDS="userid" REFTABLE="user" REFFIELDS="id"/>
      </KEYS>
      <INDEXES>
        <INDEX NAME="status" UNIQUE="false" FIELDS="status"/>
        <INDEX NAME="timecreated" UNIQUE="false" FIELDS="timecreated"/>
      </INDEXES>
    </TABLE>
  </TABLES>
</XMLDB>
```

### db/upgrade.php - Actualizar Tablas

```php
<?php
/**
 * Upgrade script
 */

defined('MOODLE_INTERNAL') || die();

function xmldb_local_miplugin_upgrade($oldversion) {
    global $DB;

    $dbman = $DB->get_manager();

    // Upgrade to version 2024112401
    if ($oldversion < 2024112401) {

        // Define field priority to be added to local_miplugin_items
        $table = new xmldb_table('local_miplugin_items');
        $field = new xmldb_field('priority', XMLDB_TYPE_INTEGER, '2',
            null, XMLDB_NOTNULL, null, '0', 'status');

        // Conditionally launch add field priority
        if (!$dbman->field_exists($table, $field)) {
            $dbman->add_field($table, $field);
        }

        // Plugin savepoint reached
        upgrade_plugin_savepoint(true, 2024112401, 'local', 'miplugin');
    }

    // Upgrade to version 2024112402
    if ($oldversion < 2024112402) {

        // Define table local_miplugin_tags to be created
        $table = new xmldb_table('local_miplugin_tags');

        // Adding fields
        $table->add_field('id', XMLDB_TYPE_INTEGER, '10', null,
            XMLDB_NOTNULL, XMLDB_SEQUENCE, null);
        $table->add_field('itemid', XMLDB_TYPE_INTEGER, '10', null,
            XMLDB_NOTNULL, null, '0');
        $table->add_field('tag', XMLDB_TYPE_CHAR, '100', null,
            XMLDB_NOTNULL, null, null);

        // Adding keys
        $table->add_key('primary', XMLDB_KEY_PRIMARY, array('id'));
        $table->add_key('itemid', XMLDB_KEY_FOREIGN,
            array('itemid'), 'local_miplugin_items', array('id'));

        // Conditionally launch create table
        if (!$dbman->table_exists($table)) {
            $dbman->create_table($table);
        }

        // Plugin savepoint reached
        upgrade_plugin_savepoint(true, 2024112402, 'local', 'miplugin');
    }

    return true;
}
```

## Próximos Temas

En las siguientes secciones verás:
- Plugin de Bloque (Block)
- Plugin de Módulo de Actividad (mod)
- Plugin de Tema (Theme)
- Plugin de Autenticación (auth)
- Publicar plugins en el repositorio oficial
