 cd "${SRC}"
  install -m755 -d "${PKG}/usr/share/licenses/${isim}"
  for dir in font-*-100dpi*; do
    if [ -d "${dir}" ]; then
      pushd ${dir}
      make DESTDIR="${PKG}" install
      install -m644 COPYING "${PKG}/usr/share/licenses/${isim}/LICENSE.${dir%-100dpi-*}"
      popd
    fi
  done
  rm -f "${PKG}"/usr/share/fonts/100dpi/fonts.*