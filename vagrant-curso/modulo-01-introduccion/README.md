# Módulo 1: Introducción y Conceptos Básicos 🚀

## ¿Qué es Vagrant?

**Vagrant** es una herramienta de código abierto para construir y gestionar entornos de desarrollo virtualizados de forma automatizada. Fue creada por Mitchell Hashimoto en 2010 y es mantenida por HashiCorp.

### ¿Por qué usar Vagrant?

Antes de Vagrant, los desarrolladores enfrentaban el famoso problema:

> "En mi máquina funciona..." 🤷‍♂️

**Vagrant soluciona esto proporcionando:**

1. **Entornos reproducibles**: Todos los desarrolladores trabajan en el mismo ambiente
2. **Automatización**: Configuración como código
3. **Portabilidad**: Funciona en Windows, macOS y Linux
4. **Aislamiento**: No contaminas tu sistema operativo principal
5. **Versionamiento**: Tu infraestructura se versiona junto con tu código

### Casos de Uso Reales

- ✅ Desarrollo de aplicaciones web (LAMP, MEAN, etc.)
- ✅ Pruebas de software en diferentes sistemas operativos
- ✅ Aprendizaje de tecnologías (Kubernetes, Docker, etc.)
- ✅ Simulación de arquitecturas distribuidas
- ✅ Demos y presentaciones técnicas

## Conceptos Fundamentales

### 1. Providers (Proveedores)

Son las plataformas de virtualización que Vagrant usa para crear las VMs:

- **VirtualBox** (gratuito, más común)
- VMware (de pago, mejor rendimiento)
- Hyper-V (Windows)
- Docker
- AWS, Azure, GCP (cloud providers)

### 2. Boxes

Son imágenes base de sistemas operativos empaquetadas para Vagrant. Piensa en ellos como "plantillas" de VMs.

- Se descargan desde **Vagrant Cloud** (https://app.vagrantup.com/boxes/search)
- Ejemplos: `ubuntu/focal64`, `centos/7`, `debian/bullseye64`
- Se pueden crear boxes personalizadas

### 3. Vagrantfile

Es el archivo de configuración escrito en Ruby que define:
- Qué box usar
- Configuración de recursos (RAM, CPU)
- Redes y puertos
- Scripts de provisionamiento
- Y mucho más...

### 4. Provisioners (Provisionadores)

Herramientas para automatizar la instalación y configuración de software:
- Shell scripts
- Ansible
- Chef
- Puppet
- Docker

## Instalación Paso a Paso

### Paso 1: Instalar VirtualBox

**Windows/Mac:**
1. Descarga de: https://www.virtualbox.org/wiki/Downloads
2. Ejecuta el instalador
3. Sigue el asistente de instalación

**Linux (Ubuntu/Debian):**
```bash
sudo apt update
sudo apt install virtualbox virtualbox-ext-pack
```

**Linux (CentOS/RHEL):**
```bash
sudo yum install VirtualBox
```

### Paso 2: Instalar Vagrant

**Windows/Mac:**
1. Descarga de: https://www.vagrantup.com/downloads
2. Ejecuta el instalador
3. Reinicia la terminal

**Linux (Ubuntu/Debian):**
```bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vagrant
```

**Linux (CentOS/RHEL):**
```bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum install vagrant
```

### Paso 3: Verificar Instalación

```bash
# Verificar versión de Vagrant
vagrant --version

# Verificar versión de VirtualBox
vboxmanage --version
```

Deberías ver algo como:
```
Vagrant 2.4.0
7.0.12r159484
```

## Tu Primera Máquina Virtual con Vagrant

### Ejemplo 1: Hello World de Vagrant

Vamos a crear tu primera VM. Es súper simple:

```bash
# 1. Crea un directorio para tu proyecto
mkdir mi-primera-vm
cd mi-primera-vm

# 2. Inicializa Vagrant con una box de Ubuntu
vagrant init ubuntu/focal64

# 3. Levanta la VM
vagrant up

# 4. Conéctate por SSH
vagrant ssh

# 5. ¡Estás dentro de la VM!
# Prueba algunos comandos:
uname -a
cat /etc/os-release
exit

# 6. Destruye la VM cuando termines
vagrant destroy
```

### ¿Qué acaba de pasar?

1. `vagrant init` creó un archivo `Vagrantfile` básico
2. `vagrant up` descargó la box (solo la primera vez) y creó la VM
3. `vagrant ssh` te conectó a la VM por SSH
4. `vagrant destroy` eliminó la VM completamente

## Anatomía de un Vagrantfile

Veamos el Vagrantfile más simple posible:

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

# Este es un comentario en Ruby
# Los Vagrantfiles siempre empiezan así:

Vagrant.configure("2") do |config|
  # "2" es la versión de configuración de Vagrant
  # |config| es el objeto de configuración

  # Define qué box (imagen) usar
  config.vm.box = "ubuntu/focal64"

  # Esto descargará Ubuntu 20.04 LTS de 64 bits
end
```

### Explicación Línea por Línea

```ruby
Vagrant.configure("2") do |config|
  # ↑ Inicia el bloque de configuración
  # "2" es la versión de la API (siempre usa "2")
  # do |config| inicia un bloque Ruby

  config.vm.box = "ubuntu/focal64"
  # config.vm → Configuración de la máquina virtual
  # .box → Especifica qué imagen base usar
  # "ubuntu/focal64" → Nombre de la box en Vagrant Cloud

end
# ↑ Cierra el bloque de configuración
```

## Comandos Básicos de Vagrant

### Ciclo de Vida de una VM

```bash
# Inicializar un nuevo proyecto
vagrant init [box-name]

# Levantar/crear la VM
vagrant up

# Ver estado de las VMs
vagrant status

# Conectarse por SSH
vagrant ssh

# Suspender la VM (como hibernar)
vagrant suspend

# Reanudar una VM suspendida
vagrant resume

# Apagar la VM (como shutdown)
vagrant halt

# Reiniciar la VM
vagrant reload

# Destruir la VM completamente
vagrant destroy

# Volver a provisionar (ejecutar scripts)
vagrant provision
```

### Comandos de Boxes

```bash
# Listar boxes instaladas
vagrant box list

# Agregar una nueva box
vagrant box add ubuntu/focal64

# Actualizar una box
vagrant box update

# Eliminar una box
vagrant box remove ubuntu/focal64

# Limpiar versiones antiguas
vagrant box prune
```

### Comandos de Información

```bash
# Ver estado global de todas las VMs
vagrant global-status

# Ver información de SSH
vagrant ssh-config

# Validar el Vagrantfile
vagrant validate

# Ver versión de Vagrant
vagrant version
```

## Flujo de Trabajo Típico

```bash
# 1. Crear directorio del proyecto
mkdir mi-proyecto
cd mi-proyecto

# 2. Crear Vagrantfile
vagrant init ubuntu/focal64

# 3. (Opcional) Editar Vagrantfile para personalizar

# 4. Levantar la VM
vagrant up

# 5. Trabajar con la VM
vagrant ssh

# ... hacer tu trabajo ...

# 6. Cuando termines por hoy
vagrant halt

# 7. Al día siguiente
vagrant up
vagrant ssh

# 8. Cuando el proyecto termine
vagrant destroy
```

## Estructura de Directorios

Cuando ejecutas `vagrant up`, Vagrant crea:

```
mi-proyecto/
├── Vagrantfile          # Configuración principal
├── .vagrant/            # Metadatos de Vagrant (no tocar)
│   ├── machines/        # Info de las máquinas
│   └── ...
└── (tus archivos)       # Se sincronizan con /vagrant dentro de la VM
```

> **Importante**: El directorio del proyecto se monta automáticamente en `/vagrant` dentro de la VM.

## Ejemplos Prácticos Incluidos

En la carpeta `ejemplos/` encontrarás:

1. **ejemplo-01-basico**: Vagrantfile mínimo con Ubuntu
2. **ejemplo-02-personalizado**: VM con nombre y configuración custom
3. **ejemplo-03-compartir-carpetas**: Sincronización de archivos
4. **ejemplo-04-script-provision**: Instalación automática de software

## Ejercicios Prácticos

Ve a la carpeta `ejercicios/` y completa:

1. **Ejercicio 1**: Crear una VM con Debian
2. **Ejercicio 2**: Crear una VM con CentOS 8
3. **Ejercicio 3**: Configurar mensaje de bienvenida personalizado
4. **Ejercicio 4**: Explorar el sistema y documentar

Las soluciones están en `soluciones/` ¡pero intenta hacerlos primero!

## Troubleshooting Común

### Problema: "No se encuentra el comando vagrant"

**Solución**:
```bash
# Reinicia tu terminal o actualiza el PATH
# Windows: Cierra y abre nueva terminal
# Linux/Mac:
source ~/.bashrc  # o ~/.zshrc
```

### Problema: "Box no se descarga"

**Solución**:
```bash
# Descarga manual primero
vagrant box add ubuntu/focal64
# Luego vagrant up
```

### Problema: "Virtualización no habilitada"

**Solución**: Habilita VT-x/AMD-V en la BIOS de tu computadora

### Problema: "Port collision"

**Solución**: Otro proceso usa el puerto, cámbialo en el Vagrantfile

## Mejores Prácticas

1. ✅ **Versiona tu Vagrantfile** en Git
2. ✅ **No versiones `.vagrant/`** (agrégalo a `.gitignore`)
3. ✅ **Comenta tu código** para que otros entiendan
4. ✅ **Usa boxes oficiales** cuando sea posible
5. ✅ **Destruye VMs que no uses** para liberar espacio

## Recursos Adicionales

- 📚 [Documentación Oficial](https://www.vagrantup.com/docs)
- 📦 [Vagrant Cloud - Boxes](https://app.vagrantup.com/boxes/search)
- 💬 [Foro de Vagrant](https://discuss.hashicorp.com/c/vagrant)
- 🎥 [YouTube - HashiCorp](https://www.youtube.com/c/HashiCorp)

## ¿Qué sigue?

Una vez que completes este módulo:

👉 **[Continúa con el Módulo 2: Primeros Pasos](../modulo-02-primeros-pasos/README.md)**

Ahí aprenderás a:
- Dominar todos los comandos de Vagrant
- Gestionar boxes eficientemente
- Personalizar tu Vagrantfile
- Sincronizar carpetas avanzado

---

## Resumen del Módulo 1

✅ Aprendiste qué es Vagrant y por qué usarlo
✅ Instalaste Vagrant y VirtualBox
✅ Creaste tu primera máquina virtual
✅ Entendiste el Vagrantfile básico
✅ Conociste los comandos fundamentales

**¡Felicitaciones! Ya eres un usuario básico de Vagrant** 🎉

Ahora ve a `ejemplos/` y prueba cada uno. ¡La práctica hace al maestro!
