if [ ! -z "$(getent group dnsmasq)" ]; then
	/usr/bin/groupdel -r dnsmasq
fi
