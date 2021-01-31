sed -i -e 's,freetype/ftsynth.h,freetype2/ftsynth.h,' util/grub-mkfont.c

sed 's|GNU/Linux|Linux|' -i "util/grub.d/10_linux.in"

unset CFLAGS
unset CPPFLAGS
unset CXXFLAGS
unset LDFLAGS
unset MAKEFLAGS

common_confs+="--enable-device-mapper --enable-cache-stats --enable-nls
--enable-grub-mkfont --enable-grub-mount --disable-werror --enable-boot-time"

# fix unifont.bdf location so grub-mkfont can create *.pf2 files
sed -i 's|/usr/share/fonts/unifont|/usr/share/fonts/misc|' configure

cp -r "${SRC}/grub-$surum/" ${SRC}/grub-efi

./configure --prefix=/usr \
		--sysconfdir=/etc \
		--enable-device-mapper \
		--disable-efiemu \
		--disable-grub-mount
	make

cd ${SRC}/grub-efi
#/autogen.sh
configure --prefix=/usr \
            --with-platform=efi --target=$ARCH \
            --program-prefix=""
        
make
