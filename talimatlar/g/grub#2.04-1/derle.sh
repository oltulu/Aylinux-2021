cd $SRC
cp -a grub grub-efi

	cd grub
	./configure --prefix=/usr \
		--sysconfdir=/etc       \
		--sbindir=/usr/bin        \
		--infodir=/usr/share/info \
                --with-platform=pc \
                --disable-efiemu \
                --disable-werror

	make
	make DESTDIR=$PKG install

  cd ../grub-efi
	./configure --prefix=/usr \
		--sysconfdir=/etc       \
		--sbindir=/usr/bin        \
		--disable-efiemu \
		--infodir=/usr/share/info \
                --with-platform=efi \
		--disable-werror
	make
	mkdir $SRC/dest
	make DESTDIR=$SRC/dest install
        install -d $PKG/boot/grub
	install -Dm644 ../grub.cfg \
	$PKG/boot/grub/grub.cfg.exemple

	cp -r $SRC/dest/usr/lib/grub/x86_64-efi $PKG/usr/lib/grub/
