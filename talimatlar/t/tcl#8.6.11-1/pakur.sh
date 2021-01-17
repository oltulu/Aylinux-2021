cd tcl$surum/unix
make DESTDIR=$PKG install

chmod -v u+w $PKG/tools/lib/libtcl8.6.so
make install-private-headers
ln -sv tclsh8.6 $PKG/tools/bin/tclsh
