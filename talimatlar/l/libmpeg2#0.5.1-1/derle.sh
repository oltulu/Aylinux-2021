  cd "${SRC}/${isim}-${surum}"
  patch -Np1 -i "${SRC}/libmpeg2-0.5.1-gcc4.6.patch"

  sed '/AC_PATH_XTRA/d' -i configure.ac
  autoreconf --force --install
  cd "${SRC}/${isim}-${surum}"
  ./configure --prefix=/usr --enable-shared --disable-static
  make	OPT_CFLAGS="${CFLAGS}" \
	MPEG2DEC_CFLAGS="${CFLAGS}" \
	LIBMPEG2_CFLAGS=""
