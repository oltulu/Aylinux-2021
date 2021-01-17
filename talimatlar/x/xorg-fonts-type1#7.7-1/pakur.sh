 cd "${SRC}"
  install -m755 -d "${PKG}/usr/share/licenses/${isim}"
  for dir in *; do
    if [ -d "${dir}" ]; then
      pushd ${dir}
      make DESTDIR="${PKG}" install
      install -m644 COPYING "${PKG}/usr/share/licenses/${isim}/LICENSE.${dir%-*}"
      popd
    fi
  done
  rm -f "${PKG}"/usr/share/fonts/Type1/fonts.*