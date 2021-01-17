  install -d "${PKG}"/usr/share/$isim/fslint/{fstool,supprt/rmlint}
  install -D -m755 -t "${PKG}"/usr/share/$isim/$isim $isim/find* $isim/zipdir $isim/fslint
  install -D -m755 -t "${PKG}"/usr/share/$isim/$isim/fstool $isim/fstool/*
  install -D -m755 -t "${PKG}"/usr/share/$isim/$isim/supprt $isim/supprt/get* $isim/supprt/fslver $isim/supprt/md5sum_approx
  install -D -m755 -t "${PKG}"/usr/share/$isim/$isim/supprt/rmlint fslint/supprt/rmlint/*
  install -D -m755 $isim-gui "${PKG}"/usr/bin/$isim-gui
  install -D -m644 $isim.glade "${PKG}"/usr/share/$isim/$isim.glade
  install -D -m644 $isim.desktop "${PKG}"/usr/share/applications/$isim.desktop
  install -D -m644 fslint_icon.png "${PKG}"/usr/share/$isim/fslint_icon.png
  mkdir -p "${PKG}"/usr/share/pixmaps
  ln -s /usr/share/$isim/fslint_icon.png "${PKG}"/usr/share/pixmaps/fslint_icon.png
  make -C po DESTDIR="${PKG}" install
  mkdir -p "${PKG}"/usr/share/fslint/po
  cp -r po/locale "${PKG}"/usr/share/fslint/po/
