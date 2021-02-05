cd $SRC
install -dm755 "$PKG/etc"
  touch "$PKG/etc/ld.so.conf"

  make -C glibc-build install_root="$PKG" install
  rm -f "$PKG"/etc/ld.so.{cache,conf}

  # Shipped in tzdata
  rm -f "$PKG"/usr/bin/{tzselect,zdump,zic}
  cd glibc

  install -dm755 "$PKG"/usr/lib/{locale,tmpfiles.d}
  install -m644 nscd/nscd.conf "$PKG/etc/nscd.conf"
  install -m644 nscd/nscd.tmpfiles "$PKG/usr/lib/tmpfiles.d/nscd.conf"
  install -dm755 "$PKG/var/db/nscd"

  install -m644 posix/gai.conf "$PKG"/etc/gai.conf

  install -m755 "$SRC/locale-gen" "$PKG/usr/bin"

  # Create /etc/locale.gen
  install -m644 "$SRC/locale.gen.txt" "$PKG/etc/locale.gen"
  sed -e '1,3d' -e 's|/| |g' -e 's|\\| |g' -e 's|^|#|g' \
    "$SRC/glibc/localedata/SUPPORTED" >> "$PKG/etc/locale.gen"

  if check_option 'debug' n; then
    find "$PKG"/usr/bin -type f -executable -exec strip $STRIP_BINARIES {} + 2> /dev/null || true
    find "$PKG"/usr/lib -name '*.a' -type f -exec strip $STRIP_STATIC {} + 2> /dev/null || true

    # Do not strip these for gdb and valgrind functionality, but strip the rest
    find "$PKG"/usr/lib \
      -not -name 'ld-*.so' \
      -not -name 'libc-*.so' \
      -not -name 'libpthread-*.so' \
      -not -name 'libthread_db-*.so' \
      -name '*-*.so' -type f -exec strip $STRIP_SHARED {} + 2> /dev/null || true
  fi

  # Provide tracing probes to libstdc++ for exceptions, possibly for other
  # libraries too. Useful for gdb's catch command.
  install -Dm644 "$SRC/sdt.h" "$PKG/usr/include/sys/sdt.h"
  install -Dm644 "$SRC/sdt-config.h" "$PKG/usr/include/sys/sdt-config.h"

  # Provided by libxcrypt; keep the old shared library for backwards compatibility
  rm -f "$PKG"/usr/include/crypt.h "$PKG"/usr/lib/libcrypt.{a,so}
  
  
