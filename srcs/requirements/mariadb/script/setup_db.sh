#!/bin/bash

set -x

groupmod -g 1050 mysql
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

if [ ! -e "/var/lib/mysql/wordpress" ]
then
    mariadb-install-db --datadir=/var/lib/mysql --user=mysql
else
    echo "Database already present"
fi

exec "$@"
