#!/bin/bash

ACTION=$1

case $ACTION in
	start|START)
		[ ! -n "${COLLECTD_SERVER_NAME}" ] && COLLECTD_SERVER_NAME=localhost
		[ ! -n "${COLLECTD_SERVER_PORT}" ] && COLLECTD_SERVER_PORT=25826

		#	Server "COLLECTD_SERVER" "25826"
		sed -i -e "s/Server .*/Server \"${COLLECTD_SERVER_NAME}\" \"${COLLECTD_SERVER_PORT}\"/g" /etc/collectd/collectd.conf

		exec /usr/bin/supervisord --nodaemon -c /etc/supervisor/supervisord.conf
	;;

	control)

		exec /usr/bin/supervisorctl -c /etc/supervisor/supervisord.conf
	;;

	*)
		exec "$@"
	;;

esac
