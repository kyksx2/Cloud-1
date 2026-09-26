FROM alpine:3.23

RUN apk update && apk add --no-cache mariadb mariadb-client bash

RUN mkdir -p /run/mysqld && \
    chown mysql:mysql /run/mysqld && \
    chmod 777 /run/mysqld

# le paquet Alpine active skip-networking par defaut (charge apres 99-custom.cnf)
RUN sed -i 's/^skip-networking/#skip-networking/' /etc/my.cnf.d/mariadb-server.cnf

COPY conf/conf_maria.d /etc/my.cnf.d/99-custom.cnf

COPY tools/mdb_script.sh /usr/local/bin/mdb_script.sh

RUN chmod +x /usr/local/bin/mdb_script.sh

EXPOSE 3306

CMD ["/usr/local/bin/mdb_script.sh"]
