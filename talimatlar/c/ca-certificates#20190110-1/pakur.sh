mkdir -p $PKG/usr/share/${isim};mkdir -p $PKG/usr/{bin,sbin};mkdir -p $PKG/etc/ssl/certs
make install DESTDIR=${PKG}
install -Dm644 sbin/update-ca-certificates.8 ${PKG}/usr/share/man/man8/update-ca-certificates.8
cd ${PKG}/usr/share/ca-certificates
find . -name '*.crt' | sort | cut -b3- > ${PKG}/etc/ca-certificates.conf
mv ${PKG}/usr/sbin/* ${PKG}/usr/bin
ln -s /etc/ssl/certs/ca-certificates.crt ${PKG}/etc/ssl/certs.pem
rm -rf ${PKG}/usr/sbin
install -d ${PKG}/etc/ca-certificates/update.d
