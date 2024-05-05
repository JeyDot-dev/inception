#MARIADB

FROM    alpine:3.19.1

COPY    ./script/setup_db.sh /scripts/
RUN apk update                          \
    && apk add --no-cache bash vim mysql mysql-client \
    && chmod +x /scripts/setup_db.sh
EXPOSE  3306

ENTRYPOINT [ "/scripts/setup_db.sh" ]
CMD [ "/usr/bin/mariadbd-safe", "--datadir=/var/lib/mysql" ]
