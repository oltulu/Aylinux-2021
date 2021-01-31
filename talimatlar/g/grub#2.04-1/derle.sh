cd $SRC
export CFLAGS="${CFLAGS} -Wno-error"
export PYTHON=python3

cp -r "${SRC}/grub-$surum/" ${SRC}/grub-efi
cd ${SRC}/grub-$surum
patch -i /sources/grub2-00_header.diff util/grub.d/00_header.in
patch -i /sources/grub2-10_linux.diff util/grub.d/10_linux.in
./configure --prefix=/usr \
		--sysconfdir=/etc \
		--enable-device-mapper \
		--disable-efiemu \
		--disable-grub-mount
	make
	make DESTDIR=$PKG install

cd ${SRC}/grub-efi
 export CFLAGS="${CFLAGS} -Wno-error"
    export PYTHON=python3

    MODLIST="boot chain configfile fat ext2 linux normal ntfs part_gpt part_msdos"

    for ARCH in i386 x86_64
    do
        mkdir $ARCH
        cd $ARCH
        ../grub-$version/configure --prefix=/usr \
            --with-platform=efi --target=$ARCH \
            --program-prefix=""
        make
        make DESTDIR=$PKG install
        cd grub-core
        ../grub-mkimage -O $ARCH-efi -d . -o grub2-$ARCH.efi -p "" $MODLIST
        cp grub2-$ARCH.efi $PKG/usr/lib/grub/
        cd ../..
    done
 
