cd $SRC
cp -a grub-$surum grub-efi

	
  cd $SRC/grub-efi
	./configure --prefix=/usr \
		--sysconfdir=/etc       \
		--sbindir=/usr/bin        \
		--enable-device-mapper \
		--disable-efiemu \
		--disable-grub-mount  \
                --with-platform=efi

make
	mkdir $SRC/dest
	make DESTDIR=$SRC/dest install
        install -d $PKG/boot/grub
	install -Dm644 ../grub.cfg \
	$PKG/boot/grub/grub.cfg.exemple

	cp -r $SRC/dest/usr/lib/grub/x86_64-efi $PKG/usr/lib/grub/
	
	cd $SRC/grub-$surum
	./configure --prefix=/usr \
		--sysconfdir=/etc       \
		--sbindir=/usr/bin        \
		--infodir=/usr/share/info \
                --with-platform=pc \
                --disable-efiemu \
                --disable-werror

	make
	make DESTDIR=$PKG install

