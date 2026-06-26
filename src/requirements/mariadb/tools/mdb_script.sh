#!/bin/bash
set -e

echo "=== Debut de l'initialisation de MariaDB ==="

ROOT_MYSQL_ARGS="-uroot"

if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "Premiere initialisation de MariaDB..."

	if command -v mariadb-install-db >/dev/null 2>&1; then
		mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db
	else
		mysql_install_db --user=mysql --datadir=/var/lib/mysql --skip-test-db
	fi
else
	ROOT_MYSQL_ARGS="-uroot -p${SQL_ROOT_PASSWORD}"
fi

echo "Demarrage temporaire de MariaDB..."
mysqld --user=mysql --datadir=/var/lib/mysql --skip-networking --socket=/run/mysqld/mysqld.sock &
MYSQL_PID=$!

for i in {1..30}; do
	if mysqladmin --socket=/run/mysqld/mysqld.sock ping --silent >/dev/null 2>&1; then
		echo "MariaDB est pret !"
		break
	fi
	echo "Tentative $i/30..."
	sleep 1
done

if ! mysqladmin --socket=/run/mysqld/mysqld.sock ping --silent >/dev/null 2>&1; then
	echo "ERREUR : MariaDB n'a pas demarre correctement"
	kill "$MYSQL_PID" 2>/dev/null || true
	exit 1
fi

echo "Configuration de la base de donnees..."

mysql --protocol=socket ${ROOT_MYSQL_ARGS} <<EOF

CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
FLUSH PRIVILEGES;
EOF

echo "Arret de l'instance temporaire..."
kill "$MYSQL_PID"
wait "$MYSQL_PID" 2>/dev/null || true

sleep 1

echo "Demarrage de MariaDB..."
exec mysqld --user=mysql --datadir=/var/lib/mysql
