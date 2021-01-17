  DESTDIR="$PKG" ninja -C build install

  # missing docs
  install -m755 -d "${PKG}/usr/share/doc/xorgproto"
  install -m644 xorgproto-$surum/*.txt "${PKG}/usr/share/doc/xorgproto/"
  install -m644 xorgproto-$surum/PM_spec "${PKG}/usr/share/doc/xorgproto/"
  rm ${PKG}/usr/share/doc/xorgproto/meson_options.txt

  # licenses
  install -m755 -d "${PKG}/usr/share/licenses/xorgproto"
  install -m644 xorgproto-$surum/COPYING* "${PKG}/usr/share/licenses/xorgproto/"

  # cleanup
  rm -f ${PKG}/usr/include/X11/extensions/{apple,windows}*
  rm -f ${PKG}/usr/share/licenses/xorgproto/COPYING-{apple,windows}wmproto
  rm -f ${PKG}/usr/share/pkgconfig/{apple,windows}wmproto.pc