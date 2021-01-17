make DESTDIR=$PKG install
	
# minilzo konumlandırma
install -m 755 libminilzo.so.0 ${PKG}/usr/lib
install -p -m 644 minilzo/minilzo.h ${PKG}/usr/include/lzo
cd ${PKG}/usr/lib
ln -s libminilzo.so.0 libminilzo.so

rm -rf $PKG/usr/lib/*.a
