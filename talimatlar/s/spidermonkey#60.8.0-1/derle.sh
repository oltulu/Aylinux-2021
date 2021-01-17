cd $SRC/firefox-${surum}

  mkdir obj

  # https://bugzilla.mozilla.org/show_bug.cgi?id=1479687
  patch -Np1 -i ../bug1415202.patch

  # https://salsa.debian.org/gnome-team/mozjs52/tree/debian/master/debian/patches
  patch -Np1 -i ../mozjs60-fix-soname.patch
  
 configure_args=(
    --prefix=/usr
    --disable-debug
    --disable-debug-symbols
    --disable-jemalloc
    --disable-strip
    --enable-hardening
    --enable-linker=gold
    --enable-optimize
    --enable-posix-nspr-emulation
    --enable-readline
    --enable-release
    --enable-shared-js
    --with-intl-api
    --with-system-zlib
    --without-system-icu
  )

  cd obj

  export PYTHON=/usr/bin/python2
  export SHELL=/bin/bash

  sh ../js/src/configure "${configure_args[@]}"
  make
