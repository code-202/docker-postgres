#!/bin/sh
set -e

if [ "$POSTGRES_DB" != "" ] && [ "$POSTGRES_USER" != "" ]; then
    /configure-backup-rotate.sh >> /dev/null
fi

exec "$@"
