# Ejemplo Completo: Plugin Local "Task Manager"

Este es un ejemplo completo de un plugin funcional que implementa un gestor de tareas.

## Estructura de Archivos

```
/local/taskmanager/
├── version.php
├── settings.php
├── lib.php
├── index.php
├── edit.php
├── delete.php
├── db/
│   ├── install.xml
│   ├── upgrade.php
│   ├── access.php
│   └── events.php
├── classes/
│   ├── form/
│   │   └── edit_form.php
│   ├── event/
│   │   ├── task_created.php
│   │   └── task_completed.php
│   └── observer.php
├── lang/
│   └── en/
│       └── local_taskmanager.php
└── pix/
    └── icon.svg
```

## Archivos del Plugin

### version.php
```php
<?php
defined('MOODLE_INTERNAL') || die();

$plugin->component = 'local_taskmanager';
$plugin->version   = 2024112400;
$plugin->requires  = 2022112800;
$plugin->maturity  = MATURITY_STABLE;
$plugin->release   = 'v1.0.0';
```

### settings.php
```php
<?php
defined('MOODLE_INTERNAL') || die;

if ($hassiteconfig) {
    $settings = new admin_settingpage('local_taskmanager',
        get_string('pluginname', 'local_taskmanager'));

    $ADMIN->add('localplugins', $settings);

    $settings->add(new admin_setting_configcheckbox(
        'local_taskmanager/allowdelete',
        get_string('allowdelete', 'local_taskmanager'),
        get_string('allowdelete_desc', 'local_taskmanager'),
        1
    ));

    $settings->add(new admin_setting_configtext(
        'local_taskmanager/maxitems',
        get_string('maxitems', 'local_taskmanager'),
        get_string('maxitems_desc', 'local_taskmanager'),
        50,
        PARAM_INT
    ));
}
```

### db/install.xml
```xml
<?xml version="1.0" encoding="UTF-8" ?>
<XMLDB PATH="local/taskmanager/db" VERSION="20241124">
  <TABLES>
    <TABLE NAME="local_taskmanager_tasks">
      <FIELDS>
        <FIELD NAME="id" TYPE="int" LENGTH="10" NOTNULL="true" SEQUENCE="true"/>
        <FIELD NAME="title" TYPE="char" LENGTH="255" NOTNULL="true"/>
        <FIELD NAME="description" TYPE="text" NOTNULL="false"/>
        <FIELD NAME="userid" TYPE="int" LENGTH="10" NOTNULL="true"/>
        <FIELD NAME="status" TYPE="int" LENGTH="2" NOTNULL="true" DEFAULT="0"/>
        <FIELD NAME="priority" TYPE="int" LENGTH="2" NOTNULL="true" DEFAULT="1"/>
        <FIELD NAME="duedate" TYPE="int" LENGTH="10" NOTNULL="false"/>
        <FIELD NAME="timecreated" TYPE="int" LENGTH="10" NOTNULL="true"/>
        <FIELD NAME="timemodified" TYPE="int" LENGTH="10" NOTNULL="true"/>
        <FIELD NAME="timecompleted" TYPE="int" LENGTH="10" NOTNULL="false"/>
      </FIELDS>
      <KEYS>
        <KEY NAME="primary" TYPE="primary" FIELDS="id"/>
        <KEY NAME="userid" TYPE="foreign" FIELDS="userid" REFTABLE="user" REFFIELDS="id"/>
      </KEYS>
      <INDEXES>
        <INDEX NAME="status" UNIQUE="false" FIELDS="status"/>
        <INDEX NAME="priority" UNIQUE="false" FIELDS="priority"/>
      </INDEXES>
    </TABLE>
  </TABLES>
</XMLDB>
```

### db/access.php
```php
<?php
defined('MOODLE_INTERNAL') || die();

$capabilities = array(

    'local/taskmanager:view' => array(
        'captype' => 'read',
        'contextlevel' => CONTEXT_SYSTEM,
        'archetypes' => array(
            'user' => CAP_ALLOW
        )
    ),

    'local/taskmanager:manage' => array(
        'riskbitmask' => RISK_SPAM,
        'captype' => 'write',
        'contextlevel' => CONTEXT_SYSTEM,
        'archetypes' => array(
            'user' => CAP_ALLOW
        )
    ),

    'local/taskmanager:viewall' => array(
        'captype' => 'read',
        'contextlevel' => CONTEXT_SYSTEM,
        'archetypes' => array(
            'manager' => CAP_ALLOW
        )
    ),
);
```

### lib.php
```php
<?php
defined('MOODLE_INTERNAL') || die();

function local_taskmanager_extend_navigation(global_navigation $navigation) {
    global $USER;

    if (isloggedin() && !isguestuser()) {
        $context = context_system::instance();

        if (has_capability('local/taskmanager:view', $context)) {
            $node = $navigation->add(
                get_string('pluginname', 'local_taskmanager'),
                new moodle_url('/local/taskmanager/index.php'),
                navigation_node::TYPE_CUSTOM,
                null,
                'local_taskmanager',
                new pix_icon('icon', '', 'local_taskmanager')
            );
            $node->showinflatnavigation = true;
        }
    }
}
```

### index.php
```php
<?php
require_once('../../config.php');

require_login();

$context = context_system::instance();
require_capability('local/taskmanager:view', $context);

$PAGE->set_context($context);
$PAGE->set_url(new moodle_url('/local/taskmanager/index.php'));
$PAGE->set_pagelayout('standard');
$PAGE->set_title(get_string('pluginname', 'local_taskmanager'));
$PAGE->set_heading(get_string('mytasks', 'local_taskmanager'));

echo $OUTPUT->header();

// Obtener tareas del usuario
global $DB, $USER;

$sql = "SELECT * FROM {local_taskmanager_tasks}
        WHERE userid = :userid
        ORDER BY status ASC, priority DESC, duedate ASC";

$tasks = $DB->get_records_sql($sql, array('userid' => $USER->id));

// Botón para crear nueva tarea
if (has_capability('local/taskmanager:manage', $context)) {
    $addurl = new moodle_url('/local/taskmanager/edit.php');
    echo $OUTPUT->single_button($addurl, get_string('addtask', 'local_taskmanager'), 'get');
}

// Mostrar tareas
if (empty($tasks)) {
    echo html_writer::tag('p', get_string('notasks', 'local_taskmanager'),
        array('class' => 'alert alert-info'));
} else {
    echo html_writer::start_tag('div', array('class' => 'task-list'));

    foreach ($tasks as $task) {
        $status_class = $task->status == 1 ? 'completed' : 'pending';
        $priority_label = array(1 => 'Baja', 2 => 'Media', 3 => 'Alta');

        echo html_writer::start_tag('div',
            array('class' => "card mb-2 task-{$status_class}"));
        echo html_writer::start_tag('div', array('class' => 'card-body'));

        echo html_writer::tag('h5', format_string($task->title));
        echo html_writer::tag('p', format_text($task->description));

        echo html_writer::tag('small',
            "Prioridad: {$priority_label[$task->priority]} | " .
            "Vencimiento: " . ($task->duedate ? userdate($task->duedate) : 'Sin fecha')
        );

        // Acciones
        $editurl = new moodle_url('/local/taskmanager/edit.php', array('id' => $task->id));
        $deleteurl = new moodle_url('/local/taskmanager/delete.php', array('id' => $task->id));

        echo html_writer::start_tag('div', array('class' => 'mt-2'));
        echo html_writer::link($editurl, get_string('edit'), array('class' => 'btn btn-sm btn-primary'));
        echo ' ';
        echo html_writer::link($deleteurl, get_string('delete'), array('class' => 'btn btn-sm btn-danger'));
        echo html_writer::end_tag('div');

        echo html_writer::end_tag('div');
        echo html_writer::end_tag('div');
    }

    echo html_writer::end_tag('div');
}

echo $OUTPUT->footer();
```

### classes/form/edit_form.php
```php
<?php
namespace local_taskmanager\form;

defined('MOODLE_INTERNAL') || die();

require_once($CFG->libdir . '/formslib.php');

class edit_form extends \moodleform {

    public function definition() {
        $mform = $this->_form;

        // Hidden ID
        $mform->addElement('hidden', 'id');
        $mform->setType('id', PARAM_INT);

        // Title
        $mform->addElement('text', 'title', get_string('title', 'local_taskmanager'),
            array('size' => 60));
        $mform->setType('title', PARAM_TEXT);
        $mform->addRule('title', get_string('required'), 'required');

        // Description
        $mform->addElement('textarea', 'description',
            get_string('description', 'local_taskmanager'),
            'rows="5" cols="60"');
        $mform->setType('description', PARAM_TEXT);

        // Priority
        $priorities = array(
            1 => get_string('low', 'local_taskmanager'),
            2 => get_string('medium', 'local_taskmanager'),
            3 => get_string('high', 'local_taskmanager')
        );
        $mform->addElement('select', 'priority',
            get_string('priority', 'local_taskmanager'), $priorities);
        $mform->setDefault('priority', 2);

        // Due date
        $mform->addElement('date_time_selector', 'duedate',
            get_string('duedate', 'local_taskmanager'),
            array('optional' => true));

        // Status
        $statuses = array(
            0 => get_string('pending', 'local_taskmanager'),
            1 => get_string('completed', 'local_taskmanager')
        );
        $mform->addElement('select', 'status',
            get_string('status', 'local_taskmanager'), $statuses);

        $this->add_action_buttons();
    }

    public function validation($data, $files) {
        $errors = parent::validation($data, $files);

        if (!empty($data['duedate']) && $data['duedate'] < time()) {
            $errors['duedate'] = get_string('pastdate', 'local_taskmanager');
        }

        return $errors;
    }
}
```

### classes/event/task_created.php
```php
<?php
namespace local_taskmanager\event;

defined('MOODLE_INTERNAL') || die();

class task_created extends \core\event\base {

    protected function init() {
        $this->data['crud'] = 'c';
        $this->data['edulevel'] = self::LEVEL_PARTICIPATING;
        $this->data['objecttable'] = 'local_taskmanager_tasks';
    }

    public static function get_name() {
        return get_string('eventtaskcreated', 'local_taskmanager');
    }

    public function get_description() {
        return "El usuario {$this->userid} creó la tarea {$this->objectid}";
    }

    public function get_url() {
        return new \moodle_url('/local/taskmanager/index.php');
    }
}
```

### lang/en/local_taskmanager.php
```php
<?php
defined('MOODLE_INTERNAL') || die();

$string['pluginname'] = 'Task Manager';
$string['mytasks'] = 'My Tasks';
$string['addtask'] = 'Add Task';
$string['notasks'] = 'You have no tasks yet.';
$string['title'] = 'Title';
$string['description'] = 'Description';
$string['priority'] = 'Priority';
$string['low'] = 'Low';
$string['medium'] = 'Medium';
$string['high'] = 'High';
$string['duedate'] = 'Due Date';
$string['status'] = 'Status';
$string['pending'] = 'Pending';
$string['completed'] = 'Completed';
$string['pastdate'] = 'Due date cannot be in the past';
$string['allowdelete'] = 'Allow users to delete tasks';
$string['allowdelete_desc'] = 'If enabled, users can delete their own tasks';
$string['maxitems'] = 'Maximum tasks per user';
$string['maxitems_desc'] = 'Maximum number of tasks a user can create';
$string['eventtaskcreated'] = 'Task created';
$string['taskmanager:view'] = 'View tasks';
$string['taskmanager:manage'] = 'Manage own tasks';
$string['taskmanager:viewall'] = 'View all tasks';
```

## Instalación

1. Copiar carpeta a `/local/taskmanager/`
2. Visitar `/admin/index.php` para instalar
3. Configurar en: Site administration > Plugins > Local plugins > Task Manager

## Uso

1. Acceder desde el menú de navegación
2. Click en "Add Task"
3. Llenar formulario y guardar
4. Ver lista de tareas
5. Editar o eliminar tareas
