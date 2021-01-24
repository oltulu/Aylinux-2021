mkdir -v build
cd build

../configure --prefix=/usr \
		--libexecdir=/usr/lib \
		--with-headers=$PKG/usr/include \
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
