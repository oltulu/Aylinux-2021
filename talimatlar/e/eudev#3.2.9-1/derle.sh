cd eudev
	sed -e 's/GROUP="dialout"/GROUP="uucp"/' \
		-e 's/GROUP="tape"/GROUP="storage"/' \
		-e 's/GROUP="cdrom"/GROUP="optical"/' \
		-i rules/*.rules
	./autogen.sh
	./configure \
		--prefix=/usr \
		--with-rootprefix=/usr \
		--sysconfdir=/etc \
		--libdir=/usr/lib \
		--sbindir=/usr/bin \
		--enable-introspection \
		--enable-kmod \
		--disable-manpages \
		--enable-split-usr

	make
