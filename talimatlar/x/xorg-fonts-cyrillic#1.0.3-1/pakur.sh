  install -m755 -d "${PKG}/usr/share/licenses/${isim}"
  cd "${SRC}"
  for dir in *; do
    if [ -d "${dir}" ]; then
      pushd "${dir}"
      make DESTDIR="${PKG}" install
      install -m644 COPYING "${PKG}/usr/share/licenses/${isim}/LICENSE.${dir%-*}"
      popd
    fi    
  done