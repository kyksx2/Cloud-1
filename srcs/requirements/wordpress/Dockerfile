FROM alpine:3.23

RUN apk add --no-cache \
    wget \
    curl \
    mariadb-client \
    php85 \
    php85-fpm \
    php85-mysqli \
    php85-pdo_mysql

RUN adduser -u 82 -D -S -G www-data www-data

RUN mkdir -p /var/log/php-fpm && \
    chown -R www-data:www-data /var/log/php-fpm

RUN wget https://fr.wordpress.org/wordpress-6.8.2-fr_FR.tar.gz -P /var/www && \
    cd /var/www && \
    tar -xzf wordpress-6.8.2-fr_FR.tar.gz && \
    rm wordpress-6.8.2-fr_FR.tar.gz

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

COPY conf/www.conf /etc/php85/php-fpm.d/www.conf

COPY tools/wp_script.sh /usr/local/bin/wp_script.sh

RUN chmod +x /usr/local/bin/wp_script.sh

RUN mkdir -p /run/php && \
    chown -R www-data:www-data /run/php

RUN chown -R www-data:www-data /var/www/wordpress && \
    chmod -R 755 /var/www/wordpress

EXPOSE 9000

CMD ["/usr/local/bin/wp_script.sh"]
