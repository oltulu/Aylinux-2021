#!/bin/sh

if [ -z "$(getent group pulse)" ]; then
	/usr/bin/groupadd -r pulse
fi

if [ -z "$(getent group pulse-access)" ]; then
	/usr/bin/groupadd -r pulse-access
fi

if [ -z "$(getent passwd pulse)" ]; then
	/usr/bin/useradd -r -g pulse -d /var/run/pulse -s /bin/false -c "Pulseaudio System User" pulse
	/usr/bin/passwd -l pulse
fi

gpasswd -a pulse audio
