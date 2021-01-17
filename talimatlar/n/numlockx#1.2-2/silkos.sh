echo "/etc/lightdm/lightdm.conf dosyası varsayılan haline döndürüldü"
sed -i 's/greeter-setup-script=numlockx on/#greeter-setup-script=/g' /etc/lightdm/lightdm.conf
