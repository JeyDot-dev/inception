#!/bin/bash
set -x
SCRIPT_DIR=$(dirname "$0")

handle_sudo()
{
    echo "please add GID 1050 www-group to current user (srcs/setup.sh \"username\")"
    exit
}

if [ "$EUID" != 0 ] && [ -z "$(id $NAME | grep 1050)"]; then #IF NOT ROOT
    handle_sudo
elif [ "$EUID" == 0 ]; then #IF ROOT
    if [ -n "$1" ] && [ -z "$(id $1 | grep 1050)" ]; then
        groupadd -g 1050 www-group ; usermod -aG  www-group $1
    else
        echo "Please either don't launch in sudo or add a user (srcs/setup.sh \"user\")"
        exit
    fi
fi


if [[ -e "$SCRIPT_DIR/.env" ]]; then
    echo ".env already exists" 
else
    touch $SCRIPT_DIR/.env
    echo "UID=$(id -u)" >> $SCRIPT_DIR/.env
    echo "GID=$(id -g)" >> $SCRIPT_DIR/.env
    echo "MAKE SURE TO FILL ANY OTHER INFO IN srcs/.env"
#    echo "GID=$(getent group docker | awk -F: '{print $3}')" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
#    echo "" >> $SCRIPT_DIR/.env
fi
