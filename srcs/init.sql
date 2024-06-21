CREATE DATABASE IF NOT EXISTS mysqldatabase;
CREATE USER 'mysqluser'@'%' IDENTIFIED BY 'mysqlpassword';
GRANT ALL PRIVILEGES ON mysqldatabase.* TO 'mysqluser'@'%';
FLUSH PRIVILEGES;
