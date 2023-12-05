#! /bin/bash

_tls_san() {
	{
		ip -oneline address | awk '{ gsub(/\/.+$/, "", $4); print "IP:" $4 }'
		{
			cat /etc/hostname
			echo 'docker'
			echo 'localhost'
			hostname -f
			hostname -s
		} | sed 's/^/DNS:/'
		[ -z "${DOCKER_TLS_SAN:-}" ] || echo "$DOCKER_TLS_SAN"
	} | sort -u | xargs printf '%s,' | sed "s/,\$//"
}


$(_tls_san)