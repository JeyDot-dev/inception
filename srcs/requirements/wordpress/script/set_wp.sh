#!/bin/bash
set -x
php -v
if  wp core is-installed --path=/www ;then
    echo "wordpress already configured"
else
    sleep 10
    rm -rf www/*
    wp core download --path=www
    cp www/wp-config-sample.php www/wp-config.php
    sed -i "s/database_name_here/$(cat /run/secrets/db_name)/" www/wp-config.php
    sed -i "s/username_here/$(cat /run/secrets/db_user)/" www/wp-config.php
    sed -i "s/password_here/$(cat /run/secrets/db_password)/" www/wp-config.php
    sed -i "s/localhost/mariadb/" www/wp-config.php
    sed -i "s/utf8/$CHAR_SET/" www/wp-config.php
    sed -i "s/COLLATE', ''/COLLATE', '$COLLATION'/" www/wp-config.php
    wp core install \
        --path=www \
        --url=https://$SERVER_NAME/ \
        --title=$SITE_TITLE \
        --admin_user=$(cat /run/secrets/wp_admin_name) \
        --admin_password=$(cat /run/secrets/wp_admin_password) \
        --admin_email=$(cat /run/secrets/wp_admin_email) \
        --skip-email
    wp user create $(cat /run/secrets/wp_user_name) \
        --path=www \
        $(cat /run/secrets/wp_user_email) \
        --user_pass=$(cat /run/secrets/wp_user_password) \
        --role=author
    wp theme install typeflow --path=www --activate
    chown -R phpfpm:phpfpm www
    if ! wp core is-installed --path=www ;then
        echo "error during installation"
        exit 1
    fi
fi

exec "$@"
