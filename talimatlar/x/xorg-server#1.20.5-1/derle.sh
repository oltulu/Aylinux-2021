./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var \
--with-xkb-output=/var/lib/xkb \
--enable-glamor \
--with-fontrootdir=/usr/share/fonts \
--enable-install-setuid \
--disable-systemd-logind \
--enable-suid-wrapper
make