mkdir -v build
cd build

../libstdc++-v3/configure       \
--host=$ONSISTEM_TARGET         \
--prefix=/tools                 \
--disable-multilib              \
--disable-nls                   \
--disable-libstdcxx-threads     \
--disable-libstdcxx-pch         \
--with-gxx-include-dir=/tools/$ONSISTEM_TARGET/include/c++/$surum

make
