#!/bin/sh

# Install MySQL
mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Start MySQL in the background
# --defaults-file 옵션을 통해 설정 파일 경로를 명시적으로 지정
# 💡 명시적으로 지정하지 않을 경우 my.cnf 적용 순서
#   - /etc/my.cnf
#   - /etc/mysql/my.cnf
#   - ~/.my.cnf
# 위 적용 순서로 인해, /etc/mysql/my.cnf 가 적용되지 않으면
# 설정이 제대로 반영되지 않을 수 있음(예: 잘못된 포트를 개방(3306이 아닌 0 포트 이용)
# 확인 버전: mysql  Ver 15.1 Distrib 10.11.8-MariaDB, for Linux (aarch64)
mysqld --defaults-file=/etc/mysql/my.cnf --user=mysql --datadir=/var/lib/mysql &
pid="$!"

# Wait for MySQL to start
until mysqladmin ping --silent; do
    echo "Waiting for database connection..."
    sleep 2
done

# Run initialization script
if [ -f /docker-entrypoint-initdb.d/init.sql ]; then
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" < /docker-entrypoint-initdb.d/init.sql
fi

# Check if MySQL is running and listening on port 3306
if netstat -tuln | grep -q 3306; then
    echo "MySQL is running and listening on port 3306"
else
    echo "MySQL is not running or not listening on port 3306"
    exit 1
fi

# Wait for MySQL to finish
wait $pid
