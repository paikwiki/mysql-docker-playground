#!/bin/sh

set -e

# Initialize MySQL data directory if it is not already initialized
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MySQL data directory"
    mysqld --initialize-insecure --user=mysql --datadir=/var/lib/mysql
else
    echo "MySQL data directory already initialized"
fi

# Start MySQL in the background
mysqld --defaults-file=/etc/mysql/my.cnf --datadir=/var/lib/mysql &
pid="$!"

# Wait for MySQL to start
until mysqladmin ping --silent; do
    echo "Waiting for database connection..."
    sleep 2
done

# Set root password
echo "Setting root password"
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"

# Run initialization script
if [ -f /docker-entrypoint-initdb.d/init.sql ]; then
    echo "Running initialization script"
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" < /docker-entrypoint-initdb.d/init.sql
fi

# Check if MySQL is running and listening on port 3306
if mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" status | grep -q 'Uptime'; then
    echo "MySQL is running and listening on port 3306"
else
    echo "MySQL is not running or not listening on port 3306"
    exit 1
fi

# Wait for MySQL to finish
wait $pid
