FROM nginx:1.15-alpine
RUN rm -f /var/log/nginx/access.log /var/log/nginx/error.log &&\
    touch /var/log/nginx/access.log /var/log/nginx/error.log &&\
    echo -e '#!/bin/sh\ndatetime(){\n    TZ="Asia/Shanghai" /bin/date "+%Y%m%d%H%M"\n}\nDATE_TIME=$(datetime)\n/bin/mv /var/log/nginx/access.log /var/log/nginx/access.${DATE_TIME}.log\n/bin/mv /var/log/nginx/error.log /var/log/nginx/error.${DATE_TIME}.log\n/bin/kill -USR1 `/bin/cat /var/run/nginx.pid`' > /etc/periodic/hourly/rotatelog.sh &&\
    chmod u+x /etc/periodic/hourly/rotatelog.sh &&\
    echo -e '#!/bin/sh\n/usr/sbin/nginx -s stop &>/dev/null\n/usr/sbin/nginx 1>/dev/null\n/usr/bin/tail -f /var/log/nginx/access.log /var/log/nginx/error.log >/dev/stdout' >/start.sh
CMD ["/bin/sh", "/start.sh"]
