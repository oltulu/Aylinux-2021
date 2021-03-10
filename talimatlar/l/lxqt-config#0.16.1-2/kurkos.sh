#!/bin/sh
if [ -f /var/lib/mps/db/xf86-input-synaptics/kurulan ];then
	paket sil xf86-input-synaptics --ona
	echo "Dokunmatik panel ayarlarında oluşacak sorunu gidermek için xf86-input-synaptics paketi kaldırıldı"	
fi
