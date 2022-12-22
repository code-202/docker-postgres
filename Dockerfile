FROM postgres:11-alpine

MAINTAINER jn.germon@code202.fr

RUN apk update && \
    apk add \
        logrotate \
    && rm -rf /var/cache/apk/*

# make life easier
ENV TERM xterm

COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

COPY configure-backup-rotate.sh /configure-backup-rotate.sh
RUN chmod a+x /configure-backup-rotate.sh

COPY cron-logrotate.sh /etc/periodic/daily/logrotate
RUN chmod a+x /etc/periodic/daily/logrotate

ENTRYPOINT ["/entrypoint.sh", "/usr/local/bin/docker-entrypoint.sh"]

CMD ["postgres"]
