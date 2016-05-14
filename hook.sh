#!/bin/sh

case "$1" in
deploy_cert)
	echo " + Hook: Restarting Webserver..."
	/sbin/service lighttpd reload
	;;
*)
	echo " + Hook: $1: Nothing to do..."
	;;
esac
