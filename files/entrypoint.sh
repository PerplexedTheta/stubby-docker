#!/usr/bin/env bash

if [[ $EUID -eq 0 ]]; then
	/usr/bin/apt update
	/usr/bin/apt install -y openssl stubby
fi

if [[ ! -f "/etc/stubby/stubby.yml" ]]; then
	/usr/bin/cp -v /stubby.example.yml /etc/stubby/stubby.yml
fi

exec /usr/bin/stubby -l -C /etc/stubby/stubby.yml
