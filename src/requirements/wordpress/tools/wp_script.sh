#!/bin/bash
set -e

# sleep 10

echo "=== Debut de l'initialisation de WordPress ==="

cd /var/www/wordpress

if [ ! -f /var/www/wordpress/wp-config.php ]; then    
    wp config create \
        --dbname="${SQL_DATABASE}" \
        --dbuser="${SQL_USER}" \
        --dbpass="${SQL_PASSWORD}" \
        --dbhost="mariadb" \
        --skip-check \
        --allow-root
    
    wp core install \
        --url="https://${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email \
        --allow-root
    
    echo "Configuration de WordPress terminee !"

    wp user create \
        "${WP_USER2_LOGIN}" \
        "${WP_USER2_EMAIL}" \
        --user_pass="${WP_USER2_PASSWORD}" \
        --role=editor \
        --allow-root
else
    echo "WordPress est deja configure"
fi

chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress
chmod -R 775 /var/www/wordpress/wp-content

echo "Demarrage de PHP-FPM..."
exec php-fpm8.2 -F --fpm-config /etc/php/8.2/fpm/php-fpm.conf