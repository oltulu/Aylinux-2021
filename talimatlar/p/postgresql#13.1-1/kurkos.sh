#!/bin/sh
if [ -z "`getent group postgres`" ]; then
groupadd -g 41 postgres
fi

if [ -z "`getent passwd postgres`" ]; then
	useradd -c "PostgreSQL Server" -g postgres -d /srv/pgsql/data -u 41 postgres
fi
