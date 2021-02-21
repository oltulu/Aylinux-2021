#cd $SRC/gst-plugins-good-$surum
#DESTDIR=$PKG meson install -C build

cd $SRC/gst-plugins-bad-$surum
DESTDIR=$PKG meson install -C build

mkdir -p ext/lib/gstreamer-1.0
  for _x in aom assrender bs2b bz2 chromaprint closedcaption colormanagement \
            curl dc1394 de265 dtls dtsdec faac faad fdkaac fluidsynthmidi gme \
            hls ladspa lv2 mms modplug mpeg2enc mplex \
            neonhttpsrc ofa openal openexr openjpeg opusparse resindvd rsvg \
            rtmp sbc smoothstreaming sndfile soundtouch spandsp srt srtp \
            teletext ttmlsubs waylandsink webp webrtc webrtcdsp \
            wildmidi x265 zbar va avtp; do
    _x="lib/gstreamer-1.0/libgst${_x}.so"
    mv "$PKG/usr/$_x" "ext/$_x"
  done


#cd $SRC/gst-plugins-ugly-$surum
#DESTDIR=$PKG meson install -C build

cd $SRC/gst-libav-$surum
DESTDIR=$PKG meson install -C build

cd $SRC/gst-python-$surum
DESTDIR=$PKG meson install -C build
