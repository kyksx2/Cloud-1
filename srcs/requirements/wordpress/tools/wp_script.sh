#!/bin/bash
set -e

# sleep 10

echo "=== Debut de l'initialisation de WordPress ==="

cd /var/www/wordpress

# chaque etape est verifiee separement -> un 1er demarrage rate ne bloque pas les suivants
if [ ! -f /var/www/wordpress/wp-config.php ]; then
    wp config create \
        --dbname="${SQL_DATABASE}" \
        --dbuser="${SQL_USER}" \
        --dbpass="${SQL_PASSWORD}" \
        --dbhost="mariadb" \
        --skip-check \
        --allow-root
fi

if ! wp core is-installed --allow-root 2>/dev/null; then
    wp core install \
        --url="https://${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email \
        --allow-root

    echo "Configuration de WordPress terminee !"
else
    echo "WordPress est deja configure"
fi

if ! wp user get "${WP_USER2_LOGIN}" --field=ID --allow-root >/dev/null 2>&1; then
    wp user create \
        "${WP_USER2_LOGIN}" \
        "${WP_USER2_EMAIL}" \
        --user_pass="${WP_USER2_PASSWORD}" \
        --role=editor \
        --allow-root
fi

chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress
chmod -R 775 /var/www/wordpress/wp-content

echo "Demarrage de PHP-FPM..."
# alpine + php85 -> binaire 'php-fpm85' (php-fpm8.2 = debian)
exec php-fpm85 -F