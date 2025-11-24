# 1.2 Configuración del Entorno de Desarrollo

## Requisitos del Sistema

### Software necesario:

1. **Servidor Web**: Apache o Nginx
2. **PHP**: Versión 7.4 o superior (recomendado 8.0+)
3. **Base de datos**: MySQL 5.7+ o MariaDB 10.2+
4. **Editor de código**: VSCode, PHPStorm, Sublime Text

## Instalación con Docker (Recomendado para principiantes)

### Paso 1: Instalar Docker y Docker Compose

```bash
# En Ubuntu/Debian
sudo apt update
sudo apt install docker.io docker-compose

# Verificar instalación
docker --version
docker-compose --version
```

### Paso 2: Crear archivo docker-compose.yml

```yaml
version: '3.8'

services:
  # Servidor web con PHP
  moodle:
    image: bitnami/moodle:latest
    ports:
      - "8080:8080"
    environment:
      - MOODLE_DATABASE_HOST=mariadb
      - MOODLE_DATABASE_USER=moodle
      - MOODLE_DATABASE_PASSWORD=moodlepass
      - MOODLE_DATABASE_NAME=moodle
    volumes:
      - moodle_data:/bitnami/moodle
      - moodledata:/bitnami/moodledata
    depends_on:
      - mariadb

  # Base de datos
  mariadb:
    image: mariadb:10.6
    environment:
      - MYSQL_ROOT_PASSWORD=rootpass
      - MYSQL_DATABASE=moodle
      - MYSQL_USER=moodle
      - MYSQL_PASSWORD=moodlepass
    volumes:
      - mariadb_data:/var/lib/mysql

volumes:
  moodle_data:
  moodledata:
  mariadb_data:
```

### Paso 3: Iniciar Moodle

```bash
# Iniciar los contenedores
docker-compose up -d

# Ver los logs
docker-compose logs -f

# Acceder a: http://localhost:8080
```

## Instalación Manual (Para desarrolladores avanzados)

### En Ubuntu/Debian:

```bash
# 1. Instalar Apache, PHP y extensiones necesarias
sudo apt update
sudo apt install apache2 php php-mysql php-xml php-mbstring \
                 php-curl php-zip php-gd php-intl php-soap \
                 php-xmlrpc git

# 2. Instalar MariaDB
sudo apt install mariadb-server

# 3. Configurar base de datos
sudo mysql -u root -p
```

```sql
-- Crear base de datos y usuario para Moodle
CREATE DATABASE moodle DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'moodleuser'@'localhost' IDENTIFIED BY 'tupassword';
GRANT ALL PRIVILEGES ON moodle.* TO 'moodleuser'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

```bash
# 4. Descargar Moodle
cd /var/www/html
sudo git clone https://github.com/moodle/moodle.git
cd moodle
sudo git checkout MOODLE_401_STABLE  # Versión 4.1 estable

# 5. Crear directorio de datos
sudo mkdir /var/moodledata
sudo chown -R www-data:www-data /var/moodledata
sudo chmod -R 770 /var/moodledata

# 6. Dar permisos
sudo chown -R www-data:www-data /var/www/html/moodle
```

## Configuración de PHP

Editar `/etc/php/8.1/apache2/php.ini`:

```ini
# Configuración recomendada para Moodle
upload_max_filesize = 128M
post_max_size = 128M
max_execution_time = 300
max_input_vars = 5000
memory_limit = 256M
```

```bash
# Reiniciar Apache
sudo systemctl restart apache2
```

## Configuración de Moodle

Crear `/var/www/html/moodle/config.php`:

```php
<?php  // Moodle configuration file

unset($CFG);
global $CFG;
$CFG = new stdClass();

// URL de tu sitio Moodle
$CFG->wwwroot   = 'http://localhost/moodle';

// Directorio de datos
$CFG->dataroot  = '/var/moodledata';

// Configuración de base de datos
$CFG->dbtype    = 'mariadb';      // Tipo de base de datos
$CFG->dblibrary = 'native';       // Biblioteca nativa
$CFG->dbhost    = 'localhost';    // Host
$CFG->dbname    = 'moodle';       // Nombre de la BD
$CFG->dbuser    = 'moodleuser';   // Usuario de BD
$CFG->dbpass    = 'tupassword';   // Contraseña de BD
$CFG->prefix    = 'mdl_';         // Prefijo de tablas

// Configuración de desarrollo (SOLO PARA DESARROLLO)
$CFG->debug = (E_ALL | E_STRICT); // Mostrar todos los errores
$CFG->debugdisplay = 1;           // Mostrar errores en pantalla

// Deshabilitar cache en desarrollo
$CFG->cachejs = false;
$CFG->cachetemplates = false;

// Directorio de instalación
$CFG->directorypermissions = 02777;

require_once(__DIR__ . '/lib/setup.php');

// FIN DEL ARCHIVO
```

## Herramientas de Desarrollo Recomendadas

### Visual Studio Code

**Extensiones útiles:**
```bash
# PHP Intelephense - Autocompletado PHP
# PHP Debug - Depuración
# Moodle Language Pack - Soporte para archivos .lang
# GitLens - Mejor integración con Git
```

### Configuración de VSCode para Moodle

Crear `.vscode/settings.json` en tu proyecto:

```json
{
  "php.suggest.basic": true,
  "php.validate.enable": true,
  "php.validate.executablePath": "/usr/bin/php",
  "files.associations": {
    "*.php": "php"
  },
  "editor.tabSize": 4,
  "editor.insertSpaces": true,
  "files.trimTrailingWhitespace": true
}
```

## Verificación de la Instalación

1. Accede a `http://localhost/moodle` (o `http://localhost:8080` con Docker)
2. Completa el asistente de instalación
3. Crea una cuenta de administrador
4. Verifica que puedas acceder al panel de administración

## Activación del Modo Desarrollador

En Moodle, ve a:
```
Administración del sitio > Desarrollo > Modo de depuración
```

Configuración recomendada para desarrollo:
- **Debug messages**: DEVELOPER
- **Display debug messages**: SÍ
- **Performance info**: SÍ

## Próximos pasos

Ahora que tienes tu entorno configurado, en el siguiente tema verás:
- Estructura de directorios de Moodle
- Convenciones de código
- Tu primer "Hola Mundo" en Moodle
