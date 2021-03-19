cd src
make DESTDIR="${PKG}" install
install -Dpm 644 config-files/krb5.conf -t "${PKG}/etc"
install -Dpm 644 config-files/kdc.conf -t "${PKG}/var/lib/krb5kdc"
install -Dm 644 util/ac_check_krb5.m4 -t "${PKG}/usr/share/aclocal"
