mkdir -pv $PKG/usr/lib/{firmware,udev/devices/pts,udev/devices/shm}
	
mkdir -pv $PKG/usr/lib/udev/rules.d
mkdir -pv $PKG/etc/udev/rules.d

	make DESTDIR=$PKG install

# man sayfalar
pushd man
make DESTDIR=$PKG install-man7 install-man8

cd $SRC
make -j1 -f udev-lfs-20171102/Makefile.lfs DESTDIR=$PKG install


	$PKG/usr/bin/udevadm hwdb --update --root=$PKG
rm -f $PKG/etc/udev/hwdb.bin
rm -rf $PKG/usr/share/doc
rm -rf $PKG/usr/lib/*.la
mkdir -p $PKG/usr/lib/udev/keymaps/force-release
rm -rf $PKG/lib/udev/rules.d
mv $PKG/lib/udev/* $PKG/usr/lib/udev/
rm -rf $PKG/lib
