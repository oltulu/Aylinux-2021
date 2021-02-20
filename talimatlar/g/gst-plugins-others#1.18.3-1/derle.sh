cd $SRC/gst-plugins-bad-$surum
milis-meson build \
-D directfb=disabled \
-D flite=disabled \
-D gsm=disabled \
-D iqa=disabled \
-D msdk=disabled \
-D nvdec=disabled \
-D nvenc=disabled \
-D opencv=disabled \
-D openh264=disabled \
-D openmpt=disabled \
-D openni2=disabled \
-D opensles=disabled \
-D sctp=disabled \
-D tinyalsa=disabled \
-D voaacenc=disabled \
-D voamrwbenc=disabled \
-D wasapi=disabled \
-D wpe=disabled \
-D gobject-cast-checks=disabled \
-D glib-asserts=disabled \
-D glib-checks=disabled \
-D kate=disabled \
-D gtk_doc=disabled \
-D musepack=disabled \
-D package-origin="https://www.milislinux.org"
ninja -C build

cd $SRC/gst-libav-$surum
milis-meson build
ninja -C build

cd $SRC/gst-python-$surum
milis-meson build \
-Dgtk_doc=disabled
ninja -C build


