mkdir -v build
cd build

../libstdc++-v3/configure       \
--host=$ONSISTEM_TARGET         \
--prefix=/usr                 \
--disable-multilib              \
--disable-nls                   \
--disable-libstdcxx-threads     \
--disable-libstdcxx-pch         \
--with-gxx-include-dir=/usr/$ONSISTEM_TARGET/include/c++/$surum

make
