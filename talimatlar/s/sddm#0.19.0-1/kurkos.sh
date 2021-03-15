#. /lib/lsb/init-functions
sed -i "s/^id:[3-5]/id:5/" /etc/inittab
echo  "/etc/inittab dosyasında varsayılan init 5 olarak ayarlandı"
