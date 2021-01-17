  cd "${SRC}"
  for dir in *; do
    if [ -d "${dir}" ]; then
      pushd "${dir}"
      ./configure --prefix=/usr \
		      --with-fontdir=/usr/share/fonts/cyrillic
      make
      popd
    fi
  done