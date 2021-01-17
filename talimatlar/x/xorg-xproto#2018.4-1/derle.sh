  mkdir build

  milis-meson xorgproto-$surum build \
    -Dlegacy=true

  ninja -C build