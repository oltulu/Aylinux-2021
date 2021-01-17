./configure --prefix=/usr \
--disable-rpath \
--disable-rpath-install \
--bundled-libraries=NONE \
--builtin-libraries=replace \
--with-modulesdir=/usr/lib/ldb/modules \
--with-privatelibdir=/usr/lib/ldb
make
