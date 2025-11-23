# Ejercicios del Módulo 1 💪

## Objetivo

Practicar los conceptos aprendidos creando tus propios Vagrantfiles desde cero.

## Instrucciones Generales

1. Lee cada ejercicio completamente antes de empezar
2. Crea el Vagrantfile en la carpeta correspondiente
3. Prueba tu solución con `vagrant up`
4. Si te atascas, revisa los ejemplos o la carpeta `soluciones/`
5. NO copies y pegues, escribe el código tú mismo para aprender mejor

## Ejercicios

### Ejercicio 1: VM con Debian ⭐ (Principiante)

**Carpeta:** `ejercicio-01-debian/`

**Objetivo:** Crear una VM básica con Debian 11

**Requisitos:**
- Usar la box `debian/bullseye64`
- Configurar hostname: `mi-debian-server`
- 1 GB de RAM
- 1 CPU

**Verificación:**
```bash
vagrant up
vagrant ssh
cat /etc/os-release  # Debe mostrar Debian 11
hostname             # Debe mostrar "mi-debian-server"
free -h              # Debe mostrar ~1GB RAM
```

---

### Ejercicio 2: VM con CentOS 8 ⭐ (Principiante)

**Carpeta:** `ejercicio-02-centos/`

**Objetivo:** Crear una VM con CentOS Stream 8

**Requisitos:**
- Usar la box `centos/stream8`
- Hostname: `centos-desarrollo`
- 2 GB de RAM
- 2 CPUs
- Nombre en VirtualBox: `CentOS-Dev-VM`

**Verificación:**
```bash
vagrant up
vagrant ssh
cat /etc/redhat-release  # Debe mostrar CentOS Stream 8
nproc                    # Debe mostrar 2
free -h                  # Debe mostrar ~2GB RAM
```

---

### Ejercicio 3: Servidor Web Personalizado ⭐⭐ (Intermedio)

**Carpeta:** `ejercicio-03-web-server/`

**Objetivo:** Crear un servidor web con Apache y MySQL

**Requisitos:**
- Ubuntu 20.04
- Instalar Apache2 y MySQL mediante provisionamiento
- Port forwarding: puerto 80 de la VM al 8888 del host
- Crear una página HTML personalizada que muestre:
  - Tu nombre
  - La fecha actual
  - Versión de Apache instalada
- Carpeta compartida: `./sitio-web` → `/var/www/html`

**Verificación:**
```bash
vagrant up
# Abrir http://localhost:8888 en el navegador
# Debe mostrar tu página personalizada
vagrant ssh
apache2 -v  # Verificar versión
mysql --version  # Verificar MySQL
```

---

### Ejercicio 4: Entorno de Desarrollo Python ⭐⭐ (Intermedio)

**Carpeta:** `ejercicio-04-python-dev/`

**Objetivo:** Crear un entorno de desarrollo para Python

**Requisitos:**
- Ubuntu 20.04
- Instalar Python 3.9+, pip, virtualenv
- Instalar git
- Crear un directorio `~/proyectos/`
- Configurar carpeta compartida: `./mi-codigo` → `/home/vagrant/proyectos`
- Crear un script de bienvenida que se ejecute siempre

**El script de bienvenida debe mostrar:**
- Versión de Python
- Versión de pip
- Número de proyectos en ~/proyectos/

**Verificación:**
```bash
vagrant up
vagrant ssh
python3 --version
pip3 --version
ls ~/proyectos
```

---

### Ejercicio 5: Multi-Tool Development Box ⭐⭐⭐ (Avanzado)

**Carpeta:** `ejercicio-05-multi-tool/`

**Objetivo:** Crear una VM completa de desarrollo con múltiples herramientas

**Requisitos:**
- Ubuntu 20.04
- 4 GB de RAM
- 2 CPUs
- Instalar:
  - Node.js (v18+)
  - Python 3
  - Docker
  - Git
  - VSCode Server (code-server)
  - htop, vim, curl, wget
- Port forwarding:
  - 8080 → VSCode Server
  - 3000 → Node.js apps
  - 5000 → Python apps
- Mensaje post-up personalizado con instrucciones de uso
- Script que se ejecute siempre mostrando:
  - Versiones instaladas de todas las herramientas
  - Espacio en disco disponible
  - Memoria disponible

**Verificación:**
```bash
vagrant up
# Abrir http://localhost:8080 para VSCode Server
vagrant ssh
node --version
python3 --version
docker --version
```

---

### Ejercicio 6: Proyecto Real ⭐⭐⭐ (Avanzado)

**Carpeta:** `ejercicio-06-proyecto-real/`

**Objetivo:** Simular un entorno real de desarrollo web

**Escenario:**
Eres un desarrollador que necesita trabajar en un proyecto WordPress local.

**Requisitos:**
- Ubuntu 20.04
- Stack LAMP (Linux, Apache, MySQL, PHP)
- Descargar e instalar WordPress automáticamente
- Base de datos MySQL:
  - Database: `wordpress_db`
  - Usuario: `wp_user`
  - Password: `wp_password`
- Port forwarding: 80 → 8080
- Carpeta compartida para el código de WordPress
- Configurar Apache para servir WordPress
- Todo debe estar funcionando después de `vagrant up`

**Verificación:**
```bash
vagrant up
# Abrir http://localhost:8080
# Debe aparecer el instalador de WordPress
# Completar instalación y crear un post
```

**Bonus:**
- Importar una base de datos de ejemplo
- Instalar plugins comunes
- Configurar permalinks

---

## Guía de Dificultad

⭐ **Principiante**: Conceptos básicos, poca configuración
⭐⭐ **Intermedio**: Requiere provisionamiento y configuración
⭐⭐⭐ **Avanzado**: Múltiples componentes, integración completa

## Consejos para Resolver

1. **Lee la documentación**: https://www.vagrantup.com/docs
2. **Revisa los ejemplos**: Los ejemplos 1-4 tienen mucho código útil
3. **Google es tu amigo**: Busca "vagrant install mysql" por ejemplo
4. **Prueba incremental**: No escribas todo de una vez, prueba paso a paso
5. **Lee los errores**: Vagrant da mensajes de error descriptivos
6. **Usa comentarios**: Documenta tu código como en los ejemplos

## Debugging

```bash
# Ver logs detallados
vagrant up --debug

# Validar Vagrantfile
vagrant validate

# Entrar en modo verbose para provisionamiento
vagrant provision --debug
```

## Formato de Entrega (Opcional)

Si quieres documentar tus soluciones:

```
ejercicio-XX/
├── Vagrantfile       # Tu solución
├── provision.sh      # Script de provisionamiento (si aplica)
├── README.md         # Documentación de tu solución
└── screenshots/      # Capturas de pantalla (opcional)
```

## ¿Terminaste Todos?

¡Excelente trabajo! 🎉

Si completaste los 6 ejercicios, ya dominas:
- ✅ Creación de VMs con diferentes sistemas operativos
- ✅ Configuración de recursos
- ✅ Provisionamiento automático
- ✅ Port forwarding
- ✅ Carpetas compartidas
- ✅ Instalación de stacks completos

👉 **[Continúa con el Módulo 2](../../modulo-02-primeros-pasos/README.md)**

---

**¿Preguntas o dudas?** Revisa las soluciones en `../soluciones/` después de intentar cada ejercicio por ti mismo.

¡Buena suerte! 💪
