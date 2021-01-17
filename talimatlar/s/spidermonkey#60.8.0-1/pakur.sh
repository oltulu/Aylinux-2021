cd $SRC/firefox-${surum}/obj
make DESTDIR=$PKG install
rm "$PKG"/usr/lib/*.ajs
find "$PKG"/usr/{lib/pkgconfig,include} -type f -exec chmod -c a-x {} +
