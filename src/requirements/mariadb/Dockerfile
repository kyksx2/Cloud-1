FROM debian:bookworm

RUN apt update -y && apt-get install mariadb-server -y

RUN mkdir -p /run/mysqld && \
    chown mysql:mysql /run/mysqld && \
    chmod 777 /run/mysqld

COPY conf/conf_maria.d /etc/mysql/mariadb.conf.d/99-custom.cnf

COPY tools/mdb_script.sh /usr/local/bin/mdb_script.sh

RUN chmod +x /usr/local/bin/mdb_script.sh

EXPOSE 3306

CMD ["/usr/local/bin/mdb_script.sh"]