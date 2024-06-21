FROM alpine:latest

ENV MYSQL_ROOT_PASSWORD=mysqlrootpassword
ENV MYSQL_DATABASE=mysqldatabase
ENV MYSQL_USER=mysqluser
ENV MYSQL_PASSWORD=mysqlpassword

RUN apk update && apk add mysql mysql-client && \
    mkdir -p /run/mysqld && \
    mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql && \
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY srcs/my.cnf /etc/mysql/my.cnf
COPY srcs/init.sql /docker-entrypoint-initdb.d/

COPY srcs/docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld"]
