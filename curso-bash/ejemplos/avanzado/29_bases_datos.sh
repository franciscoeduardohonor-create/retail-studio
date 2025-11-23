#!/bin/bash

################################################################################
# Ejemplo 29: Interacción con Bases de Datos
# Descripción: Conectar y consultar bases de datos desde BASH
# Nivel: Avanzado
################################################################################

echo "=== SQLite ==="

# SQLite es perfecto para scripts
sqlite_ejemplo() {
    local db="/tmp/ejemplo_$$.db"

    echo "Usando SQLite:"

    # Crear tabla
    sqlite3 "$db" << 'EOF'
CREATE TABLE IF NOT EXISTS usuarios (
    id INTEGER PRIMARY KEY,
    nombre TEXT,
    edad INTEGER
);
INSERT INTO usuarios (nombre, edad) VALUES ('Juan', 30);
INSERT INTO usuarios (nombre, edad) VALUES ('María', 25);
INSERT INTO usuarios (nombre, edad) VALUES ('Pedro', 35);
EOF

    echo "✓ Datos insertados"

    # Consultar
    echo -e "\nUsuarios en la base de datos:"
    sqlite3 -header -column "$db" "SELECT * FROM usuarios;"

    # Consulta con filtro
    echo -e "\nUsuarios mayores de 28:"
    sqlite3 -header -column "$db" "SELECT * FROM usuarios WHERE edad > 28;"

    # Limpiar
    rm -f "$db"
}

if command -v sqlite3 &> /dev/null; then
    sqlite_ejemplo
else
    echo "SQLite no instalado (ejemplo omitido)"
fi

echo -e "\n=== MySQL/MariaDB ==="

mysql_ejemplo() {
    local host="localhost"
    local user="root"
    local pass="password"
    local db="myapp"

    echo "Conexión a MySQL:"

    # Ejecutar query
    # mysql -h "$host" -u "$user" -p"$pass" -D "$db" -e "SELECT * FROM usuarios;"

    # Desde archivo
    # mysql -h "$host" -u "$user" -p"$pass" -D "$db" < query.sql

    # Exportar a CSV
    # mysql -h "$host" -u "$user" -p"$pass" -D "$db" -e "SELECT * FROM usuarios;" | sed 's/\t/,/g' > usuarios.csv

    echo "✓ (Ejemplo simulado - requiere MySQL)"
}

mysql_ejemplo

echo -e "\n=== PostgreSQL ==="

postgres_ejemplo() {
    local host="localhost"
    local user="postgres"
    local db="myapp"

    echo "Conexión a PostgreSQL:"

    # Con psql
    # PGPASSWORD=password psql -h "$host" -U "$user" -d "$db" -c "SELECT * FROM usuarios;"

    # Exportar a CSV
    # psql -h "$host" -U "$user" -d "$db" -c "COPY usuarios TO STDOUT WITH CSV HEADER" > usuarios.csv

    echo "✓ (Ejemplo simulado - requiere PostgreSQL)"
}

postgres_ejemplo

echo -e "\n=== EJEMPLO: BACKUP DE DB ==="

backup_database() {
    local db_name=$1
    local backup_dir="/backup"
    local fecha=$(date +%Y%m%d_%H%M%S)

    echo "Backup de base de datos:"

    # MySQL
    # mysqldump -u root -p $db_name > $backup_dir/${db_name}_$fecha.sql

    # PostgreSQL
    # pg_dump -U postgres $db_name > $backup_dir/${db_name}_$fecha.sql

    # Comprimir
    # gzip $backup_dir/${db_name}_$fecha.sql

    echo "✓ Backup creado: ${db_name}_$fecha.sql.gz"
}

backup_database "myapp"

echo -e "\n=== EJEMPLO: QUERY BUILDER ==="

query_builder() {
    local tabla=$1
    local campo=$2
    local valor=$3

    local query="SELECT * FROM $tabla WHERE $campo = '$valor';"

    echo "Query generada:"
    echo "  $query"

    # Ejecutar
    # sqlite3 db.db "$query"
}

query_builder "usuarios" "edad" "30"

echo -e "\n=== EJEMPLO: MIGRACIÓN ==="

migration_script() {
    local db="/tmp/migration_$$.db"

    echo "Ejecutando migraciones..."

    # Migración 001
    echo "  001: Crear tabla usuarios"
    sqlite3 "$db" "CREATE TABLE usuarios (id INTEGER PRIMARY KEY, nombre TEXT);"

    # Migración 002
    echo "  002: Añadir campo email"
    sqlite3 "$db" "ALTER TABLE usuarios ADD COLUMN email TEXT;"

    # Migración 003
    echo "  003: Crear índice"
    sqlite3 "$db" "CREATE INDEX idx_email ON usuarios(email);"

    echo "✓ Migraciones completadas"

    # Ver estructura
    echo -e "\nEstructura final:"
    sqlite3 "$db" ".schema usuarios"

    rm -f "$db"
}

if command -v sqlite3 &> /dev/null; then
    migration_script
fi

echo -e "\n=== REDIS (Key-Value Store) ==="

redis_ejemplo() {
    echo "Interacción con Redis:"

    # Set valor
    # redis-cli SET usuario:1:nombre "Juan"

    # Get valor
    # redis-cli GET usuario:1:nombre

    # Set con expiración
    # redis-cli SETEX session:abc123 3600 "datos_sesion"

    # Listas
    # redis-cli LPUSH tareas "tarea1" "tarea2" "tarea3"
    # redis-cli LRANGE tareas 0 -1

    echo "✓ (Ejemplo simulado - requiere Redis)"
}

redis_ejemplo

echo -e "\n¡Bases de datos completado!"
