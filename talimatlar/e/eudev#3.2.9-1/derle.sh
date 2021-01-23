sed -r -i 's|/usr(/bin/test)|\1|' test/udev-test.pl

sed -e 's/GROUP="dialout"/GROUP="uucp"/' \
		-e 's/GROUP="tape"/GROUP="storage"/' \
		-e 's/GROUP="cdrom"/GROUP="optical"/' \
		-i rules/*.rules

	./configure --prefix=/usr \
		--with-rootprefix=/usr \
		--sysconfdir=/etc \
		--libdir=/usr/lib \
		--sbindir=/usr/bin \
	--disable-static        \
	--config-cache \
	--enable-kmod \
	--disable-gtk-doc-html \
	--with-firmware-path=/usr/lib/firmware
 make

