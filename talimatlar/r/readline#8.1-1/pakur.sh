make SHLIB_LIBS="-L/lib -lncursesw" DESTDIR=$PKG install

chmod -v u+w $PKG/lib/lib{readline,history}.so.*
ln -sfv /lib/libreadline.so.8.0 $PKG/lib/libreadline.so
ln -sfv /lib/libhistory.so.8.0 $PKG/lib/libhistory.so

rm -rf $PKG/bin
rm -rf $PKG/share/info
rm -rf $PKG/share/doc
