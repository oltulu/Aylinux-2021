if [ -z "$(getent group dnsmasq)" ]; then
	/usr/bin/groupadd -r dnsmasq
fi
