[[ -z $(pkg-config --libs --static libavutil | grep -- '-lvdpau') ]] && \
    PKGMK_VLC+=' --disable-vdpau'

  autoreconf -fi

#  export LUAC=/usr/bin/luac5.2
#  export LUA_LIBS="$(pkg-config --libs lua5.2)"
  export RCC=/usr/bin/rcc-qt5
  eval PKGMK_VLC="($PKGMK_VLC)"

  sed -e 's|-Werror-implicit-function-declaration||g' -i configure

  BUILDCC="gcc -std=gnu11"          \
  ./configure "${PKGMK_VLC[@]}"     \
              --prefix=/usr         \
              --disable-nls         \
              --enable-alsa         \
              --disable-dbus        \
              --disable-fribidi     \
              --disable-update-check 

  V=1 ./compile
