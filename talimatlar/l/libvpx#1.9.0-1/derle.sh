CFLAGS+=" -fPIC" ./configure \
--prefix='/usr' \
--disable-static \
--disable-install-docs \
--disable-install-srcs \
--enable-pic \
--enable-postproc \
--enable-runtime-cpu-detect \
--enable-shared \
--enable-vp8 \
--enable-vp9 \
--enable-vp9-highbitdepth \
--enable-vp9-temporal-denoising --target=generic-gnu
make
