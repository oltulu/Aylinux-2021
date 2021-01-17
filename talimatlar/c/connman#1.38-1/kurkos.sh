#!/bin/sh
if [ -f /etc/init.d/networkmanager ];then
	service stop networkmanager
	echo "networkmanager servisinin kurulu olduğu algılandığı, çakışmayı önlemek için durduruldu"
	service remove networkmanager
	echo "networkmanager servisi kaldırıldı"
fi
