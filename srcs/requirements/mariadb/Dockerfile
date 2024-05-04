#MARIADB

FROM    alpine:3.19.1

RUN apk update                          \
    && apk add --no-cache bash vim mysql mysql-client \
    && mkdir -p /var/lib/mysql /run/mysqld \
    && mariadb-install-db --user=mysql --datadir=/var/lib/mysql \
    && chown -R mysql:mysql /run/mysqld /var/lib/mysql \
    && mysql_secure_installation --use-default

USER    mysql
EXPOSE 3306

CMD [ "/usr/bin/mariadb-safe", "--datadir='/var/lib/mysql'" ]
