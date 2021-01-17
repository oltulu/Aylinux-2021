cd $SRC/gst-plugins-good-$surum
DESTDIR=$PKG meson install -C build

cd $SRC/gst-plugins-bad-$surum
DESTDIR=$PKG meson install -C build

cd $SRC/gst-plugins-ugly-$surum
DESTDIR=$PKG meson install -C build

cd $SRC/gst-libav-$surum
DESTDIR=$PKG meson install -C build

cd $SRC/gst-python-$surum
DESTDIR=$PKG meson install -C build
