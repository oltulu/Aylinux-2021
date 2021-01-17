 mkdir -p build

  cd qtdeclarative-everywhere-src-$surum
  patch -p1 -i ../qtbug-75203.patch 

  cd ../build

  qmake ../qtdeclarative-everywhere-src-$surum
  make

  make INSTALL_ROOT="$PKG" install

  # Symlinks for backwards compatibility
  for b in "$PKG"/usr/bin/*; do
    ln -s $(basename $b) "$PKG"/usr/bin/$(basename $b)-qt5
  done

  # Drop QMAKE_PRL_BUILD_DIR because reference the build dir
  find "$PKG/usr/lib" -type f -name '*.prl' \
    -exec sed -i -e '/^QMAKE_PRL_BUILD_DIR/d' {} \;