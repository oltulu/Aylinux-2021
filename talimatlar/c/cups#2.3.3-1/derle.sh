patch -Np1 -i "${SRC}"/cups-1.6.2-statedir.patch
sed -i -e '5i\ ' conf/cupsd.conf.in
sed -i -e '6i# Disable cups internal logging - use logrotate instead' conf/cupsd.conf.in
sed -i -e '7iMaxLogSize 0' conf/cupsd.conf.in
aclocal -I config-scripts
autoconf -I config-scripts
./configure --prefix=/usr \
--sysconfdir=/etc \
--localstatedir=/var \
--sbindir=/usr/bin \
--libdir=/usr/lib \
--with-logdir=/var/log/cups --enable-acl --enable-dbus --enable-raw-printing --enable-threads --with-dbusdir=/usr/share/dbus-1 --with-logdir=/var/log/cups --with-docdir=/usr/share/cups/doc --with-rundir=/run/cups \
--with-cupsd-file-perm=0755 --with-cups-user=lp --with-cups-group=lp --with-system-groups="lpadmin sys root" --enable-relro --enable-libpaper --enable-pam --enable-ssl --enable-avahi --enable-gnutls \
--with-menudir=/usr/share/applications --with-xinetd=/etc/xinetd.d --with-optim="${CFLAGS}" --disable-systemd --disable-launchd --without-rcdir --without-java --without-perl --without-php --without-python 

make
