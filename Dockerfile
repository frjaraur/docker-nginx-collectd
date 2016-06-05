FROM debian
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    nginx collectd supervisor

COPY nginx.conf /etc/nginx/nginx,conf

COPY collectd.conf /etc/collectd/collectd.conf

COPY supervisor_collectd.conf /etc/supervisor/conf.d/supervisor_collectd.conf

COPY supervisor_nginx.conf /etc/supervisor/conf.d/supervisor_nginx.conf

COPY entrypoint.sh /entrypoint.sh

ENV COLLECTD_SERVER_NAME "testserver"

ENV COLLECTD_SERVER_PORT 9090

ENTRYPOINT ["/entrypoint.sh"]

CMD ["start"]
