cd grub
#sed -i -e 's,freetype/ftsynth.h,freetype2/ftsynth.h,' util/grub-mkfont.c
#patch -Np1 -i "/sources/0005-grub-install-fix-inverted-test-for-NLS-enabled-when-.patch"

sed 's|GNU/Linux|Linux|' -i "util/grub.d/10_linux.in"

export CFLAGS="${CFLAGS} -Wno-error"
export PYTHON=python3
unset MAKEFLAGS
CFLAGS+=" -fno-stack-protector"
common_confs+="--enable-device-mapper --enable-cache-stats --enable-nls
--enable-grub-mkfont --enable-grub-mount --disable-werror --enable-boot-time"

# fix unifont.bdf location so grub-mkfont can create *.pf2 files
#sed -i 's|/usr/share/fonts/unifont|/usr/share/fonts/misc|' configure

cp -r "${SRC}/grub" ${SRC}/grub-efi
./bootstrap --gnulib-srcdir="${SRC}/gnulib/" --no-git
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
