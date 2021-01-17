echo "/etc/lightdm/lightdm.conf dosyası değiştirildi"
sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=hvl-lightdm-greeter/g' /etc/lightdm/lightdm.conf
