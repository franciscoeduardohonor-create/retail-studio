# Módulo 2: Primeros Pasos y Dominio de Comandos 🎯

## Introducción

En el Módulo 1 aprendiste lo básico. Ahora es momento de dominar Vagrant como un profesional. Este módulo te convertirá en un usuario eficiente de Vagrant.

## Objetivos de Aprendizaje

Al finalizar este módulo podrás:

✅ Usar todos los comandos de Vagrant con confianza
✅ Gestionar boxes eficientemente
✅ Optimizar tu flujo de trabajo diario
✅ Resolver problemas comunes
✅ Configurar el Vagrantfile como un experto
✅ Usar snapshots para salvar estados

## Contenido del Módulo

### 1. Comandos de Vagrant: La Guía Completa

#### Comandos del Ciclo de Vida

```bash
# ============================================
# CREAR Y LEVANTAR VMS
# ============================================

# Inicializar nuevo proyecto con una box
vagrant init ubuntu/focal64

# Inicializar con opciones mínimas (Vagrantfile simple)
vagrant init -m ubuntu/focal64

# Inicializar forzando sobrescritura
vagrant init -f ubuntu/focal64

# Levantar la VM
vagrant up

# Levantar con provisionamiento forzado
vagrant up --provision

# Levantar sin provisionamiento
vagrant up --no-provision

# Levantar con provider específico
vagrant up --provider=virtualbox
vagrant up --provider=vmware_desktop

# Levantar mostrando logs detallados
vagrant up --debug

# ============================================
# GESTIÓN DE ESTADO
# ============================================

# Ver estado de VMs en el directorio actual
vagrant status

# Ver estado de TODAS las VMs en tu sistema
vagrant global-status

# Limpiar cache de global-status (eliminar VMs muertas)
vagrant global-status --prune

# ============================================
# CONEXIÓN SSH
# ============================================

# Conectarse por SSH
vagrant ssh

# Ejecutar comando sin entrar a la VM
vagrant ssh -c "ls -la /vagrant"
vagrant ssh -c "uptime"

# Ver configuración SSH
vagrant ssh-config

# Usar SSH nativo (útil para SCP)
ssh -F $(vagrant ssh-config | grep IdentityFile) vagrant@127.0.0.1 -p 2222

# ============================================
# SUSPENDER Y REANUDAR
# ============================================

# Suspender VM (como hibernar - más rápido)
vagrant suspend

# Reanudar VM suspendida
vagrant resume

# ============================================
# APAGAR Y REINICIAR
# ============================================

# Apagar VM (gracefully)
vagrant halt

# Apagar forzadamente
vagrant halt -f

# Reiniciar VM
vagrant reload

# Reiniciar y re-provisionar
vagrant reload --provision

# ============================================
# DESTRUIR
# ============================================

# Destruir VM (pide confirmación)
vagrant destroy

# Destruir sin confirmación
vagrant destroy -f

# Destruir VM específica (en multi-machine)
vagrant destroy nombre-vm

# ============================================
# PROVISIONAMIENTO
# ============================================

# Ejecutar provisionamiento en VM existente
vagrant provision

# Provisionar con un provisionador específico
vagrant provision --provision-with shell
vagrant provision --provision-with ansible

# ============================================
# INFORMACIÓN Y DEBUGGING
# ============================================

# Validar Vagrantfile
vagrant validate

# Ver versión de Vagrant
vagrant version
vagrant --version

# Ver puertos mapeados
vagrant port

# Ver información de SSH
vagrant ssh-config

# Modo debug (super verbose)
vagrant up --debug > vagrant.log 2>&1
```

#### Comandos de Boxes

```bash
# ============================================
# LISTAR Y BUSCAR
# ============================================

# Listar boxes instaladas localmente
vagrant box list

# Buscar boxes en Vagrant Cloud (desde web)
# https://app.vagrantup.com/boxes/search

# ============================================
# AGREGAR BOXES
# ============================================

# Agregar box desde Vagrant Cloud
vagrant box add ubuntu/focal64

# Agregar versión específica
vagrant box add ubuntu/focal64 --box-version 20230215.0.0

# Agregar desde URL
vagrant box add mi-box https://ejemplo.com/mi-box.box

# Agregar con nombre personalizado
vagrant box add --name mi-ubuntu ubuntu/focal64

# ============================================
# ACTUALIZAR BOXES
# ============================================

# Actualizar box específica
vagrant box update --box ubuntu/focal64

# Actualizar box de la VM actual
vagrant box update

# ============================================
# ELIMINAR BOXES
# ============================================

# Eliminar box (todas las versiones)
vagrant box remove ubuntu/focal64

# Eliminar versión específica
vagrant box remove ubuntu/focal64 --box-version 20230215.0.0

# Eliminar con provider específico
vagrant box remove ubuntu/focal64 --provider virtualbox

# ============================================
# LIMPIEZA
# ============================================

# Eliminar versiones antiguas de boxes
vagrant box prune

# Eliminar versiones antiguas manteniendo las N más recientes
vagrant box prune --keep-active-boxes

# ============================================
# INFORMACIÓN
# ============================================

# Ver información de una box
vagrant box outdated

# Ver todas las boxes desactualizadas
vagrant box outdated --global

# Reempaquetar box modificada
vagrant box repackage ubuntu/focal64 virtualbox 20230215.0.0
```

#### Comandos de Snapshots

```bash
# ============================================
# CREAR SNAPSHOTS
# ============================================

# Crear snapshot con nombre
vagrant snapshot save nombre-snapshot

# Ejemplo práctico
vagrant snapshot save estado-limpio
vagrant snapshot save antes-de-actualizar
vagrant snapshot save con-nginx-instalado

# ============================================
# LISTAR SNAPSHOTS
# ============================================

# Ver todos los snapshots
vagrant snapshot list

# ============================================
# RESTAURAR SNAPSHOTS
# ============================================

# Restaurar a un snapshot específico
vagrant snapshot restore nombre-snapshot

# Restaurar sin provisionar
vagrant snapshot restore --no-provision nombre-snapshot

# ============================================
# ELIMINAR SNAPSHOTS
# ============================================

# Eliminar snapshot específico
vagrant snapshot delete nombre-snapshot

# Eliminar TODOS los snapshots (¡cuidado!)
vagrant snapshot pop

# ============================================
# GUARDAR Y RESTAURAR RÁPIDO
# ============================================

# Push: guardar estado actual (como stack)
vagrant snapshot push

# Pop: restaurar último push y eliminarlo
vagrant snapshot pop

# Pop sin eliminar el snapshot
vagrant snapshot pop --no-delete
```

### 2. Gestión Avanzada de Boxes

#### ¿Qué es una Box?

Una box es una imagen base empaquetada que contiene:
- Sistema operativo instalado
- Configuraciones básicas
- Usuarios y permisos
- Software pre-instalado (según la box)

#### Fuentes de Boxes

**1. Vagrant Cloud (oficial)**
```bash
# Boxes oficiales verificadas
vagrant box add ubuntu/focal64      # Ubuntu oficial
vagrant box add debian/bullseye64   # Debian oficial
vagrant box add centos/8            # CentOS oficial
vagrant box add hashicorp/bionic64  # HashiCorp oficial
```

**2. Boxes de la comunidad**
```bash
# Boxes creadas por la comunidad
vagrant box add bento/ubuntu-20.04  # Chef Bento (muy populares)
vagrant box add generic/ubuntu2004  # Generic (multi-provider)
```

**3. Boxes personalizadas**
```bash
# Desde archivo local
vagrant box add mi-box ./mi-box.box

# Desde URL directa
vagrant box add mi-box http://ejemplo.com/box.box
```

#### Versionamiento de Boxes

```ruby
# En Vagrantfile, especificar versión
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.box_version = "20230215.0.0"  # Versión exacta

  # O rango de versiones
  config.vm.box_version = ">= 20230215.0.0, < 20240101.0.0"

  # No verificar actualizaciones
  config.vm.box_check_update = false
end
```

#### Crear Tu Propia Box

```bash
# 1. Partir de una VM existente
vagrant up
vagrant ssh
# ... instalar y configurar software ...
exit

# 2. Empaquetar la VM actual como box
vagrant package --output mi-box.box

# 3. Agregar la box localmente
vagrant box add mi-custom-box mi-box.box

# 4. Usar en nuevos proyectos
vagrant init mi-custom-box
vagrant up
```

#### Mejores Prácticas con Boxes

```bash
# ✅ HACER:

# Usar boxes oficiales cuando sea posible
vagrant box add ubuntu/focal64

# Especificar versión en producción
config.vm.box_version = "20230215.0.0"

# Actualizar boxes regularmente
vagrant box update
vagrant box prune  # Limpiar versiones antiguas

# Documentar qué box usas
# En README.md: "Este proyecto usa ubuntu/focal64"

# ❌ NO HACER:

# No uses boxes desconocidas sin verificar
vagrant box add usuario-random/box-sospechosa  # ⚠️

# No ignores actualizaciones de seguridad
config.vm.box_check_update = false  # Solo en casos específicos

# No acumules boxes sin usar
# Limpia regularmente con vagrant box prune
```

### 3. Configuración del Vagrantfile: Nivel Intermedio

#### Estructura Completa de un Vagrantfile

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

# Variables globales (fuera del bloque configure)
RAM = "2048"
CPUS = "2"
VM_NAME = "mi-servidor"

Vagrant.configure("2") do |config|

  # ====================================
  # CONFIGURACIÓN DE LA BOX
  # ====================================

  config.vm.box = "ubuntu/focal64"
  config.vm.box_version = ">= 20230215.0.0"
  config.vm.box_check_update = true
  config.vm.hostname = VM_NAME

  # ====================================
  # CONFIGURACIÓN DE RED
  # ====================================

  # Port forwarding
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 443, host: 8443

  # IP privada (acceso desde el host)
  config.vm.network "private_network", ip: "192.168.33.10"

  # ====================================
  # CARPETAS COMPARTIDAS
  # ====================================

  config.vm.synced_folder "./app", "/var/www/app", create: true

  # ====================================
  # PROVIDER (VirtualBox)
  # ====================================

  config.vm.provider "virtualbox" do |vb|
    vb.name = VM_NAME
    vb.memory = RAM
    vb.cpus = CPUS
    vb.gui = false

    # Optimizaciones
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
  end

  # ====================================
  # PROVISIONAMIENTO
  # ====================================

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y nginx
  SHELL

  # ====================================
  # MENSAJES
  # ====================================

  config.vm.post_up_message = "VM lista en http://192.168.33.10"

end
```

#### Configuraciones Útiles

**1. Timeouts y Paciencia**

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  # Timeout para boot (segundos)
  config.vm.boot_timeout = 600  # 10 minutos

  # Timeout para conexión SSH
  config.ssh.connect_timeout = 30

  # Reintentos de SSH
  config.ssh.max_tries = 40

  # Reenviar agente SSH
  config.ssh.forward_agent = true

  # Reenviar X11
  config.ssh.forward_x11 = true
end
```

**2. Configuración de Disco**

```ruby
config.vm.provider "virtualbox" do |vb|
  # Crear disco adicional de 50GB
  unless File.exist?('./segundo-disco.vdi')
    vb.customize ['createhd', '--filename', './segundo-disco.vdi', '--size', 50 * 1024]
  end

  vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', './segundo-disco.vdi']
end
```

**3. Hooks y Triggers**

```ruby
config.trigger.before :up do |trigger|
  trigger.name = "Pre-inicio"
  trigger.info = "Preparando ambiente..."
  trigger.run = {inline: "echo 'Iniciando VM...'"}
end

config.trigger.after :up do |trigger|
  trigger.name = "Post-inicio"
  trigger.info = "VM lista!"
  trigger.run = {inline: "echo 'Puedes conectarte con: vagrant ssh'"}
end
```

### 4. Flujo de Trabajo Eficiente

#### Día a Día con Vagrant

```bash
# Lunes por la mañana
cd mi-proyecto
vagrant up          # Encender VM (rápido si está halt)
vagrant ssh         # Entrar a trabajar

# Durante el día
# ... trabajas normalmente ...
# Editas archivos en tu host, se sincronizan con /vagrant

# Instalaste algo y quieres guardarlo
vagrant snapshot save lunes-tarde-con-postgres

# Fin del día
vagrant halt        # Apagar (libera RAM)

# Al día siguiente
vagrant up          # Encender de nuevo
vagrant ssh         # Continuar trabajando

# Viernes al salir
vagrant suspend     # O halt, según prefieras
```

#### Patrones de Uso

**Patrón 1: Desarrollo web local**

```bash
# Setup inicial (una vez)
mkdir mi-proyecto-web
cd mi-proyecto-web
vagrant init ubuntu/focal64
# ... editar Vagrantfile ...
vagrant up
vagrant ssh -c "sudo apt install nginx php-fpm mysql-server"

# Trabajo diario
vagrant up && vagrant ssh
# ... programar en tu IDE favorito ...
# Los cambios se reflejan automáticamente en /vagrant
```

**Patrón 2: Pruebas en múltiples OS**

```bash
# Probar en Ubuntu
mkdir test-ubuntu && cd test-ubuntu
vagrant init ubuntu/focal64
vagrant up
vagrant ssh -c "python mi-script.py"
cd ..

# Probar en CentOS
mkdir test-centos && cd test-centos
vagrant init centos/8
vagrant up
vagrant ssh -c "python mi-script.py"
```

**Patrón 3: Snapshots para experimentos**

```bash
# Estado limpio
vagrant snapshot save limpio

# Experimento 1: Instalar Docker
vagrant ssh
sudo apt install docker.io
# ¿No funciona? Volver atrás
exit
vagrant snapshot restore limpio

# Experimento 2: Instalar Podman
vagrant ssh
sudo apt install podman
# ¡Funciona! Guardar este estado
exit
vagrant snapshot save con-podman
```

### 5. Troubleshooting y Debugging

#### Problemas Comunes y Soluciones

**Problema 1: VM no inicia**

```bash
# Ver logs detallados
vagrant up --debug > vagrant.log 2>&1

# Verificar VirtualBox
VBoxManage list vms

# Forzar destrucción y recrear
vagrant destroy -f
vagrant up
```

**Problema 2: SSH no conecta**

```bash
# Ver configuración SSH
vagrant ssh-config

# Probar SSH manual
ssh vagrant@127.0.0.1 -p 2222 -i ~/.vagrant.d/insecure_private_key

# Reiniciar red de la VM
vagrant reload
```

**Problema 3: Carpetas no se sincronizan**

```bash
# Reinstalar VirtualBox Guest Additions
vagrant plugin install vagrant-vbguest
vagrant vbguest --do install
vagrant reload
```

**Problema 4: VM muy lenta**

```bash
# Soluciones en Vagrantfile:
config.vm.provider "virtualbox" do |vb|
  # Más CPUs
  vb.cpus = 2

  # Más RAM
  vb.memory = 2048

  # Habilitar PAE
  vb.customize ["modifyvm", :id, "--pae", "on"]

  # Habilitar VT-x/AMD-V
  vb.customize ["modifyvm", :id, "--ioapic", "on"]
end
```

**Problema 5: Port already in use**

```bash
# Cambiar puerto en Vagrantfile
config.vm.network "forwarded_port", guest: 80, host: 8081  # En vez de 8080

# O auto-corregir puertos
config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
```

#### Comandos de Debugging

```bash
# Ver información completa de la VM
VBoxManage showvminfo nombre-vm

# Ver VMs corriendo
VBoxManage list runningvms

# Ver logs de VirtualBox
VBoxManage showvminfo nombre-vm --log 0 > vm.log

# Matar proceso de Vagrant colgado
ps aux | grep vagrant
kill -9 [PID]
```

### 6. Tips y Trucos de Productividad

#### Alias Útiles

```bash
# Agregar a tu ~/.bashrc o ~/.zshrc

alias vu='vagrant up'
alias vh='vagrant halt'
alias vs='vagrant ssh'
alias vr='vagrant reload'
alias vd='vagrant destroy -f'
alias vp='vagrant provision'
alias vst='vagrant status'
alias vgs='vagrant global-status'
```

#### Vagrantfile Template Personal

Crea un template que uses siempre:

```ruby
# ~/vagrant-templates/base/Vagrantfile
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = 2
  end
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y curl wget vim git htop
  SHELL
end
```

Luego:
```bash
# Nuevo proyecto
mkdir mi-proyecto
cp ~/vagrant-templates/base/Vagrantfile mi-proyecto/
cd mi-proyecto
vagrant up
```

#### Script de Utilidades

```bash
# ~/bin/vagrant-utils.sh

#!/bin/bash

# Limpiar todas las VMs muertas
vagrant-clean-all() {
    vagrant global-status --prune
    vagrant box prune
}

# Reiniciar VM rápido
vagrant-restart() {
    vagrant halt && vagrant up
}

# Snapshot rápido con fecha
vagrant-snap() {
    local snapshot_name="snapshot-$(date +%Y%m%d-%H%M%S)"
    vagrant snapshot save "$snapshot_name"
    echo "Snapshot created: $snapshot_name"
}

# Listar todas las VMs con sus IPs
vagrant-list-ips() {
    vagrant global-status | grep virtualbox | awk '{print $1}' | while read id; do
        echo "VM ID: $id"
        vagrant ssh-config $id | grep HostName
    done
}
```

## Ejercicios Prácticos

Ve a la carpeta `ejercicios/` para practicar:

1. **Gestión de boxes**: Agregar, actualizar y eliminar boxes
2. **Comandos avanzados**: Usar snapshots, port forwarding, etc.
3. **Optimización**: Configurar una VM de alto rendimiento
4. **Troubleshooting**: Resolver problemas simulados

## Recursos Adicionales

- 📚 [Documentación oficial de comandos](https://www.vagrantup.com/docs/cli)
- 📚 [Vagrant Cloud](https://app.vagrantup.com/boxes/search)
- 🎥 [HashiCorp Learn - Vagrant](https://learn.hashicorp.com/vagrant)

## ¿Qué sigue?

👉 **[Módulo 3: Configuración Intermedia](../modulo-03-configuracion-intermedia/README.md)**

En el próximo módulo aprenderás:
- Configuración avanzada de redes
- Múltiples carpetas compartidas
- Permisos y seguridad
- Variables de entorno
- Y mucho más...

---

## Resumen del Módulo 2

✅ Dominas todos los comandos de Vagrant
✅ Sabes gestionar boxes eficientemente
✅ Puedes crear y usar snapshots
✅ Conoces patrones de flujo de trabajo eficientes
✅ Sabes resolver problemas comunes

**¡Felicitaciones! Ahora eres un usuario intermedio de Vagrant** 🎉
