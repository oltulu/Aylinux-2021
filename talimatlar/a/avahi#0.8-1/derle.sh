 NOCONFIGURE=1 ./autogen.sh
 
  ./configure \
    --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --sbindir=/usr/bin \
    with_dbus_sys=/usr/share/dbus-1/system.d \
    --disable-mono \
    --enable-compat-libdns_sd \
    --with-distro=none \
    --with-avahi-priv-access-group=network \
    --with-autoipd-user=avahi \
    --with-autoipd-group=avahi \
     --with-systemdsystemunitdir=no

  sed -i -e 's/ -shared / -Wl,-O1,--as-needed\0/g' libtool

  make
