 #   NOCONFIGURE=1 ./autogen.sh
 ./configure --prefix=/usr \
    --enable-introspection \
    --enable-egl-backend \
    --enable-gdk-backend \
    --enable-wayland-backend \
    --enable-x11-backend \
    --enable-evdev-input \
    --enable-wayland-compositor

  # https://bugzilla.gnome.org/show_bug.cgi?id=655517
 # sed -i -e 's/ -shared / -Wl,-O1,--as-needed\0/g' libtool

  make