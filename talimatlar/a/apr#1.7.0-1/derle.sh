 ./configure --prefix=/usr \
                --with-installbuilddir=/usr/share/apr-1 
    make 
    make -j1 DESTDIR=$PKG install

    cd $SRC/$isim-util-1.6.1
    ./configure --prefix=/usr \
                --with-apr=$SRC/$isim-$surum \
                --with-expat=/usr \
                --with-berkeley-db=/usr \
                --with-gdbm=/usr \
                --without-sqlite3 \
                --disable-util-dso
    make
    make DESTDIR=$PKG install
