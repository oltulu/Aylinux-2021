cd $SRC
[[ -e "/usr/lib/pkgconfig/xtst.pc" && -e "/usr/lib/pkgconfig/ice.pc" ]] || PKGMK_PULSEAUDIO+=' -D x11=disabled'
  [[ -e "/usr/lib/pkgconfig/bluez.pc" && -e "/usr/lib/pkgconfig/sbc.pc" ]] || PKGMK_PULSEAUDIO+=' -D bluez5=false'
  [[ -e /usr/lib/pkgconfig/gstreamer-1.0.pc ]] && PKGMK_PULSEAUDIO+=' -D gstreamer=enabled'
  [[ -e /usr/lib/pkgconfig/bash-completion.pc ]] || PKGMK_PULSEAUDIO+=' -D bashcompletiondir=no'
  [[ -e /usr/bin/zsh ]] || PKGMK_PULSEAUDIO+=' -D zshcompletiondir=no'

   meson setup $isim-$surum build $PKGMK_PULSEAUDIO \
    --prefix=/usr \
    --libexecdir=/usr/lib/$name \
    -D buildtype=plain \
    -D udevrulesdir=/etc/udev/rules.d \
    -D database=gdbm \
    -D tests=false
  meson compile -C build
  
