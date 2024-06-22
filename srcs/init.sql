INSTALL COMPONENT 'file://component_validate_password';
CREATE DATABASE IF NOT EXISTS mysqldatabase;
CREATE USER 'mysqluser'@'%' IDENTIFIED BY 'P@ssWord42$';
GRANT ALL PRIVILEGES ON mysqldatabase.* TO 'mysqluser'@'%';
FLUSH PRIVILEGES;
