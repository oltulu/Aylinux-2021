  ./configure --prefix=/usr \
    --libexecdir=/usr/bin \
    --with-bug-report-url=https://crux.nu/bugs \
    --enable-mp \
    --disable-static \
    --disable-python \
    --disable-nls \
    --disable-check-update \
    --without-webkit

  make
