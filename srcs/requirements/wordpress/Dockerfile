#WORDPRESS

FROM    alpine:3.19.1

RUN apk update                          \
    && apk --no-cache add bash curl wget tar php82 php82-fpm php82-phar php82-mysqli php82-curl    \
    && addgroup -S phpfpm && adduser -S phpfpm -G phpfpm \
    && mkdir www && chown phpfpm:phpfpm www \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod a+x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
    && wp cli update
   # && wget "http://wordpress.org/latest.tar.gz" \
  #  && tar -xzvf latest.tar.gz    \
 #   && mv wordpress/* www/      \
#    && rm -rf wordpress latest.tar.gz \
#    && sed -i "s/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/" /etc/php82/php-fpm.d/www.conf \
#    && cp www/wp-config-sample.php www/wp-config.php
#    && wp core install --path=www

USER    phpfpm

RUN     wp core download --path=www && \
        cp www/wp-config-sample.php www/wp-config.php

COPY ./config/www.conf /etc/php82/php-fpm.d/
EXPOSE 9000

USER    root
CMD ["/usr/sbin/php-fpm82", "-F"]
