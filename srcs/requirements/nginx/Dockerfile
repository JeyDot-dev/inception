#NGINX
FROM alpine:3.18

RUN apk update                          \
    && apk add nginx                    \
    && apk add openssl                  \
    && rm -rf /var/cache/apk/*          \
                                        \
    && mkdir /www                       \
    && mkdir /ssl                       \
    && adduser -D -g 'www' www          \
    && chown -R www:www /var/lib/nginx  www \
    && openssl req -newkey rsa:4096     \
       -x509 -keyout /ssl/jsousa-a.key  \
       -out /ssl/jsousa-a.crt -sha256   \
       -days 500 -nodes -subj           \
       "/C=CH/ST=Vaud/L=Lausanne/O=42Lausanne/OU=42Lausanne/CN=jsousa-a"

COPY conf/nginx.conf /etc/nginx/nginx.conf
#COPY conf/html /www

CMD ["nginx", "-g", "daemon off;"]
