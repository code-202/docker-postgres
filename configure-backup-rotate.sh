#!/bin/sh
set -e

POSTGRES_DB=${POSTGRES_DB:-""}

if [ "$POSTGRES_DB" == "" ]; then
    read -p "What is your database name ? " POSTGRES_DB
fi

POSTGRES_USER=${POSTGRES_USER:-""}

if [ "$POSTGRES_USER" == "" ]; then
    read -p "What is your user name ? " POSTGRES_USER
fi

if [ ! -d /var/backups ]; then
    mkdir /var/backups
fi

DUMP_FILE=/var/backups/$POSTGRES_DB.sql
BACKUP_FILE=$DUMP_FILE.gz
LOGROTATE_FILE=/etc/logrotate.d/$POSTGRES_DB-dump

if [ -e $LOGROTATE_FILE ]; then
    echo "[i] $LOGROTATE_FILE already present, skipping creation"
else
    echo "[i] $LOGROTATE_FILE not found, creating file"
    if [ ! -e $BACKUP_FILE ];
    then
        echo "Create an empty file $BACKUP_FILE"
        touch $BACKUP_FILE
    fi


    cat << EOF > $LOGROTATE_FILE
$BACKUP_FILE {
    daily
    rotate 7
    nocompress
    create 640 root root
    postrotate
        pg_dump -U $POSTGRES_USER -w -d $POSTGRES_DB > $DUMP_FILE
        gzip -9f $DUMP_FILE
    endscript
}
EOF

    #logrotate -vf $LOGROTATE_FILE
fi

crond_running=$(ps aux | grep crond | wc -l)
if [ $crond_running == 1 ]; then
    echo "crond is not running, we start it"
    crond
fi
