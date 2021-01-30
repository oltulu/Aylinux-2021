make DESTDIR=$PKG install

install -d $PKG/lib
mv -v $PKG/usr/lib/libnss_win{s,bind}.so*   $PKG/lib
ln -v -sf /lib/libnss_winbind.so.2 $PKG/usr/lib/libnss_winbind.so
ln -v -sf /lib/libnss_wins.so.2    $PKG/usr/lib/libnss_wins.so
   
install -v -m644 examples/smb.conf.default $PKG/etc/samba/smb.conf.default

mkdir -pv $PKG/etc/openldap/schema
install -v -m644 examples/LDAP/README \
$PKG/etc/openldap/schema/README.LDAP

install -v -m644 examples/LDAP/samba* \
$PKG/etc/openldap/schema

install -v -m755 examples/LDAP/{get*,ol*} \
$PKG/etc/openldap/schema


#  cups 
cd $PKG/usr/lib/
install -d cups/backend
ln -v -sf /usr/bin/smbspool $PKG/usr/lib/cups/backend/smb
