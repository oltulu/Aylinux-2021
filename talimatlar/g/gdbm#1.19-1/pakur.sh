# uyumluluk için kısayolların atanması
install -dm755 "$PKG/usr/include/gdbm"
ln -sf ../gdbm.h "$PKG/usr/include/gdbm/gdbm.h"
ln -sf ../ndbm.h "$PKG/usr/include/gdbm/ndbm.h"
ln -sf ../dbm.h  "$PKG/usr/include/gdbm/dbm.h"
rm -rf $PKG/usr/lib/*.a
