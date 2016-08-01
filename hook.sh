#!/bin/sh

case "$1" in
deploy_cert)
	DOMAIN="$2"
	PRIVKEY="$3"
	CERT="$4"
	FULLCHAINCERT="$5"
	CHAINCERT="$6"
	TIMESTAMP="$7"
	if [ -x /usr/sbin/lighttpd -a -f /etc/lighttpd/ligcert.pem ]; then
		echo " + Hook: Overwritting /etc/lighttpd/ligcert.pem and reloading lighttpd..."
		cat "/etc/webapps/letsencrypt.sh/certs/${DOMAIN}/{privkey,fullchain}.pem" > /etc/lighttpd/ligcert.pem
		/sbin/service lighttpd reload
	fi
	if [ -f /etc/nginx/server.pem -a -f /etc/nginx/server.key ]; then
		nginx="nginx-standard"
		[ -x /etc/rc.d/init.d/nginx-light ] && nginx="nginx-light"
		echo " + Hook: Overwritting /etc/nginx/server.{pem,key} and reloading nginx..."
		cat "/etc/webapps/letsencrypt.sh/certs/${DOMAIN}/fullchain.pem" > /etc/nginx/server.pem
		cat "/etc/webapps/letsencrypt.sh/certs/${DOMAIN}/privkey.pem" > /etc/nginx/server.key
		/sbin/service "$nginx" reload
	fi
	if [ -x /etc/rc.d/init.d/httpd ]; then
		echo " + Hook: Reloading apache..."
		/sbin/service httpd graceful
	fi
	;;
clean_challenge)
	CHALLENGE_TOKEN="$2"
	KEYAUTH="$3"
	echo " + Hook: $1: Nothing to do..."
	;;
deploy_challenge)
	echo " + Hook: $1: Nothing to do..."
	;;
unchanged_cert)
	echo " + Hook: $1: Nothing to do..."
	;;
*)
	echo " + Hook: $1: Nothing to do..."
	;;
esac
