# Módulo 6: Temas Avanzados

## 6.1 Programación Orientada a Objetos en Moodle

### Namespaces y Autoloading

```php
<?php
namespace local_miplugin\output;

class renderer extends \plugin_renderer_base {
    public function render_my_item($data) {
        return $this->render_from_template('local_miplugin/item', $data);
    }
}
```

### Clases y Herencia

```php
<?php
namespace local_miplugin;

class item {
    protected $id;
    protected $name;

    public function __construct($id, $name) {
        $this->id = $id;
        $this->name = $name;
    }

    public function save() {
        global $DB;
        // Save logic
    }

    public static function get_by_id($id) {
        global $DB;
        return $DB->get_record('table', ['id' => $id]);
    }
}
```

## 6.2 Mustache Templates

### Crear Template

```mustache
{{!-- templates/item.mustache --}}
<div class="item" data-id="{{id}}">
    <h3>{{name}}</h3>
    <p>{{description}}</p>
    {{#hasimage}}
    <img src="{{imageurl}}" alt="{{name}}">
    {{/hasimage}}
    <div class="actions">
        {{#canedit}}
        <a href="{{editurl}}">Edit</a>
        {{/canedit}}
    </div>
</div>
```

### Usar Template

```php
$data = [
    'id' => $item->id,
    'name' => $item->name,
    'description' => format_text($item->description),
    'hasimage' => !empty($item->image),
    'imageurl' => $item->get_image_url(),
    'canedit' => has_capability('local/miplugin:edit', $context),
    'editurl' => new moodle_url('/local/miplugin/edit.php', ['id' => $item->id])
];

echo $OUTPUT->render_from_template('local_miplugin/item', $data);
```

## 6.3 JavaScript AMD Modules

### Crear Módulo JS

```javascript
// amd/src/main.js
define(['jquery', 'core/ajax', 'core/notification'], function($, Ajax, Notification) {

    return {
        init: function() {
            $('.delete-btn').on('click', function(e) {
                e.preventDefault();
                var itemId = $(this).data('id');

                Ajax.call([{
                    methodname: 'local_miplugin_delete_item',
                    args: {itemid: itemId}
                }])[0].done(function(response) {
                    if (response.success) {
                        $('[data-id="' + itemId + '"]').remove();
                        Notification.addNotification({
                            message: 'Item deleted',
                            type: 'success'
                        });
                    }
                }).fail(Notification.exception);
            });
        }
    };
});
```

### Usar en PHP

```php
$PAGE->requires->js_call_amd('local_miplugin/main', 'init');
```

## 6.4 Web Services

### Definir Servicios

```php
// db/services.php
$functions = array(
    'local_miplugin_get_items' => array(
        'classname'   => 'local_miplugin\external\get_items',
        'methodname'  => 'execute',
        'classpath'   => '',
        'description' => 'Get all items',
        'type'        => 'read',
        'ajax'        => true,
        'capabilities'=> 'local/miplugin:view'
    ),
);

$services = array(
    'Task Manager Service' => array(
        'functions' => array('local_miplugin_get_items'),
        'restrictedusers' => 0,
        'enabled' => 1,
    )
);
```

### Implementar Función

```php
<?php
namespace local_miplugin\external;

use external_api;
use external_function_parameters;
use external_value;
use external_multiple_structure;

class get_items extends external_api {

    public static function execute_parameters() {
        return new external_function_parameters([
            'userid' => new external_value(PARAM_INT, 'User ID', VALUE_DEFAULT, 0)
        ]);
    }

    public static function execute($userid) {
        global $DB, $USER;

        $params = self::validate_parameters(self::execute_parameters(), [
            'userid' => $userid
        ]);

        if ($params['userid'] == 0) {
            $params['userid'] = $USER->id;
        }

        $items = $DB->get_records('local_miplugin_items',
            ['userid' => $params['userid']]);

        $result = [];
        foreach ($items as $item) {
            $result[] = [
                'id' => $item->id,
                'name' => $item->name,
                'description' => $item->description
            ];
        }

        return $result;
    }

    public static function execute_returns() {
        return new external_multiple_structure(
            new external_single_structure([
                'id' => new external_value(PARAM_INT, 'Item ID'),
                'name' => new external_value(PARAM_TEXT, 'Item name'),
                'description' => new external_value(PARAM_TEXT, 'Description')
            ])
        );
    }
}
```

## 6.5 Testing

### PHPUnit Test

```php
<?php
namespace local_miplugin;

class item_test extends \advanced_testcase {

    public function test_create_item() {
        global $DB;

        $this->resetAfterTest(true);

        $user = $this->getDataGenerator()->create_user();
        $this->setUser($user);

        $item = new \stdClass();
        $item->name = 'Test Item';
        $item->userid = $user->id;
        $item->timecreated = time();

        $id = $DB->insert_record('local_miplugin_items', $item);

        $this->assertNotEmpty($id);

        $saved = $DB->get_record('local_miplugin_items', ['id' => $id]);
        $this->assertEquals('Test Item', $saved->name);
    }
}
```

### Behat Test

```gherkin
# tests/behat/create_item.feature
@local @local_miplugin
Feature: Create new item
  In order to manage items
  As a user
  I need to be able to create items

  Scenario: User creates a new item
    Given the following "users" exist:
      | username | firstname | lastname |
      | user1    | User      | One      |
    And I log in as "user1"
    When I navigate to "Task Manager" in site navigation
    And I click on "Add Task" "button"
    And I set the field "Title" to "My Task"
    And I press "Save"
    Then I should see "My Task"
```

## 6.6 Privacy API (GDPR)

```php
<?php
namespace local_miplugin\privacy;

use core_privacy\local\metadata\collection;
use core_privacy\local\request\contextlist;

class provider implements
    \core_privacy\local\metadata\provider,
    \core_privacy\local\request\plugin\provider {

    public static function get_metadata(collection $collection): collection {
        $collection->add_database_table(
            'local_miplugin_items',
            [
                'userid' => 'privacy:metadata:items:userid',
                'name' => 'privacy:metadata:items:name',
                'timecreated' => 'privacy:metadata:items:timecreated',
            ],
            'privacy:metadata:items'
        );

        return $collection;
    }

    public static function get_contexts_for_userid(int $userid): contextlist {
        // Implementation
    }

    public static function export_user_data(approved_contextlist $contextlist) {
        // Export data
    }

    public static function delete_data_for_user(approved_contextlist $contextlist) {
        // Delete user data
    }
}
```

## 6.7 Scheduled Tasks

```php
<?php
namespace local_miplugin\task;

class cleanup_task extends \core\task\scheduled_task {

    public function get_name() {
        return get_string('cleanuptask', 'local_miplugin');
    }

    public function execute() {
        global $DB;

        // Delete old items
        $onemonthago = time() - (30 * 24 * 60 * 60);

        $DB->delete_records_select('local_miplugin_items',
            'timecreated < ? AND status = ?',
            [$onemonthago, 1]);

        mtrace('Cleanup completed');
    }
}
```

## 6.8 Performance y Caching

### MUC (Moodle Universal Cache)

```php
// Definir en db/caches.php
$definitions = array(
    'items' => array(
        'mode' => cache_store::MODE_APPLICATION,
        'simplekeys' => true,
        'simpledata' => false,
    ),
);

// Usar cache
$cache = cache::make('local_miplugin', 'items');

// Get
$item = $cache->get($itemid);

if ($item === false) {
    $item = $DB->get_record('local_miplugin_items', ['id' => $itemid]);
    $cache->set($itemid, $item);
}

// Purge
$cache->delete($itemid);
$cache->purge();
```

### Optimización de Consultas

```php
// ❌ Mal (N+1 problem)
$items = $DB->get_records('items');
foreach ($items as $item) {
    $user = $DB->get_record('user', ['id' => $item->userid]);
}

// ✅ Bien (1 query con JOIN)
$sql = "SELECT i.*, u.firstname, u.lastname
        FROM {items} i
        JOIN {user} u ON u.id = i.userid";
$items = $DB->get_records_sql($sql);
```

## Checklist de Aprendizaje Avanzado

- [ ] Usar namespaces correctamente
- [ ] Crear clases con OOP
- [ ] Implementar templates Mustache
- [ ] Desarrollar módulos JavaScript AMD
- [ ] Crear Web Services
- [ ] Escribir tests PHPUnit y Behat
- [ ] Implementar Privacy API (GDPR)
- [ ] Crear scheduled tasks
- [ ] Usar sistema de caché
- [ ] Optimizar rendimiento
