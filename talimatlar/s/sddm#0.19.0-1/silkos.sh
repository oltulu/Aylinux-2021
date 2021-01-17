#!/bin/sh
if [ ! -z "$(id sddm)" ]; then
	userdel sddm
	echo "sddm kullanıcısı silindi"
fi
if [ ! -z "$(getent group sddm)" ]; then
	groupdel -f sddm
	echo "sddm grubu silindi"
fi
if [ -d /var/lib/mps/db/lightdm ];then
	service install lightdm
	echo "lightdm paketinin kurulu olduğu algılandı, servisi yeniden kuruldu"
fi
