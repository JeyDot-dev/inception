#MARIADB

FROM    alpine:3.18

COPY    ./script/setup_db.sh /scripts/
COPY    ./conf/mariadb-server.cnf /etc/my.cnf.d/

RUN apk update                          \
    && apk add --no-cache bash vim mysql mysql-client \
    && chmod +x /scripts/setup_db.sh


EXPOSE  3306

STOPSIGNAL SIGTERM

ENTRYPOINT [ "/scripts/setup_db.sh" ]

CMD [ "/usr/bin/mariadbd-safe", "--datadir=/var/lib/mysql", "--user=mysql", "--bind-address=0.0.0.0" ]
