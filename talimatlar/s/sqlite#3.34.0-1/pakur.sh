  cd sqlite-src-3280000
  make DESTDIR=${PKG} install

  install -m755 showdb showjournal showstat4 showwal sqldiff ${PKG}/usr/bin/

  # Manpage kur
  install -m755 -d ${PKG}/usr/share/man/man1
  install -m644 sqlite3.1 ${PKG}/usr/share/man/man1/

  # install manpage
  install -m755 -d ${PKG}/usr/share/man/mann
  install -m644 ${SRC}/sqlite-src-3280000/autoconf/tea/doc/sqlite3.n ${PKG}/usr/share/man/mann/

  # link license
  install -m755 -d ${PKG}/usr/share/licenses
  ln -sf /usr/share/licenses/${isim} "${PKG}/usr/share/licenses/${isim}"

  install -m755 -d ${PKG}/usr/bin
  install -m755 sqlite3_analyzer ${PKG}/usr/bin/
