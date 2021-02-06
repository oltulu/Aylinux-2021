_libdir=usr/lib/gcc/$CHOST/${surum%%+*}
_majorver=${surum%%.*}
cd $SRC/gcc-build
  make -C $CHOST/libgcc DESTDIR="$PKG" install-shared
  rm -f "$PKG/$_libdir/libgcc_eh.a"

  for lib in libatomic \
             libgfortran \
             libgo \
             libgomp \
             libitm \
             libquadmath \
             libsanitizer/{a,l,ub,t}san \
             libstdc++-v3/src \
             libvtv; do
    make -C $CHOST/$lib DESTDIR="$PKG" install-toolexeclibLTLIBRARIES
  done

  make -C $CHOST/libobjc DESTDIR="$PKG" install-libs
  make -C $CHOST/libstdc++-v3/po DESTDIR="$PKG" install

  make -C $CHOST/libphobos DESTDIR="$PKG" install
  rm -rf "$PKG"/$_libdir/include/d/
  rm -f "$PKG"/usr/lib/libgphobos.spec

  for lib in libgomp \
             libitm \
             libquadmath; do
    make -C $CHOST/$lib DESTDIR="$PKG" install-info
  done

 rm -rf "$pkgdir"/usr/lib32/
