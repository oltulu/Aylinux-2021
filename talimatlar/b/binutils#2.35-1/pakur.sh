cd build

make DESTDIR=$PKG install

make -C ld clean
make -C ld LIB_PATH=/usr/lib:/lib
cp -v ld/ld-new $PKG/tools/bin
