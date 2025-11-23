# Módulo 5: Networking Avanzado 🌐

## Introducción

Domina las redes en Vagrant: port forwarding, redes privadas/públicas, comunicación entre VMs y más.

## Tipos de Redes en Vagrant

### 1. Port Forwarding (NAT)

Mapea puertos del guest al host.

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  # Puerto simple
  config.vm.network "forwarded_port", guest: 80, host: 8080

  # Con auto-corrección si el puerto está ocupado
  config.vm.network "forwarded_port", guest: 443, host: 8443, auto_correct: true

  # Solo accesible desde localhost (más seguro)
  config.vm.network "forwarded_port", guest: 3000, host: 3000, host_ip: "127.0.0.1"

  # Múltiples puertos
  (3000..3005).each do |port|
    config.vm.network "forwarded_port", guest: port, host: port
  end

  # Protocolo específico
  config.vm.network "forwarded_port", guest: 53, host: 5353, protocol: "udp"
end
```

### 2. Red Privada (Host-Only)

VM solo accesible desde el host.

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  # IP estática
  config.vm.network "private_network", ip: "192.168.33.10"

  # DHCP automático
  config.vm.network "private_network", type: "dhcp"

  # Con nombre de adaptador
  config.vm.network "private_network", ip: "192.168.33.10", virtualbox__intnet: "mi-red-privada"
end
```

### 3. Red Pública (Bridged)

VM accesible desde la red local.

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  # DHCP en red pública
  config.vm.network "public_network"

  # IP estática en red pública
  config.vm.network "public_network", ip: "192.168.1.100"

  # Especificar interfaz de bridge
  config.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)"

  # Evitar pregunta de interfaz
  config.vm.network "public_network", bridge: [
    "en1: Wi-Fi (AirPort)",
    "en6: Broadcom NetXtreme Gigabit Ethernet Controller",
  ]
end
```

## Ejemplos Prácticos

### Servidor Web Accesible en Red Local

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.hostname = "web-server"

  # Acceso local (desarrollo)
  config.vm.network "forwarded_port", guest: 80, host: 8080

  # Acceso desde red local (demos)
  config.vm.network "public_network", ip: "192.168.1.100"

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y nginx

    cat > /var/www/html/index.html <<EOF
<!DOCTYPE html>
<html>
<head><title>Mi Servidor</title></head>
<body>
  <h1>Servidor Web en Vagrant</h1>
  <p>Accesible desde:</p>
  <ul>
    <li>Host: http://localhost:8080</li>
    <li>Red Local: http://192.168.1.100</li>
  </ul>
</body>
</html>
EOF

    systemctl restart nginx
  SHELL
end
```

### Múltiples VMs en Red Privada

```ruby
Vagrant.configure("2") do |config|

  # Web Server
  config.vm.define "web" do |web|
    web.vm.box = "ubuntu/focal64"
    web.vm.hostname = "web"
    web.vm.network "private_network", ip: "192.168.33.10"
    web.vm.network "forwarded_port", guest: 80, host: 8080

    web.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y nginx
      echo "<h1>Web Server</h1><p>Conectado a DB en 192.168.33.11:5432</p>" > /var/www/html/index.html
    SHELL
  end

  # Database Server
  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/focal64"
    db.vm.hostname = "db"
    db.vm.network "private_network", ip: "192.168.33.11"

    db.vm.provision "shell", inline: <<-SHELL
      apt-get update
      apt-get install -y postgresql postgresql-contrib

      # Configurar PostgreSQL para aceptar conexiones externas
      echo "listen_addresses = '*'" >> /etc/postgresql/*/main/postgresql.conf
      echo "host all all 192.168.33.0/24 trust" >> /etc/postgresql/*/main/pg_hba.conf

      systemctl restart postgresql
    SHELL
  end
end
```

Conectar desde web a db:
```bash
vagrant ssh web
psql -h 192.168.33.11 -U postgres
```

### Cluster de 3 Nodos

```ruby
Vagrant.configure("2") do |config|
  NUM_NODES = 3

  (1..NUM_NODES).each do |i|
    config.vm.define "node#{i}" do |node|
      node.vm.box = "ubuntu/focal64"
      node.vm.hostname = "node#{i}"
      node.vm.network "private_network", ip: "192.168.33.#{10+i}"

      node.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
        vb.cpus = 1
      end

      node.vm.provision "shell", inline: <<-SHELL
        apt-get update
        apt-get install -y curl

        # Agregar otros nodos al /etc/hosts
        #{(1..NUM_NODES).map { |j|
          "echo '192.168.33.#{10+j} node#{j}' >> /etc/hosts" unless i == j
        }.compact.join("\n        ")}

        echo "Node #{i} configurado"
        echo "Puede hacer ping a otros nodos:"
        #{(1..NUM_NODES).map { |j|
          "ping -c 1 node#{j} || true" unless i == j
        }.compact.join("\n        ")}
      SHELL
    end
  end
end
```

### DNS Local con Hostmanager

```bash
vagrant plugin install vagrant-hostmanager
```

```ruby
Vagrant.configure("2") do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true

  config.vm.define "web" do |web|
    web.vm.box = "ubuntu/focal64"
    web.vm.hostname = "web.local"
    web.vm.network "private_network", ip: "192.168.33.10"
  end

  config.vm.define "api" do |api|
    api.vm.box = "ubuntu/focal64"
    api.vm.hostname = "api.local"
    api.vm.network "private_network", ip: "192.168.33.11"
  end

  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/focal64"
    db.vm.hostname = "db.local"
    db.vm.network "private_network", ip: "192.168.33.12"
  end
end
```

Ahora puedes usar:
```bash
# Desde tu host
ping web.local
curl http://web.local

# Desde dentro de cualquier VM
vagrant ssh web
ping api.local
ping db.local
```

### Firewall y Seguridad

```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.provision "shell", inline: <<-SHELL
    # Instalar UFW (Uncomplicated Firewall)
    apt-get install -y ufw

    # Política por defecto: denegar todo
    ufw default deny incoming
    ufw default allow outgoing

    # Permitir SSH
    ufw allow 22/tcp

    # Permitir HTTP/HTTPS
    ufw allow 80/tcp
    ufw allow 443/tcp

    # Permitir solo desde red privada
    ufw allow from 192.168.33.0/24 to any port 5432

    # Activar firewall
    ufw --force enable

    # Ver estado
    ufw status verbose
  SHELL
end
```

## Troubleshooting de Red

```bash
# Dentro de la VM, verificar interfaces
ip addr show

# Ver rutas
ip route

# Ver puertos abiertos
sudo netstat -tulpn

# Verificar conectividad
ping google.com
ping 192.168.33.10

# Ver DNS
cat /etc/resolv.conf

# Traceroute
traceroute google.com
```

## Resumen

✅ Port forwarding (NAT)
✅ Redes privadas (Host-Only)
✅ Redes públicas (Bridged)
✅ Comunicación entre VMs
✅ DNS local
✅ Seguridad y firewall

👉 **[Continúa con Módulo 6: Multi-Máquinas](../modulo-06-multi-maquinas/README.md)**
