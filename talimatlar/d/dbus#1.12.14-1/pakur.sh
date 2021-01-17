    make DESTDIR=$PKG install
	# Adjust some files
	chown -v root:messagebus $PKG/usr/libexec/dbus-daemon-launch-helper
	chmod -v      4750       $PKG/usr/libexec/dbus-daemon-launch-helper
        mkdir -p $PKG/etc/dbus-1
     #   mv ../dbus.system-local.conf $PKG/etc/dbus-1/system-local.conf
	# service
        cd blfs-bootscripts-20190313
        make DESTDIR=$PKG install-dbus
	mkdir -p $PKG/usr/lib/dbus-1.0/services
	mkdir -p $PKG/usr/share/dbus-1/services
	mkdir -p $PKG/etc/dbus-1/system.d/
	mkdir -p $PKG/etc/dbus-1/session.d/
	for i in 2 3 4 5
	do
		mv $PKG/etc/rc.d/rc$i.d/S{29,15}dbus
	done
	for i in 0 1 6
	do
		mv $PKG/etc/rc.d/rc$i.d/K{30,85}dbus
	done