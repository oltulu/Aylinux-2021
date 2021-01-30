patch -p1 -d $SRC/$isim-${surum:0:4} -i /sources/$isim-$surum-2.patch
mkdir -v build
cd build
export CFLAGS="-O2 -U_FORTIFY_SOURCE"
 CFLAGS="-O2 -U_FORTIFY_SOURCE -fno-stack-protector"  ../configure --prefix=/usr \
		--libexecdir=/usr/lib \
		--with-headers=/usr/include \
		--enable-kernel=4.9 \
		--enable-add-ons \
		--with-headers=/usr/include  \
		--enable-static-nss \
		--enable-stack-protector=strong \
		--disable-profile \
		--disable-werror \
		--without-gd \
		--enable-multi-arch

 make
