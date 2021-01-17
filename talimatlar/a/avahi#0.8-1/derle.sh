ekconf="--disable-qt3 --disable-qt4 --disable-mono --disable-monodoc
 --disable-doxygen-doc --enable-compat-libdns_sd --enable-compat-howl
 --with-xml=expat --with-avahi-user=avahi --with-avahi-group=avahi --with-autoipd-user=avahi
 --with-autoipd-group=avahi --with-distro=none --disable-xmltoman
 --disable-static ssp_cv_lib=no
 with_dbus_sys=/usr/share/dbus-1/system.d 
 --disable-python --disable-gtk
 --disable-gtk3 --sbindir=/usr/bin
 --with-systemdsystemunitdir=no"

autoreconf -if

sed -e 's,\(avahi_runtime_dir=\).*,\1\"/run\",' -i configure
