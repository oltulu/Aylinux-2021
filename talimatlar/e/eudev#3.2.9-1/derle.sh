sed -i '/^Libs:/s/-ludev/-ludev -lrt/' src/libudev/libudev.pc.in


	./configure --prefix=/usr \
        --sysconfdir=/etc \
	--libdir=/usr/lib \
	--sbindir=/usr/bin \
	--with-rootprefix=      \
	--libexecdir=/usr/lib \
	--with-rootlibdir=/usr/lib  \
	--disable-manpages       \
	--disable-static        \
	--config-cache \
	--enable-kmod \
	--disable-gtk-doc-html \
	--with-firmware-path=/usr/lib/firmware  \
        --disable-introspection \
        --enable-split-usr
 make

