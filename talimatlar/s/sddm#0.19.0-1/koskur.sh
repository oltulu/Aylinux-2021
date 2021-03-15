if [ -f /etc/init.d/lightdm ];then
	service stop lightdm
	echo "lightdm servisinin kurulu olduğu algılandığı, çakışmayı önlemek için durduruldu"
	service remove lightdm
	echo "lightdm servisi kaldırıldı"
fi
if [ -f /etc/init.d/slim ];then
	service stop slim
	echo "slim servisinin kurulu olduğu algılandığı, çakışmayı önlemek için durduruldu"
	service remove slim
	echo "slim servisi kaldırıldı"
fi
if [ -f /etc/init.d/lxdm ];then
	service stop lxdm
	echo "lxdm servisinin kurulu olduğu algılandığı, çakışmayı önlemek için durduruldu"
	service remove lxdm
	echo "lxdm servisi kaldırıldı"
fi

if ! getent group sddm > /dev/null; then
   groupadd -g 64 sddm
   echo "sddm grubu eklendi"
fi
if ! getent passwd sddm > /dev/null; then
   useradd -c "Simple Desktop Display Manager" \
           -d /var/lib/sddm \
           -u 64 -g sddm    \
           -s /bin/false sddm
           
   passwd -l sddm > /dev/null
   echo "sddm kullanıcısı eklendi"
fi

mkdir -p /var/lib/sddm
chown -R sddm:sddm /var/lib/sddm > /dev/null

