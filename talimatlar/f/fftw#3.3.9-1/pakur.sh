cd $SRC/$isim-$surum-double
make DESTDIR=$PKG install

cd $SRC/$isim-$surum-long-double
make DESTDIR=$PKG install

cd $SRC/$isim-$surum-single
make DESTDIR=$PKG install  
