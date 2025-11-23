# Módulo 4: Provisionamiento Avanzado 🔧

## Introducción

El provisionamiento es la automatización de la instalación y configuración de software. Este módulo cubre todos los métodos de provisionamiento en Vagrant.

## Contenido

### 1. Provisionamiento con Shell Scripts

#### Script Inline Básico

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y nginx git curl
    systemctl start nginx
  SHELL
end
```

#### Script Externo

```ruby
# Vagrantfile
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  # Script como root
  config.vm.provision "shell", path: "provision.sh"

  # Script como usuario vagrant
  config.vm.provision "shell", path: "user-setup.sh", privileged: false
end
```

```bash
# provision.sh
#!/bin/bash
set -e  # Salir si hay errores

echo "=== Instalando Stack LAMP ==="

# Actualizar
apt-get update

# Apache
apt-get install -y apache2
systemctl start apache2
systemctl enable apache2

# MySQL
debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
apt-get install -y mysql-server

# PHP
apt-get install -y php libapache2-mod-php php-mysql php-cli php-curl php-json

# Reiniciar Apache
systemctl restart apache2

echo "=== LAMP Stack Instalado ==="
```

```bash
# user-setup.sh
#!/bin/bash
# Este script corre como usuario vagrant (no root)

echo "Configurando usuario vagrant..."

# Git config
git config --global user.name "Vagrant User"
git config --global user.email "vagrant@localhost"

# Alias útiles
cat >> ~/.bashrc <<'EOF'

# Alias personalizados
alias ll='ls -lah'
alias ..='cd ..'
alias gs='git status'

# Prompt mejorado
PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
EOF

# Crear directorio de proyectos
mkdir -p ~/proyectos

echo "Usuario configurado!"
```

#### Script con Argumentos

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  config.vm.provision "shell" do |s|
    s.path = "install-app.sh"
    s.args = ["produccion", "1.5.0", "postgres"]
    # $1 = produccion, $2 = 1.5.0, $3 = postgres
  end
end
```

```bash
# install-app.sh
#!/bin/bash
ENVIRONMENT=$1
VERSION=$2
DATABASE=$3

echo "Instalando aplicación..."
echo "Entorno: $ENVIRONMENT"
echo "Versión: $VERSION"
echo "Base de datos: $DATABASE"

# Tu lógica aquí...
```

#### Provisionamiento Condicional

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  # Solo la primera vez
  config.vm.provision "shell", inline: "apt-get update", run: "once"

  # Cada vez que hagas vagrant up o reload
  config.vm.provision "shell", inline: "echo Uptime: $(uptime)", run: "always"

  # Nunca ejecutar automáticamente (solo con --provision-with)
  config.vm.provision "shell", inline: "apt-get upgrade -y", run: "never"
end
```

### 2. Provisionamiento con Ansible

```bash
# Instalar Ansible en tu host
# Ubuntu/Debian:
sudo apt-get install ansible

# macOS:
brew install ansible

# Verificar:
ansible --version
```

#### Vagrantfile con Ansible

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.verbose = "v"  # Modo verbose: v, vv, vvv, vvvv
    ansible.extra_vars = {
      environment: "development",
      app_version: "1.0.0"
    }
  end
end
```

#### Playbook de Ansible

```yaml
# playbook.yml
---
- name: Configurar servidor web
  hosts: all
  become: yes
  vars:
    nginx_port: 80
    app_dir: /var/www/app

  tasks:
    - name: Actualizar APT cache
      apt:
        update_cache: yes
        cache_valid_time: 3600

    - name: Instalar paquetes
      apt:
        name:
          - nginx
          - git
          - curl
          - vim
        state: present

    - name: Crear directorio de aplicación
      file:
        path: "{{ app_dir }}"
        state: directory
        owner: www-data
        group: www-data
        mode: '0755'

    - name: Copiar configuración de Nginx
      template:
        src: nginx.conf.j2
        dest: /etc/nginx/sites-available/default
      notify: Reiniciar Nginx

    - name: Asegurar que Nginx esté corriendo
      service:
        name: nginx
        state: started
        enabled: yes

  handlers:
    - name: Reiniciar Nginx
      service:
        name: nginx
        state: restarted
```

```jinja2
# nginx.conf.j2
server {
    listen {{ nginx_port }};
    server_name localhost;

    root {{ app_dir }};
    index index.html index.htm;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

#### Estructura de Proyecto con Ansible

```
mi-proyecto/
├── Vagrantfile
├── playbook.yml
├── ansible.cfg          # Configuración de Ansible
├── roles/
│   ├── common/
│   │   └── tasks/
│   │       └── main.yml
│   ├── webserver/
│   │   ├── tasks/
│   │   │   └── main.yml
│   │   ├── templates/
│   │   │   └── nginx.conf.j2
│   │   └── handlers/
│   │       └── main.yml
│   └── database/
│       └── tasks/
│           └── main.yml
└── inventory/
    └── vagrant
```

### 3. Provisionamiento con Docker

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  # Instalar Docker
  config.vm.provision "docker" do |d|
    # Docker se instala automáticamente
  end

  # Ejecutar contenedores
  config.vm.provision "docker" do |d|
    # Nginx
    d.run "nginx",
      image: "nginx:latest",
      args: "-p 80:80 -v /vagrant/html:/usr/share/nginx/html"

    # PostgreSQL
    d.run "postgres",
      image: "postgres:14",
      args: "-e POSTGRES_PASSWORD=secreto -p 5432:5432"

    # Redis
    d.run "redis",
      image: "redis:7-alpine",
      args: "-p 6379:6379"
  end

  # O usar Docker Compose
  config.vm.provision "docker_compose" do |dc|
    dc.yml = "/vagrant/docker-compose.yml"
    dc.rebuild = true
    dc.run = "always"
  end
end
```

```yaml
# docker-compose.yml
version: '3.8'

services:
  web:
    image: nginx:latest
    ports:
      - "80:80"
    volumes:
      - ./html:/usr/share/nginx/html

  api:
    image: node:18
    working_dir: /app
    volumes:
      - ./backend:/app
    command: npm start
    ports:
      - "3000:3000"
    environment:
      - DATABASE_URL=postgres://postgres:secreto@db:5432/appdb

  db:
    image: postgres:14
    environment:
      - POSTGRES_PASSWORD=secreto
      - POSTGRES_DB=appdb
    volumes:
      - db-data:/var/lib/postgresql/data

volumes:
  db-data:
```

### 4. Provisionamiento con Chef (Solo)

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe "nginx"
    chef.add_recipe "mysql"

    chef.json = {
      mysql: {
        server_root_password: 'rootpass',
        server_debian_password: 'debpass',
        server_repl_password: 'replpass'
      }
    }
  end
end
```

### 5. Provisionamiento con Puppet

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "default.pp"
    puppet.module_path = "modules"
  end
end
```

```puppet
# manifests/default.pp
node default {
  # Asegurar que Nginx esté instalado
  package { 'nginx':
    ensure => installed,
  }

  # Asegurar que Nginx esté corriendo
  service { 'nginx':
    ensure => running,
    enable => true,
    require => Package['nginx'],
  }

  # Crear archivo de configuración
  file { '/var/www/html/index.html':
    ensure => file,
    content => '<h1>Provisionado con Puppet</h1>',
    require => Package['nginx'],
  }
}
```

### 6. Múltiples Provisionadores

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  # 1. Actualizar sistema
  config.vm.provision "actualizar", type: "shell", inline: <<-SHELL
    apt-get update
    apt-get upgrade -y
  SHELL

  # 2. Instalar Docker
  config.vm.provision "docker"

  # 3. Configurar con Ansible
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
  end

  # 4. Script final de usuario
  config.vm.provision "usuario", type: "shell", privileged: false, inline: <<-SHELL
    echo "Configuración completa!"
  SHELL

  # 5. Mensaje final (siempre)
  config.vm.provision "status", type: "shell", run: "always", inline: <<-SHELL
    echo "================================"
    echo "Estado del Sistema"
    echo "================================"
    docker ps
    systemctl status nginx --no-pager
    echo "================================"
  SHELL
end
```

Ejecutar provisionadores específicos:

```bash
# Solo el de Ansible
vagrant provision --provision-with ansible

# Varios específicos
vagrant provision --provision-with actualizar,docker

# Todos
vagrant provision
```

### 7. Ejemplo Completo: WordPress con Provisionamiento

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.hostname = "wordpress-dev"
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "private_network", ip: "192.168.33.30"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end

  # Provisionamiento: LAMP + WordPress
  config.vm.provision "shell", inline: <<-SHELL
    export DEBIAN_FRONTEND=noninteractive

    echo "=== Actualizando sistema ==="
    apt-get update

    echo "=== Instalando Apache ==="
    apt-get install -y apache2
    systemctl start apache2

    echo "=== Instalando MySQL ==="
    debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
    debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
    apt-get install -y mysql-server

    echo "=== Instalando PHP ==="
    apt-get install -y php libapache2-mod-php php-mysql php-curl php-gd php-mbstring php-xml php-xmlrpc php-zip

    echo "=== Configurando MySQL ==="
    mysql -uroot -proot <<MYSQL_SCRIPT
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS 'wpuser'@'localhost' IDENTIFIED BY 'wppass';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

    echo "=== Descargando WordPress ==="
    cd /tmp
    wget -q https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz

    echo "=== Instalando WordPress ==="
    rm -rf /var/www/html/*
    cp -r wordpress/* /var/www/html/
    chown -R www-data:www-data /var/www/html

    echo "=== Configurando WordPress ==="
    cd /var/www/html
    cp wp-config-sample.php wp-config.php
    sed -i "s/database_name_here/wordpress/" wp-config.php
    sed -i "s/username_here/wpuser/" wp-config.php
    sed -i "s/password_here/wppass/" wp-config.php

    echo "=== Reiniciando Apache ==="
    systemctl restart apache2

    echo ""
    echo "================================================"
    echo "✅ WordPress instalado correctamente!"
    echo "================================================"
    echo "URL: http://localhost:8080"
    echo "Base de datos: wordpress"
    echo "Usuario DB: wpuser"
    echo "Password DB: wppass"
    echo "================================================"
  SHELL
end
```

### 8. Mejores Prácticas

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  # ===== BUENAS PRÁCTICAS =====

  # 1. Scripts con control de errores
  config.vm.provision "shell", inline: <<-SHELL
    set -e  # Salir si hay error
    set -u  # Error si variable no definida
    set -x  # Mostrar comandos (debug)

    apt-get update
    apt-get install -y nginx
  SHELL

  # 2. Idempotencia (puede ejecutarse múltiples veces)
  config.vm.provision "shell", inline: <<-SHELL
    # Verificar antes de instalar
    if ! command -v nginx &> /dev/null; then
      echo "Instalando nginx..."
      apt-get update
      apt-get install -y nginx
    else
      echo "nginx ya está instalado"
    fi
  SHELL

  # 3. Logging apropiado
  config.vm.provision "shell", inline: <<-SHELL
    LOG_FILE="/var/log/vagrant-provision.log"

    log() {
      echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1" | tee -a $LOG_FILE
    }

    log "Iniciando provisionamiento..."
    apt-get update >> $LOG_FILE 2>&1
    log "Provisionamiento completado"
  SHELL

  # 4. Usar archivos separados para scripts largos
  config.vm.provision "shell", path: "scripts/provision.sh"

  # 5. Variables de entorno
  config.vm.provision "shell", env: {
    "APP_ENV" => "production",
    "DB_PASSWORD" => ENV['DB_PASSWORD'] || 'default'
  }, inline: <<-SHELL
    echo "Entorno: $APP_ENV"
    echo "DB Password: $DB_PASSWORD"
  SHELL
end
```

## Resumen

✅ Shell scripts (inline y externos)
✅ Ansible playbooks
✅ Docker y Docker Compose
✅ Chef y Puppet
✅ Múltiples provisionadores
✅ Ejemplo completo de WordPress
✅ Mejores prácticas

👉 **[Continúa con Módulo 5: Networking](../modulo-05-networking/README.md)**
