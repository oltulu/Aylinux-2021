  getent group mdm >/dev/null 2>&1 || groupadd -g 128 mdm
	getent passwd mdm >/dev/null 2>&1 || usr/sbin/useradd -c 'Linux Mint Display Manager' -u 128 -g mdm -d /var/lib/mdm -s /sbin/nologin mdm
	passwd -l mdm > /dev/null
	chown root:mdm /var/lib/mdm > /dev/null
	chmod 1770 /var/lib/mdm > /dev/null

	gtk-update-icon-cache -q -t -f usr/share/icons/hicolor
	printf "\n Varsayılan olarak tty1 devre dışı bırakılır,"
	printf "\n bunun nedeni tty1 çalışıyorsa, mdm'nin sonsuz bir döngüde  "
	printf "\n otomatik olarak yeniden başlatılması hatasıdır,     "
	printf "\n bu, oturum açma sonrası yaklaşık 1 dakika sürer,   "
	printf "\n lütfen nasıl başa çıkacağınızı bildiğiniz sürece"
	printf "\n getty @ tty1 kullanımını zorlamayın"
	printf "\n Servis kullanımı: # servis baslat mdm"
	printf "\n"
