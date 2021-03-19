milis-meson xserver build \
    -D os_vendor="Arch Linux" \
    -D ipv6=false \
    -D xcsecurity=false \
    -D xorg=false \
    -D xwayland=true \
    -D xwayland_eglstream=false \
    -D udev=true \
    -D suid_wrapper=false \
    -D xkb_dir=/usr/share/X11/xkb \
    -D xkb_output_dir=/var/lib/xkb \
    -D systemd_logind=false \
    -D b_lto=true \
    -D xinerama=true \
    -D screensaver=false \
    -D dmx=false \
    -D glamor=true \
    -D linux_apm=false \
    -D mitshm=true \
    -D vgahw=false \
    -D xdmcp=false \
    -D xephyr=false \
    -D xnest=false \
    -D xquartz=false \
    -D xv=true \
    -D xvmc=false \
    -D xvfb=false \
    -D xwin=false \
    -D xres=false \
    -D xdm-auth-1=false \
    -D secure-rpc=false \
    -D dtrace=false \
    -D listen_tcp=false \
    -D dpms=false \
    -D xf86bigfont=false \
    -D xselinux=false \
    -D dga=false \
    -D linux_acpi=false \
    -D agp=false \
    -D dri1=false \
    -D dri2=false \
    -D xpbproxy=false \
    -D errorlogs=false \
    -D stdsplit=false \
    -D b_pgo=off \
    -D libunwind=false \
    -D hal=false \
    -D xf86-input-inputtest=false \
    -D xace=false \
    -D debug=false \
    -D input_thread=true \
    -D int10=false \
    -D sparkle=false \
    -D composite=false \
    -D record=false \
    -D dri=false \
    -D dri3=true \
    -D present=false \
    -D xf86vidmode=false \
    -D dbe=false \
    -D xfree86-utils=false \
    -D windowsdri=false \
    -D kdrive=false \
    -D systemd-daemon=false \
    -D libdrm=false \
    -D clientids=false \
    -D pciaccess=false \
    -D xshmfence=false

  # Print config
  meson configure build
  ninja $NINJAFLAGS -C build
 
  # fake installation to be seperated into packages
  DESTDIR="${SRC}/fakeinstall" ninja $NINJAFLAGS -C build install

_install() {
  local src f dir
  for src; do
    f="${src#fakeinstall/}"
    dir="${PKG}/${f%/*}"
    install -m755 -d "${dir}"
    mv -v "${src}" "${dir}/"
  done
}
  
  _install fakeinstall/usr/lib/xorg/protocol.txt
  _install fakeinstall/usr/share/man/man1/Xserver.1
  _install fakeinstall/usr/bin/Xwayland
  
#  _install fakeinstall/usr/include/xorg/*
