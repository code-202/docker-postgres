#!/bin/sh

/usr/sbin/logrotate /etc/logrotate.conf

EXITVALUE=$?

if [ $EXITVALUE != 0 ]; then
    /usr/bin/logger -t logrotate "ALERT exited anormally with [$EXITVALUE]"
fi

exit 0
