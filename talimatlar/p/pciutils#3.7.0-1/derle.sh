make OPT="${CFLAGS} -fPIC -DPIC" ZLIB=no SHARED=no PREFIX=/usr SHAREDIR=/usr/share/hwdata MANDIR=/usr/share/man SBINDIR=/usr/bin lib/libpci.a 
cp lib/libpci.a "$SRC/"
make clean
make OPT="${CFLAGS}" ZLIB=no SHARED=yes PREFIX=/usr SBINDIR=/usr/bin SHAREDIR=/usr/share/hwdata MANDIR=/usr/share/man all
