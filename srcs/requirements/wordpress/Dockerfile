FROM alpine:3.23

RUN apk add --no-cache \
    wget \
    curl \
    mariadb-client \
    php85 \
    php85-fpm \
    php85-mysqli \
    php85-pdo_mysql \
    php85-phar \
    php85-mbstring \
    php85-ctype \
    php85-iconv \
    php85-openssl \
    php85-session \
    bash

RUN [ -e /usr/bin/php ] || ln -s /usr/bin/php85 /usr/bin/php

RUN getent group www-data || addgroup -g 82 -S www-data && \
    id -u www-data &>/dev/null || adduser -u 82 -D -S -G www-data www-data

RUN mkdir -p /var/log/php-fpm /run/php /var/www && \
    chown -R www-data:www-data /var/log/php-fpm /run/php

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

RUN wget https://fr.wordpress.org/wordpress-6.8.2-fr_FR.tar.gz -P /var/www && \
    cd /var/www && \
    tar -xzf wordpress-6.8.2-fr_FR.tar.gz && \
    rm wordpress-6.8.2-fr_FR.tar.gz && \
    chown -R www-data:www-data /var/www/wordpress && \
    chmod -R 755 /var/www/wordpress

COPY conf/www.conf /etc/php85/php-fpm.d/www.conf
COPY --chmod=755 tools/wp_script.sh /usr/local/bin/wp_script.sh

EXPOSE 9000

CMD ["/usr/local/bin/wp_script.sh"]
