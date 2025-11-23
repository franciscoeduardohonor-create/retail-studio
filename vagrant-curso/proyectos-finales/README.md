# Proyectos Finales: Aplicando Todo lo Aprendido 🎯

## Introducción

¡Felicitaciones por llegar hasta aquí! Estos proyectos finales integran TODO lo que aprendiste en el curso. Cada proyecto simula un escenario real del mundo laboral.

## Proyectos Disponibles

### [Proyecto 1: Stack LAMP Completo](./proyecto-01-lamp/) ⭐⭐
**Dificultad:** Intermedia
**Tiempo estimado:** 2-3 horas
**Tecnologías:** Linux, Apache, MySQL, PHP

Crea un entorno de desarrollo web completo con:
- Apache Web Server
- MySQL Database
- PHP 7.4+
- phpMyAdmin
- WordPress instalado y funcionando

**Habilidades practicadas:**
- Provisionamiento con shell
- Port forwarding
- Configuración de bases de datos
- Instalación automatizada de aplicaciones

---

### [Proyecto 2: Cluster de Kubernetes](./proyecto-02-kubernetes/) ⭐⭐⭐
**Dificultad:** Avanzada
**Tiempo estimado:** 4-6 horas
**Tecnologías:** Kubernetes, Docker, kubectl

Despliega un cluster de Kubernetes con:
- 1 Master Node
- 2 Worker Nodes
- Dashboard de Kubernetes
- Aplicación de ejemplo desplegada

**Habilidades practicadas:**
- Multi-VM
- Networking privado
- Provisionamiento complejo
- Orquestación de contenedores

---

### [Proyecto 3: Arquitectura de Microservicios](./proyecto-03-microservicios/) ⭐⭐⭐
**Dificultad:** Avanzada
**Tiempo estimado:** 5-7 horas
**Tecnologías:** Node.js, Redis, RabbitMQ, Nginx

Sistema distribuido con:
- API Gateway (Nginx)
- 4 Microservicios (Auth, Users, Products, Orders)
- Redis (Cache)
- RabbitMQ (Message Queue)
- PostgreSQL (Database)
- Load Balancer

**Habilidades practicadas:**
- Arquitectura multi-VM compleja
- Service discovery
- Load balancing
- Comunicación entre servicios

---

### [Proyecto 4: Sistema de Monitoreo](./proyecto-04-monitoring/) ⭐⭐⭐
**Dificultad:** Avanzada
**Tiempo estimado:** 4-5 horas
**Tecnologías:** Prometheus, Grafana, Node Exporter, Alertmanager

Stack completo de observabilidad:
- Prometheus (métricas)
- Grafana (visualización)
- Node Exporter (métricas del sistema)
- Alertmanager (alertas)
- 3 servidores monitoreados

**Habilidades practicadas:**
- Configuración avanzada de servicios
- Dashboards
- Alertas
- Networking entre VMs

---

## Cómo Usar Estos Proyectos

### 1. Preparación

```bash
# Asegúrate de tener suficiente espacio en disco (al menos 20 GB libres)
df -h

# Verifica versiones
vagrant --version
VBoxManage --version
```

### 2. Ejecutar un Proyecto

```bash
# Navega al proyecto
cd proyectos-finales/proyecto-01-lamp/

# Lee el README específico del proyecto
cat README.md

# Levanta el proyecto
vagrant up

# Sigue las instrucciones específicas del proyecto
```

### 3. Explorar y Modificar

- Lee el código del Vagrantfile
- Entiende cada sección
- Modifica configuraciones
- Experimenta con cambios

### 4. Troubleshooting

Si algo falla:

```bash
# Ver logs detallados
vagrant up --debug > vagrant.log 2>&1

# Destruir y volver a crear
vagrant destroy -f
vagrant up

# Validar Vagrantfile
vagrant validate
```

## Evaluación y Aprendizaje

### Checklist de Cada Proyecto

Después de completar cada proyecto, verifica:

- [ ] Todas las VMs levantan sin errores
- [ ] Todos los servicios funcionan correctamente
- [ ] Puedes acceder a las interfaces web
- [ ] Entiendes el Vagrantfile línea por línea
- [ ] Has modificado algo y funcionó
- [ ] Documentaste lo que aprendiste

### Extensiones Sugeridas

Una vez completados los proyectos básicos, intenta:

**Para Proyecto 1 (LAMP):**
- Instalar Magento o Drupal en vez de WordPress
- Agregar Redis para caché
- Implementar backup automático de la DB

**Para Proyecto 2 (Kubernetes):**
- Desplegar Helm
- Instalar Ingress Controller
- Desplegar una aplicación multi-contenedor real

**Para Proyecto 3 (Microservicios):**
- Agregar autenticación JWT
- Implementar circuit breaker
- Agregar logging centralizado (ELK Stack)

**Para Proyecto 4 (Monitoring):**
- Agregar Loki para logs
- Implementar Jaeger para tracing
- Crear alertas personalizadas

## Recursos de Apoyo

### Documentación Oficial
- [Vagrant Docs](https://www.vagrantup.com/docs)
- [VirtualBox Manual](https://www.virtualbox.org/manual/)
- [Kubernetes Docs](https://kubernetes.io/docs/)
- [Prometheus Docs](https://prometheus.io/docs/)

### Comunidad
- [Vagrant Discuss](https://discuss.hashicorp.com/c/vagrant)
- [Stack Overflow - Vagrant](https://stackoverflow.com/questions/tagged/vagrant)
- [r/vagrant](https://www.reddit.com/r/vagrant/)

## Certificado de Finalización (Opcional)

Al completar los 4 proyectos, habrás demostrado dominio de:

✅ Provisionamiento automatizado
✅ Arquitecturas multi-VM
✅ Networking avanzado
✅ Configuración de servicios complejos
✅ Debugging y troubleshooting
✅ Mejores prácticas de DevOps

**Comparte tu logro:**
- Sube tus proyectos a GitHub
- Documenta tus aprendizajes en un blog
- Incluye "Vagrant" en tu CV/LinkedIn

## Siguientes Pasos

Después de estos proyectos, considera aprender:

- **Terraform**: Infraestructura como código en cloud
- **Ansible**: Automatización y configuración a escala
- **Docker Swarm/Kubernetes**: Orquestación de contenedores
- **CI/CD**: Jenkins, GitLab CI, GitHub Actions
- **Cloud Providers**: AWS, Azure, GCP con Vagrant

---

## ¿Listo para el Desafío?

Elige un proyecto y comienza:

- 👉 [Proyecto 1: LAMP Stack](./proyecto-01-lamp/)
- 👉 [Proyecto 2: Kubernetes Cluster](./proyecto-02-kubernetes/)
- 👉 [Proyecto 3: Microservicios](./proyecto-03-microservicios/)
- 👉 [Proyecto 4: Sistema de Monitoreo](./proyecto-04-monitoring/)

**¡Buena suerte y que disfrutes construyendo!** 🚀
