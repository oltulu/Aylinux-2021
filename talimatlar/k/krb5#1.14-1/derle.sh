	cd $isim-$surum/src/build-tools
	patch -p1 -i $SRC/$isim-config_LDFLAGS.patch

	cd $SRC/$isim-$surum/src
        sed -e '/KRB5ROOT=/ s/\/local//' -i util/ac_check_krb5.m4

	export CFLAGS="${CFLAGS/-Os/-O2} -I/usr/include/et"

	./configure --prefix=/usr \
                    --localstatedir=/var \
                    --enable-shared \
                    --disable-rpath \
                    --without-tcl \
                    --with-ldap \
                    --with-system-et \
                    --with-system-ss \
                    --without-system-verto

	make