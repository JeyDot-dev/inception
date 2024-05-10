#!/bin/bash

if  [[-e /www/wordpress]];
then
    echo "wordpress already installed"
else
    wp core download --path=www --user=php-fpm
    cp www/wp-config-sample.php www/wp-config.php
fi

exec $@
