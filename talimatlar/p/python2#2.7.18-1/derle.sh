  # Temporary workaround for FS#22322
  # See http://bugs.python.org/issue10835 for upstream report
  sed -i "/progname =/s/python/python2.7/" Python/pythonrun.c

  # Enable built-in SQLite module to load extensions (fix FS#22122)
  sed -i "/SQLITE_OMIT_LOAD_EXTENSION/d" setup.py

  # FS#23997
  sed -i -e "s|^#.* /usr/local/bin/python|#!/usr/bin/python2|" Lib/cgi.py

  sed -i "s/python2.3/python2/g" Lib/distutils/tests/test_build_scripts.py \
    Lib/distutils/tests/test_install_scripts.py

  # Ensure that we are using the system copy of various libraries (expat, zlib and libffi),
  # rather than copies shipped in the tarball
  rm -r Modules/expat
  rm -r Modules/zlib
  rm -r Modules/_ctypes/{darwin,libffi}*

  # clean up #!s
  find . -name '*.py' | \
    xargs sed -i "s|#[ ]*![ ]*/usr/bin/env python$|#!/usr/bin/env python2|"

  # Workaround asdl_c.py/makeopcodetargets.py errors after we touched the shebangs
  touch Include/Python-ast.h Python/Python-ast.c Python/opcode_targets.h

  export OPT="${CFLAGS}"
  ./configure --prefix=/usr \
              --enable-shared \
              --disable-gtk-doc \
              --with-threads \
              --enable-optimizations \
              --with-lto \
              --enable-ipv6 \
              --enable-unicode=ucs4 \
              --with-system-expat \
              --with-system-ffi \
              --with-dbmliborder=gdbm:ndbm \
              --without-ensurepip

  make

  # Hack to avoid building again
  sed -i 's/^all:.*$/all: build_all/' Makefile

  make DESTDIR="${PKG}" altinstall maninstall

  rm "${PKG}"/usr/share/man/man1/python.1

  ln -sf python2.7        "${PKG}"/usr/bin/python2
  ln -sf python2.7-config "${PKG}"/usr/bin/python2-config
  ln -sf python2.7.1      "${PKG}"/usr/share/man/man1/python2.1

  # FS#33954
  ln -sf python-2.7.pc    "${PKG}"/usr/lib/pkgconfig/python2.pc

  ln -sf ../../libpython2.7.so "${PKG}"/usr/lib/python2.7/config/libpython2.7.so

  mv "${PKG}"/usr/bin/smtpd.py "${PKG}"/usr/lib/python2.7/

  # some useful "stuff"
  install -dm755 "${PKG}"/usr/lib/python2.7/Tools/{i18n,scripts}
  install -m755 Tools/i18n/{msgfmt,pygettext}.py "${PKG}"/usr/lib/python2.7/Tools/i18n/
  install -m755 Tools/scripts/{README,*py} "${PKG}"/usr/lib/python2.7/Tools/scripts/


