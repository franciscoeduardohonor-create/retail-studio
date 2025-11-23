# Módulo 6: Arquitecturas Multi-Máquinas 🏗️

## Introducción

Aprende a crear entornos complejos con múltiples VMs que trabajan juntas como un sistema distribuido.

## Conceptos Básicos

### Definición de Múltiples VMs

```ruby
Vagrant.configure("2") do |config|

  # Primera VM
  config.vm.define "web" do |web|
    web.vm.box = "ubuntu/focal64"
    web.vm.hostname = "web"
  end

  # Segunda VM
  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/focal64"
    db.vm.hostname = "db"
  end
end
```

Comandos:
```bash
# Levantar todas
vagrant up

# Levantar solo una
vagrant up web
vagrant up db

# SSH a una específica
vagrant ssh web
vagrant ssh db

# Estado de todas
vagrant status

# Destruir solo una
vagrant destroy web
```

## Ejemplos Prácticos

### 1. Stack Web Completo (3-Tier)

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # ===== LOAD BALANCER =====
  config.vm.define "lb" do |lb|
    lb.vm.box = "ubuntu/focal64"
    lb.vm.hostname = "loadbalancer"
    lb.vm.network "private_network", ip: "192.168.33.10"
    lb.vm.network "forwarded_port", guest: 80, host: 8080

    lb.vm.provider "virtualbox" do |vb|
      vb.name = "LoadBalancer"
      vb.memory = "512"
    end

    lb.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y nginx

      # Configurar Nginx como load balancer
      cat > /etc/nginx/sites-available/default <<'EOF'
upstream backend {
    server 192.168.33.11:80;
    server 192.168.33.12:80;
}

server {
    listen 80;
    location / {
        proxy_pass http://backend;
    }
}
EOF

      systemctl restart nginx
      echo "✅ Load Balancer configurado"
    SHELL
  end

  # ===== WEB SERVERS (2 instancias) =====
  (1..2).each do |i|
    config.vm.define "web#{i}" do |web|
      web.vm.box = "ubuntu/focal64"
      web.vm.hostname = "web#{i}"
      web.vm.network "private_network", ip: "192.168.33.#{10+i}"

      web.vm.provider "virtualbox" do |vb|
        vb.name = "WebServer#{i}"
        vb.memory = "1024"
      end

      web.vm.provision "shell", inline: <<-SHELL
        apt-get update
        apt-get install -y nginx php-fpm php-mysql

        # Página de prueba
        cat > /var/www/html/index.php <<'EOF'
<!DOCTYPE html>
<html>
<head><title>Web #{i}</title></head>
<body>
    <h1>Web Server #{i}</h1>
    <p>Hostname: <?php echo gethostname(); ?></p>
    <p>IP: <?php echo $_SERVER['SERVER_ADDR']; ?></p>
    <p>Timestamp: <?php echo date('Y-m-d H:i:s'); ?></p>
</body>
</html>
EOF

        # Configurar Nginx para PHP
        cat > /etc/nginx/sites-available/default <<'NGINX'
server {
    listen 80;
    root /var/www/html;
    index index.php index.html;

    location ~ \\.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
    }
}
NGINX

        systemctl restart nginx php7.4-fpm
        echo "✅ Web Server #{i} configurado"
      SHELL
    end
  end

  # ===== DATABASE SERVER =====
  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/focal64"
    db.vm.hostname = "database"
    db.vm.network "private_network", ip: "192.168.33.20"

    db.vm.provider "virtualbox" do |vb|
      vb.name = "DatabaseServer"
      vb.memory = "2048"
    end

    db.vm.provision "shell", inline: <<-SHELL
      export DEBIAN_FRONTEND=noninteractive

      apt-get update
      apt-get install -y mysql-server

      # Configurar MySQL para conexiones remotas
      sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mysql.conf.d/mysqld.cnf

      systemctl restart mysql

      # Crear usuario y base de datos
      mysql <<MYSQL
CREATE DATABASE IF NOT EXISTS appdb;
CREATE USER IF NOT EXISTS 'appuser'@'%' IDENTIFIED BY 'apppass';
GRANT ALL PRIVILEGES ON appdb.* TO 'appuser'@'%';
FLUSH PRIVILEGES;
MYSQL

      echo "✅ Database Server configurado"
    SHELL
  end

end
```

Probar:
```bash
vagrant up
curl http://localhost:8080  # Refresh varias veces, verás web1 y web2
```

### 2. Cluster de Kubernetes (K8s)

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

NUM_WORKERS = 2

Vagrant.configure("2") do |config|

  # ===== MASTER NODE =====
  config.vm.define "k8s-master" do |master|
    master.vm.box = "ubuntu/focal64"
    master.vm.hostname = "k8s-master"
    master.vm.network "private_network", ip: "192.168.33.10"

    master.vm.provider "virtualbox" do |vb|
      vb.name = "K8s-Master"
      vb.memory = "2048"
      vb.cpus = 2
    end

    master.vm.provision "shell", path: "scripts/install-k8s.sh"
    master.vm.provision "shell", path: "scripts/master-setup.sh"
  end

  # ===== WORKER NODES =====
  (1..NUM_WORKERS).each do |i|
    config.vm.define "k8s-worker#{i}" do |worker|
      worker.vm.box = "ubuntu/focal64"
      worker.vm.hostname = "k8s-worker#{i}"
      worker.vm.network "private_network", ip: "192.168.33.#{10+i}"

      worker.vm.provider "virtualbox" do |vb|
        vb.name = "K8s-Worker#{i}"
        vb.memory = "2048"
        vb.cpus = 2
      end

      worker.vm.provision "shell", path: "scripts/install-k8s.sh"
      worker.vm.provision "shell", path: "scripts/worker-setup.sh"
    end
  end

end
```

### 3. Microservicios

```ruby
Vagrant.configure("2") do |config|

  # ===== API GATEWAY =====
  config.vm.define "gateway" do |gw|
    gw.vm.box = "ubuntu/focal64"
    gw.vm.hostname = "api-gateway"
    gw.vm.network "private_network", ip: "192.168.33.10"
    gw.vm.network "forwarded_port", guest: 80, host: 8080
  end

  # ===== MICROSERVICIOS =====
  services = {
    "auth" => { ip: "192.168.33.20", port: 3001 },
    "users" => { ip: "192.168.33.21", port: 3002 },
    "products" => { ip: "192.168.33.22", port: 3003 },
    "orders" => { ip: "192.168.33.23", port: 3004 }
  }

  services.each do |name, config_data|
    config.vm.define name do |service|
      service.vm.box = "ubuntu/focal64"
      service.vm.hostname = "#{name}-service"
      service.vm.network "private_network", ip: config_data[:ip]
      service.vm.network "forwarded_port", guest: 3000, host: config_data[:port]

      service.vm.provision "shell", inline: <<-SHELL
        apt-get update
        apt-get install -y nodejs npm

        mkdir -p /opt/#{name}-service
        cat > /opt/#{name}-service/index.js <<'EOF'
const http = require('http');
const server = http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify({
    service: '#{name}',
    status: 'running',
    timestamp: new Date().toISOString()
  }));
});
server.listen(3000, () => {
  console.log('#{name} service running on port 3000');
});
EOF

        node /opt/#{name}-service/index.js &
      SHELL
    end
  end

  # ===== MESSAGE QUEUE (RabbitMQ) =====
  config.vm.define "queue" do |mq|
    mq.vm.box = "ubuntu/focal64"
    mq.vm.hostname = "rabbitmq"
    mq.vm.network "private_network", ip: "192.168.33.30"
    mq.vm.network "forwarded_port", guest: 15672, host: 15672  # Admin UI

    mq.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y rabbitmq-server
      systemctl start rabbitmq-server
      rabbitmq-plugins enable rabbitmq_management
    SHELL
  end

  # ===== MONITORING (Prometheus + Grafana) =====
  config.vm.define "monitoring" do |mon|
    mon.vm.box = "ubuntu/focal64"
    mon.vm.hostname = "monitoring"
    mon.vm.network "private_network", ip: "192.168.33.40"
    mon.vm.network "forwarded_port", guest: 3000, host: 3000  # Grafana
    mon.vm.network "forwarded_port", guest: 9090, host: 9090  # Prometheus
  end

end
```

### 4. Entorno de Testing Multi-OS

```ruby
Vagrant.configure("2") do |config|

  # Configuración común
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.cpus = 1
  end

  # Ubuntu 20.04
  config.vm.define "ubuntu20" do |ubuntu|
    ubuntu.vm.box = "ubuntu/focal64"
    ubuntu.vm.hostname = "test-ubuntu20"
    ubuntu.vm.network "private_network", ip: "192.168.33.20"
  end

  # Ubuntu 22.04
  config.vm.define "ubuntu22" do |ubuntu|
    ubuntu.vm.box = "ubuntu/jammy64"
    ubuntu.vm.hostname = "test-ubuntu22"
    ubuntu.vm.network "private_network", ip: "192.168.33.22"
  end

  # Debian 11
  config.vm.define "debian11" do |debian|
    debian.vm.box = "debian/bullseye64"
    debian.vm.hostname = "test-debian11"
    debian.vm.network "private_network", ip: "192.168.33.30"
  end

  # CentOS 8
  config.vm.define "centos8" do |centos|
    centos.vm.box = "centos/stream8"
    centos.vm.hostname = "test-centos8"
    centos.vm.network "private_network", ip: "192.168.33.40"
  end

  # Provisionar en todas: instalar tu app y testear
  config.vm.provision "shell", inline: <<-SHELL
    # Tu script de instalación aquí
    echo "Testeando en $(lsb_release -d | cut -f2)"
  SHELL

end
```

Ejecutar tests:
```bash
# Levantar todas las VMs
vagrant up

# Ejecutar tests en cada una
for vm in ubuntu20 ubuntu22 debian11 centos8; do
  echo "Testing on $vm..."
  vagrant ssh $vm -c "bash /vagrant/run-tests.sh"
done
```

## Patrones Avanzados

### Provisionamiento Ordenado

```ruby
Vagrant.configure("2") do |config|

  # Base de datos (debe estar primero)
  config.vm.define "db", primary: true do |db|
    db.vm.box = "ubuntu/focal64"
    db.vm.network "private_network", ip: "192.168.33.10"

    db.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y postgresql
      # ... configurar DB ...
      touch /tmp/db-ready  # Señal de que DB está lista
    SHELL
  end

  # App (espera a que DB esté lista)
  config.vm.define "app", autostart: false do |app|
    app.vm.box = "ubuntu/focal64"
    app.vm.network "private_network", ip: "192.168.33.11"

    app.vm.provision "shell", inline: <<-SHELL
      # Esperar a que DB esté lista
      echo "Esperando a que DB esté lista..."
      while ! vagrant ssh db -c "test -f /tmp/db-ready" 2>/dev/null; do
        sleep 5
      done

      # Instalar app
      apt-get update
      apt-get install -y nodejs npm
      # ... configurar app ...
    SHELL
  end

end
```

### Configuración Compartida

```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

# Configuración compartida
COMMON_PROVISION = <<-SHELL
  apt-get update
  apt-get install -y curl wget vim git htop
  timedatectl set-timezone America/Mexico_City
SHELL

Vagrant.configure("2") do |config|

  # Configuración global para todas las VMs
  config.vm.box = "ubuntu/focal64"
  config.vm.provision "shell", inline: COMMON_PROVISION

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
    vb.cpus = 1
  end

  # VM 1
  config.vm.define "vm1" do |vm1|
    vm1.vm.hostname = "vm1"
    vm1.vm.network "private_network", ip: "192.168.33.11"
  end

  # VM 2
  config.vm.define "vm2" do |vm2|
    vm2.vm.hostname = "vm2"
    vm2.vm.network "private_network", ip: "192.168.33.12"
  end

end
```

## Comandos Útiles Multi-VM

```bash
# Levantar todas en paralelo
vagrant up --parallel

# Provisionar solo una
vagrant provision web

# Reload específica
vagrant reload db

# SSH a específica
vagrant ssh app

# Ejecutar comando en todas
vagrant ssh web -c "hostname"
vagrant ssh db -c "hostname"

# Destruir solo una
vagrant destroy web -f

# Ver estado global
vagrant global-status

# Suspender todas
vagrant suspend

# Reanudar todas
vagrant resume
```

## Resumen

✅ Definición de múltiples VMs
✅ Arquitecturas 3-tier
✅ Clusters de Kubernetes
✅ Microservicios
✅ Testing multi-OS
✅ Provisionamiento ordenado
✅ Configuración compartida

👉 **[Continúa con Módulo 7: Avanzado](../modulo-07-avanzado/README.md)**
