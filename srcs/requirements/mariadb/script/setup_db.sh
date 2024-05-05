#!/bin/bash

set -x


mkdir -p /var/lib/mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql /run/mysqld

if [ ! -e "/var/lib/mysql/wordpress" ]
then
    mariadb-install-db --datadir=/var/lib/mysql --user=mysql
else
    echo "Database already present"
fi

exec "$@"
