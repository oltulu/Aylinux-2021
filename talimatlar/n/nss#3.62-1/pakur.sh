cd $SRC/nss-$surum

  local libdir=/usr/lib nsprver="$(pkg-config --modversion nspr)"
  sed nss/pkg/pkg-config/nss.pc.in \
    -e "s,%libdir%,$libdir,g" \
    -e "s,%prefix%,/usr,g" \
    -e "s,%exec_prefix%,/usr/bin,g" \
    -e "s,%includedir%,/usr/include/nss,g" \
    -e "s,%NSPR_VERSION%,$nsprver,g" \
    -e "s,%NSS_VERSION%,$surum,g" |
    install -Dm644 /dev/stdin "$PKG$libdir/pkgconfig/nss.pc"

  ln -s nss.pc "$PKG$libdir/pkgconfig/mozilla-nss.pc"

  install -Dt "$PKG$libdir" dist/Release/lib/*.so
