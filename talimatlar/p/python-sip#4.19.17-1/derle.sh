mkdir -p build{,-py2,-pyqt5,-pyqt5-py2}

  cd "$SRC"/build
  python3 ../sip-$surum/configure.py CFLAGS="$CFLAGS" LFLAGS="$LDFLAGS"
  make

  cd "$SRC"/build-py2
  python2 ../sip-$surum/configure.py CFLAGS="$CFLAGS" LFLAGS="$LDFLAGS"
  make

  cd "$SRC"/build-pyqt5
  python3 ../sip-$surum/configure.py CFLAGS="$CFLAGS" LFLAGS="$LDFLAGS" --sip-module PyQt5.sip --no-tools
  make

  cd "$SRC"/build-pyqt5-py2
  python2 ../sip-$surum/configure.py CFLAGS="$CFLAGS" LFLAGS="$LDFLAGS" --sip-module PyQt5.sip --no-tools
  make


  cd $SRC/build
  make DESTDIR="$PKG" install -C sipgen
# move sip.h to /usr/include
  mv "$PKG"/usr/include/{python*/sip.h,}

  make DESTDIR="$PKG" install

  cd $SRC/build-py2
  make DESTDIR="$PKG" install

  cd $SRC/build-pyqt5
  make DESTDIR="$PKG" install

  cd $SRC/build-pyqt5-py2
  make DESTDIR="$PKG" install