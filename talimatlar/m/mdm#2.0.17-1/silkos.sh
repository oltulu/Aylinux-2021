  gtk-update-icon-cache -q -t -f usr/share/icons/hicolor
	getent passwd mdm || userdel mdm
	getent group mdm || groupdel mdm
