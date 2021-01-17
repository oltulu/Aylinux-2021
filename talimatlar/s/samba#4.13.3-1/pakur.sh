cat examples/smb.conf.default | \
	sed 's|log file = .*$|log file = /var/log/samba/%m.log|g' > \
	${PKG}/etc/samba/smb.conf

# fix logrotate
sed -i -e 's|log.%m|%m.log|g' ${PKG}/etc/samba/smb.conf

# fix spool directory
sed -i 's|/usr/spool/samba|/var/spool/samba|g' ${PKG}/etc/samba/smb.conf

# PAM support
install -Dm644 $SRC/samba.pam $PKG/etc/pam.d/samba

# Link cups backend
mkdir -p $PKG/usr/lib/cups/backend
ln -s /usr/bin/smbspool ${PKG}/usr/lib/cups/backend/smb
