mkdir -p $PKG/usr/bin
make BINDIR=$PKG/usr/bin install

install -Dm644 ../syslog.conf "$PKG/etc/syslog.conf"
