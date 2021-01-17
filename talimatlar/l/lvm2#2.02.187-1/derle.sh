./configure $confopt \
--prefix=/usr --sbindir=/usr/bin --sysconfdir=/etc --localstatedir=/var --enable-applib \
--enable-cmdlib \
--enable-pkgconfig \
--enable-udev_sync \
--enable-dmeventd \
--with-udev-prefix=/usr
make
