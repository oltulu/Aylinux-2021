sed -i -e 's,freetype/ftsynth.h,freetype2/ftsynth.h,' util/grub-mkfont.c

sed 's|GNU/Linux|Linux|' -i "util/grub.d/10_linux.in"

./bootstrap --gnulib-srcdir="${SRC}/gnulib-9ce9be2ef0cb1180e35dfe9dfbbe90d774b374bd/" --no-git

unset CFLAGS
unset CPPFLAGS
unset CXXFLAGS
unset LDFLAGS
unset MAKEFLAGS

common_confs+="--enable-device-mapper --enable-cache-stats --enable-nls
--enable-grub-mount --enable-boot-time"
# --enable-grub-mkfont
# fix unifont.bdf location so grub-mkfont can create *.pf2 files
sed -i 's|/usr/share/fonts/unifont|/usr/share/fonts/misc|' configure

#patch grub-core/disk/mdraid1x_linux.c $SRC/mdraid1x-gcc10.patch
#patch -Np1 -i $SRC/zsf-grub-gcc10.patch

cp -r "${SRC}/grub-8fcfd1e0fc72d58766ce3dc09cf883c032f063f6/" ${SRC}/grub-efi


export M4=m4
./configure $CONF_OPT \
--with-platform="pc" \
--target="i386" \
--enable-efiemu \
$common_conf
make

cd ${SRC}/grub-efi
./autogen.sh
./configure $CONF_OPT \
--with-platform="efi" \
--target="x86_64" \
--disable-efiemu \
$common_conf
make
