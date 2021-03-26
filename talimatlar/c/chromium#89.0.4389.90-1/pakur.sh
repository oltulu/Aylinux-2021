  cd $SRC/chromium-launcher-7
  make PREFIX=/usr DESTDIR="$PKG" install


  cd "$SRC/$isim-$surum"

  install -D out/Release/chrome "$PKG/usr/lib/chromium/chromium"
  install -Dm4755 out/Release/chrome_sandbox "$PKG/usr/lib/chromium/chrome-sandbox"
  ln -s /usr/lib/chromium/chromedriver "$PKG/usr/bin/chromedriver"

  install -Dm644 chrome/installer/linux/common/desktop.template \
    "$PKG/usr/share/applications/chromium.desktop"
  install -Dm644 chrome/app/resources/manpage.1.in \
    "$PKG/usr/share/man/man1/chromium.1"
  sed -i \
    -e 's/@@MENUNAME@@/Chromium/g' \
    -e 's/@@PACKAGE@@/chromium/g' \
    -e 's/@@USR_BIN_SYMLINK_NAME@@/chromium/g' \
    "$PKG/usr/share/applications/chromium.desktop" \
    "$PKG/usr/share/man/man1/chromium.1"

  install -Dm644 chrome/installer/linux/common/chromium-browser/chromium-browser.appdata.xml \
    "$PKG/usr/share/metainfo/chromium.appdata.xml"
  sed -ni \
    -e 's/chromium-browser\.desktop/chromium.desktop/' \
    -e '/<update_contact>/d' \
    -e '/<p>/N;/<p>\n.*\(We invite\|Chromium supports Vorbis\)/,/<\/p>/d' \
    -e '/^<?xml/,$p' \
    "$PKG/usr/share/metainfo/chromium.appdata.xml"

  local toplevel_files=(
    chrome_100_percent.pak
    chrome_200_percent.pak
    resources.pak
    v8_context_snapshot.bin

    # ANGLE
    libEGL.so
    libGLESv2.so

    chromedriver
  )

  if [[ -z ${_system_libs[icu]+set} ]]; then
    toplevel_files+=(icudtl.dat)
  fi

  cp "${toplevel_files[@]/#/out/Release/}" "$PKG/usr/lib/chromium/"
  install -Dm644 -t "$PKG/usr/lib/chromium/locales" out/Release/locales/*.pak
  install -Dm755 -t "$PKG/usr/lib/chromium/swiftshader" out/Release/swiftshader/*.so

  for size in 24 48 64 128 256; do
    install -Dm644 "chrome/app/theme/chromium/product_logo_$size.png" \
      "$PKG/usr/share/icons/hicolor/${size}x${size}/apps/chromium.png"
  done

  for size in 16 32; do
    install -Dm644 "chrome/app/theme/default_100_percent/chromium/product_logo_$size.png" \
      "$PKG/usr/share/icons/hicolor/${size}x${size}/apps/chromium.png"
  done

