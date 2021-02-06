cd $SRC/eudev
mkdir -pv $PKG/usr/lib/{firmware,udev/devices/pts,udev/devices/shm}
	
mkdir -pv $PKG/usr/lib/udev/rules.d
make CFLAGS="$CFLAGS -D_GNU_SOURCE"
    make install DESTDIR=$PKG
    make -C man install DESTDIR=$PKG

 # create binary hwdb
    LD_LIBRARY_PATH=$PKG/usr/lib $PKG/usr/bin/udevadm hwdb --update --root=$PKG


    # Devices
    install -d $PKG/usr/lib/{firmware,udev/devices/{pts,shm}}
    install -d $PKG/run

    # Add CRUX items
 #   install -m 0755 $SRC/start_udev $PKG/usr/bin
 #   install -m 0644 $SRC/81-crux.rules $PKG/usr/lib/udev/rules.d
