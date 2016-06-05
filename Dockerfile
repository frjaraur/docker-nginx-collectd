FROM debian
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    nginx collectd supervisor wget unzip

COPY nginx.conf /etc/nginx/nginx,conf

COPY collectd.conf /etc/collectd/collectd.conf

COPY supervisor_collectd.conf /etc/supervisor/conf.d/supervisor_collectd.conf

COPY supervisor_nginx.conf /etc/supervisor/conf.d/supsupervisor_consul-template.confervisor_nginx.conf

COPY supervisor_consul-template.conf  /etc/supervisor/conf.d/supervisor_consul-template.conf

COPY consul-template.conf /etc/consul-template.conf

COPY nginx.conf.ctmpl /etc/nginx.conf.ctmpl

WORKDIR /tmp

RUN wget --no-check-certificate https://releases.hashicorp.com/consul-template/0.14.0/consul-template_0.14.0_linux_amd64.zip -O consul-template.zip && \
  unzip consul-template.zip -d /usr/bin

COPY entrypoint.sh /entrypoint.sh

ENV COLLECTD_SERVER_NAME "testserver"

ENV COLLECTD_SERVER_PORT 9090

ENV CONSUL_SERVER_NAME "testserver"

ENV CONSUL_SERVER_PORT 9091

ENTRYPOINT ["/entrypoint.sh"]

CMD ["start"]
