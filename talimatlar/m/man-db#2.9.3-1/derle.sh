./configure --prefix=/usr \
        --sysconfdir=/etc \
        --libexecdir=/usr/lib/$name \
        --disable-setuid \
        --disable-cache-owner \
        --disable-nls \
        --with-systemdtmpfilesdir=no \
        --with-systemdsystemunitdir=no

make
