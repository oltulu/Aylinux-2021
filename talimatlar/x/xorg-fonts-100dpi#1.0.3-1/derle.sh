  cd "${SRC}"
  for dir in font-*-100dpi*; do
    if [ -d "${dir}" ]; then
      pushd ${dir}
      ./configure --prefix=/usr \
          --with-fontdir=/usr/share/fonts/100dpi
      make
      popd
    fi
  done