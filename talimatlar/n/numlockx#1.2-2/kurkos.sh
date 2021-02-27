if [ -f /etc/lightdm/lightdm.conf ];then
echo "/etc/lightdm/lightdm.conf dosyası değiştirildi"
sed -i 's/#greeter-setup-script=/greeter-setup-script=numlockx on/g' /etc/lightdm/lightdm.conf
fi
