cd $isim-$surum
[[ -e /usr/lib/pkgconfig/jack.pc ]] || PKGMK_PW+=' -Dpipewire-jack=disabled -Djack=disabled'
  [[ -e /usr/lib/pkgconfig/vulkan.pc ]] || PKGMK_PW+=' -Dpipewire-vulkan=disabled -Dvulkan=disabled'
  [[ -e /usr/lib/pkgconfig/bluez.pc ]] || PKGMK_PW+=' -Dbluez5=disabled'
  [[ -e /usr/lib/pkgconfig/libv4l2.pc ]] || PKGMK_PW+=' -Dv4l2=disabled'
  [[ -e /usr/include/pulse/glib-mainloop.h ]] || PKGMK_PW+=' -Dpipewire-pulseaudio=disabled'
  [[ -e /usr/lib/pkgconfig/gstreamer-1.0.pc ]] || PKGMK_PW+=' -Dgstreamer=disabled'
cd $SRC  
    milis-meson setup $isim-$surum build $PKGMK_PW \
    -D prefix=/usr \
    --buildtype=plain \
    -D docs=disabled \
    -D tests=disabled
 

  meson compile -C build

