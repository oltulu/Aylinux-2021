cp ${SRC}/docbook-style-dsssl.Makefile Makefile
make install \
     BINDIR="${PKG}/usr/bin" \
     DESTDIR="${PKG}/usr/share/sgml/docbook/dsssl-stylesheets-${surum}" \
     MANDIR="${PKG}/usr/share/man"
  
  ln -s dsssl-stylesheets-${surum} ${PKG}/usr/share/sgml/docbook/dsssl-stylesheets