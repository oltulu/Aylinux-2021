mkdir -p ext/lib/gstreamer-1.0
  for _x in alsa cdparanoia libvisual ogg opengl opus pango theora vorbis; do
    _x="lib/gstreamer-1.0/libgst${_x}.so"
    mv "$PKG/usr/$_x" "ext/$_x"
  done
  
  mv ext "$PKG/usr"
