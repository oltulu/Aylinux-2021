sed -r -i 's|/usr(/bin/test)|\1|' test/udev-test.pl

if [ -d /tools ];then
cat > config.cache << "EOF"
HAVE_BLKID=1
BLKID_LIBS="-lblkid"
BLKID_CFLAGS="-I/tools/include"
EOF
fi

	./configure $confopt \
	--with-rootprefix=      \
	--with-rootlibdir=/usr/lib  \
	--enable-manpages       \
	--disable-static        \
	--config-cache \
	--enable-kmod \
	--disable-gtk-doc-html \
	--with-firmware-path=/usr/lib/firmware
	
	if [ -d /tools ];then
		LIBRARY_PATH=/tools/lib make
	else
		make
	fi
