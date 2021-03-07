make DESTDIR=$PKG distro-pack-install

  install -dm755 $PKG/usr/etc/libreoffice
  install -m644 $PKG/usr/lib/libreoffice/program/{bootstraprc,sofficerc} \
    $PKG/usr/etc/libreoffice/
  install -m644 $PKG/usr/lib/libreoffice/share/psprint/psprint.conf \
    $PKG/usr/etc/libreoffice/

  # install dummy links to make them found by lo
  cd $PKG/usr/lib/libreoffice/program/
  ln -vsrf $PKG/usr/etc/libreoffice/{bootstraprc,sofficerc} .
