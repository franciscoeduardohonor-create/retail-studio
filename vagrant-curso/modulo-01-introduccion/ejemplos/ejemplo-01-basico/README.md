# Ejemplo 1: Vagrantfile Básico 🎯

## Objetivo

Aprender la estructura mínima de un Vagrantfile y crear tu primera VM.

## Descripción

Este es el "Hello World" de Vagrant. Crea una máquina virtual con Ubuntu 20.04 usando solo 2 líneas de configuración.

## Pre-requisitos

- Vagrant instalado
- VirtualBox instalado
- Conexión a Internet (para descargar la box)

## Estructura

```
ejemplo-01-basico/
├── Vagrantfile       # Configuración de la VM
└── README.md         # Este archivo
```

## Paso a Paso

### 1. Revisar el Vagrantfile

Abre `Vagrantfile` y lee todos los comentarios. Notarás que solo tiene:

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
end
```

¡Eso es todo! Con esto Vagrant sabe:
- Usar VirtualBox como provider
- Descargar Ubuntu 20.04
- Configurar red NAT
- Configurar SSH automáticamente
- Compartir la carpeta actual en `/vagrant`

### 2. Levantar la VM

```bash
# Asegúrate de estar en este directorio
cd ejemplo-01-basico

# Levanta la VM
vagrant up
```

**¿Qué verás?**

```
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'ubuntu/focal64'...
==> default: Matching MAC address for NAT networking...
==> default: Checking if box 'ubuntu/focal64' is up to date...
==> default: Setting the name of the VM...
==> default: Booting VM...
==> default: Waiting for machine to boot...
```

La primera vez tardará más porque descarga la box (~500 MB).

### 3. Conectarse a la VM

```bash
vagrant ssh
```

Ahora estás dentro de Ubuntu. Verás un prompt como:

```
vagrant@ubuntu-focal:~$
```

### 4. Explorar el Sistema

Prueba estos comandos dentro de la VM:

```bash
# Ver información del sistema operativo
cat /etc/os-release

# Ver recursos de la VM
free -h        # Memoria RAM (por defecto ~1GB)
nproc          # CPUs (por defecto 1)
df -h          # Espacio en disco

# Ver la carpeta compartida
ls -la /vagrant
cat /vagrant/Vagrantfile

# Crear un archivo desde dentro de la VM
echo "Hola desde Ubuntu" > /vagrant/prueba.txt
```

### 5. Salir de la VM

```bash
exit
```

Ahora estás de vuelta en tu máquina host.

### 6. Verificar el archivo compartido

```bash
# En tu máquina host
cat prueba.txt
```

Deberías ver "Hola desde Ubuntu". ¡La carpeta se sincroniza automáticamente!

### 7. Gestionar la VM

```bash
# Ver estado
vagrant status

# Apagar (pero no eliminar)
vagrant halt

# Encender de nuevo
vagrant up

# Reiniciar
vagrant reload

# Eliminar completamente
vagrant destroy
```

## Conceptos Aprendidos

✅ **Sintaxis básica del Vagrantfile**
- Bloque `Vagrant.configure("2")`
- Especificar una box con `config.vm.box`

✅ **Comandos esenciales**
- `vagrant up` → crear/encender
- `vagrant ssh` → conectarse
- `vagrant halt` → apagar
- `vagrant destroy` → eliminar

✅ **Carpeta compartida**
- Tu directorio local se monta en `/vagrant`
- Los cambios se sincronizan en tiempo real

✅ **Defaults automáticos**
- Red NAT
- 1 CPU
- ~1 GB RAM
- SSH configurado

## Ejercicios para Practicar

1. **Instalar software**: Conéctate por SSH e instala `nginx`:
   ```bash
   vagrant ssh
   sudo apt update
   sudo apt install -y nginx
   nginx -v
   ```

2. **Crear archivos**: Crea un archivo dentro de la VM y verifica que aparece en tu host

3. **Explorar recursos**: Usa `top` o `htop` para ver procesos

4. **Práctica de ciclo de vida**:
   ```bash
   vagrant up      # Crear
   vagrant ssh     # Conectar
   exit            # Salir
   vagrant halt    # Apagar
   vagrant up      # Encender de nuevo
   vagrant destroy # Eliminar
   ```

## Troubleshooting

### La box no descarga

```bash
# Intenta descargar manualmente primero
vagrant box add ubuntu/focal64
```

### Error de virtualización

Asegúrate de tener habilitada la virtualización (VT-x/AMD-V) en la BIOS.

### VM muy lenta

Es normal en la primera ejecución. Las siguientes veces será más rápido.

## Siguiente Ejemplo

Una vez domines este ejemplo básico:

👉 **[Ejemplo 2: VM Personalizada](../ejemplo-02-personalizado/)**

Aprenderás a configurar nombre, recursos, y más.

---

**¡Felicidades!** Has creado tu primera VM con Vagrant 🎉
