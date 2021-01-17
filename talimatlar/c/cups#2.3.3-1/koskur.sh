#!/bin/sh
if [ -z "`getent group lp`" ]; then
	useradd -c "Print Service User" -d /var/spool/cups -g lp -s /bin/false -u 9 lp
fi

if [ -z "`getent group lpadmin`" ]; then
	groupadd -g 19 lpadmin
fi
