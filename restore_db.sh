#!/bin/bash

# Variables de configuración
DB_NAME="kamailio"
DB_USER="root"
DB_PASS="rootpw"
SQL_FILE="/usr/src/kamailio_structure.sql"

# Verificar si el archivo SQL existe
if [ ! -f "$SQL_FILE" ]; then
    echo "Error: El archivo SQL no existe en $SQL_FILE"
    exit 1
fi

# Crear la base de datos si no existe
echo "Creando la base de datos $DB_NAME si no existe..."
mariadb -u "$DB_USER" -p"$DB_PASS" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

# Restaurar la estructura de la base de datos
echo "Restaurando la base de datos desde $SQL_FILE..."
mariadb -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < "$SQL_FILE"

echo "Restauración completada."
