# Proyecto Final 1: Stack LAMP Completo 🌐

## Descripción

Crea un servidor web completo con Linux, Apache, MySQL y PHP, incluyendo WordPress y phpMyAdmin pre-instalados.

## Objetivos de Aprendizaje

Al completar este proyecto serás capaz de:

✅ Provisionar un stack LAMP completo automáticamente
✅ Configurar Apache, MySQL y PHP desde cero
✅ Instalar y configurar WordPress
✅ Gestionar bases de datos con phpMyAdmin
✅ Crear scripts de backup automatizados
✅ Usar herramientas CLI como WP-CLI y Composer

## Especificaciones Técnicas

### Stack Instalado

- **Sistema Operativo:** Ubuntu 20.04 LTS
- **Servidor Web:** Apache 2.4+
- **Base de Datos:** MySQL 8.0+
- **Lenguaje:** PHP 7.4+
- **CMS:** WordPress (última versión)
- **Administración DB:** phpMyAdmin

### Recursos de la VM

- **RAM:** 2 GB
- **CPUs:** 2
- **Disco:** ~20 GB (después de instalación)

### Puertos Mapeados

| Servicio | Puerto Guest | Puerto Host |
|----------|--------------|-------------|
| HTTP     | 80           | 8080        |
| HTTPS    | 443          | 8443        |
| MySQL    | 3306         | 3306        |

### Red

- **IP Privada:** 192.168.33.10
- **Hostname:** lamp-server

## Instalación y Uso

### Paso 1: Pre-requisitos

```bash
# Verificar instalaciones
vagrant --version  # Debe ser 2.0+
VBoxManage --version  # Debe estar instalado

# Verificar espacio en disco (necesitas al menos 15 GB)
df -h
```

### Paso 2: Levantar el Servidor

```bash
# Navegar al directorio del proyecto
cd proyectos-finales/proyecto-01-lamp/

# Levantar la VM (primera vez tarda ~10-15 minutos)
vagrant up

# Ver el proceso de instalación
# Todo está automatizado, solo espera
```

### Paso 3: Verificar Instalación

```bash
# Verificar estado
vagrant status

# Conectarse a la VM
vagrant ssh

# Dentro de la VM, verificar servicios
systemctl status apache2
systemctl status mysql
php -v
```

### Paso 4: Acceder a los Servicios

Abre tu navegador:

1. **Página Principal:** http://localhost:8080
   - Verás un dashboard con toda la información del sistema

2. **WordPress:** http://localhost:8080/wordpress
   - Completa la instalación web (5 minutos)
   - Elige idioma, crea usuario admin, etc.

3. **phpMyAdmin:** http://localhost:8080/phpmyadmin
   - Usuario: `root`
   - Password: `root`
   - Explora las bases de datos

## Estructura del Proyecto

```
proyecto-01-lamp/
├── Vagrantfile          # Configuración completa del proyecto
├── README.md            # Este archivo
├── www/                 # Tu código de desarrollo (sincronizado)
│   └── (tus archivos PHP aquí)
└── backups/             # Backups automáticos
    └── (archivos .tar.gz y .sql.gz)
```

## Tareas y Desafíos

### Tarea 1: Configurar WordPress

```bash
# Accede a http://localhost:8080/wordpress
# Completa la instalación:
# - Idioma: Español
# - Título del sitio: "Mi Blog Vagrant"
# - Usuario: admin
# - Password: (elige uno seguro)
# - Email: tu@email.com

# Inicia sesión y crea:
# 1. Tu primer artículo
# 2. Instala un tema (Astra, OceanWP, etc.)
# 3. Instala plugin "Contact Form 7"
```

### Tarea 2: Desarrollar un Sitio Custom

```bash
# En tu HOST, crea un archivo PHP
mkdir -p www
cat > www/index.php <<'EOF'
<?php
// Conectar a MySQL
$conn = mysqli_connect('localhost', 'root', 'root', 'wordpress');

// Verificar conexión
if (!$conn) {
    die("Conexión fallida: " . mysqli_connect_error());
}

echo "<h1>Mi Aplicación PHP</h1>";
echo "<p>Conectado a MySQL exitosamente!</p>";

// Contar posts de WordPress
$result = mysqli_query($conn, "SELECT COUNT(*) as total FROM wp_posts WHERE post_status='publish'");
$row = mysqli_fetch_assoc($result);

echo "<p>Posts publicados en WordPress: " . $row['total'] . "</p>";

mysqli_close($conn);
?>
EOF

# Accede a: http://localhost:8080/dev/
```

### Tarea 3: Usar WP-CLI

```bash
vagrant ssh

# Ver información de WordPress
wp --info

# Ir al directorio de WordPress
cd /var/www/html/wordpress

# Listar plugins
wp plugin list --allow-root

# Instalar un plugin
wp plugin install jetpack --activate --allow-root

# Actualizar WordPress
wp core update --allow-root

# Crear un post desde la terminal
wp post create --post_title="Mi Post desde CLI" --post_content="Contenido del post" --post_status=publish --allow-root

# Listar posts
wp post list --allow-root

# Crear usuarios
wp user create editor editor@example.com --role=editor --allow-root
```

### Tarea 4: Backup y Restore

```bash
vagrant ssh

# Ejecutar backup
~/backup.sh

# Ver backups creados
ls -lh ~/backups/

# Copiar backup al host (desde fuera de la VM)
exit
vagrant ssh -c "cp ~/backups/* /vagrant/backups/"

# Ver backups en tu host
ls -lh backups/
```

**Restaurar un backup:**

```bash
vagrant ssh

# Restaurar base de datos
cd ~/backups/
gunzip -c wordpress-db-YYYYMMDD-HHMMSS.sql.gz | mysql -uroot -proot wordpress

# Restaurar archivos
tar -xzf wordpress-YYYYMMDD-HHMMSS.tar.gz -C /
```

### Tarea 5: Personalizar Apache

```bash
vagrant ssh

# Crear un VirtualHost personalizado
sudo cat > /etc/apache2/sites-available/miapp.conf <<'EOF'
<VirtualHost *:80>
    ServerName miapp.local
    DocumentRoot /var/www/html/dev

    <Directory /var/www/html/dev>
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/miapp-error.log
    CustomLog ${APACHE_LOG_DIR}/miapp-access.log combined
</VirtualHost>
EOF

# Habilitar el sitio
sudo a2ensite miapp.conf
sudo systemctl reload apache2

# Agregar al /etc/hosts de tu HOST (fuera de la VM):
# 192.168.33.10  miapp.local

# Acceder: http://miapp.local
```

## Troubleshooting

### Problema: WordPress muestra "Error estableciendo conexión con la base de datos"

**Solución:**
```bash
vagrant ssh
mysql -uroot -proot

# Dentro de MySQL:
SHOW DATABASES;
SELECT User, Host FROM mysql.user WHERE User='wpuser';

# Si no existe el usuario, créalo:
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'wppass123';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';
FLUSH PRIVILEGES;
```

### Problema: Apache no inicia

**Solución:**
```bash
vagrant ssh
sudo systemctl status apache2
sudo journalctl -xe  # Ver logs de error

# Probar configuración
sudo apache2ctl configtest

# Reiniciar
sudo systemctl restart apache2
```

### Problema: phpMyAdmin muestra error 404

**Solución:**
```bash
vagrant ssh
sudo a2enconf phpmyadmin
sudo systemctl reload apache2
```

### Problema: Muy lento

**Solución:**
Edita el Vagrantfile y aumenta recursos:

```ruby
vb.memory = "4096"  # Aumentar a 4 GB
vb.cpus = 4         # Aumentar a 4 CPUs
```

Luego:
```bash
vagrant reload
```

## Extensiones Sugeridas

### 1. Instalar Redis para Caché

```bash
vagrant ssh
sudo apt-get install -y redis-server php-redis
sudo systemctl start redis

# Verificar
redis-cli ping  # Debe responder PONG
```

### 2. Configurar HTTPS con SSL

```bash
vagrant ssh

# Habilitar SSL
sudo a2enmod ssl
sudo a2ensite default-ssl

# Generar certificado autofirmado
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/ssl/private/apache-selfsigned.key \
  -out /etc/ssl/certs/apache-selfsigned.crt

sudo systemctl restart apache2

# Acceder: https://localhost:8443
```

### 3. Monitoreo con Netdata

```bash
vagrant ssh

# Instalar Netdata
bash <(curl -Ss https://my-netdata.io/kickstart.sh) --dont-wait

# Configurar port forwarding en Vagrantfile:
# config.vm.network "forwarded_port", guest: 19999, host: 19999

vagrant reload

# Acceder: http://localhost:19999
```

### 4. Staging de WordPress

```bash
# Crear segunda instancia de WordPress para staging
vagrant ssh

cd /var/www/html
sudo cp -r wordpress wordpress-staging
sudo chown -R www-data:www-data wordpress-staging

# Crear base de datos de staging
mysql -uroot -proot -e "CREATE DATABASE wordpress_staging;"

# Actualizar wp-config.php en wordpress-staging
```

## Checklist de Finalización

- [ ] VM levanta sin errores
- [ ] Apache responde en http://localhost:8080
- [ ] MySQL funciona correctamente
- [ ] PHP muestra información correcta
- [ ] WordPress está instalado y accesible
- [ ] phpMyAdmin permite acceso
- [ ] Puedes crear contenido en WordPress
- [ ] El script de backup funciona
- [ ] WP-CLI ejecuta comandos
- [ ] Entiendes cada sección del Vagrantfile

## Recursos Adicionales

- [Documentación de WordPress](https://wordpress.org/support/)
- [WP-CLI Handbook](https://make.wordpress.org/cli/handbook/)
- [PHP Manual](https://www.php.net/manual/es/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [Apache HTTP Server Docs](https://httpd.apache.org/docs/)

## Siguiente Proyecto

Una vez domines este proyecto:

👉 **[Proyecto 2: Cluster de Kubernetes](../proyecto-02-kubernetes/)**

---

**¡Felicitaciones por completar el Proyecto 1!** 🎉

Has creado un entorno de desarrollo web profesional completamente automatizado.
