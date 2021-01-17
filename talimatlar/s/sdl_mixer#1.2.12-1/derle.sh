cd SDL_mixer-$surum

patch -Np1 -i ../mikmod1.patch
patch -Np1 -i ../mikmod2.patch
patch -Np1 -i ../fluidsynth-volume.patch
patch -Np1 -i ../double-free-crash.patch

sed -e "/CONFIG_FILE_ETC/s|/etc/timidity.cfg|/etc/timidity++/timidity.cfg|" \
  -e "/DEFAULT_PATH/s|/etc/timidity|/etc/timidity++|" \
  -e "/DEFAULT_PATH2/s|/usr/local/lib/timidity|/usr/lib/timidity|" \
  -i timidity/config.h

./configure --prefix=/usr --disable-static
make
