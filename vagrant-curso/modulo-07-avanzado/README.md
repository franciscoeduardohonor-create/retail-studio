# Módulo 7: Temas Avanzados y Mejores Prácticas 🚀

## Introducción

Domina los aspectos más avanzados de Vagrant: plugins, optimización, CI/CD, boxes personalizadas y más.

## 1. Crear Boxes Personalizadas

### Método 1: Desde una VM Existente

```bash
# 1. Crear y configurar tu VM
vagrant init ubuntu/focal64
vagrant up
vagrant ssh

# 2. Dentro de la VM, instalar y configurar todo
sudo apt-get update
sudo apt-get install -y nginx nodejs npm docker.io
# ... más instalaciones y configuraciones ...

# 3. Limpiar antes de empaquetar
sudo apt-get clean
sudo dd if=/dev/zero of=/EMPTY bs=1M || true
sudo rm -f /EMPTY
history -c
exit

# 4. Empaquetar la VM
vagrant package --output mi-stack.box

# 5. Agregar la box localmente
vagrant box add mi-stack mi-stack.box

# 6. Usar en nuevos proyectos
mkdir nuevo-proyecto
cd nuevo-proyecto
vagrant init mi-stack
vagrant up
```

### Método 2: Con Packer (Profesional)

```bash
# Instalar Packer
# Ubuntu/Debian:
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install packer
```

```json
// ubuntu-custom.json
{
  "builders": [
    {
      "type": "virtualbox-iso",
      "guest_os_type": "Ubuntu_64",
      "iso_url": "https://releases.ubuntu.com/20.04/ubuntu-20.04.6-live-server-amd64.iso",
      "iso_checksum": "sha256:...",
      "ssh_username": "vagrant",
      "ssh_password": "vagrant",
      "shutdown_command": "echo 'vagrant' | sudo -S shutdown -P now"
    }
  ],
  "provisioners": [
    {
      "type": "shell",
      "script": "provision.sh"
    }
  ],
  "post-processors": [
    {
      "type": "vagrant",
      "output": "ubuntu-custom-{{.Provider}}.box"
    }
  ]
}
```

```bash
# Construir la box
packer build ubuntu-custom.json
```

### Distribuir Tu Box

```bash
# 1. Subir a Vagrant Cloud
# Crear cuenta en: https://app.vagrantup.com

# 2. Crear nueva box en la web UI

# 3. Subir usando CLI
vagrant cloud auth login
vagrant cloud publish username/mi-box 1.0.0 virtualbox mi-stack.box \
  --description "Mi stack personalizado" \
  --release

# 4. Otros pueden usarla:
vagrant init username/mi-box
vagrant up
```

## 2. Plugins Avanzados

### Plugin: vagrant-berkshelf (Chef)

```bash
vagrant plugin install vagrant-berkshelf
```

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.berkshelf.enabled = true

  config.vm.provision "chef_solo" do |chef|
    chef.cookbooks_path = "cookbooks"
    chef.add_recipe "nginx"
  end
end
```

### Plugin: vagrant-aws (Cloud)

```bash
vagrant plugin install vagrant-aws
```

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "dummy"

  config.vm.provider :aws do |aws, override|
    aws.access_key_id = ENV['AWS_ACCESS_KEY']
    aws.secret_access_key = ENV['AWS_SECRET_KEY']
    aws.keypair_name = "mi-keypair"

    aws.ami = "ami-0c55b159cbfafe1f0"
    aws.region = "us-east-1"
    aws.instance_type = "t2.micro"

    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = "~/.ssh/mi-keypair.pem"
  end
end
```

### Plugin: vagrant-digitalocean

```bash
vagrant plugin install vagrant-digitalocean
```

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "digital_ocean"
  config.vm.box_url = "https://github.com/devopsgroup-io/vagrant-digitalocean/raw/master/box/digital_ocean.box"

  config.vm.provider :digital_ocean do |provider, override|
    provider.token = ENV['DIGITALOCEAN_TOKEN']
    provider.image = 'ubuntu-20-04-x64'
    provider.region = 'nyc3'
    provider.size = 's-1vcpu-1gb'

    override.ssh.private_key_path = '~/.ssh/id_rsa'
  end
end
```

## 3. Integración CI/CD

### GitHub Actions

```yaml
# .github/workflows/vagrant-test.yml
name: Vagrant Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: macos-latest  # macOS tiene mejor soporte de virtualización

    steps:
      - uses: actions/checkout@v2

      - name: Cache Vagrant boxes
        uses: actions/cache@v2
        with:
          path: ~/.vagrant.d/boxes
          key: ${{ runner.os }}-vagrant-${{ hashFiles('Vagrantfile') }}

      - name: Install VirtualBox
        run: brew install --cask virtualbox

      - name: Install Vagrant
        run: brew install vagrant

      - name: Vagrant up
        run: vagrant up

      - name: Run tests
        run: vagrant ssh -c "cd /vagrant && ./run-tests.sh"

      - name: Cleanup
        if: always()
        run: vagrant destroy -f
```

### GitLab CI

```yaml
# .gitlab-ci.yml
stages:
  - test

vagrant_test:
  stage: test
  image: ubuntu:20.04
  before_script:
    - apt-get update
    - apt-get install -y vagrant virtualbox
  script:
    - vagrant up
    - vagrant ssh -c "cd /vagrant && ./run-tests.sh"
  after_script:
    - vagrant destroy -f
```

### Jenkins

```groovy
// Jenkinsfile
pipeline {
    agent any

    stages {
        stage('Setup') {
            steps {
                sh 'vagrant up'
            }
        }

        stage('Test') {
            steps {
                sh 'vagrant ssh -c "cd /vagrant && ./run-tests.sh"'
            }
        }

        stage('Deploy') {
            when {
                branch 'main'
            }
            steps {
                sh 'vagrant ssh -c "cd /vagrant && ./deploy.sh"'
            }
        }
    }

    post {
        always {
            sh 'vagrant destroy -f'
        }
    }
}
```

## 4. Optimización y Performance

### Caché de Paquetes

```bash
vagrant plugin install vagrant-cachier
```

```ruby
Vagrant.configure("2") do |config|
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box  # Compartir cache entre proyectos
    config.cache.enable :apt
    config.cache.enable :apt_lists
    config.cache.enable :npm
    config.cache.enable :gem
    config.cache.enable :composer
    config.cache.enable :yum
  end

  config.vm.box = "ubuntu/focal64"
end
```

### Parallel Provision

```ruby
Vagrant.configure("2") do |config|

  # Múltiples VMs
  (1..5).each do |i|
    config.vm.define "node#{i}" do |node|
      node.vm.box = "ubuntu/focal64"
      node.vm.network "private_network", ip: "192.168.33.#{10+i}"
    end
  end

  # Provisionamiento en paralelo (más rápido)
  config.vm.provision "shell", inline: "apt-get update", run: "always"
end
```

```bash
# Levantar todas en paralelo
vagrant up --parallel
vagrant up --parallel --provider=virtualbox
```

### Optimizar VirtualBox

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  config.vm.provider "virtualbox" do |vb|
    # Más CPUs
    vb.cpus = 4

    # Más RAM
    vb.memory = 4096

    # Habilitar PAE/NX
    vb.customize ["modifyvm", :id, "--pae", "on"]

    # Habilitar IOAPIC (multi-core)
    vb.customize ["modifyvm", :id, "--ioapic", "on"]

    # Modo de caché de disco
    vb.customize ["storagectl", :id, "--name", "SATA Controller", "--hostiocache", "on"]

    # CPU execution cap (100% = sin límite)
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]

    # Controlador de red virtio (más rápido)
    vb.customize ["modifyvm", :id, "--nictype1", "virtio"]

    # Disable audio
    vb.customize ["modifyvm", :id, "--audio", "none"]

    # VRAM para GUI (si usas)
    vb.customize ["modifyvm", :id, "--vram", "128"]
  end
end
```

### NFS para Carpetas Compartidas (Linux/Mac)

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.network "private_network", ip: "192.168.33.10"

  # NFS es MUCHO más rápido que vboxsf
  config.vm.synced_folder ".", "/vagrant",
    type: "nfs",
    nfs_version: 4,
    nfs_udp: false,
    mount_options: ['rw', 'vers=4', 'tcp', 'nolock']
end
```

## 5. Seguridad

### SSH Keys

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  # No insertar llave insegura de Vagrant
  config.ssh.insert_key = false

  # Usar tu llave SSH
  config.ssh.private_key_path = ["~/.ssh/id_rsa", "~/.vagrant.d/insecure_private_key"]

  config.vm.provision "shell", inline: <<-SHELL
    # Copiar tu llave pública
    mkdir -p /home/vagrant/.ssh
    echo "#{File.read(File.expand_path("~/.ssh/id_rsa.pub"))}" >> /home/vagrant/.ssh/authorized_keys
    chown -R vagrant:vagrant /home/vagrant/.ssh
    chmod 700 /home/vagrant/.ssh
    chmod 600 /home/vagrant/.ssh/authorized_keys
  SHELL
end
```

### Secrets Management

```bash
# .env
DB_PASSWORD=super-secreto
API_KEY=mi-api-key-secreta
```

```ruby
# Vagrantfile
require 'dotenv'
Dotenv.load('.env')

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  config.vm.provision "shell", env: {
    "DB_PASSWORD" => ENV['DB_PASSWORD'],
    "API_KEY" => ENV['API_KEY']
  }, inline: <<-SHELL
    # Usar variables
    echo "DB_PASSWORD=$DB_PASSWORD" >> /etc/environment
    echo "API_KEY=$API_KEY" >> /etc/environment
  SHELL
end
```

```bash
# .gitignore
.env
.vagrant/
*.box
```

## 6. Mejores Prácticas

### Estructura de Proyecto

```
mi-proyecto/
├── Vagrantfile              # Configuración principal
├── .vagrant/                # Metadatos (no versionar)
├── .gitignore               # Ignorar .vagrant/, .env, etc.
├── .env                     # Variables de entorno (no versionar)
├── .env.example             # Template de .env (sí versionar)
├── README.md                # Documentación
├── scripts/                 # Scripts de provisionamiento
│   ├── bootstrap.sh
│   ├── install-app.sh
│   └── cleanup.sh
├── ansible/                 # Playbooks de Ansible
│   ├── playbook.yml
│   └── roles/
├── docker-compose.yml       # Si usas Docker
└── docs/                    # Documentación adicional
    └── setup.md
```

### Vagrantfile Template Profesional

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

# ============================================
# PROYECTO: Mi Aplicación
# DESCRIPCIÓN: Entorno de desarrollo completo
# AUTOR: Tu Nombre
# FECHA: 2024-01-01
# ============================================

# Cargar variables de entorno
require 'dotenv'
Dotenv.load('.env') if File.exist?('.env')

# Variables de configuración
HOSTNAME = ENV['VM_HOSTNAME'] || 'mi-app'
RAM = ENV['VM_RAM'] || '2048'
CPUS = ENV['VM_CPUS'] || '2'
IP = ENV['VM_IP'] || '192.168.33.10'

Vagrant.configure("2") do |config|

  # ====================================
  # CONFIGURACIÓN BÁSICA
  # ====================================

  config.vm.box = "ubuntu/focal64"
  config.vm.box_check_update = true
  config.vm.hostname = HOSTNAME

  # ====================================
  # RED
  # ====================================

  config.vm.network "private_network", ip: IP
  config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
  config.vm.network "forwarded_port", guest: 3000, host: 3000, auto_correct: true

  # ====================================
  # CARPETAS COMPARTIDAS
  # ====================================

  if OS.mac? || OS.linux?
    # NFS en Mac/Linux (más rápido)
    config.vm.synced_folder ".", "/vagrant", type: "nfs"
  else
    # VirtualBox en Windows
    config.vm.synced_folder ".", "/vagrant"
  end

  # ====================================
  # PROVIDER (VirtualBox)
  # ====================================

  config.vm.provider "virtualbox" do |vb|
    vb.name = HOSTNAME
    vb.memory = RAM
    vb.cpus = CPUS
    vb.gui = false

    # Optimizaciones
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  # ====================================
  # PLUGINS
  # ====================================

  # Cache (si está instalado)
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
    config.cache.enable :apt
  end

  # ====================================
  # PROVISIONAMIENTO
  # ====================================

  # Bootstrap
  config.vm.provision "shell", path: "scripts/bootstrap.sh"

  # Instalación de aplicación
  config.vm.provision "shell", path: "scripts/install-app.sh", env: {
    "APP_ENV" => ENV['APP_ENV'] || 'development',
    "DB_PASSWORD" => ENV['DB_PASSWORD']
  }

  # Configuración de usuario
  config.vm.provision "shell", path: "scripts/user-setup.sh", privileged: false

  # Status (siempre)
  config.vm.provision "shell", run: "always", inline: <<-SHELL
    echo "================================"
    echo "VM: #{HOSTNAME}"
    echo "IP: #{IP}"
    echo "Uptime: $(uptime -p)"
    echo "================================"
  SHELL

  # ====================================
  # MENSAJE POST-UP
  # ====================================

  config.vm.post_up_message = <<-MSG
    ╔════════════════════════════════════════════╗
    ║   #{HOSTNAME} está listo!                  ║
    ╠════════════════════════════════════════════╣
    ║   URL: http://localhost:8080               ║
    ║   IP: #{IP}                                ║
    ║   SSH: vagrant ssh                         ║
    ╚════════════════════════════════════════════╝
  MSG

end

# Helper para detectar OS
module OS
  def OS.windows?
    (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  end

  def OS.mac?
    (/darwin/ =~ RUBY_PLATFORM) != nil
  end

  def OS.unix?
    !OS.windows?
  end

  def OS.linux?
    OS.unix? and not OS.mac?
  end
end
```

## Resumen

✅ Crear boxes personalizadas
✅ Plugins avanzados (AWS, DigitalOcean)
✅ Integración CI/CD
✅ Optimización de performance
✅ Seguridad y secrets
✅ Mejores prácticas profesionales

👉 **[Proyectos Finales](../proyectos-finales/README.md)**
