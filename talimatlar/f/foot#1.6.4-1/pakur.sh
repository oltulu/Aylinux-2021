  if [[ -v WAYLAND_DISPLAY ]]; then
    build/foot \
      --config /dev/null \
      --term=xterm \
      sh -c "./scripts/generate-alt-random-writes.py --scroll --scroll-region --colors-regular --colors-bright --colors-256 --colors-rgb --attr-bold --attr-italic --attr-underline $(mktemp) && cat $(mktemp)"
  else
    ./scripts/generate-alt-random-writes.py \
      --rows=67 \
      --cols=135 \
      --scroll --scroll-region --colors-regular --colors-bright --colors-256 --colors-rgb --attr-bold --attr-italic --attr-underline \
     $(mktemp)
    build/pgo $(mktemp) $(mktemp) $(mktemp)
  fi

  rm "$(mktemp)"

  meson configure -Db_pgo=use build
  ninja -C build

  DESTDIR="${PKG}/" ninja -C build install
 # rm -rf "${pkgdir}/usr/share/terminfo"

  install -dm 755 "${pkgdir}/usr/share/terminfo/f/"
  cp build/f/* "${pkgdir}/usr/share/terminfo/f/"
