#!/bin/bash
/usr/bin/mysqld_safe  &

# 接著跳過授權表訪問,运行出現ERROR 1045 (28000): Access denied for user 'root'@'localhost' (using password: NO)
service mysql stop
mysqld_safe --user=mysql --skip-grant-tables --skip-networking &

service mysql start
sleep 5
lsof -i:3306
mysql -u root -e "CREATE DATABASE hope"
mysql -u root -e "CREATE USER dataturks@'127.0.0.1' IDENTIFIED BY '12345';"
mysql -u root -e "GRANT SELECT, INSERT, UPDATE, DELETE ON hope.* TO dataturks@127.0.0.1;FLUSH PRIVILEGES;"
mysql -u root hope < /home/dataturks/mysqlInit.sql
