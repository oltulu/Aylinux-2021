sed -e 's:truetype/ttf-dejavu:TTF:g' -i modules/visualization/projectm.cpp
sed -e 's|-Werror-implicit-function-declaration||g' -i configure
sed 's|whoami|echo builduser|g' -i configure
sed 's|hostname -f|echo aylinux|g' -i configure

patch -Np1 < $SRC/vlc_qt_5_15.patch
patch -Np1 < $SRC/vlc-3.0.11.1-srt_1.4.2.patch
patch -Np1 < $SRC/vlc-lua53_compat.patch

export CFLAGS+=" -I/usr/include/samba-4.0"
  export CPPFLAGS+=" -I/usr/include/samba-4.0"
  export CXXFLAGS+=" -std=c++11"
  export LUAC=/usr/bin/luac
  export LUA_LIBS="$(pkg-config --libs lua)"
  export RCC=/usr/bin/rcc-qt5

./configure --prefix=/usr \
--sysconfdir=/etc \
--disable-rpath \
--enable-nls \
--enable-archive \
--disable-live555 \
--enable-dc1394 \
--enable-dv1394 \
--enable-dvdread \
--disable-dvdnav \
--enable-bluray \
--disable-opencv \
--enable-smbclient \
--disable-sftp \
--disable-nfs \
--enable-realrtsp \
--enable-dvbpsi \
--enable-gme \
--enable-ogg \
--enable-shout \
--enable-matroska \
--enable-mod \
--enable-mpc \
--enable-mad \
--enable-mpg123 \
--enable-gst-decode \
--enable-avcodec \
--enable-libva \
--enable-avformat \
--enable-postproc \
--enable-faad \
--enable-vpx \
--disable-twolame \
--disable-fdkaac \
--enable-a52 \
--enable-dca \
--enable-flac \
--enable-libmpeg2 \
--enable-vorbis \
--enable-speex \
--enable-opus \
--enable-oggspots \
--disable-schroedinger \
--enable-png \
--enable-jpeg \
--enable-x264 \
--enable-x265 \
--enable-zvbi \
--enable-libass \
--disable-kate \
--disable-tiger \
--enable-vdpau \
--enable-wayland \
--disable-sdl-image \
--enable-freetype \
--enable-fribidi \
--enable-harfbuzz \
--enable-fontconfig \
--enable-svg \
--enable-svgdec \
--enable-aa \
--enable-caca \
--enable-pulse \
--enable-alsa \
--enable-jack \
--enable-samplerate \
--enable-soxr \
--enable-qt \
--enable-skins2 \
--enable-libtar \
--disable-ncurses \
--enable-avahi \
--enable-mtp \
--enable-upnp \
--enable-libxml2 \
--disable-libgcrypt \
--enable-gnutls \
--enable-taglib \
--enable-secret \
--disable-kwallet \
--disable-update-check \
--enable-notify \
--disable-libplacebo \
--enable-vlc \
--disable-aribsub \
--enable-aom \
--disable-srt \
--enable-dav1d \
--enable-run-as-root
make
