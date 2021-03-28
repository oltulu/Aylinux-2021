patch -Np1 -i ../fix_apr-config.patch
patch -Np1 -i ../ship_find_apr.m4.patch
patch -Np1 -i ../fix-apr.pc.patch
patch -Np1 -i ../omit_extra_libs.patch
patch -Np1 -i ../dont_override_external_buildflags
patch -Np1 -i /sources/atomic64.patch
sed -e 's/env python/env python2/' -i build/gen-build.py
sed -e 's/python/python2/g' -i build/buildcheck.sh

./buildconf

./configure --prefix=/usr --includedir=/usr/include/apr-1 \
--with-installbuilddir=/usr/share/apr-1/build \
--enable-nonportable-atomics \
--with-devrandom=/dev/urandom --disable-static

make
