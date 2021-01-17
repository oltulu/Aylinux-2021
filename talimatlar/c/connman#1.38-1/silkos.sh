#!/bin/sh
if [ -d /var/lib/mps/db/networkmanager ];then
	service install networkmanager
	echo "networkmanager paketinin kurulu olduğu algılandı, servisi yeniden kuruldu"
fi
