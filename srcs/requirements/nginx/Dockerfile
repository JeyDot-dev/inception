FROM alpine:3.19.1

RUN apk update                          \
    && apk add nginx                    \
    && apk add openssl                  \
    && rm -rf /var/cache/apk/*          \
                                        \
    && mkdir /www                       \
    && mkdir /img                       \
    && mkdir /ssl                       \
    && adduser -D -g 'www' www          \
    && chown -R www:www /var/lib/nginx  \
    && chown -R www:www /www            \
    && chown -R www:www /img            \
    && openssl req -newkey rsa:4096     \
       -x509 -keyout /ssl/jsousa-a.key  \
       -out /ssl/jsousa-a.crt -sha256   \
       -days 500 -nodes -subj           \
       "/C=CH/ST=Vaud/L=Lausanne/O=42Lausanne/OU=42Lausanne/CN=jsousa-a"

COPY conf/html /www
COPY conf/img /img
COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80/tcp

CMD ["nginx", "-g", "daemon off;"]
