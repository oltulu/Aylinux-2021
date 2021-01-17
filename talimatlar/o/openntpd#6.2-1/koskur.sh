#!/bin/sh
if [ -z "`getent group ntp`" ]; then
groupadd -fg 87 ntp
fi

if [ -z "`getent passwd ntp`" ]; then
useradd -c "Network Time Protocol" -d /var/lib/ntp -u 87 -g ntp -s /bin/false ntp
fi
