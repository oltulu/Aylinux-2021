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
            teletext ttmlsubs vulkan waylandsink webp webrtc webrtcdsp \
            wildmidi x265 zbar va svthevcenc avtp zxing microdns; do
    _x="lib/gstreamer-1.0/libgst${_x}.so"
    mv "$PKG/usr/$_x" "ext/$_x"
  done

  mkdir -p opencv/{lib,include/gstreamer-1.0/gst}
  mv -t opencv/lib "$pkgdir"/usr/lib/*opencv*
  mv -t opencv/include/gstreamer-1.0/gst \
    "$PKG"/usr/include/gstreamer-1.0/gst/opencv

  for _x in opencv wpe; do
    mkdir -p "$_x/lib/gstreamer-1.0"
    _f="lib/gstreamer-1.0/libgst${_x}.so"
    mv "$PKG/usr/$_f" "$_x/$_f"
  done

#cd $SRC/gst-plugins-ugly-$surum
#DESTDIR=$PKG meson install -C build

cd $SRC/gst-libav-$surum
DESTDIR=$PKG meson install -C build

cd $SRC/gst-python-$surum
DESTDIR=$PKG meson install -C build
