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
if [ -f /etc/init.d/slim ];then
	service stop slim
	echo "slim servisinin kurulu olduğu algılandığı, Çakışmayı önlemek için durduruldu"
	service remove slim
	echo "slim servisi kaldırıldı"
fi
echo "Lxdm kurulum için hazır"
