FROM mysql:8.0

ENV MYSQL_ROOT_PASSWORD=mysqlrootpassword
ENV MYSQL_DATABASE=mysqldatabase
ENV MYSQL_USER=mysqluser
ENV MYSQL_PASSWORD=mysqlpassword

COPY srcs/my.cnf /etc/mysql/my.cnf
COPY srcs/init.sql /docker-entrypoint-initdb.d/
COPY srcs/docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld"]
