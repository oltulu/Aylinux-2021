patch -Np1 -i ../no-drmdevice-test.diff
  milis-meson $SRC/$isim-$surum build \
    -Dudev=false \
    -Dvalgrind=false
  ninja -C build