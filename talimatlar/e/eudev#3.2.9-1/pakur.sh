mkdir -pv $PKG/usr/lib/{firmware,udev/devices/pts,udev/devices/shm}
	
mkdir -pv $PKG/usr/lib/udev/rules.d
mkdir -pv $PKG/etc/udev/rules.d
if [ -d /tools ];then
	make LD_LIBRARY_PATH=/tools/lib DESTDIR=$PKG install
else
	make DESTDIR=$PKG install
fi
# man sayfalar
pushd man
make DESTDIR=$PKG install-man7 install-man8

cd $SRC
make -j1 -f udev-lfs-20171102/Makefile.lfs DESTDIR=$PKG install

# DB
if [ -d /tools ];then
	LD_LIBRARY_PATH=/tools/lib $PKG/usr/bin/udevadm hwdb --update --root=$PKG
else
	$PKG/usr/bin/udevadm hwdb --update --root=$PKG
fi
rm -f $PKG/etc/udev/hwdb.bin
rm -rf $PKG/usr/share/doc
rm -rf $PKG/usr/lib/*.la
mkdir -p $PKG/usr/lib/udev/keymaps/force-release
rm -rf $PKG/lib/udev/rules.d
mv $PKG/lib/udev/* $PKG/usr/lib/udev/
rm -rf $PKG/lib
