cd "${SRC}"/lmdb-LMDB_${surum}/libraries/liblmdb
install -dm755 "${PKG}"/usr/{bin,lib,include,man/man1,share}
make DESTDIR="${PKG}" prefix=/usr install
mv "${PKG}"/usr/man "${PKG}"/usr/share/man
install -Dm644 "${SRC}"/lmdb.pc "${PKG}"/usr/lib/pkgconfig/lmdb.pc
rm -f $PKG/usr/lib/*.a
