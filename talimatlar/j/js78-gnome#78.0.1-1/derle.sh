cd mozjs-78.0.1gnome

  mkdir mozjs-build
  cd    mozjs-build
export SHELL=/bin/bash
  ../js/src/configure --prefix=/usr       \
              --with-intl-api     \
              --with-system-zlib  \
              --with-system-nspr  \
              --with-system-icu   \
              --disable-jemalloc  \
              --enable-readline

make