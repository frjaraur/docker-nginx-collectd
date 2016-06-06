#!/bin/bash

ACTION=$1

case $ACTION in
	start|START)
		[ ! -n "${COLLECTD_SERVER_NAME}" ] && COLLECTD_SERVER_NAME=localhost
		[ ! -n "${COLLECTD_SERVER_PORT}" ] && COLLECTD_SERVER_PORT=25826

		#	Server "COLLECTD_SERVER" "25826"
		sed -i -e "s/Server .*/Server \"${COLLECTD_SERVER_NAME}\" \"${COLLECTD_SERVER_PORT}\"/g" /etc/collectd/collectd.conf

		# Consul Template
		sed -i -e "s/consul .*/consul = \"${CONSUL_SERVER_NAME}:${CONSUL_SERVER_PORT}\"/g" /etc/consul-template.conf


		exec /usr/bin/supervisord --nodaemon -c /etc/supervisor/supervisord.conf
	;;

	*)
		exec "$@"
	;;

esac
