./configure --prefix=/usr \
        --sysconfdir=/etc \
        --sbindir=/usr/bin \
        --libexecdir=/usr/lib/$isim \
        --disable-setuid \
        --disable-cache-owner \
        --disable-nls \
        --with-systemdtmpfilesdir=no \
        --with-systemdsystemunitdir=no

make
