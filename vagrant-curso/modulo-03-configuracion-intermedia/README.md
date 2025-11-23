# Módulo 3: Configuración Intermedia ⚙️

## Introducción

Este módulo profundiza en configuraciones avanzadas del Vagrantfile para optimizar recursos, seguridad y rendimiento.

## Contenido

### 1. Configuración Avanzada de Recursos

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  config.vm.provider "virtualbox" do |vb|
    # ===== RECURSOS =====
    vb.memory = "4096"  # 4 GB RAM
    vb.cpus = 4         # 4 CPUs

    # ===== OPTIMIZACIONES DE RENDIMIENTO =====

    # Habilitar PAE/NX (Performance Address Extension)
    vb.customize ["modifyvm", :id, "--pae", "on"]

    # Habilitar IOAPIC (necesario para múltiples CPUs)
    vb.customize ["modifyvm", :id, "--ioapic", "on"]

    # Memoria de video (MB)
    vb.customize ["modifyvm", :id, "--vram", "128"]

    # Aceleración 3D (solo si usas GUI)
    vb.customize ["modifyvm", :id, "--accelerate3d", "on"]

    # Modo de audio (desactivar si no necesitas)
    vb.customize ["modifyvm", :id, "--audio", "none"]

    # Portapapeles bidireccional
    vb.customize ["modifyvm", :id, "--clipboard-mode", "bidirectional"]

    # DNS mejorado
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]

    # Cache de red (mejora rendimiento)
    vb.customize ["modifyvm", :id, "--nictype1", "virtio"]
  end
end
```

### 2. Variables y Condicionales

```ruby
# Variables globales
VM_NAME = ENV['VM_NAME'] || 'mi-servidor'
RAM = ENV['RAM'] || '2048'
ENVIRONMENT = ENV['ENVIRONMENT'] || 'development'

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.hostname = VM_NAME

  # Condicionales basadas en environment
  if ENVIRONMENT == 'production'
    ram = "8192"
    cpus = 4
    install_monitoring = true
  elsif ENVIRONMENT == 'staging'
    ram = "4096"
    cpus = 2
    install_monitoring = true
  else  # development
    ram = RAM
    cpus = 2
    install_monitoring = false
  end

  config.vm.provider "virtualbox" do |vb|
    vb.memory = ram
    vb.cpus = cpus
  end

  # Provisionamiento condicional
  if install_monitoring
    config.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y prometheus node-exporter
    SHELL
  end

  # Configuración de red según ambiente
  if ENVIRONMENT == 'production'
    config.vm.network "public_network", bridge: "eth0"
  else
    config.vm.network "private_network", ip: "192.168.33.10"
  end
end
```

Usar:
```bash
VM_NAME=prod-server RAM=8192 ENVIRONMENT=production vagrant up
```

### 3. Configuración de SSH Avanzada

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  # ===== SSH CONFIGURATION =====

  # Usuario SSH (por defecto: vagrant)
  config.ssh.username = "vagrant"

  # Ruta a llave privada personalizada
  # config.ssh.private_key_path = "~/.ssh/mi-llave-privada"

  # Puerto SSH (por defecto: 2222)
  config.ssh.guest_port = 22
  config.ssh.host = "127.0.0.1"

  # Forward SSH agent (usar tus llaves SSH del host)
  config.ssh.forward_agent = true

  # Forward X11 (para GUI)
  config.ssh.forward_x11 = true

  # Timeout de conexión
  config.ssh.connect_timeout = 30

  # Número de intentos
  config.ssh.max_tries = 40

  # Mantener conexión viva
  config.ssh.keep_alive = true

  # Shell por defecto
  config.ssh.shell = "bash -l"

  # Insertar llave insegura de Vagrant (solo dev)
  config.ssh.insert_key = true

  # Reenviar variables de entorno
  config.ssh.forward_env = ["CUSTOM_VAR", "OTRO_VAR"]

  # Comandos extra antes de SSH
  config.ssh.extra_args = ["-o", "StrictHostKeyChecking=no"]
end
```

### 4. Discos Adicionales

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"

    # Ruta al segundo disco
    segundo_disco = './segundo-disco.vdi'

    # Crear disco si no existe
    unless File.exist?(segundo_disco)
      vb.customize ['createhd', '--filename', segundo_disco, '--size', 50 * 1024]  # 50 GB
    end

    # Adjuntar disco a la VM
    vb.customize ['storageattach', :id,
                  '--storagectl', 'SATA Controller',
                  '--port', 1,
                  '--device', 0,
                  '--type', 'hdd',
                  '--medium', segundo_disco]
  end

  # Provisionar: formatear y montar el disco
  config.vm.provision "shell", inline: <<-SHELL
    # Verificar si ya está formateado
    if ! blkid /dev/sdb1 > /dev/null 2>&1; then
      echo "Formateando disco /dev/sdb..."

      # Particionar
      (echo n; echo p; echo 1; echo ; echo ; echo w) | fdisk /dev/sdb

      # Formatear
      mkfs.ext4 /dev/sdb1

      # Crear punto de montaje
      mkdir -p /mnt/datos

      # Montar
      mount /dev/sdb1 /mnt/datos

      # Agregar a fstab para montaje automático
      echo '/dev/sdb1 /mnt/datos ext4 defaults 0 0' >> /etc/fstab

      echo "Disco montado en /mnt/datos"
    else
      echo "Disco ya está formateado"
      mount /dev/sdb1 /mnt/datos 2>/dev/null || true
    fi

    df -h /mnt/datos
  SHELL
end
```

### 5. Triggers (Hooks)

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  # ===== BEFORE UP =====
  config.trigger.before :up do |trigger|
    trigger.name = "Preparando ambiente"
    trigger.info = "Verificando dependencias..."
    trigger.run = {inline: "bash -c 'echo Iniciando...'"}
    trigger.warn = "Asegúrate de tener VirtualBox corriendo"
  end

  # ===== AFTER UP =====
  config.trigger.after :up do |trigger|
    trigger.name = "Post-inicio"
    trigger.info = "VM lista!"
    trigger.run = {inline: "echo 'Conéctate con: vagrant ssh'"}
  end

  # ===== BEFORE HALT =====
  config.trigger.before :halt do |trigger|
    trigger.name = "Pre-apagado"
    trigger.info = "Guardando estado..."
    trigger.run_remote = {inline: "echo 'Ejecutando limpieza...'"}
  end

  # ===== AFTER DESTROY =====
  config.trigger.after :destroy do |trigger|
    trigger.name = "Post-destrucción"
    trigger.info = "Limpiando archivos..."
    trigger.run = {inline: "rm -f segundo-disco.vdi"}
  end

  # ===== TRIGGER CON CONDICIÓN =====
  config.trigger.before :up do |trigger|
    trigger.name = "Verificar espacio en disco"
    trigger.ruby do |env, machine|
      # Código Ruby personalizado
      disk_space = `df -h . | tail -1 | awk '{print $5}' | sed 's/%//'`.to_i
      if disk_space > 90
        raise "ERROR: Poco espacio en disco (#{disk_space}% usado)"
      end
    end
  end
end
```

### 6. Configuración de Sincronización Avanzada

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  # ===== CARPETA POR DEFECTO =====
  # Deshabilitar carpeta /vagrant por defecto
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # ===== MÚLTIPLES CARPETAS =====

  # Código fuente (bidireccional)
  config.vm.synced_folder "./src", "/var/www/html",
    owner: "www-data",
    group: "www-data",
    mount_options: ["dmode=775,fmode=664"]

  # Logs (solo escritura desde VM)
  config.vm.synced_folder "./logs", "/var/log/app",
    create: true,
    owner: "vagrant",
    group: "vagrant"

  # Cache (NFS para mejor rendimiento en Linux/Mac)
  # Requiere: sudo password para configurar NFS
  config.vm.synced_folder "./cache", "/tmp/cache",
    type: "nfs",
    nfs_version: 4,
    nfs_udp: false

  # Datos (RSync - una sola dirección)
  config.vm.synced_folder "./datos", "/home/vagrant/datos",
    type: "rsync",
    rsync__exclude: [".git/", "node_modules/", "*.log"],
    rsync__args: ["--verbose", "--archive", "--delete", "-z"],
    rsync__auto: true  # Auto-sync cuando detecte cambios

  # ===== CARPETA ENCRIPTADA =====
  # Útil para información sensible
  config.vm.synced_folder "./secrets", "/mnt/secrets",
    mount_options: ["ro"]  # Read-only
end
```

### 7. Variables de Entorno

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  # ===== PASAR VARIABLES AL GUEST =====
  config.vm.provision "shell", env: {
    "APP_ENV" => "production",
    "DB_HOST" => "localhost",
    "DB_NAME" => "miapp",
    "API_KEY" => ENV['API_KEY'] || 'default-key'  # Desde host
  }, inline: <<-SHELL
    # Variables disponibles en el script
    echo "Entorno: $APP_ENV"
    echo "Base de datos: $DB_NAME en $DB_HOST"

    # Guardar en archivo de configuración
    cat > /etc/environment <<EOF
APP_ENV=$APP_ENV
DB_HOST=$DB_HOST
DB_NAME=$DB_NAME
API_KEY=$API_KEY
EOF

    # También en .bashrc para usuario vagrant
    cat >> /home/vagrant/.bashrc <<EOF
export APP_ENV=$APP_ENV
export DB_HOST=$DB_HOST
export DB_NAME=$DB_NAME
export API_KEY=$API_KEY
EOF
  SHELL

  # ===== LEER DESDE ARCHIVO .env =====
  # Instalar: gem install dotenv (si usas)
  # require 'dotenv'
  # Dotenv.load('.env')

  # O leer manualmente:
  if File.exist?('.env')
    File.readlines('.env').each do |line|
      key, value = line.strip.split('=', 2)
      ENV[key] = value if key && value
    end
  end
end
```

### 8. Plugins Útiles

```bash
# ===== INSTALACIÓN DE PLUGINS =====

# VirtualBox Guest Additions (auto-actualiza)
vagrant plugin install vagrant-vbguest

# Variables de entorno desde archivo
vagrant plugin install vagrant-env

# Caché compartido de packages (ahorra ancho de banda)
vagrant plugin install vagrant-cachier

# Host manager (gestión de DNS local)
vagrant plugin install vagrant-hostmanager

# Reload (reiniciar VM desde provisioning)
vagrant plugin install vagrant-reload

# ===== LISTAR PLUGINS INSTALADOS =====
vagrant plugin list

# ===== ACTUALIZAR PLUGINS =====
vagrant plugin update

# ===== DESINSTALAR PLUGIN =====
vagrant plugin uninstall nombre-plugin
```

Ejemplo de configuración con plugins:

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  # Plugin: vagrant-cachier (caché compartido)
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
    config.cache.enable :apt
    config.cache.enable :gem
    config.cache.enable :npm
  end

  # Plugin: vagrant-hostmanager (DNS local)
  if Vagrant.has_plugin?("vagrant-hostmanager")
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.vm.hostname = "miapp.local"
  end

  # Plugin: vagrant-vbguest (Guest Additions)
  if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = true
  end
end
```

## Ejemplo Completo: VM de Desarrollo Full-Stack

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

# Variables de configuración
HOSTNAME = "dev-fullstack"
RAM = "4096"
CPUS = "2"
IP = "192.168.33.20"

Vagrant.configure("2") do |config|
  # Sistema base
  config.vm.box = "ubuntu/focal64"
  config.vm.hostname = HOSTNAME

  # Red privada con IP fija
  config.vm.network "private_network", ip: IP

  # Port forwarding para servicios
  config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 5432, host: 5432
  config.vm.network "forwarded_port", guest: 6379, host: 6379

  # Carpetas compartidas
  config.vm.synced_folder "./frontend", "/var/www/frontend", create: true
  config.vm.synced_folder "./backend", "/var/www/backend", create: true
  config.vm.synced_folder "./logs", "/var/log/app", create: true

  # Proveedor VirtualBox
  config.vm.provider "virtualbox" do |vb|
    vb.name = HOSTNAME
    vb.memory = RAM
    vb.cpus = CPUS
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  # Provisionamiento: Stack completo
  config.vm.provision "shell", inline: <<-SHELL
    export DEBIAN_FRONTEND=noninteractive

    # Actualizar sistema
    apt-get update

    # Node.js 18
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
    apt-get install -y nodejs

    # PostgreSQL
    apt-get install -y postgresql postgresql-contrib
    systemctl start postgresql
    sudo -u postgres createuser -s vagrant 2>/dev/null || true
    sudo -u postgres createdb -O vagrant appdb 2>/dev/null || true

    # Redis
    apt-get install -y redis-server
    systemctl start redis

    # Nginx
    apt-get install -y nginx
    systemctl start nginx

    # Herramientas de desarrollo
    apt-get install -y git curl wget vim htop build-essential

    echo "✅ Stack instalado: Node.js, PostgreSQL, Redis, Nginx"
  SHELL

  # Mensaje final
  config.vm.post_up_message = <<-MSG
    ╔════════════════════════════════════════════════════╗
    ║   Full-Stack Development Environment Ready!        ║
    ╠════════════════════════════════════════════════════╣
    ║   Hostname: #{HOSTNAME}                            ║
    ║   IP: #{IP}                                        ║
    ║                                                    ║
    ║   Services:                                        ║
    ║   - Frontend: http://localhost:3000                ║
    ║   - Backend: http://localhost:8080                 ║
    ║   - PostgreSQL: localhost:5432                     ║
    ║   - Redis: localhost:6379                          ║
    ║                                                    ║
    ║   Connect: vagrant ssh                             ║
    ╚════════════════════════════════════════════════════╝
  MSG
end
```

## Resumen

✅ Optimización de recursos y rendimiento
✅ Variables y condicionales en Vagrantfile
✅ SSH avanzado y seguridad
✅ Discos adicionales
✅ Triggers y hooks
✅ Sincronización avanzada de carpetas
✅ Variables de entorno
✅ Plugins útiles

👉 **[Continúa con Módulo 4: Provisionamiento](../modulo-04-provisionamiento/README.md)**
