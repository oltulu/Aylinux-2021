cd $SRC
cp xwayland-config.h.meson.in ${isim}-${surum}/include/

export CFLAGS=${CFLAGS/-fno-plt}
export CXXFLAGS=${CXXFLAGS/-fno-plt}
export LDFLAGS=${LDFLAGS/,-z,now}

milis-meson $isim-$surum build \
-D os_vendor="Milis Linux" \
-D ipv6=true \
-D dmx=true \
-D xvfb=true \
-D xnest=true \
-D xcsecurity=true \
-D xorg=true \
-D xephyr=true \
-D xwayland=true \
-D glamor=true \
-D udev=true \
-D systemd_logind=false \
-D suid_wrapper=true \
-D xkb_dir=/usr/share/X11/xkb \
-D xkb_output_dir=/var/lib/xkb

ninja -C build
