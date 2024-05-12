#!/bin/bash

set -x


mkdir -p /var/lib/mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql /run/mysqld

if [ ! -e "/var/lib/mysql/$(cat /run/secrets/db_name)" ]
then
    mariadb-install-db --datadir=/var/lib/mysql --user=mysql
    mysqld --user=mysql --datadir=/var/lib/mysql &
    sleep 4
    mariadb -e "CREATE DATABASE $(cat /run/secrets/db_name) CHARACTER SET $CHAR_SET COLLATE $COLLATION;"
    mariadb -e "CREATE USER '$(cat /run/secrets/db_user)'@'%' IDENTIFIED BY '$(cat /run/secrets/db_password)';"
    mariadb -e "GRANT ALL PRIVILEGES ON $(cat /run/secrets/db_name).* TO '$(cat /run/secrets/db_user)'@'%';"
    mariadb -e "FLUSH PRIVILEGES;"
    mysqladmin shutdown

else
    echo "Database already present"
fi

exec "$@"
