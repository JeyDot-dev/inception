#WORDPRESS

FROM    alpine:3.19.1

RUN apk update                          \
    && mkdir www                        \
    && apk add bash wget tar php php-fpm     \
    && wget "http://wordpress.org/latest.tar.gz" \
    && tar -xzvf latest.tar.gz    \
    && mv wordpress/* www/      \
    && rm -rf wordpress latest.tar.gz

EXPOSE 9000

CMD ["/usr/sbin/php-fpm82", "-F"]
