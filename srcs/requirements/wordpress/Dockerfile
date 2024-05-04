#WORDPRESS

FROM    alpine:3.19.1

RUN apk update                          \
    && mkdir www                        \
    && apk add bash curl wget tar php82 php82-fpm php82-phar php82-mysqli php82-curl    \
   # && wget "http://wordpress.org/latest.tar.gz" \
  #  && tar -xzvf latest.tar.gz    \
 #   && mv wordpress/* www/      \
#    && rm -rf wordpress latest.tar.gz \
    && curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
    && wp cli update && wp core download --path=www --allow-root \
    && sed -i "s/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/" /etc/php82/php-fpm.d/www.conf 
#    && cp www/wp-config-sample.php www/wp-config.php && wp core install --path=www

#COPY ./config/www.conf /etc/php82/php-fpm.d/
EXPOSE 9000

CMD ["/usr/sbin/php-fpm82", "-F"]
