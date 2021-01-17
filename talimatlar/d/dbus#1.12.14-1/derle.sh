	source /etc/blfs-bootscripts
	wget http://anduin.linuxfromscratch.org/BLFS/blfs-bootscripts/blfs-bootscripts-20190313.tar.xz
	tar xvf blfs-bootscripts-20190313.tar.xz

	cd $isim-$surum
	./configure --prefix=/usr --with-x \
		--localstatedir=/var \
		--disable-doxygen-docs \
		--disable-xml-docs \
		--docdir=/usr/share/doc/$isim-$surum \
		--sysconfdir=/etc \
		--with-console-auth-dir=/run/console \
		--without-systemdsystemunitdir \
		--disable-systemd --disable-static

	make