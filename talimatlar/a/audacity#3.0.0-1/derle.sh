cd $isim-Audacity-${surum}
autoreconf -vfi
sed -i "s/which python/which/g" lib-src/lv2/build 
sed -i "s/which python/which/g" lib-src/lv2/configure 
WX_CONFIG=wx-config ./configure --prefix="/usr" \
--with-libsndfile="system" \
--with-ffmpeg="system" \
--with-expat="system" \
--with-lame="system" \
--with-libsoxr="system" \
--with-portaudio \
--with-portmidi \
--with-libflac \
--with-libid3tag \
--with-libsamplerate \
--with-soundtouch \
--with-libvorbis \
--with-lv2
make
