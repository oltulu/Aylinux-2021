if [ -f /etc/init.d/lightdm ];then
	service stop lightdm
	echo "lightdm servisinin kurulu olduğu algılandığı, Çakışmayı önlemek için durduruldu"
	service remove lightdm
	echo "lightdm servisi kaldırıldı"
fi
if [ -f /etc/init.d/sddm ];then
	service stop sddm
	echo "sddm servisinin kurulu olduğu algılandığı, Çakışmayı önlemek için durduruldu"
	service remove sddm
	echo "sddm servisi kaldırıldı"
fi
if [ -f /etc/init.d/lxdm ];then
	service stop lxdm
	echo "lxdm servisinin kurulu olduğu algılandığı, Çakışmayı önlemek için durduruldu"
	service remove lxdm
	echo "lxdm servisi kaldırıldı"
fi
echo "slim kurulum için hazır"
