cd lua-$surum

make \
TO_BIN='lua5.2 luac5.2' \
TO_LIB="liblua5.2.a liblua5.2.so liblua5.2.so.5.2 liblua5.2.so.$surum" \
INSTALL_DATA='cp -d' \
INSTALL_TOP="$PKG"/usr \
INSTALL_INC="$PKG"/usr/include/lua5.2 \
INSTALL_MAN="$PKG"/usr/share/man/man1 \
install

install -Dm644 lua52.pc "$PKG"/usr/lib/pkgconfig/$isim.pc

ln -s liblua5.2.so "$PKG"/usr/lib/liblua.so.5.2
ln -s liblua5.2.so "$PKG"/usr/lib/liblua.so.$surum

rm -rf "$PKG"/usr/share/man
rm -f  "$PKG"/usr/lib/*.a
