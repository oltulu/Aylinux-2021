cd $SRC
cp -a grub-$surum grub-efi

	
  cd $SRC/grub-efi
  	sed 's|/usr/share/fonts/dejavu|/usr/share/fonts/dejavu /usr/share/fonts/TTF|g' -i "configure.ac"
		sed 's|GNU/Linux|Linux|' -i "util/grub.d/10_linux.in"
		./linguas.sh
		./bootstrap \
		--gnulib-srcdir="${SRC}/gnulib/" --no-git
		unset CFLAGS
	unset CPPFLAGS
	unset CXXFLAGS
	unset LDFLAGS
	unset MAKEFLAGS

	echo "Make translations reproducible..."
	sed -i '1i /^PO-Revision-Date:/ d' po/*.sed
	./configure --enable-mm-debug --enable-nls \
	--enable-device-mapper \
	--enable-cache-stats \
	--enable-grub-mkfont \
	--enable-grub-mount \
	--prefix="/usr" \
	--bindir="/usr/bin" \
	--sbindir="/usr/bin" \
	--mandir="/usr/share/man" \
	--infodir="/usr/share/info" \
	--datarootdir="/usr/share" \
	--sysconfdir="/etc" \
	--program-prefix="" \
	--with-bootdir="/boot" \
	--with-grubdir="grub" \
	--disable-silent-rules \
	--disable-werror

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

