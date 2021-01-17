#!/bin/sh
if [ -f /var/lib/mps/db/xf86-input-synaptics/kurulan ];then
	mps sil xf86-input-synaptics --ona
	echo "Dokunmatik fare ayarlarında oluşacak sorunu gidermek için xf86-input-synaptics paketi kaldırıldı"	
fi
