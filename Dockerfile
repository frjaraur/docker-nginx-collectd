FROM debian
RUN apt-get -qq update && \
    apt-get  -qq install --no-install-recommends \
    nginx collectd supervisor wget unzip

COPY config /config

COPY  supervisor /etc/supervisor/conf.d/

COPY templates /templates

WORKDIR /tmp

RUN wget -q --no-check-certificate https://releases.hashicorp.com/consul-template/0.14.0/consul-template_0.14.0_linux_amd64.zip -O consul-template.zip && \
  unzip consul-template.zip -d /usr/bin

COPY entrypoint.sh /entrypoint.sh

ENV COLLECTD_SERVER_NAME "collectdserver"

ENV COLLECTD_SERVER_PORT 9090

ENV CONSUL_SERVER_NAME "consulserver"

ENV CONSUL_SERVER_PORT 9091

ENTRYPOINT ["/entrypoint.sh"]

CMD ["start"]
