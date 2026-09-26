FROM alpine:3.23

RUN apk update && apk add --no-cache mariadb mariadb-client bash

RUN mkdir -p /run/mysqld && \
    chown mysql:mysql /run/mysqld && \
    chmod 777 /run/mysqld

# alpine lit /etc/my.cnf.d/*.cnf (pas /etc/mysql/... = debian). On remplace mariadb-server.cnf
# qui contient 'skip-networking' (sinon wordpress ne peut pas se connecter en TCP)
COPY conf/conf_maria.d /etc/my.cnf.d/mariadb-server.cnf

COPY tools/mdb_script.sh /usr/local/bin/mdb_script.sh

RUN chmod +x /usr/local/bin/mdb_script.sh

EXPOSE 3306

CMD ["/usr/local/bin/mdb_script.sh"]
