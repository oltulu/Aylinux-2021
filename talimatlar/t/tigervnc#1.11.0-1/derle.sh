cd unix/xserver
cp -r "$SRC"/xorg-server-1.20.5/* .
patch -Np1 -i ../xserver120.patch

cd "$SRC"/${isim}-${surum}

cmake -G "Unix Makefiles" \
-DCMAKE_INSTALL_PREFIX=/usr \
-DBUILD_JAVA=FALSE
make

cd unix/xserver
autoreconf -fiv
CFLAGS="$CFLAGS -I/usr/include/libdrm" ./configure --prefix=/usr \
--disable-static --without-dtrace \
--disable-xorg --disable-xnest --disable-xvfb --disable-dmx \
--disable-xwin --disable-xephyr --disable-kdrive --disable-xwayland \
--disable-config-hal --disable-config-udev --with-pic \
--disable-unit-tests --disable-devel-docs --disable-selective-werror \
--disable-dri --enable-dri2 --enable-dri3 --enable-glx
make
