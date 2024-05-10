#!/bin/bash

if  [[-e /www/wordpress]];
then
    echo "wordpress already installed"
else
    wp core download --path=www
    cp www/wp-config-sample.php www/wp-config.php
fi
