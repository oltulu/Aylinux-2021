echo "/etc/lightdm/lightdm.conf dosyası varsayılan haline döndürüldü"
sed -i 's/greeter-session=hvl-lightdm-greeter/#greeter-session=example-gtk-gnome/g' /etc/lightdm/lightdm.conf
