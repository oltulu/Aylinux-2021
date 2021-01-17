sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install

CFLAGS="$CFLAGS -fPIC"
./configure --prefix=/usr \
--disable-static

make SHLIB_LIBS="-L/lib -lncursesw"
