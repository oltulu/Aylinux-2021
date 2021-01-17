if [ ! -z "$(id ntp)" ]; then
	userdel ntp
fi
if [ ! -z "$(getent group ntp)" ]; then
	groupdel -f ntp
fi
