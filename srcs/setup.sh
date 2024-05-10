#!/bin/bash
SERVER_USER=""
DIR_HOME="/home/$1/data"
DB="$DIR_HOME/db-volume"
WP="$DIR_HOME/wordpress-volume"

set -x
SCRIPT_DIR=$(dirname "$0")

handle_sudo()
{
    echo "please add GID 1050 www-group to current user (srcs/setup.sh \"username\")"
    exit 1
}
#CREATE GROUPE AND ADD USER TO GROUPE
if [ "$EUID" != 0 ] && [ -z "$(id $USER | grep 1050)"]; then #IF NOT ROOT
    handle_sudo
elif [ "$EUID" == 0 ] && [ "$SERVER_USER" != "create" ]; then #IF ROOT
    if [ -n "$SERVER_USER" ] && [ -z "$(id $SERVER_USER | grep 1050)" ]; then
        groupadd -g 1050 www-group ; usermod -aG  www-group $SERVER_USER
        mkdir -m 770 -p $DB $WP
        chown :www-group $DB $WP
    else
        echo "User doesn't have the right GID, please use script with root privileges.\
\nALSO change SERVER_USER's value to your username at the top of the script"
        exit 1
    fi
fi
#CREATE AND SET BIND FOLDER PERMISSIONS
if [ ! -d "$DB" ] || [ ! -d "$WP" ] || [$1 == "create"] ; then
    if [ "$EUID" == 0 ]; then #IF ROOT
        mkdir -m 770 -p $DB $WP
        chown :www-group $DB $WP
    else
        "Mount bind directories do not exist, please relaunch the script with root privileges and arg \"create\""
        exit 1
    fi
fi

if [[ -e "$SCRIPT_DIR/.env" ]]; then
    echo ".env already exists" 
else
    touch $SCRIPT_DIR/.env
    chmod 333 $SCRIPT_DIR/.env
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
