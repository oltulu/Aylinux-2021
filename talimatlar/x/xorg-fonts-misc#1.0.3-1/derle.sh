  cd "${SRC}"
  for dir in *; do
    if [ -d "${dir}" ]; then
      pushd "${dir}"
      ./configure --prefix=/usr \
		      --with-fontdir=/usr/share/fonts/misc
      make
      popd
    fi
  done