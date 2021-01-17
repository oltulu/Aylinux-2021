install -Dm644 $SRC/rsyncd.conf "$PKG/etc/rsyncd.conf"
install -Dm644 $SRC/rsync.xinetd "$PKG/etc/xinetd.d/rsync"
install -Dm755 support/rrsync "$PKG/usr/lib/rsync/rrsync"
